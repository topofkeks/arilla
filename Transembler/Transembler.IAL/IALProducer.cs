using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Transembler.IAL
{
    public interface IALProducer
    {
        IALProgram GetProgram();

        void SetInputStream(Stream s);
    }
}
