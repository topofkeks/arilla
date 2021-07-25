using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Transembler.IAL.Lines;

namespace ARILLADestination.Lines
{
    class Comment : Line
    {
        public static void TranslateComment(IALComment comment, List<Line> outLines)
        {
            outLines.Add(new Comment(comment));
        }

        public Comment (IALComment comment) 
        {
            text = comment.GetText();
        }

        public string text;

        public override string Emit()
        {
            return "//" + text;
        }

    }
}
