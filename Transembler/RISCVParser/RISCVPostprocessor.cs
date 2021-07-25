using RISCVSource.Lines;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Transembler.IAL.Lines;

namespace RISCVSource
{
    static class RISCVPostprocessor
    {
        public static List<IALLine> Postprocess(List<AssemblyLine> assemblyLines) 
        {
            List<IALLine> IALLines=assemblyLines.ConvertAll(x=>(IALLine)x);

            return IALLines;
        }
    }
}
