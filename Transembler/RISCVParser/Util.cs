using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RISCVSource
{
    static class Util
    {
        public static string RemoveExtraSpaces(string s)
        {
            StringBuilder sb = new StringBuilder();

            for (int i = 0; i < s.Length - 1; i++)
            {
                if (s[i] == ' ')
                {
                    if (s[i + 1] != ' ')
                    {
                        sb.Append(s[i]);
                    }
                }
                else
                {
                    sb.Append(s[i]);
                }
            }
            sb.Append(s[s.Length - 1]);

            return sb.ToString();
        }

        public static int CharCount(string s, char c)
        {
            int cnt = 0;
            foreach (char chr in s)
            {
                if (chr == c)
                {
                    cnt++;
                }
            }

            return cnt;
        }
    }
}
