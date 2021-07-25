using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Transembler.IAL
{
    public interface IALConsumer
    {
        void Emit(Stream s);

        void SetProgram(IALProgram prog);
    }
}
