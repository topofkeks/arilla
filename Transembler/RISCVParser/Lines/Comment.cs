using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RISCVParser.Lines
{
    class Comment : AssemblyLine
    {
        public Comment(string line)
        {
            text = line.Substring(1);
        }

        public override string ToString()
        {
            return "COMMENT " + text;
        }

        public string text;
    }
}
