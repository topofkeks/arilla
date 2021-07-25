using RISCVSource.Lines;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Transembler.IAL;
using Transembler.IAL.Lines;

namespace RISCVSource
{
    public class RISCVIALProducer : IDisposable, IALProducer
    {
        public RISCVIALProducer() 
        {
            program = null;
        }

        public RISCVIALProducer(Stream s)
        {
            sr = new StreamReader(s);
            program = null;
        }

        private StreamReader sr;
        private IALProgram program;

        public IALProgram GetProgram()
        {
            if (program == null) 
            {
                ProduceProgram();
            }
            return program;
        }

        private void ProduceProgram()
        {
            if (sr == null) 
            {
                throw new InvalidOperationException("Source stream is not set");
            }
            List<string> lines = RISCVPreprocessor.Preprocess(sr);
            List<AssemblyLine> assemblyLines = RISCVParser.Parse(lines);
            List<IALLine> IALLines = RISCVPostprocessor.Postprocess(assemblyLines);
            program = new RISCVProgram() { Lines = IALLines, Architecture = new RISCVArchitecture() };
        }

        public void SetInputStream(Stream s)
        {
            sr?. Dispose();
            sr = new StreamReader(s);
            program = null;
        }

        public void Dispose()
        {
            sr.Dispose();
        }
    }
}
