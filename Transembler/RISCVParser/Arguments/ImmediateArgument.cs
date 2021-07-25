using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Transembler.IAL.Arguments;

namespace RISCVSource.Arguments
{
    abstract class ImmediateArgument :Argument, IALImmediateArgument
    {
        public static ImmediateArgument ParseImmediateArgument(string arg) 
        {
            if (arg.StartsWith("%"))
            {
                return new MacroArgument(arg);
            }
            else if (arg.StartsWith("0x"))
            {
                return new LiteralArgument(arg);
            }
            else if (long.TryParse(arg, out _))
            {
                return new LiteralArgument(arg);
            }
            else 
            {
                return new LabelArgument(arg);
            }
        }
    }
}
