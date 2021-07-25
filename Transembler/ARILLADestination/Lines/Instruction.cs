using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Transembler.IAL.Lines;

namespace ARILLADestination.Lines
{
    class Instruction : Line
    {
        public static void TranslateInstruction(IALInstruction instruction, List<Line> outLines)
        {

        }



        public override string Emit()
        {
            return "";
        }

    }
}