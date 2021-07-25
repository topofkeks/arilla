using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Transembler.IAL.Arguments;

namespace RISCVSource.Arguments
{
    class MacroArgument : ImmediateArgument, IALMacroArgument
    {
        public MacroArgument(string arg) 
        {
            if (arg.StartsWith("%lo"))
            {
                macro = MACRO.LO;
            }
            else 
            {
                macro = MACRO.HI;
            }
            arg= arg.Substring(0, arg.Length - 1);
            imm = ImmediateArgument.ParseImmediateArgument(arg.Substring(arg.IndexOf("(") + 1));
        }
        public enum MACRO{ LO,HI };

        public MACRO macro;
        public ImmediateArgument imm;

        public string GetMacro()
        {
            return macro.ToString();
        }

        public IALImmediateArgument GetArgument()
        {
            return imm;
        }

        public override string ToString()
        {
            return macro.ToString()+imm.ToString();
        }
    }
}
