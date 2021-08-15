using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PeripheralSimulator
{
    public partial class gpu : Form, Peripheral
    {
        uint[] regs = new uint[4];

        Graphics g;
        Pen p;
        SolidBrush sb;
        Bitmap bmp;

        mouse m;

        public gpu(mouse m)
        {
            InitializeComponent();

            Location = new Point(450, 10);

            this.m = m;

            Updatetext();

            Show();
        }

        private void gpu_Load(object sender, EventArgs e)
        {
            bmp = new Bitmap(800, 600);
            g = Graphics.FromImage(bmp);
            pbCanvas.Image = bmp;
            p = new Pen(Color.Black);
            sb = new SolidBrush(Color.Black);
        }

        private void Updatetext()
        {
            bool on = (regs[0] & 1) != 0;
            bool cursor = (regs[0] & 4) != 0;
            Text = $"VGA 800x600 OUTPUT:{(on ? "ON" : "OFF")} CRUSOR:{(cursor ? "ON" : "OFF")}";
        }

        public uint getBaseAddress()
        {
            return 0x20000000;
        }

        public uint getSize()
        {
            return 4;
        }

        public uint read(uint address)
        {
            return regs[address - getBaseAddress()];
        }

        public void write(uint address, uint value)
        {
            if (address == getBaseAddress() && (value & 1) == 1 && (regs[0] & 1) == 0)
            {
                //Power ON
                regs[1] |= 1;
            }
            regs[address - getBaseAddress()] = value;
            if (address == getBaseAddress())
            {
                doWork();
            }
        }

        public void doWork()
        {
            this.Invoke(new Action(() =>
            {
                Updatetext();
                UpdateColor();
                if ((regs[0] & 2) != 0)
                {
                    regs[0] &= ~(uint)2;
                    regs[1] &= ~(uint)1;


                    doOpcode((regs[0] & 0xE0) >> 5);

                    regs[1] |= 1;
                }
            }));
        }

        private void UpdateColor()
        {
            uint blue = ((regs[0] >> 20) & 0xF) << 4;
            uint green = ((regs[0] >> 24) & 0xF) << 4;
            uint red = ((regs[0] >> 28) & 0xF) << 4;
            Color c = Color.FromArgb((int)red, (int)green, (int)blue);
            p.Color = c;
            sb.Color = c;
        }

        private void doOpcode(uint v)
        {
            int xs = (int)(regs[2] & 0x3FF);
            int ys = (int)(regs[2] >> 10);
            int xe = (int)(regs[3] & 0x3FF);
            int ye = (int)(regs[3] >> 10);
            switch (v)
            {
                case 0:
                    {
                        g.FillRectangle(sb, xs, ys, 1, 1);
                        pbCanvas.Invalidate();
                        break;
                    }
                case 1:
                    {
                        g.DrawLine(p, xs, ys, xe, ye);
                        pbCanvas.Invalidate();
                        break;
                    }
                case 2:
                    {
                        g.DrawRectangle(p, Math.Min(xs,xe), Math.Min(ys,ye),Math.Abs(xe - xs), Math.Abs(ye - ys));
                        pbCanvas.Invalidate();
                        break;
                    }
                case 3:
                    {
                        g.FillRectangle(sb, Math.Min(xs, xe), Math.Min(ys, ye), Math.Abs(xe - xs)+1, Math.Abs(ye - ys)+1);
                        pbCanvas.Invalidate();
                        break;
                    }
                case 4:
                    {
                        Color c = bmp.GetPixel(xs, ys);
                        uint color = checked((((uint)(c.R) >> 4) << 28) | (((uint)(c.G) >> 4) << 24) | (((uint)(c.B) >> 4) << 20));
                        regs[1] &= ~0xFFF00000;
                        regs[1] |= color;
                        break;
                    }
            }
        }

        private void gpu_MouseDown(object sender, MouseEventArgs e)
        {
            m.mouseDown(e);
        }

        private void gpu_MouseUp(object sender, MouseEventArgs e)
        {
            m.mouseUp(e);
        }

        private void gpu_MouseMove(object sender, MouseEventArgs e)
        {
            m.mouseMove(e);
        }

        public class mouse : Peripheral
        {
            uint[] regs = new uint[2];
            uint lastX = 0;
            uint lastY = 0;

            public uint getBaseAddress()
            {
                return 0x10000000;
            }

            public uint getSize()
            {
                return 2;
            }

            public uint read(uint address)
            {
                uint val = regs[address - getBaseAddress()];
                if (address == getBaseAddress() + 1)
                {
                    regs[1] &= ~(uint)8;
                }
                return val;
            }

            public void write(uint address, uint value)
            {
                regs[address - getBaseAddress()] = value;
            }

            internal void mouseDown(MouseEventArgs e)
            {
                if ((regs[0] & 1) != 0)
                {
                    if (e.Button == MouseButtons.Left)
                    {
                        regs[1] |= 2;
                    }
                    else
                    {
                        regs[1] |= 4;
                    }
                }
            }

            internal void mouseUp(MouseEventArgs e)
            {
                if ((regs[0] & 1) != 0)
                {
                    if (e.Button == MouseButtons.Left)
                    {
                        regs[1] &= ~(uint)2;
                    }
                    else
                    {
                        regs[1] &= ~(uint)4;
                    }
                }
            }

            internal void mouseMove(MouseEventArgs e)
            {
                uint x = (uint)Math.Min(Math.Max(0, e.X), 799);
                uint y = (uint)Math.Min(Math.Max(0, e.Y), 599);
                if (x!=lastX ||y!=lastY) {
                    regs[1] |= 8;
                    regs[1] &= 0xFFF;
                    regs[1] |= (x & 0x3FF) << 12;
                    regs[1] |= (y & 0x3FF) << 22;
                    lastX = x;
                    lastY = y;
                }
            }
        }
    }
}
