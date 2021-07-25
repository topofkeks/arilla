using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Transembler.IAL.Arguments;

namespace Transembler.IAL.Lines
{
    public interface IALInstruction : IALLine
    {
        string GetOpcode();
        List<IALArgument> GetArguments();
    }
}
