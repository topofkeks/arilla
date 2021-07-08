using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RISCVParser.Arguments.Instruction
{
    class LabelArgument : ImmediateArgument
    {
        public LabelArgument(string arg) 
        {
            label = arg;
        }

        string label;

        public override string ToString()
        {
            return "LA"+label;
        }
    }
}
