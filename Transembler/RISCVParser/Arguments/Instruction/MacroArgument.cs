using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RISCVParser.Arguments.Instruction
{
    class MacroArgument : ImmediateArgument
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
            imm = ImmediateArgument.parseImmediateArgument(arg.Substring(arg.IndexOf("(") + 1));
        }

        public MACRO macro;
        public ImmediateArgument imm;

        public enum MACRO{ LO,HI };

        public override string ToString()
        {
            return macro.ToString()+imm.ToString();
        }
    }
}
