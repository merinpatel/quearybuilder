using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using Microsoft.Ajax.Utilities;

namespace quearybuilder
{
    public partial class delete : System.Web.UI.Page
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

            
        //    SqlDataSource1.SelectCommand = $@"
        //SELECT COLUMN_NAME
        //FROM INFORMATION_SCHEMA.COLUMNS
        //WHERE TABLE_NAME = '{selectedTable}'";

            SqlDataSource3.SelectCommand = $@"
        SELECT COLUMN_NAME
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = '{selectedTable}'";



            // Update the SelectCommand of SqlDataSource1 to fetch columns for the selected table
            DropDownList3.DataBind();


            // Rebind the CheckBoxList to refresh the data
         
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


        protected void run(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["employeeConnectionString2"].ToString();
            con.Open();

            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = textbox8.Text;

            cmd.Connection = con;

            int a = cmd.ExecuteNonQuery();

            if (a > 0)
            {
                //SqlConnection con = new SqlConnection();

                getdata();

                //SqlCommand cmd = new SqlCommand();
                

            }

          


        }
        protected void getdata()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["employeeConnectionString2"].ToString();
            string tableName = DropDownList2.SelectedValue; 

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                 
                string query = $"SELECT * FROM {tableName};";

                using (SqlCommand cmd1 = new SqlCommand(query, con))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd1);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
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