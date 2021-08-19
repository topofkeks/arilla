using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace mifgen
{
    class Program
    {
        static void Main(string[] args)
        {
            string infile = args[0];
            string outfile = args[1];

            string header = @"DEPTH = {0};
WIDTH = 32;
ADDRESS_RADIX = HEX;
DATA_RADIX = HEX;
CONTENT
BEGIN
";

            StreamReader sr = new StreamReader(infile);
            StreamWriter sw = new StreamWriter(outfile);

            List<string> lines = new List<string>();

            while (!sr.EndOfStream) 
            {
                lines.Add(sr.ReadLine());
            }

            sw.Write(string.Format(header, lines.Count));

            for (int i = 0; i < lines.Count; i++)
            {
                sw.WriteLine(i.ToString("x") + " : " + lines[i] + " ;");
            }

            sw.Write("END ;");

            sr.Dispose();
            sw.Dispose();
        }
    }
}
