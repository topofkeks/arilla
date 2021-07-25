using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Transembler.IAL.Arguments;

namespace RISCVSource.Arguments
{
    class LiteralArgument : ImmediateArgument, IALLiteralArgument
    {
        public LiteralArgument(string arg)
        {
            if (arg.StartsWith("0x"))
            {
                val = Convert.ToInt64(arg.Substring(2), 16);
            }
            else
            {
                val = Convert.ToInt64(arg);
            }
        }

        readonly long val;
        public long GetValue()
        {
            return val;
        }

        public override string ToString()
        {
            return "TI"+val.ToString();
        }

    }
}
