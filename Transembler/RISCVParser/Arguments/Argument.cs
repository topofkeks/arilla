using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Transembler.IAL.Arguments;

namespace RISCVSource.Arguments
{
    abstract class Argument : IALArgument
    {
        public static Argument ParseInstructionArgument(string arg)
        {
            if (RegisterArgument.IsRegister(arg))
            {
                return new RegisterArgument(arg);
            }
            if (arg.EndsWith(")") && (!arg.StartsWith("%") || Util.CharCount(arg, '(') == 2))
            {
                return new IndirectArgument(arg);
            }
            return ImmediateArgument.ParseImmediateArgument(arg);
        }
    }
}
