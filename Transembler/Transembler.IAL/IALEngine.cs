using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Transembler.IAL
{
    public interface IALEngine
    {

        void Transemble(Stream inputStream, Stream outputStream);
    }

    public interface IALEngine<Producer, Consumer> where Producer : IALProducer where Consumer : IALConsumer
    {
        void Transemble(Stream inputStream, Stream outputStream);
    }
}
