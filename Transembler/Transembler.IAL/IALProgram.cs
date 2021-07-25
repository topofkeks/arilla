using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Transembler.IAL.Lines;

namespace Transembler.IAL
{
    public interface IALProgram
    {
        List<IALLine> GetLines();
        IALArchitecture GetAchitecture();
    }
}
