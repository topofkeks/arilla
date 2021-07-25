using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ARILLADestination;
using RISCVSource;
using Transembler.IAL;
using Transembler.IAL.Lines;

namespace Transembler.App
{
    class Program
    {
        static void Main(string[] args)
        {
            RISCVIALProducer p;
            if (args.Length > 0)
            {
                p = new RISCVIALProducer(new FileStream(args[0], FileMode.Open));
            }
            else if (File.Exists("RISCV.asm"))
            {
                p = new RISCVIALProducer(new FileStream("RISCV.asm", FileMode.Open));
            }
            else 
            {
                Console.WriteLine("NO FILE");
                return;
            }

            IALProgram prog = p.GetProgram();
            ARILLAIALConsumer c = new ARILLAIALConsumer(prog);
            c.Emit(Console.OpenStandardOutput());
            p.Dispose();

        }
    }
}
