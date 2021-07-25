using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RISCVSource
{
    static class RISCVPreprocessor
    {
        public static List<string> Preprocess(StreamReader sr) 
        {
            List<string> lines = new List<string>();
            while (!sr.EndOfStream)
            {
                string l = Util.RemoveExtraSpaces(sr.ReadLine().Trim().Replace('\t',' '));
                if (l.Equals(".Letext0:")) break;
                lines.Add(l);
            }
            return lines;
        }
    }
}
