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

        public gpu()
        {
            InitializeComponent();

            Location = new Point(450, 10);

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
            int xs=(int)(regs[2]&0x3FF);
            int ys=(int)(regs[2]>>10);
            int xe=(int)(regs[3]&0x3FF);
            int ye=(int)(regs[3]>>10);
            switch (v)
            {
                case 0:
                    {
                        g.FillRectangle(sb, xs, ys,1,1);
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
                        g.DrawRectangle(p, xs, ys, xe-xs, ye-ys);
                        pbCanvas.Invalidate();
                        break;
                    }
                case 3:
                    {
                        g.FillRectangle(sb, xs, ys, xe-xs+1, ye-ys+1);
                        pbCanvas.Invalidate();
                        break;
                    }
                case 4:
                    {
                        Color c=bmp.GetPixel(xs, ys);
                        uint color = checked((((uint)(c.R) >> 4) << 28) | (((uint)(c.G) >> 4) << 24) | (((uint)(c.B) >> 4) << 20));
                        regs[1] &= ~0xFFF00000;
                        regs[1] |= color;
                        break;
                    }
            }
        }
    }
}
