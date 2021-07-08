using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RISCVParser.Arguments.Instruction
{
    class TrueImmediateArgument : ImmediateArgument
    {
        public TrueImmediateArgument(string arg)
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

        long val;

        public override string ToString()
        {
            return "TI"+val.ToString();
        }
    }
}
