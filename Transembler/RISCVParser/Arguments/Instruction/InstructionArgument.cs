using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RISCVParser.Arguments.Instruction
{
    class InstructionArgument : Argument
    {
        public static InstructionArgument parseInstructionArgument(string arg)
        {
            if (RegisterArgument.isRegister(arg))
            {
                return new RegisterArgument(arg);
            }
            if (arg.EndsWith(")") && (!arg.StartsWith("%") || Util.charCount(arg, '(') == 2))
            {
                return new IndirectArgument(arg);
            }
            return ImmediateArgument.parseImmediateArgument(arg);
        }
    }
}
