using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Transembler.IAL.Lines
{
    public interface IALDirective : IALLine
    {
        string GetName();
        string GetArgument();
    }
}
