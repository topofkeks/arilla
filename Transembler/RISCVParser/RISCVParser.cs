using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using RISCVParser.Lines;
using RISCVParser.Arguments;
using RISCVParser.Arguments.Instruction;

namespace RISCVParser
{
    public class RISCVAssemblyParser :IDisposable
    {
        public RISCVAssemblyParser(Stream s) 
        {
            sr = new StreamReader(s);
        }

        private StreamReader sr;

        private List<string> preprocess()
        {
            List<string> ret = new List<string>();
            while (!sr.EndOfStream) 
            {
                string l = Util.removeExtraSpaces(sr.ReadLine().Trim());
                if (l.Equals(".Letext0:")) break;
                ret.Add(l);
            }
            return ret;
        }

        private List<AssemblyLine> parse(List<string> stringLines) 
        {
            List<AssemblyLine> lines = new List<AssemblyLine>();
            foreach (string sl in stringLines) 
            {
                lines.Add(AssemblyLine.parseLine(sl));
            }
            return lines;
        }

        public void Test()
        {
            List<AssemblyLine> lines = parse(preprocess());
            foreach (AssemblyLine line in lines)
            {
                if (line is Instruction)
                {
                    foreach (InstructionArgument argument in ((Instruction)line).arguments)
                    {
                        Console.WriteLine(argument);
                    }
                }
            }
        }

        public void Dispose()
        {
            sr.Dispose();
        }
    }
}
