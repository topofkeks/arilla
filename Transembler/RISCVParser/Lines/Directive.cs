using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RISCVParser.Lines
{
    class Directive : AssemblyLine
    {
        public Directive(string line)
        {
            parseDirective(line);
        }

        private void parseDirective(string line)
        {
            if (line.Contains(' '))
            {
                name = line.Substring(1, line.IndexOf(' ') - 1);
                arguments = line.Substring(line.IndexOf(' ') + 1);
            }
            else
            {
                name = line;
                arguments = null;
            }
        }

        public override string ToString()
        {
            return "DIRECTIVE " + name;
        }

        public string name;
        public string arguments;
    }
}
