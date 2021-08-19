using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PeripheralSimulator
{
    interface Peripheral
    {
        uint getBaseAddress();
        uint getSize();
        void write(uint address,uint value);
        uint read(uint address);
    }
}
