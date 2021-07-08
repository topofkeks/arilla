using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RISCVParser.Lines
{
    class Label : AssemblyLine
    {
        public Label(string line)
        {
            parseLabel(line);
        }

        private void parseLabel(string line)
        {
            name = line.Substring(0, line.Length - 1);
        }

        public override string ToString()
        {
            return "LABEL " + name;
        }

        public string name;
    }
}
