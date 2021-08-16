
namespace PeripheralSimulator
{
    partial class PeripheralSimulator
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.tbExe = new System.Windows.Forms.TextBox();
            this.btnRun = new System.Windows.Forms.Button();
            this.lbDebug = new System.Windows.Forms.ListBox();
            this.cbLog = new System.Windows.Forms.CheckBox();
            this.SuspendLayout();
            // 
            // tbExe
            // 
            this.tbExe.Location = new System.Drawing.Point(0, 0);
            this.tbExe.Name = "tbExe";
            this.tbExe.Size = new System.Drawing.Size(306, 20);
            this.tbExe.TabIndex = 0;
            this.tbExe.Text = "D:\\Faks\\4.Semestar\\AR\\arilla\\Paint\\bin\\Debug\\Paint.exe";
            // 
            // btnRun
            // 
            this.btnRun.Location = new System.Drawing.Point(350, 0);
            this.btnRun.Name = "btnRun";
            this.btnRun.Size = new System.Drawing.Size(50, 20);
            this.btnRun.TabIndex = 1;
            this.btnRun.Text = "Run";
            this.btnRun.UseVisualStyleBackColor = true;
            this.btnRun.Click += new System.EventHandler(this.btnRun_Click);
            // 
            // lbDebug
            // 
            this.lbDebug.Font = new System.Drawing.Font("Consolas", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lbDebug.FormattingEnabled = true;
            this.lbDebug.ItemHeight = 15;
            this.lbDebug.Location = new System.Drawing.Point(0, 20);
            this.lbDebug.Name = "lbDebug";
            this.lbDebug.Size = new System.Drawing.Size(400, 784);
            this.lbDebug.TabIndex = 2;
            this.lbDebug.MouseDoubleClick += new System.Windows.Forms.MouseEventHandler(this.lbDebug_MouseDoubleClick);
            // 
            // cbLog
            // 
            this.cbLog.AutoSize = true;
            this.cbLog.Location = new System.Drawing.Point(306, 2);
            this.cbLog.Name = "cbLog";
            this.cbLog.Size = new System.Drawing.Size(44, 17);
            this.cbLog.TabIndex = 3;
            this.cbLog.Text = "Log";
            this.cbLog.UseVisualStyleBackColor = true;
            this.cbLog.CheckedChanged += new System.EventHandler(this.cbLog_CheckedChanged);
            // 
            // PeripheralSimulator
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(400, 804);
            this.Controls.Add(this.cbLog);
            this.Controls.Add(this.lbDebug);
            this.Controls.Add(this.btnRun);
            this.Controls.Add(this.tbExe);
            this.DoubleBuffered = true;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.MaximumSize = new System.Drawing.Size(416, 843);
            this.MinimumSize = new System.Drawing.Size(416, 843);
            this.Name = "PeripheralSimulator";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.Manual;
            this.Text = "PeripheralSimulator";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.PeripheralSimulator_FormClosing);
            this.Load += new System.EventHandler(this.PeripheralSimulator_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox tbExe;
        private System.Windows.Forms.Button btnRun;
        private System.Windows.Forms.ListBox lbDebug;
        private System.Windows.Forms.CheckBox cbLog;
    }
}

