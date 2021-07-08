using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RISCVParser.Arguments.Instruction
{
    class RegisterArgument : InstructionArgument
    {

        public RegisterArgument(string arg)
        {
            if (!isRegister(arg))
            {
                regNo = -1;
                return;
            }
            if (char.IsDigit(arg[arg.Length - 1]))
            {
                regNo = convertRegister(arg[0] + "", Convert.ToInt32(arg.Substring(1)));
            }
            else
            {
                regNo = convertRegister(arg, -1);
            }
        }

        public int regNo;

        public static bool isRegister(string reg)
        {
            if (reg == "zero" || reg == "ra" || reg == "sp" || reg == "gp" || reg == "tp" || reg == "fp") { return true; }
            else
            {
                int max;
                switch (reg[0])
                {
                    case 'x': { max = 32; break; }
                    case 't': { max = 7; break; }
                    case 's': { max = 12; break; }
                    case 'a': { max = 8; break; }
                    default: { return false; }
                }
                int num;
                if (int.TryParse(reg.Substring(1), out num))
                {
                    return num >= 0 && num < max;
                }
                else
                {
                    return false;
                }
            }
        }

        public static int convertRegister(string type, int No)
        {
            int[] LUTt = new int[] { 5, 6, 7, 28, 29, 30, 31 };
            int[] LUTs = new int[] { 8, 9, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27 };
            int[] LUTa = new int[] { 10, 11, 12, 13, 14, 15, 16, 17 };

            switch (type)
            {
                case "zero": { return 0; }
                case "ra": { return 1; }
                case "sp": { return 2; }
                case "gp": { return 3; }
                case "tp": { return 4; }
                case "fp": { return 8; }
                case "x": { return No; }
                case "t": { return LUTt[No]; }
                case "s": { return LUTs[No]; }
                case "a": { return LUTa[No]; }
                default: { return -1; }
            }
        }

        public override string ToString()
        {
            return "x" + regNo;
        }

    }
}
