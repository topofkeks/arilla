using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Transembler.IAL.Arguments;

namespace RISCVSource.Arguments
{
    class LabelArgument : ImmediateArgument, IALLabelArgument
    {
        public LabelArgument(string arg) 
        {
            label = arg;
        }

        readonly string label;

        public string GetName()
        {
            return label;
        }

        public override string ToString()
        {
            return "LA"+label;
        }
    }
}
