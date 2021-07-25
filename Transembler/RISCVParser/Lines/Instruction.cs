using RISCVSource.Arguments;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Transembler.IAL.Arguments;
using Transembler.IAL.Lines;

namespace RISCVSource.Lines
{
    class Instruction : AssemblyLine, IALInstruction
    {
        public Instruction(string line)
        {
            arguments = new List<IALArgument>();
            ParseInstruction(line);
        }

        public string name;
        public List<IALArgument> arguments;

        private void ParseInstruction(string line)
        {
            if (line.Contains(' '))
            {
                name = line.Substring(0, line.IndexOf(' '));
                string[] stringargs = line.Substring(line.IndexOf(' ') + 1).Split(',');
                foreach (string arg in stringargs)
                {
                    arguments.Add(Argument.ParseInstructionArgument(arg));
                }
            }
            else
            {
                name = line;
            }
        }

        public string GetOpcode()
        {
            return name;
        }

        public List<IALArgument> GetArguments()
        {
            return arguments;
        }

        public override string ToString()
        {
            string ret = "INSTRUCTION " + name + " ";
            foreach (IALArgument arg in arguments)
            {
                ret += arg.ToString() + " ";
            }
            return ret;
        }
    }
}
