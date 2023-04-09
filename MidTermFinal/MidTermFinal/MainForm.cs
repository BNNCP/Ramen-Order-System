using Google.Protobuf.Collections;
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
using System.Xml.Linq;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.Button;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using TextBox = System.Windows.Forms.TextBox;
using Button = System.Windows.Forms.Button;
using MidTermFinal.Cart;
using System.Text.RegularExpressions;
using static ServiceStack.Script.Lisp;
using System.Linq.Expressions;

namespace MidTermFinal
{
    public partial class MainForm : Form
    {
        bool SlideBarExpand;
        List<GlobalProduct> Products;
        CartBox cartBox;
        Label Label加料;
        TextBox TextBox加料;
        List<TextBox> ListTextBox加料;
        List<Label> ListLabel加料;
        Decimal TotalPrice;
        Decimal sumtemp;
        int ordercount = 1; //計算o_id+1

        public MainForm()
        {
            Products = new List<GlobalProduct>();
            cartBox = new CartBox();
            ListTextBox加料 = new List<TextBox>();
            ListLabel加料 = new List<Label>();
            InitializeComponent();
        }

        private void MainForm_Load(object sender, EventArgs e)
        {
            
            LoadData();
            ListViewPic();
            加料Spawn(2,3);
            Insert硬度();
            Insert鹹度();
            LoadUser(GlobalConnection.UserID);
      
        }

        public void LoadUser(int user)
        {
            SqlConnection con = new SqlConnection(GlobalConnection.strMyDBConnectionsString);
            con.Open();
            string strSQL = "select * from customer where c_id = @user";
            SqlCommand cmd = new SqlCommand(strSQL, con);
            cmd.Parameters.AddWithValue("@user", user);
            SqlDataReader reader = cmd.ExecuteReader();
            if(reader.Read())
            {
                txtName.Text = reader["c_name"].ToString();
                txtContact.Text = reader["c_contact"].ToString();
            }
            reader.Close();
            con.Close();
        }

        public void Insert鹹度()
        {
            SqlConnection con = new SqlConnection(GlobalConnection.strMyDBConnectionsString);
            con.Open();
            string strSQL = "select * from 鹹度";
            SqlCommand cmd = new SqlCommand(strSQL, con);
            SqlDataReader reader = cmd.ExecuteReader();
            while(reader.Read())
            {
                combo鹹度.Items.Add(reader["鹹度_desc"].ToString());
            }
            reader.Close();
            con.Close();
        }
        public void Insert硬度()
        {
            SqlConnection con = new SqlConnection(GlobalConnection.strMyDBConnectionsString);
            con.Open();
            string strSQL = "select * from 硬度";
            SqlCommand cmd = new SqlCommand(strSQL, con);
            SqlDataReader reader = cmd.ExecuteReader();
            while(reader.Read())
            {
                combo硬度.Items.Add(reader["硬度_desc"].ToString());
            }
            reader.Close(); 
            con.Close();   
        }

        public void 加料Spawn(int x, int y)
        {
            int Count = 0;
            SqlConnection con = new SqlConnection(GlobalConnection.strMyDBConnectionsString);
            con.Open();
            string strSQL = "select * from Addons";
            SqlCommand cmd = new SqlCommand(strSQL, con);
            SqlDataReader reader = cmd.ExecuteReader();
            
            for (int i = 0; i < x; i++)
            {
                for (int j = 0; j < y; j++)
                {
                    TextBox加料 = new TextBox();
                    TextBox加料.TextChanged += TextBox加料_TextChanged;
                    TextBox加料.Font = new Font("微軟正黑體", 15, FontStyle.Bold);
                    TextBox加料.Location = new Point(175 + 325 * i, 345 + 50 * j);
                    TextBox加料.Name = $"TextBox加料{Count}";
                    TextBox加料.KeyPress += TextBox加料_KeyPress;
                    lvMenu.Controls.Add(TextBox加料);
                    ListTextBox加料.Add(TextBox加料);


                    Label加料 = new Label();
                    Label加料.Size = new Size(200, 40);
                    Label加料.Font = new Font("微軟正黑體", 15, FontStyle.Bold);
                    Label加料.ForeColor = Color.White;
                    Label加料.Location = new Point(50 + 300 * i, 350 + 50 * j);
                    lvMenu.Controls.Add(Label加料);
                    ListLabel加料.Add(Label加料);

                    Count++;
                }
            }
            int tempcount = 0;
            while (reader.Read())
            {
                ListLabel加料[tempcount].Text = $"{reader["a_name"]}  {reader["a_price"]}元";
                tempcount++;
            }
            reader.Close();
            con.Close();
        }
        private void TextBox加料_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar != 8 && !Char.IsDigit(e.KeyChar)&& lvMenu.SelectedItems.Count < 1)
            {
                e.Handled = true;
            }
        }

        private void TextBox加料_TextChanged(object sender, EventArgs e)
        {
            if (lvMenu.SelectedItems.Count >= 1)
            {
                sumtemp = 0;
                int count = 0;
                for (int i = 0; i < ListTextBox加料.Count; i++)
                {
                    if (ListTextBox加料[i].Text!= "")
                    {
                        SqlConnection con = new SqlConnection(GlobalConnection.strMyDBConnectionsString);
                        con.Open();
                        string strSQL = "select * from Addons where a_id = @i";
                        SqlCommand cmd = new SqlCommand(strSQL, con);
                        count = i + 1;
                        cmd.Parameters.AddWithValue("@i", count);
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            sumtemp += (Decimal)reader["a_price"] * Convert.ToDecimal(ListTextBox加料[i].Text);
                        }
                        reader.Close();
                        con.Close();
                    }
                }
                
                PriceChange();
            }
        }

        public void PriceChange()
        {

                TotalPrice = 0;
                SqlConnection con = new SqlConnection(GlobalConnection.strMyDBConnectionsString);
                con.Open();
                string strSQL = "select * from products where p_id = @id";
                SqlCommand cmd = new SqlCommand(strSQL, con);
                cmd.Parameters.AddWithValue("@id", lvMenu.SelectedItems[0].Tag);
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    TotalPrice = (Decimal)reader["p_price"] + sumtemp;
                    lblPrice.Text = $"價格：{TotalPrice}元";
                }
                reader.Close();
                con.Close();
            
        }

        public void LoadData()
        {
            SqlConnection con = new SqlConnection(GlobalConnection.strMyDBConnectionsString);
            con.Open();
            string strSQL = "select * from products";
            SqlCommand cmd = new SqlCommand(strSQL, con);
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                Products.Add(new GlobalProduct
                {
                    p_id = (int)reader["p_id"],
                    p_name = reader["p_name"].ToString(),
                    p_price = (decimal)reader["p_price"],
                    p_desc = reader["p_description"].ToString(),
                    p_image = reader["p_picture"].ToString()
                });
            }
            for(int i = 0;i < Products.Count; i++)
            {
                string fulladress = GlobalConnection.image_dir + Products[i].p_image;
                Image imgProduct = Image.FromFile(fulladress);
                imageListProduct.Images.Add(imgProduct);
            }
            reader.Close();
            con.Close();
        }
       
        public void ListViewPic()
        {
            lvMenu.Clear();
            lvMenu.View = View.LargeIcon;//LargeIcon, SmallIcon, List, Tile
            imageListProduct.ImageSize = new Size(256, 256);
            lvMenu.LargeImageList = imageListProduct;//LargeIcon, Tile
            lvMenu.SmallImageList = imageListProduct;//SmallIcon, List
            for (int i = 0; i < imageListProduct.Images.Count; i += 1)
            {
                ListViewItem item = new ListViewItem();
                item.ImageIndex = i;
                item.Font = new Font("微軟正黑體", 14, FontStyle.Regular);
                item.ForeColor= Color.White;
                item.Text = $"{Products[i].p_name} {Products[i].p_price}元";
                item.Tag = Products[i].p_id;
                lvMenu.Items.Add(item);
            }
        }

        public void HideButton()
        {
                btnEdit.Hide();
                btnAdd.Hide();
                btnEmployee.Hide();
                btnMember.Hide();
        }

        private void slidebarTimer_Tick(object sender, EventArgs e)
        {
            if(SlideBarExpand)
            {
                SlideBar.Width -= 35;
                if(SlideBar.Width==SlideBar.MinimumSize.Width)
                {
                    SlideBarExpand = false;
                    slidebarTimer.Stop();
                }
            }
            else
            {
                SlideBar.Width += 35;
                if(SlideBar.Width==SlideBar.MaximumSize.Width)
                {
                    SlideBarExpand = true;
                    slidebarTimer.Stop();
                }
            }
        }

        private void picMenu_Click(object sender, EventArgs e)
        {
            slidebarTimer.Start();
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            Close();
        }
        public void btnEnterColorChange(Button button)
        {
            button.BackColor= Color.SlateGray;
        }

        public void btnLeaveColorChange(Button button)
        {
            button.BackColor = Color.LightSlateGray;
        }

        private void btnHome_MouseEnter(object sender, EventArgs e)
        {
            btnEnterColorChange(btnHome);
        }

        private void btnHome_MouseLeave(object sender, EventArgs e)
        {
            btnLeaveColorChange(btnHome);
        }

        private void btnExit_MouseEnter(object sender, EventArgs e)
        {
            btnEnterColorChange(btnExit);
        }

        private void btnExit_MouseLeave(object sender, EventArgs e)
        {
            btnLeaveColorChange(btnExit);
        }

        private void btnEdit_MouseEnter(object sender, EventArgs e)
        {
            if(btnEdit.Visible==true)
            {
                btnEnterColorChange(btnEdit);
            }
            
        }

        private void btnEdit_MouseLeave(object sender, EventArgs e)
        {
            if (btnEdit.Visible==true)
            {
                btnLeaveColorChange(btnEdit);
            }
            
        }

        private void btnAdd_MouseEnter(object sender, EventArgs e)
        {
            if(btnAdd.Visible==true)
            {
                btnEnterColorChange(btnAdd);
            }
            
        }

        private void btnAdd_MouseLeave(object sender, EventArgs e)
        {
            if (btnAdd.Visible==true)
            {
                btnLeaveColorChange(btnAdd);
            }
            
        }

        private void btnCart_MouseEnter(object sender, EventArgs e)
        {
            btnEnterColorChange(btnCart);
        }

        private void btnCart_MouseLeave(object sender, EventArgs e)
        {
            btnLeaveColorChange(btnCart);
        }

        private void btnMember_MouseEnter(object sender, EventArgs e)
        {
            if(btnMember.Visible==true)
            {
                btnEnterColorChange(btnMember);
            }
            
        }

        private void btnMember_MouseLeave(object sender, EventArgs e)
        {
            if(btnMember.Visible== true)
            {
                btnLeaveColorChange(btnMember);
            }
            
        }

        private void btnEmployee_MouseEnter(object sender, EventArgs e)
        {
            if(btnEmployee.Visible==true)
            {
                btnEnterColorChange(btnEmployee);
            }
           
        }

        private void btnEmployee_MouseLeave(object sender, EventArgs e)
        {
            if(btnEmployee.Visible==true)
            {
                btnLeaveColorChange(btnEmployee);
            }
            
        }

        private void btnCart_Click(object sender, EventArgs e)
        {
            if (GlobalConnection.Authority == 4)
            {
                BtnRemoveAll.Visible = false;
                BtnRemoveSelected.Visible = false;
                btnSubmit.Visible = false;
            }
            panelCartList.Visible = true;
            LoadCartList();
            CartTotal();
            panelHome.Visible = false;
            panelEdit.Visible = false;
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            panelHome.Visible = false;
            panelCartList.Visible = false;
            panelEdit.Visible = true;
        }

        private void btnHome_Click(object sender, EventArgs e)
        {
            panelHome.Visible = true;
            panelCartList.Visible = false;
            panelEdit.Visible = false;
        }
        public void ClearTextbox()
        {
            for(int i = 0; i<ListTextBox加料.Count; i++)
            {
                ListTextBox加料[i].Clear();
            }
            combo硬度.SelectedIndex = -1;
            combo鹹度.SelectedIndex = -1;
            
            PriceChange();
        }

        public void DescChange()
        {
            SqlConnection con = new SqlConnection(GlobalConnection.strMyDBConnectionsString);
            con.Open();
            string strSQL = "select * from products where p_id = @id";
            SqlCommand cmd = new SqlCommand(strSQL, con);
            cmd.Parameters.AddWithValue("@id", lvMenu.SelectedItems[0].Tag);
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                lblDescription.Text = reader["p_description"].ToString();
            }
            reader.Close();
            con.Close();
        }

        private void lvMenu_MouseClick(object sender, MouseEventArgs e)
        {
            PriceChange();
            ClearTextbox();
            DescChange();
        }

        private void btnAddtoCart_MouseLeave(object sender, EventArgs e)
        {
            btnLeaveColorChange(btnAddtoCart);
        }

        private void btnAddtoCart_MouseEnter(object sender, EventArgs e)
        {
            btnEnterColorChange(btnAddtoCart);
        }

        private void btnAddtoCart_Click(object sender, EventArgs e)
        {
            if (lvMenu.SelectedItems.Count < 1)
            {
                MessageBox.Show("請選擇拉麵口味");
            }
            else if (combo鹹度.SelectedIndex == -1)
            {
                MessageBox.Show("請選擇湯頭濃度");
            }
            else if (combo硬度.SelectedIndex == -1)
            {
                MessageBox.Show("請選擇麵條硬度");
            }
            else
            {
                SqlConnection con = new SqlConnection(GlobalConnection.strMyDBConnectionsString);
                con.Open();
                string strSQL = "select * from products where p_id = @p_id";
                SqlCommand cmd = new SqlCommand(strSQL, con);
                cmd.Parameters.AddWithValue("@p_id", lvMenu.SelectedItems[0].Tag);
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    Orders RamenOrder = new Orders()
                    {
                        p_id = (int)reader["p_id"],
                        硬度_id = combo硬度.SelectedIndex + 1,
                        鹹度_id = combo鹹度.SelectedIndex + 1,
                        price = TotalPrice
                    };
                    reader.Close();

                    strSQL = "select top(1)* from cart order by cart_id desc";
                    cmd = new SqlCommand(strSQL, con);
                    reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        RamenOrder.cart_id = (int)reader["cart_id"] + 1;
                    }
                    cartBox.RamenOrder.Add(RamenOrder);
                    reader.Close();
                }
                reader.Close();
                con.Close();
                for (int i = 0; i < ListTextBox加料.Count; i++)
                {
                    if (ListTextBox加料[i].Text.Trim() != "")
                    {
                        SqlConnection con2 = new SqlConnection(GlobalConnection.strMyDBConnectionsString);
                        con2.Open();
                        strSQL = "select * from addons where a_id = @a_id";
                        cmd = new SqlCommand(strSQL, con2);
                        cmd.Parameters.AddWithValue("@a_id", i+1);
                        reader = cmd.ExecuteReader();
                        if(reader.Read()) 
                        {
                            Addons_Order addons = new Addons_Order()
                            {
                                a_id = (int)reader["a_id"],
                                ao_quantity = Convert.ToInt32(ListTextBox加料[i].Text)
                            };
                            reader.Close();
                            strSQL = "select top(1)* from Orders order by o_id desc";
                            cmd = new SqlCommand(strSQL, con2);
                            reader = cmd.ExecuteReader();
                            if (reader.Read())
                            {
                                addons.o_id = (int)reader["o_id"]+ordercount;
                            }
                            cartBox.RamenOrder[cartBox.RamenOrder.Count-1].AddonsOrder.Add(addons);
                            reader.Close();
                            con2.Close();
                        }
                    }
                }
                ClearTextbox();
                lblPrice.Text = "價格：";
                lvMenu.SelectedIndices.Clear();
                ordercount++;
                MessageBox.Show("加入成功！");
            }
        }
        //PanelHome

        public void LoadCartList()
        {
            if(GlobalConnection.Authority==1)
            {
                if (cartBox.RamenOrder.Count > 0)
                {
                    listCart.Items.Clear();
                    for (int i = 0; i < cartBox.RamenOrder.Count; i++)
                    {
                        string 口味 = "";
                        string 硬度 = "";
                        string 濃度 = "";
                        SqlConnection con = new SqlConnection(GlobalConnection.strMyDBConnectionsString);
                        con.Open();
                        string strSQL = "select * from products where p_id = @p_id";
                        SqlCommand cmd = new SqlCommand(strSQL, con);
                        cmd.Parameters.AddWithValue("@p_id", cartBox.RamenOrder[i].p_id);
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            口味 = reader["p_name"].ToString();
                        }
                        reader.Close();
                        strSQL = "select * from 硬度 where 硬度_id = @硬度_id";
                        cmd = new SqlCommand(strSQL, con);
                        cmd.Parameters.AddWithValue("@硬度_id", cartBox.RamenOrder[i].硬度_id);
                        reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            硬度 = reader["硬度_desc"].ToString();
                        }
                        reader.Close();
                        strSQL = "select * from 鹹度 where 鹹度_id = @鹹度_id";
                        cmd = new SqlCommand(strSQL, con);
                        cmd.Parameters.AddWithValue("@鹹度_id", cartBox.RamenOrder[i].鹹度_id);
                        reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            濃度 = reader["鹹度_desc"].ToString();
                        }
                        Decimal 價格 = cartBox.RamenOrder[i].price;
                        string itemInfo = $"{口味}          麵條硬度：{硬度}          湯頭濃度：{濃度}          價格：{價格}";
                        listCart.Items.Add(itemInfo);
                        reader.Close();
                        con.Close();
                    }
                }
            }
            else if (GlobalConnection.Authority == 4)
            {
                GlobalConnection.TotalCart = 0;
                listCart.Items.Clear();
                MessageBox.Show("好");
                Decimal 總價;
                string 姓名;
                string 電話;
                DateTime 日期;
                SqlConnection con = new SqlConnection(GlobalConnection.strMyDBConnectionsString);
                con.Open();
                string strSQL = "select ca.cart_id,cu.c_name,cu.c_contact,ca.cart_salesdate,sum(Isnull(p.p_price,0)+Isnull(a.a_price,0)*Isnull(ao.ao_quantity,0)) as Total from customer as cu full join cart as ca on (cu.c_id = ca.c_id)  full join orders as o on(ca.cart_id = o.cart_id)  full join Products as p on (o.p_id = p.p_id)  full join [Addons Order]as ao on (o.o_id = ao.o_id)  full join addons as a on (ao.a_id=a.a_id) where ca.cart_id is not null and month(ca.cart_salesdate) = month(GETDATE()) group by ca.cart_id,cu.c_name,cu.c_contact,ca.cart_salesdate;";
                SqlCommand cmd = new SqlCommand(strSQL, con);
                SqlDataReader reader = cmd.ExecuteReader();
                while(reader.Read())
                {
                    姓名 = reader["c_name"].ToString();
                    電話 = reader["c_contact"].ToString();
                    日期 = (DateTime)reader["cart_salesdate"];
                    總價 = (Decimal)reader["Total"];
                    GlobalConnection.TotalCart += 總價;
                    string itemInfo = $"{姓名}          電話：{電話}          訂購日期：{日期}          價格：{總價}";
                    listCart.Items.Add(itemInfo);

                }
               
                reader.Close();
                con.Close();
            }
        }

        public void CartTotal()
        {
            if(GlobalConnection.Authority==1)
            {
                Decimal total = 0;
                for (int i = 0; i < cartBox.RamenOrder.Count; i++)
                {
                    total += cartBox.RamenOrder[i].price;
                }
                lblCartTotalPrice.Text = "總價：" + total.ToString() + "元";
            }
            else if(GlobalConnection.Authority==4)
            {
                lblCartTotalPrice.Text = "本月營業額：" + GlobalConnection.TotalCart.ToString() + "元";
            }
        }

        private void BtnRemoveSelected_Click(object sender, EventArgs e)
        {
            if (listCart.SelectedIndices.Count > 0)
            {
                ordercount -= listCart.SelectedIndices.Count;
                for (int i = (listCart.SelectedIndices.Count - 1); i >= 0; i--)
                {
                    
                    cartBox.RamenOrder.RemoveAt(listCart.SelectedIndices[i]);
                    listCart.Items.RemoveAt(listCart.SelectedIndices[i]);
                   
                }
            }
            LoadCartList();
            CartTotal();
        }

        private void BtnRemoveAll_Click(object sender, EventArgs e)
        {
            ordercount = 1;
            cartBox.RamenOrder.Clear();
            listCart.Items.Clear();
            LoadCartList();
            CartTotal();
        }

        private void btnSubmit_Click(object sender, EventArgs e)
        {
            DialogResult R = MessageBox.Show("確定送出訂單", "訂單送出確認", MessageBoxButtons.YesNo, MessageBoxIcon.Question);

            if (R == DialogResult.Yes)
            {
                SqlConnection con = new SqlConnection(GlobalConnection.strMyDBConnectionsString);
                con.Open();
                string strSQL = "Insert into cart values(@c_id,@cart_salesdate)";
                SqlCommand cmd = new SqlCommand(strSQL, con);
                cmd.Parameters.AddWithValue("@c_id",GlobalConnection.UserID);
                cmd.Parameters.AddWithValue("cart_salesdate",DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                cmd.ExecuteNonQuery();

                MessageBox.Show(cartBox.RamenOrder[0].cart_id.ToString());
                for(int i =0; i < cartBox.RamenOrder.Count;i++)
                {
                    Decimal tempDecimal=0;
                    int tempid = 0;
                    strSQL = "Insert into Orders values(@cart,@p_id,@硬度_id,@鹹度_id);"+ "Update Ingredients set i_quantity=i_quantity-@r_quantity where i_id = @i_id;";
                    string strSQL2 = "select * from recipe where p_id = @p_id;";
                    SqlCommand cmd2 = new SqlCommand(strSQL2, con);
                    cmd2.Parameters.AddWithValue("@p_id", cartBox.RamenOrder[i].p_id);
                    SqlDataReader reader = cmd2.ExecuteReader();
                    if (reader.Read())
                    {
                        tempDecimal = (Decimal)reader["r_quantity"];
                        tempid = (int)reader["i_id"];
                    }
                    reader.Close();
                    cmd = new SqlCommand(strSQL, con);
                    
                    cmd.Parameters.AddWithValue("@cart", cartBox.RamenOrder[0].cart_id);
                    cmd.Parameters.AddWithValue("@p_id", cartBox.RamenOrder[i].p_id);
                    cmd.Parameters.AddWithValue("@硬度_id", cartBox.RamenOrder[i].硬度_id);
                    cmd.Parameters.AddWithValue("@鹹度_id", cartBox.RamenOrder[i].鹹度_id);
                    cmd.Parameters.AddWithValue("@r_quantity", tempDecimal);
                    cmd.Parameters.AddWithValue("@i_id", tempid);
                    cmd.ExecuteNonQuery();
                   
                    
                    
                }


                for (int i = 0;i<cartBox.RamenOrder.Count;i++)
                {
                    for(int j =0; j < cartBox.RamenOrder[i].AddonsOrder.Count;j++)
                    {
                        Decimal tempDecimal = 0;
                        int tempid = 0;
                        strSQL = "Insert into [Addons Order] values(@o_id,@a_id,@ao_quantity);"+"Update Ingredients set i_quantity=i_quantity-@ar_quantity where i_id =@i_id;";
                        string strSQL2 = "Select * from [Addon Recipe] where a_id = @a_id;";
                        SqlCommand cmd2 = new SqlCommand(strSQL2, con);
                        cmd2.Parameters.AddWithValue("@a_id", (int)cartBox.RamenOrder[i].AddonsOrder[j].a_id);
                        SqlDataReader reader = cmd2.ExecuteReader();
                        if (reader.Read())
                        {
                            tempDecimal = (Decimal)reader["ar_quantity"];
                            tempid = (int)reader["i_id"];
                        }
                        reader.Close();
                        cmd = new SqlCommand(strSQL, con);
                        cmd.Parameters.AddWithValue("@o_id", (int)cartBox.RamenOrder[i].AddonsOrder[j].o_id);
                        cmd.Parameters.AddWithValue("@a_id", (int)cartBox.RamenOrder[i].AddonsOrder[j].a_id);
                        cmd.Parameters.AddWithValue("@ao_quantity", (int)cartBox.RamenOrder[i].AddonsOrder[j].ao_quantity);
                        cmd.Parameters.AddWithValue("@ar_quantity", tempDecimal);
                        cmd.Parameters.AddWithValue("@i_id", tempid);
                        cmd.ExecuteNonQuery();
                        
                    }
                }
                con.Close();
                MessageBox.Show("送出訂單成功！");
                this.Close();
            }
            else
            {
                return;
            }
        }

        private void listCart_DoubleClick(object sender, EventArgs e)
        {
            if(GlobalConnection.Authority==1)
            {
                string 加料 = "";
                if (listCart.SelectedIndex < 0)
                {
                    return;
                }

                for (int i = 0; i < cartBox.RamenOrder[listCart.SelectedIndex].AddonsOrder.Count; i++)
                {
                    SqlConnection con = new SqlConnection(GlobalConnection.strMyDBConnectionsString);
                    con.Open();
                    string strSQL = "select * from addons where a_id = @a_id";
                    SqlCommand cmd = new SqlCommand(strSQL, con);
                    cmd.Parameters.AddWithValue("@a_id", cartBox.RamenOrder[listCart.SelectedIndex].AddonsOrder[i].a_id);
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        加料 += $"{reader["a_name"]}  {cartBox.RamenOrder[listCart.SelectedIndex].AddonsOrder[i].ao_quantity}個    {cartBox.RamenOrder[listCart.SelectedIndex].AddonsOrder[i].ao_quantity * (Decimal)reader["a_price"]}元\n";
                    }
                    reader.Close();
                    con.Close();
                }

                MessageBox.Show($"==============加料品項==============\n{加料}");
            }
            else if(GlobalConnection.Authority==4)
            {
                return;
            }
        }
    }
}
