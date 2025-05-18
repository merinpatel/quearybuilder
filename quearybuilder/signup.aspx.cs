using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace quearybuilder
{
    public partial class signup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void register(object sender, EventArgs e)
        {
            var useremail = textbox1.Text;
            var password = textbox2.Text;

            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["employeeConnectionString2"].ToString();
            con.Open();

            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select * from login where useremail= @username;";
            cmd.Parameters.AddWithValue("@username", useremail);
            
            cmd.Connection = con;


            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt= new DataTable();
            adapter.Fill(dt);

            if(dt.Rows.Count==0)
            {
                cmd.CommandText = "insert into login  values(@useremail,@password);";
                cmd.Parameters.AddWithValue("@useremail", useremail);
                cmd.Parameters.AddWithValue ("@Password", password);
                int a=cmd.ExecuteNonQuery();
                if (a > 0)
                {
                    Response.Redirect("login.aspx");
                }
                con.Close();
            }
            else
            {
                textbox4.Text = "email is alrady register";
                 
            }



        }
    }
}