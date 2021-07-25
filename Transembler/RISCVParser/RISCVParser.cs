using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using RISCVSource.Lines;
using RISCVSource.Arguments;

namespace RISCVSource
{
    static class RISCVParser
    {
        public static List<AssemblyLine> Parse(List<string> stringLines)
        {
            List<AssemblyLine> lines = new List<AssemblyLine>();
            foreach (string sl in stringLines)
            {
                lines.Add(AssemblyLine.ParseLine(sl));
            }
            return lines;
        }
    }
}
