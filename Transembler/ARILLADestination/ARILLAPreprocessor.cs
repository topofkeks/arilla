using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Transembler.IAL;
using Transembler.IAL.Lines;

namespace ARILLADestination
{
    static class ARILLAPreprocessor
    {
        public static List<IALLine> Preprocess(IALProgram program)
        {
            List<IALLine> IALLines = program.GetLines();

            return IALLines;
        }
    }
}
