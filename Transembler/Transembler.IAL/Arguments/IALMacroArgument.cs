using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Transembler.IAL.Arguments
{
    public interface IALMacroArgument : IALImmediateArgument
    {
        string GetMacro();
        IALImmediateArgument GetArgument();
    }
}
