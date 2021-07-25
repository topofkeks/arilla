using ARILLADestination.Lines;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Transembler.IAL.Lines;

namespace ARILLADestination
{
    static class ARILLAEmitter
    {
        public static List<string> Emit(List<Line> lines) 
        {
            List<string> outLines = new List<string>();
            foreach (Line line in lines)
            {
                outLines.Add(line.Emit());
            }
            return outLines;
        }
    }
}
