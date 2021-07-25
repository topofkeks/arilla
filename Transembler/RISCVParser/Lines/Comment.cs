using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Transembler.IAL.Lines;

namespace RISCVSource.Lines
{
    class Comment : AssemblyLine, IALComment
    {
        public Comment(string line)
        {
            text = line.Substring(1);
        }

        public string text;

        public string GetText()
        {
            return text;
        }

        public override string ToString()
        {
            return "COMMENT " + text;
        }
    }
}
