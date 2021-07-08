using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RISCVParser.Arguments.Instruction
{
    class ImmediateArgument :InstructionArgument
    {
        public static ImmediateArgument parseImmediateArgument(string arg) 
        {
            long val;
            if (arg.StartsWith("%"))
            {
                return new MacroArgument(arg);
            }
            else if (arg.StartsWith("0x"))
            {
                return new TrueImmediateArgument(arg);
            }
            else if (long.TryParse(arg, out val))
            {
                return new TrueImmediateArgument(arg);
            }
            else 
            {
                return new LabelArgument(arg);
            }
        }
    }
}
