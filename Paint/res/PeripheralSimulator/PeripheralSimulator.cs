using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PeripheralSimulator
{
    public partial class PeripheralSimulator : Form
    {
        Thread t;
        List<Peripheral> peripherals;
        bool run = false;
        bool exited = true;
        bool log = false;

        public PeripheralSimulator()
        {
            InitializeComponent();

            Location = new Point(10, 10);

            InitializePeripherals();
        }

        private void PeripheralSimulator_Load(object sender, EventArgs e)
        {

        }

        private void lbDebug_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            lbDebug.Items.Clear();
        }

        private void PeripheralSimulator_FormClosing(object sender, FormClosingEventArgs e)
        {
            run = false;

            while (exited == false) { Application.DoEvents(); }
        }

        private void btnRun_Click(object sender, EventArgs e)
        {
            btnRun.Enabled = false;
            run = true;
            exited = false;
            t = new Thread(() => threadFunc(tbExe.Text));
            t.Start();
        }

        private void threadFunc(string exePath)
        {

            ProcessStartInfo psi = new ProcessStartInfo(exePath);
            psi.UseShellExecute = false;
            psi.RedirectStandardOutput = true;
            psi.RedirectStandardInput = true;
            //psi.CreateNoWindow = true;
            psi.WindowStyle = ProcessWindowStyle.Minimized;
            Process p = new Process();
            p.StartInfo = psi;
            p.Start();

            while (run)
            {
                string line = p.StandardOutput.ReadLine();
                if (line == null) { break; }
                if (line.Contains(':'))
                {
                    int ind = line.IndexOf(':');
                    uint addr = Convert.ToUInt32(line.Substring(0, ind), 16);
                    uint value = Convert.ToUInt32(line.Substring(ind + 1), 16);
                    if (log)
                    {
                        lbDebug.Invoke(new Action(() =>
                        {
                            lbDebug.Items.Add($"0x{value.ToString("X8")} => 0x{addr.ToString("X8")}");
                            lbDebug.SelectedIndex = lbDebug.Items.Count - 1;
                        }));
                    }
                    write(addr, value);
                }
                else
                {
                    uint addr = Convert.ToUInt32(line, 16);
                    uint value = read(addr);
                    if (log)
                    {
                        lbDebug.Invoke(new Action(() =>
                        {
                            lbDebug.Items.Add($"0x{value.ToString("X8")} <= 0x{addr.ToString("X8")}");
                            lbDebug.SelectedIndex = lbDebug.Items.Count - 1;
                        }));
                    }
                    p.StandardInput.WriteLine("0x" + value.ToString("X8"));
                }
            }


            p.Kill();

            exited = true;
        }

        private void write(uint addr, uint value)
        {
            foreach (Peripheral peripheral in peripherals)
            {
                uint basea = peripheral.getBaseAddress();
                uint size = peripheral.getSize();
                if (addr >= basea && addr < basea + size)
                {
                    peripheral.write(addr, value);
                    break;
                }
            }
        }

        private uint read(uint addr)
        {
            foreach (Peripheral peripheral in peripherals)
            {
                uint basea = peripheral.getBaseAddress();
                uint size = peripheral.getSize();
                if (addr >= basea && addr < basea + size)
                {
                    return peripheral.read(addr);
                }
            }
            return 0;
        }

        private void InitializePeripherals()
        {
            peripherals = new List<Peripheral>();

            //Add peripherals here

            peripherals.Add(new gpu());

            //
        }

        private void cbLog_CheckedChanged(object sender, EventArgs e)
        {
            log = cbLog.Checked;
        }
    }
}
