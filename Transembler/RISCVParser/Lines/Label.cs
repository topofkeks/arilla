using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Transembler.IAL.Lines;

namespace RISCVSource.Lines
{
    class Label : AssemblyLine, IALLabel
    {
        public Label(string line)
        {
            ParseLabel(line);
        }

        public string name;

        private void ParseLabel(string line)
        {
            name = line.Substring(0, line.Length - 1);
        }

        public string GetName()
        {
            return name;
        }

        public override string ToString()
        {
            return "LABEL " + name;
        }
    }
}
