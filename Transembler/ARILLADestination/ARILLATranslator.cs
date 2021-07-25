using ARILLADestination.Lines;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Transembler.IAL.Lines;

namespace ARILLADestination
{
    static class ARILLATranslator
    {
        public static List<Line> Translate(List<IALLine> IALLines) 
        {
            List<Line> ARILLALines = new List<Line>();
            foreach (IALLine line in IALLines)
            {
                Line.TranslateLine(line,ARILLALines);
            }
            return ARILLALines;
        }
    }
}
