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
    public partial class select : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string database = textbox11.Text;
            if (Session["username"] == null)
            {
                Response.Redirect("login.aspx");
            }

            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(database))
                {
                    // Update the SqlDataSource SelectCommand
                    SqlDataSource2.SelectCommand = $@"
                SELECT TABLE_NAME 
                FROM INFORMATION_SCHEMA.TABLES 
                WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_CATALOG = @Database";

                    // Add a parameter to prevent SQL injection
                    SqlDataSource2.SelectParameters.Add("Database", database);
                }
            }

        }
        protected void Indexchange(object sender, EventArgs e)

        {


            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["employeeConnectionString2"].ToString();
            con.Open();

            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "SELECT COUNT(COLUMN_NAME) AS ColumnCount FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @name;";
            cmd.Parameters.AddWithValue("@name", DropDownList1.SelectedItem.Text);
            cmd.Connection = con;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable(); 
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                number.Text = dt.Rows[0]["ColumnCount"].ToString(); 
            }

            con.Close();






        }

        protected void Run(object sender, EventArgs e)
        {
          


            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["employeeConnectionString2"].ToString();
            con.Open();

            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = textbox6.Text;
           
            cmd.Connection = con;

            int a=cmd.ExecuteNonQuery();

            if (a > 0)
            {
                Response.Write("ok");
            }


        }

        protected void save(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["employeeConnectionString2"].ToString();
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "insert into querystr values (@useremail,@querystring,@querydescription);";
            cmd.Parameters.AddWithValue("@useremail", Session["username"]);
            cmd.Parameters.AddWithValue("@querystring", filename.Text);
            cmd.Parameters.AddWithValue("@querydescription", textbox6.Text);

            cmd.Connection = con;

            int a = cmd.ExecuteNonQuery();

            if (a > 0)
            {
                Response.Redirect("/");
            }


        }
    }
}