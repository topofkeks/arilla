using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Transembler.IAL.Lines;

namespace RISCVSource.Lines
{
    abstract class AssemblyLine : IALLine
    {
        public static AssemblyLine ParseLine(string line)
        {
            if (line.StartsWith("#"))
            {
                return new Comment(line);
            }
            else if (line.EndsWith(":"))
            {
                return new Label(line);
            }
            else if (line.StartsWith("."))
            {
                return new Directive(line);
            }
            else
            {
                return new Instruction(line);
            }
        }
    }
}
