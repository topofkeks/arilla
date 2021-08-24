using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LineDrawerSimulator
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Random r = new Random();

            Graphics g = CreateGraphics();

            int cnt = Convert.ToInt32(textBox1.Text);
            for (int i = 0; i < cnt; i++)
            {
                int xs = r.Next(0, 800);
                int xe = r.Next(0, 800);
                int ys = r.Next(0, 600);
                int ye = r.Next(0, 600);

                listBox1.Items.Add($"Line ({xs},{ys}) to ({xe},{ye})");

                g.DrawLine(Pens.Red, xs, ys, xe, ye);

                DrawLineManual(g, Brushes.Black, xs, ys, xe, ye);

            }
        }

        private void DrawLineManual(Graphics g, Brush black, int xs, int ys, int xe, int ye)
        {
            int dx = Math.Abs(xe - xs);
            int sx = xs < xe ? 1 : -1;
            int dy = -Math.Abs(ye - ys);
            int sy = ys < ye ? 1 : -1;
            int err = dx + dy;
            while (true)
            {
                g.FillRectangle(black, xs, ys, 1, 1);
                listBox1.Items.Add($"({xs},{ys})");
                if (xs == xe && ys == ye) { break; }
                int e2 = 2 * err;
                if (e2 >= dy)
                {
                    err += dy;
                    xs += sx;
                }
                if (e2 <= dx)
                {
                    err += dx;
                    ys += sy;
                }
            }
        }

        private void listBox1_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            listBox1.Items.Clear();
            CreateGraphics().Clear(SystemColors.Control);
        }
    }
}
