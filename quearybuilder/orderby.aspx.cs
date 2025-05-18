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
    public partial class orderby : System.Web.UI.Page
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
                  
                    SqlDataSource2.SelectCommand = $@"
                SELECT TABLE_NAME 
                FROM INFORMATION_SCHEMA.TABLES 
                WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_CATALOG = @Database";

                  
                    SqlDataSource2.SelectParameters.Add("Database", database);
                }
            }

        }
        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
        
            string selectedTable = DropDownList2.SelectedValue;

            
            SqlDataSource1.SelectCommand = $@"
        SELECT COLUMN_NAME
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = '{selectedTable}'";

            SqlDataSource3.SelectCommand = $@"
        SELECT COLUMN_NAME
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = '{selectedTable}'";



         
            DropDownList3.DataBind();
  
            CheckBoxList2.DataBind();
        }



        protected void additeam(object sender, EventArgs e)
        {



            var statement = textbox9.Text;
            var val1 = DropDownList3.SelectedValue;
            var val2 = textbox7.Text;
            var val4 = DropDownList4.SelectedValue;

            textbox9.Text = statement + val4 + " " + val1 + "=" + "'" + val2 + "'";

            textbox7.Text = "";


        }

        protected void additeam1(object sender, EventArgs e)
        {

            var statement = textbox1.Text;
            var val1 = DropDownList1.SelectedValue;
         
            var val4 = DropDownList5.SelectedValue;

            textbox1.Text = statement + val4 + " " + val1;

        }


        protected void run(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["employeeConnectionString2"].ToString();
            con.Open();

            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = textbox8.Text;

            cmd.Connection = con;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            GridView1.DataSource = dt;
            GridView1.DataBind();

            con.Close();


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
            cmd.Parameters.AddWithValue("@querydescription", textbox8.Text);

            cmd.Connection = con;

            int a = cmd.ExecuteNonQuery();

            if (a > 0)
            {
                Response.Redirect("/");
            }


        }
    }
}