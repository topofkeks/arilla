using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Transembler.IAL;
using Transembler.IAL.Lines;

namespace RISCVSource
{
    class RISCVProgram : IALProgram
    {
        public RISCVArchitecture Architecture { get; set; }
        public List<IALLine> Lines { get; set; }

        public IALArchitecture GetAchitecture()
        {
            return Architecture;
        }

        public List<IALLine> GetLines()
        {
            return Lines;
        }
    }
}
