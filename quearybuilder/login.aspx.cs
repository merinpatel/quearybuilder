using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace quearybuilder
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loginin(object sender, EventArgs e)
        {
            var useremail = textbox1.Text;
            string password = textbox2.Text;

            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["employeeConnectionString4"].ToString();
            con.Open();

            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "select password from login where useremail= @username;";
            cmd.Parameters.AddWithValue("@username", useremail);

            cmd.Connection = con;


            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);

            if (dt.Rows.Count == 0)
            {

                textbox4.Text = "user email not register";
                Response.Redirect("signup.aspx");
            }
            else
            {

                if ( dt.Rows[0]["password"].ToString().Trim()==password.Trim())
                {

                    Session["username"] = textbox1.Text;
                  
                    Response.Redirect("/");
                }
                else
                {
                    textbox4.Text = "check password";
                }


            }



        }

       
    }
}