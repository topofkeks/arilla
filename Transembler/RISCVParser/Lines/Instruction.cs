using RISCVParser.Arguments;
using RISCVParser.Arguments.Instruction;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RISCVParser.Lines
{
    class Instruction : AssemblyLine
    {
        public Instruction(string line)
        {
            arguments = new List<InstructionArgument>();
            parseInstruction(line);
        }

        private void parseInstruction(string line)
        {
            if (line.Contains(' '))
            {
                name = line.Substring(0, line.IndexOf(' '));
                string[] stringargs = line.Substring(line.IndexOf(' ') + 1).Split(',');
                foreach (string arg in stringargs)
                {
                    arguments.Add(InstructionArgument.parseInstructionArgument(arg));
                }
            }
            else
            {
                name = line;
            }
        }

        public override string ToString()
        {
            return "INSTRUCTION " + name;
        }

        public string name;
        public List<InstructionArgument> arguments;
    }
}
