using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SRAMMifgen
{
    class Program
    {
        static void Main(string[] args)
        {
            if (args.Length < 2) 
            {
                Console.WriteLine("Invalid Arguments");
                return;
            }

            bool bootstrap = args.Length > 2 && args[2] == "-bootstrap";

            StreamReader sr = new StreamReader(args[0]);
            StreamWriter sw = new StreamWriter(args[1]);

            List<string> Lines= new List<string>();
            while (!sr.EndOfStream) 
            {
                Lines.Add(sr.ReadLine().Trim());
            }
            List<string> dataLines = new List<string>();
            for (int i = Lines.IndexOf("Contents of section .text:")+1; i < Lines.IndexOf("Contents of section .comment:"); i++)
            {
                if (Lines[i].StartsWith("1")) 
                {
                    dataLines.Add(Lines[i]);
                }
            }

            string PCLine="";
            List<string> GPLines = new List<string>();

            for (int i = Lines.IndexOf("Disassembly of section .text:")+1; i < Lines.IndexOf("Disassembly of section .rodata:"); i++)
            {
                if (Lines[i].EndsWith(" <_start>:")) 
                {
                    //Console.WriteLine("PC "+Lines[i]);
                    PCLine = Lines[i];
                }
                if (Lines[i].Contains("(gp) # "))
                {
                    //Console.WriteLine("GP " + Lines[i]);
                    GPLines.Add(Lines[i]);
                }
            }

            if (PCLine == "") 
            {
                Console.WriteLine("Cant calculate PC, _start function not found");
            }
            Console.WriteLine("Using hardcoded SP");
            if (GPLines.Count == 0) 
            {
                Console.WriteLine("Cant calculate GP, no instructions that ure gp found");
            }

            List<ulong> Address = new List<ulong>();
            List<ulong> Data = new List<ulong>();
            foreach (string dataline in dataLines)
            {
                string[] splits = dataline.Split(' ');
                ulong startAddress = FromHex(splits[0]) & 0xFFFF;
                for (int i = 1; i < 5; i++)
                {
                    if (splits[i] != "")
                    {
                        Address.Add(startAddress);
                        string[] bytes = Split(splits[i], 2).ToArray();
                        bytes = bytes.Reverse().ToArray();
                        string actualdata = "";
                        bytes.Select(x => { actualdata += x; return x; }).ToArray();
                        Data.Add(FromHex(actualdata));
                        startAddress += 4;
                    }
                    else 
                    {
                        break;
                    }
                }
            }

            ulong PC = 0;
            ulong SP = 32700;
            long GP = 0;

            PC = (FromHex(PCLine.Split(' ')[0]) & 0xFFFF);

            for (int i = 0; i < GPLines.Count; i++)
            {
                string GPLINE = GPLines[i];
                
                int indgp = GPLINE.IndexOf("(gp)");
                int lindz = GPLINE.LastIndexOf(',', indgp);
                long ofs = Convert.ToInt64(GPLINE.Substring(lindz + 1, indgp - lindz-1));

                int sindex = indgp + 7;
                int eindex = GPLINE.IndexOf(' ', sindex);
                long dest = checked((long)FromHex(GPLINE.Substring(sindex, eindex - sindex)))&0xFFFF;

                long tgp = dest - ofs;

                if (tgp != GP && i != 0)
                {
                    GP = 0;
                    break;
                }
                else 
                {
                    GP = tgp;
                }
            }

            if (!bootstrap)
            {
                sw.WriteLine($"--PC = {PC};");
                sw.WriteLine($"--SP x2 = {SP};");
                sw.WriteLine($"--GP x3 = {GP};");
            }
            else 
            {
                sw.WriteLine($"--Bootstraping SP,GP and PC;");
                sw.WriteLine($"--PC = 0;");
                sw.WriteLine($"--SP x2 = Dont care;");
                sw.WriteLine($"--GP x3 = Dont care;");
            }
            sw.WriteLine($"DEPTH = {(Address[Address.Count-1]/4)+1};");
            sw.WriteLine("WIDTH = 32;");
            sw.WriteLine("ADDRESS_RADIX = HEX;");
            sw.WriteLine("DATA_RADIX = HEX;");
            sw.WriteLine("CONTENT");
            sw.WriteLine("BEGIN");

            if (bootstrap)
            {
                uint ofs = (uint)(PC-16u);
                if (Address.Count > 0 && Address[0] >= 5 * 4)
                {
                    sw.WriteLine($"{ToHex(0)} : {ToHex(GenerateLUI(2,2, (uint)(SP)))}; --LUI SP x2 = {SP >> 12};");
                    sw.WriteLine($"{ToHex(1)} : {ToHex(GenerateADDI(2,2, (uint)(SP)))}; --ADDI SP x2 = {SP} ({ToHex(SP)});");
                    sw.WriteLine($"{ToHex(2)} : {ToHex(GenerateLUI(3,3, (uint)(GP)))}; --LUI GP x3 = {GP >> 12};");
                    sw.WriteLine($"{ToHex(3)} : {ToHex(GenerateADDI(3,3, (uint)(GP)))}; --ADDI GP x3 = {GP} ({ToHex((ulong)GP)});");
                    sw.WriteLine($"{ToHex(4)} : {ToHex(GenerateJAL(0,ofs))}; --JAL PC = {PC};");
                }
                else
                {
                    Console.WriteLine("Cant bootstrap, memory starts from 0");
                }
            }

            for (int i = 0; i < Address.Count; i++)
            {
                //Console.WriteLine($"{ToHex(Address[i]/4)} : {ToHex(Data[i])};");
                sw.WriteLine($"{ToHex(Address[i] / 4)} : {ToHex(Data[i])};");
            }

            sw.WriteLine("END;");

            sr.Dispose();
            sw.Dispose();

        }

        private static ulong GenerateJAL(uint reg,uint ofs)
        {
            uint ret = 111;
            ret |= reg << 7;
            ret |= (ofs&0xFF000);
            ret |= (ofs & 0x800) << 9;
            ret |= (ofs & 0x7FE) << 20;
            ret |= (ofs & 0x100000) << 11;
            return ret;
        }

        private static ulong GenerateADDI(uint des,uint src,uint val)
        {
            val =((val & 0x800) == 0 ? (val&0xFFF) : (val & 0xFFF) - 4096);
            uint ret = 19;
            ret |= des << 7;
            ret |= src << 15;
            ret |= val << 20;
            return ret;
        }

        private static ulong GenerateLUI(uint des, uint src, uint val)
        {
            val = (val >> 12) + ((val & 0x800) == 0 ? 0u : 1u);
            uint ret = 55;
            ret |= des << 7;
            ret |= val << 12;
            return ret;
        }

        static ulong FromHex(string s) 
        {
            return Convert.ToUInt64(s, 16);
        }

        static string ToHex(ulong u) 
        {
            return u.ToString("x").PadLeft(8, '0');
        }

        static IEnumerable<string> Split(string str, int chunkSize)
        {
            return Enumerable.Range(0, str.Length / chunkSize)
                .Select(i => str.Substring(i * chunkSize, chunkSize));
        }
    }
}
