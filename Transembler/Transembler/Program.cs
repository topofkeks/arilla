using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using RISCVParser;

namespace Transembler
{
    class Program
    {
        static void Main(string[] args)
        {
            RISCVAssemblyParser p;
            if (args.Length > 0)
            {
                p = new RISCVAssemblyParser(new FileStream(args[0], FileMode.Open));
            }
            else if (File.Exists("RISCV.asm"))
            {
                p = new RISCVAssemblyParser(new FileStream("RISCV.asm", FileMode.Open));
            }
            else 
            {
                Console.WriteLine("NO FILE");
                return;
            }

            p.Test();
            p.Dispose();

        }
    }
}
