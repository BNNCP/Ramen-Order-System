using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace MidTermFinal
{
    public partial class Register : Form
    {
        public Register()
        {
            InitializeComponent();
        }

        private void txtName_Enter(object sender, EventArgs e)
        {
            if (txtName.Text == "姓名")
                txtName.Text = null;

            txtName.ForeColor = Color.Black;
        }

        private void txtName_Leave(object sender, EventArgs e)
        {
            if (txtName.Text == "")
            {
                txtName.Text = "姓名";
                txtName.ForeColor = Color.Black;
            }
        }

        private void txtContact_Leave(object sender, EventArgs e)
        {
            if (txtContact.Text == "")
            {
                txtContact.Text = "聯絡電話";
                txtContact.ForeColor = Color.Black;
            }
        }

        private void txtContact_Enter(object sender, EventArgs e)
        {
            if(txtContact.Text == "聯絡電話")
                txtContact.Text = null;

            txtContact.ForeColor = Color.Black;
        }

        private void lbl_exit_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void textAddress_Enter(object sender, EventArgs e)
        {
            if (textAddress.Text == "地址")
                textAddress.Text = null;

            textAddress.ForeColor = Color.Black;
        }

        private void textAddress_Leave(object sender, EventArgs e)
        {
            if (textAddress.Text == "")
            {
                textAddress.Text = "地址";
                textAddress.ForeColor = Color.Black;
            }
        }

        private void textEmail_Leave(object sender, EventArgs e)
        {
            if (textEmail.Text == "")
            {
                textEmail.Text = "Email";
                textEmail.ForeColor = Color.Black;
            }
        }

        private void textEmail_Enter(object sender, EventArgs e)
        {
            if (textEmail.Text == "Email")
                textEmail.Text = null;

            textEmail.ForeColor = Color.Black;
        }

        private void btnRegister_Click(object sender, EventArgs e)
        {
            bool EmailCheck = IsValidEmail(textEmail.Text);
            if(txtName.Text != ""&&txtContact.Text !=""&& textAddress.Text != ""&& EmailCheck ==true&&txtAccount.Text != ""&& txtPassword.Text!="")
            {
                SqlConnection con = new SqlConnection(GlobalConnection.strMyDBConnectionsString);
                con.Open();
                string stringSQL = "Insert into customer values(@name,@contact,@birthday,@address,null,@account,@password,@email)";
                SqlCommand cmd = new SqlCommand(stringSQL, con);
                cmd.Parameters.AddWithValue("@name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@contact", txtContact.Text.Trim());
                cmd.Parameters.AddWithValue("@birthday", dtpBirthday.Value);
                cmd.Parameters.AddWithValue("@address", textAddress.Text.Trim());
                cmd.Parameters.AddWithValue("@account", txtAccount.Text.Trim());
                cmd.Parameters.AddWithValue("@password",txtPassword.Text.Trim());
                cmd.Parameters.AddWithValue("@email",textEmail.Text.Trim());
                cmd.ExecuteNonQuery();
                MessageBox.Show("註冊成功");
                con.Close();
                this.Close();
            }
            else
            {
                MessageBox.Show("尚有欄位未填寫或是格式錯誤","警告" , MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
        }

        public bool IsValidEmail(string eMail)
        {
            bool Result = false;

            try
            {
                var eMailValidator = new System.Net.Mail.MailAddress(eMail);

                Result = (eMail.LastIndexOf(".") > eMail.LastIndexOf("@"));
            }
            catch
            {
                Result = false;
            };

            return Result;
        }

        private void txtContact_KeyPress(object sender, KeyPressEventArgs e)
        {
                if (((int)e.KeyChar < 48 | (int)e.KeyChar > 57) & (int)e.KeyChar != 8||txtContact.Text.Length>=10)
                {
                    e.Handled = true;
                }
        }
    }
}
