using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RISCVParser.Lines
{
    class AssemblyLine
    {
        public static AssemblyLine parseLine(string line)
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
