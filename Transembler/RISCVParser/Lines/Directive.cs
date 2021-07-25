using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Transembler.IAL.Lines;

namespace RISCVSource.Lines
{
    class Directive : AssemblyLine, IALDirective
    {
        public Directive(string line)
        {
            ParseDirective(line);
        }

        public string name;
        public string arguments;

        private void ParseDirective(string line)
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

        public string GetName()
        {
            return name;
        }

        public string GetArgument()
        {
            return arguments;
        }

        public override string ToString()
        {
            return "DIRECTIVE " + name + " " + arguments;
        }
    }
}
