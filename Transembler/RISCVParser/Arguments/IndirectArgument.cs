using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Transembler.IAL.Arguments;

namespace RISCVSource.Arguments
{
    class IndirectArgument : Argument, IALIndirectArgument
    {
        public IndirectArgument(string arg)
        {
            arg = arg.Substring(0, arg.Length - 1);
            baseReg = new RegisterArgument(arg.Substring(arg.LastIndexOf('(')+1));
            ofs = ImmediateArgument.ParseImmediateArgument(arg.Substring(0, arg.LastIndexOf('(')));
        }

        public ImmediateArgument ofs;
        public RegisterArgument baseReg;

        public IALRegisterArgument GetBase()
        {
            return baseReg;
        }

        public IALImmediateArgument GetOffset()
        {
            return ofs;
        }

        public override string ToString()
        {
            return ofs.ToString()+"("+baseReg.ToString()+")";
        }
    }
}
