using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RISCVParser.Arguments.Instruction
{
    class IndirectArgument : InstructionArgument
    {
        public IndirectArgument(string arg)
        {
            arg = arg.Substring(0, arg.Length - 1);
            baseReg = new RegisterArgument(arg.Substring(arg.LastIndexOf('(')+1));
            ofs = ImmediateArgument.parseImmediateArgument(arg.Substring(0, arg.LastIndexOf('(')));
        }

        public ImmediateArgument ofs;
        public RegisterArgument baseReg;

        public override string ToString()
        {
            return ofs.ToString()+"("+baseReg.ToString()+")";
        }
    }
}
