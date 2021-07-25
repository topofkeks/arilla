using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Transembler.IAL.Lines;

namespace ARILLADestination.Lines
{
    abstract class Line
    {
        public static void TranslateLine(IALLine line, List<Line> outLines)
        {
            if (line is IALInstruction instruction)
            {
                Instruction.TranslateInstruction(instruction, outLines);
            }
            else if (line is IALDirective directive)
            {
                Directive.TranslateDirective(directive, outLines);
            }
            else if (line is IALLabel label)
            {
                Label.TranslateLabel(label, outLines);
            }
            else if (line is IALComment comment)
            {
                Comment.TranslateComment(comment, outLines);
            }
            else
            {
                throw new Exception("Line is not of a known type");
            }
        }

        public abstract string Emit();
    }
}
