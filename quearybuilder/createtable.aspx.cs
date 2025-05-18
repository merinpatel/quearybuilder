using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace quearybuilder
{
    public partial class createtable : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            
        }


        protected void Savequery(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["employeeConnectionString2"].ToString();
            con.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "insert into querystr values (@useremail,@querystring,@querydescription);";
            cmd.Parameters.AddWithValue("@useremail", Session["username"]);
            cmd.Parameters.AddWithValue("@querystring", textbox14.Text);
            cmd.Parameters.AddWithValue("@querydescription", textbox16.Text);

            cmd.Connection = con;

            int a = cmd.ExecuteNonQuery();

            if (a > 0)
            {
                Response.Redirect("/");
            }


        }

        //private void LoadTables()
        //{
        //    string query = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE'";
        //    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["employeeConnectionString6"].ConnectionString);
        //    SqlCommand cmd = new SqlCommand(query, con);

        //    con.Open();
        //    ddlForeignTable.DataSource = cmd.ExecuteReader();
        //    ddlForeignTable.DataTextField = "TABLE_NAME";
        //    ddlForeignTable.DataValueField = "TABLE_NAME";
        //    ddlForeignTable.DataBind();
        //    con.Close();
        //}


        //protected void getfiled(object sender, EventArgs e)
        //{
        //    string selectedTable = ddlForeignTable.SelectedItem.ToString();
        //    Response.Write("<script>alert('Hello " + selectedTable + "');</script>");

        //    if (!string.IsNullOrEmpty(selectedTable))
        //    {
        //        string query = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableName";

        //        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["employeeConnectionString6"].ConnectionString))
        //        {
        //            using (SqlCommand cmd = new SqlCommand(query, con))
        //            {
        //                cmd.Parameters.AddWithValue("@TableName", selectedTable);
        //                con.Open();

        //                SqlDataReader reader = cmd.ExecuteReader();
        //                ddlForeignColumn.DataSource = reader;
        //                ddlForeignColumn.DataTextField = "COLUMN_NAME";
        //                ddlForeignColumn.DataValueField = "COLUMN_NAME";
        //                ddlForeignColumn.DataBind();

        //                con.Close();
        //            }
        //        }
        //    }
        //}


        protected void button16_Click(object sender, EventArgs e)
        {
            string dbName = hiddenDbName.Value; // 👈 Get DB name from hidden field

            if (string.IsNullOrWhiteSpace(dbName))
            {
                Response.Write("<script>alert('Database name not found in local storage');</script>");
                return;
            }

            if (!string.IsNullOrEmpty(textbox16.Text))
            {
                try
                {
                    // 🔄 Build connection string dynamically
                    string connStr = $"Data Source=MERIN\\MSSQLSERVER01;Initial Catalog={dbName};Integrated Security=True;";

                    using (SqlConnection con = new SqlConnection(connStr))
                    {
                        con.Open();

                        // Optional: Get DB user (for granting permissions, if needed)
                        string currentUserQuery = "SELECT SUSER_NAME();";
                        string databaseUser;

                        using (SqlCommand userCmd = new SqlCommand(currentUserQuery, con))
                        {
                            databaseUser = userCmd.ExecuteScalar().ToString();
                        }

                        // Optional: Grant CREATE TABLE (only needed once per user per DB)
                        string grantQuery = $"GRANT CREATE TABLE TO [{databaseUser}];";
                        using (SqlCommand grantCmd = new SqlCommand(grantQuery, con))
                        {
                            grantCmd.ExecuteNonQuery();
                        }

                        // 🧱 Execute the CREATE TABLE query
                        using (SqlCommand cmd = new SqlCommand(textbox16.Text, con))
                        {
                            cmd.ExecuteNonQuery();
                        }
                    }

                    // ✅ Success message and UI update
                    SiteMaster master = (SiteMaster)this.Master;
                    if (master != null)
                    {
                        Response.Write("<script>alert('Table created successfully!'); window.location='/';</script>");
                        master.go(this, EventArgs.Empty);
                    }
                }
                catch (SqlException ex)
                {
                    Response.Write("<script>alert('SQL Error: " + ex.Message.Replace("'", "\\'") + "');</script>");
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "\\'") + "');</script>");
                }
            }
        }


    }
}