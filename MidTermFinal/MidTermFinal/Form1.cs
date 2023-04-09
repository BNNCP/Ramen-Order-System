using MidTermFinal.Cart;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Runtime.InteropServices;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace MidTermFinal
{
    public partial class RamenKing : Form
    {
        public RamenKing()
        {
            SqlConnectionStringBuilder scsb = new SqlConnectionStringBuilder();
            scsb.DataSource = @".";
            scsb.InitialCatalog = "Ramen";
            scsb.IntegratedSecurity = true;
            GlobalConnection.strMyDBConnectionsString = scsb.ConnectionString;
            InitializeComponent();
        }

        bool AbstractAccountGetter(string table, string account, string password)
        {
            bool isOK = false;
            SqlConnection con = new SqlConnection(GlobalConnection.strMyDBConnectionsString);
            con.Open();
            string strSQL = $"select * from {table} where account = @acc and password = @pw";
            SqlCommand cmd = new SqlCommand(strSQL, con);
            cmd.Parameters.AddWithValue("@acc", account);
            cmd.Parameters.AddWithValue("@pw", password);
            SqlDataReader reader = cmd.ExecuteReader();
            if(reader.Read())
            {
                try
                {
                    if(table == "customer")
                    {
                        GlobalConnection.UserID = Convert.ToInt32(reader["c_id"]);
                    }
                    else if(table == "employee")
                    {
                        GlobalConnection.UserID = Convert.ToInt32(reader["e_id"]);
                    }
                    GlobalConnection.Authority = Convert.ToInt32(reader["a_id"]);
                }
                catch
                {
                    isOK = true;
                    return isOK;
                }
                isOK = true;
                return isOK;
            }
            else
            {
                return isOK;
            }
            
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            if(txtAccount.Text!= ""|| txtPassword.Text != "")
            {
                string account = txtAccount.Text;
                string password = txtPassword.Text;
                AbstractAccountGetter("customer", account, password);
                AbstractAccountGetter("employee", account, password);
                bool customercheck = AbstractAccountGetter("customer", account, password);
                bool employeecheck = AbstractAccountGetter("employee", account, password);

                MessageBox.Show($"{GlobalConnection.Authority}     {employeecheck}  ");
                if (GlobalConnection.Authority == 1|| GlobalConnection.Authority == 4&& (customercheck ==true||
                employeecheck==true))
                {
                    MainForm mymain = new MainForm();
                    MessageBox.Show("登入成功");
                    if (GlobalConnection.Authority == 1)
                    {
                        mymain.HideButton();
                    }
                    mymain.ShowDialog();
                    Close();
                }
                else if (GlobalConnection.Authority == 5 && employeecheck == true)
                {
                    SqlConnection con = new SqlConnection(GlobalConnection.strMyDBConnectionsString);
                    con.Open();
                    string strSQL = $"select * from Attendance where e_id = @e_id";
                    SqlCommand cmd = new SqlCommand(strSQL, con);
                    cmd.Parameters.AddWithValue("@e_id", GlobalConnection.UserID);
                    SqlDataReader reader = cmd.ExecuteReader();
                    
                    if (reader.Read())
                    {
                        MessageBox.Show($"{GlobalConnection.Authority}     {employeecheck}  ");
                        if (DateTime.Now.Hour <= 18 && DateTime.Now.Hour >= 9 && reader["onduty"] == null && reader["offduty"] == null)
                        {
                            OndutyCheck();
                            MessageBox.Show("打卡成功");
                        }
                        else if (DateTime.Now.Hour <= 18 && DateTime.Now.Hour >= 9 && reader["onduty"] != null && reader["offduty"] == null)
                        {
                            MessageBox.Show("您已經打卡過！");
                            return;
                        }
                        else if (DateTime.Now.Hour >= 18 && DateTime.Now.Hour <= 24 && reader["onduty"] != null && reader["offduty"] == null)
                        {
                            OffdutyCheck();
                            MessageBox.Show("打卡成功");
                        }
                        else if (DateTime.Now.Hour >= 18 && DateTime.Now.Hour <= 24 && reader["onduty"] != null && reader["offduty"] != null)
                        {
                            MessageBox.Show("您已經打卡過！");
                        }
                    }
                    else
                    {
                        if (DateTime.Now.Hour <= 18 && DateTime.Now.Hour >= 9)
                        {
                            OndutyCheck();
                            MessageBox.Show("打卡成功");
                        }
                    }
                    reader.Close();
                    con.Close();
                }
                else if(GlobalConnection.Authority < 1 && (customercheck == true ||
                employeecheck == true))
                {
                    MessageBox.Show("權限不足");
                    return;
                }
                else
                {
                    MessageBox.Show("登入失敗");
                }
            }
        }

        public void OndutyCheck()
        {
            SqlConnection con = new SqlConnection(GlobalConnection.strMyDBConnectionsString);
            con.Open();
            string strSQL = $"Insert into Attendance(e_id,onduty) values(@e_id,@onduty)";
            SqlCommand cmd = new SqlCommand(strSQL, con);
            cmd.Parameters.AddWithValue("@e_id", GlobalConnection.UserID);
            cmd.Parameters.AddWithValue("@onduty", DateTime.Now.ToString("yyyy-MM-dd hh:mm"));
            cmd.ExecuteNonQuery();
            con.Close();
        }

        public void OffdutyCheck()
        {
            SqlConnection con = new SqlConnection(GlobalConnection.strMyDBConnectionsString);
            con.Open();
            string strSQL = $"Insert into Attendance(offduty) values(@offduty) where att_id = @e_id, day(onduty) = day(@offduty)";
            SqlCommand cmd = new SqlCommand(strSQL, con);
            cmd.Parameters.AddWithValue("@e_id", GlobalConnection.UserID);
            cmd.Parameters.AddWithValue("@offduty", DateTime.Now.ToString("yyyy-MM-dd hh:mm"));
            cmd.ExecuteNonQuery();
            con.Close();
        }

        private void lbl_exit_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void btnRegister_Click(object sender, EventArgs e)
        {
            Register register = new Register();
            register.ShowDialog();
        }
    }
}
