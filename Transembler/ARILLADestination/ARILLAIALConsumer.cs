using ARILLADestination.Lines;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Transembler.IAL;
using Transembler.IAL.Lines;

namespace ARILLADestination
{
    public class ARILLAIALConsumer : IALConsumer
    {
        public ARILLAIALConsumer() 
        {
            outputLines = null;
        }

        public ARILLAIALConsumer(IALProgram prog) 
        {
            program = prog;
            outputLines = null;
        }

        private IALProgram program;
        private List<string> outputLines;

        public void Emit(Stream s)
        {
            StreamWriter sw = new StreamWriter(s);
            if (outputLines == null) 
            {
                ProduceOutputLines();
            }
            foreach (string line in outputLines)
            {
                sw.WriteLine(line);
            }
            sw.Dispose();
        }

        private void ProduceOutputLines()
        {
            List<IALLine> IALLines = ARILLAPreprocessor.Preprocess(program);
            List<Line> ARILALines = ARILLATranslator.Translate(IALLines);
            List<string> lines = ARILLAEmitter.Emit(ARILALines);
            outputLines = ARILLAPostprocessor.Postprocess(lines);
        }

        public void SetProgram(IALProgram prog)
        {
            program = prog;
            outputLines = null;
        }
    }
}
