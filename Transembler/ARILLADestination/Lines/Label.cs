using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Transembler.IAL.Lines;

namespace ARILLADestination.Lines
{
    class Label : Line
    {
        public static void TranslateLabel(IALLabel label, List<Line> outLines)
        {
            outLines.Add(new Label(label));
        }

        public Label(IALLabel label) 
        {
            name = label.GetName(); ;
            if (name[0] == '.') 
            {
                name = "_dot" + name.Substring(1);
            }
        }

        private readonly string name;

        public override string Emit()
        {
            return name + ":";
        }

    }
}
