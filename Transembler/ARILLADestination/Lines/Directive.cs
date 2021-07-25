using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Transembler.IAL.Lines;

namespace ARILLADestination.Lines
{
    class Directive : Line
    {
        internal static void TranslateDirective(IALDirective directive, List<Line> outLines)
        {
            string name = directive.GetName();
            if (name[0] != '.') 
            {
                outLines.Add(new Directive(directive));
            }
        }

        public Directive(IALDirective directive) 
        {
            name = directive.GetName();
            argument = directive.GetArgument();
        }

        private readonly string name;
        private readonly string argument;

        public override string Emit()
        {
            return "." + name + " " + argument;
        }
    }
}
