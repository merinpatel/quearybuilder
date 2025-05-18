using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Drawing;

namespace quearybuilder
{
    public partial class SiteMaster :MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["username"] == null)
            {
                string script = $@"
    <script>
        localStorage.setItem('database', '');
        localStorage.setItem('listItems', '');
    </script>";

                Page.ClientScript.RegisterStartupScript(this.GetType(), "SetLocalStorage", script);
            }


            if (!IsPostBack)
           {

                LoadDatabaseAndTables();



                string useremail = Session["username"] as string;

                if (Session["username"]==null)
                {
                    string script = $@"
    <script>
        localStorage.setItem('database', '');
        localStorage.setItem('listItems', '');
    </script>";

                    Page.ClientScript.RegisterStartupScript(this.GetType(), "SetLocalStorage", script);
                }


                SqlDataSource2.SelectCommand = $@"
                 SELECT * from [querystr] where useremail='{useremail}'";


                SqlDataSource4.SelectCommand = $@"
SELECT [querystring], [querydescription] FROM [querystr] where useremail='{useremail}'";
           }
            
        }


       
        public void go(object sender, EventArgs e)
        {


            if (Session["username"] == null)
            {
               
                Response.Redirect("login.aspx");
            }
            else
            {
                string selectedTable = textbox10.Text;



                // Update the SelectCommand of SqlDataSource1 to fetch columns for the selected table
                string connStr = $"Data Source=MERIN\\MSSQLSERVER01;Initial Catalog={selectedTable};Integrated Security=True;";
                SqlDataSource1.ConnectionString = connStr;
                SqlDataSource1.SelectCommand = @"
    SELECT TABLE_NAME 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_TYPE = 'BASE TABLE'";
                ListBox1.DataSourceID = "SqlDataSource1";
                ListBox1.DataBind();

                string script = $@"
    <script>
        localStorage.setItem('database', '{selectedTable.ToString().Replace("'", "\\'")}');
        localStorage.setItem('listItems', '{ListBox1.Text.Replace("'","\\'")}');
    </script>";

                Page.ClientScript.RegisterStartupScript(this.GetType(), "SetLocalStorage", script);



            }

        }



        //protected void Column(object sender, EventArgs e)
        //{

        //    string selectedTable = textbox11.Text.Trim();

        //    if (!string.IsNullOrEmpty(selectedTable))
        //    {
        //        try
        //        {
        //            // Set the query to fetch column names for the selected table
        //            SqlDataSource6.SelectCommand = @"
        //    SELECT COLUMN_NAME
        //    FROM INFORMATION_SCHEMA.COLUMNS
        //    WHERE TABLE_NAME = @TableName";

        //            // Clear previous parameters and set the new parameter
        //            SqlDataSource6.SelectParameters.Clear();
        //            SqlDataSource6.SelectParameters.Add("TableName", selectedTable);

        //            // Bind data to ListBox4
        //            ListBox4.DataBind();

        //            // Ensure that there are items in ListBox4
        //            if (ListBox4.Items.Count > 0)
        //            {
        //                coulmn.Text = string.Join(", ", ListBox4.Items.Cast<ListItem>().Select(item => item.Text));

        //            }
        //            else
        //            {
        //                textbox11.Text = "No columns found.";
        //            }
        //        }
        //        catch (Exception ex)
        //        {
        //            textbox11.Text = $"Error: {ex.Message}";
        //        }
        //    }
        //    else
        //    {
        //        textbox11.Text = "Please provide a valid table name.";
        //    }







        //}




        protected void Column(object sender, EventArgs e)
        {
            string selectedTable = textbox11.Text.Trim();

            if (!string.IsNullOrEmpty(selectedTable))
            {
                try
                {
                    string selectedTable1= textbox10.Text;



                    // Update the SelectCommand of SqlDataSource1 to fetch columns for the selected table
                    string connStr = $"Data Source=MERIN\\MSSQLSERVER01;Initial Catalog={selectedTable1};Integrated Security=True;";
                    SqlDataSource6.ConnectionString = connStr;
                    SqlDataSource6.SelectCommand = @"
                SELECT COLUMN_NAME
                FROM INFORMATION_SCHEMA.COLUMNS
                WHERE TABLE_NAME = @TableName";

                    SqlDataSource6.SelectParameters.Clear();
                    SqlDataSource6.SelectParameters.Add("TableName", selectedTable);

                    ListBox4.DataBind();

                    if (ListBox4.Items.Count > 0)
                    {
                        coulmn.Text = string.Join(", ", ListBox4.Items.Cast<ListItem>().Select(item => item.Text));

                        
                    }
                    else
                    {
                        coulmn.Text = "No columns found.";
                    }
                }
                catch (Exception ex)
                {
                    coulmn.Text = $"Error: {ex.Message}";
                }
            }
            else
            {
                coulmn.Text = "Please provide a valid table name.";
            }
        }




        protected void run(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection())
                {
                    string selectedTable1 = textbox10.Text;



                    // Update the SelectCommand of SqlDataSource1 to fetch columns for the selected table
                    string connStr = $"Data Source=MERIN\\MSSQLSERVER01;Initial Catalog={selectedTable1};Integrated Security=True;";
                    //con.ConnectionString = ConfigurationManager.ConnectionStrings["employeeConnectionString2"].ToString();
                    con.ConnectionString= connStr;
                    con.Open();

                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = textbox12.Text + ";"; // Caution: avoid this in production!
                        cmd.Connection = con;

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            GridView1.DataSource = dt;
                            GridView1.DataBind();
                        }
                        else
                        {
                            // Show alert for no result
                            Response.Write("<script>alert('No results found!');</script>");

                            GridView1.DataSource = null;
                            GridView1.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Show alert with error message
                string msg = ex.Message.Replace("'", "").Replace("\n", "").Replace("\r", ""); // clean the error message
                Response.Write("<script>alert('No results found!');</script>");

            }
        }


        protected void Savequery(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["employeeConnectionString2"].ToString();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                string querystring = textbox14.Text;
                string querydescription = textbox12.Text;
                string useremail = Session["username"]?.ToString();

                // Check if querystring already exists
                string checkQuery = "SELECT COUNT(*) FROM querystr WHERE querystring = @querystring";
                SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                checkCmd.Parameters.AddWithValue("@querystring", querystring);

                int exists = (int)checkCmd.ExecuteScalar();

                SqlCommand cmd;
                if (exists > 0)
                {
                    // Update description for existing querystring
                    string updateQuery = "UPDATE querystr SET querydescription = @querydescription WHERE querystring = @querystring";
                    cmd = new SqlCommand(updateQuery, con);
                    cmd.Parameters.AddWithValue("@querydescription", querydescription);
                    cmd.Parameters.AddWithValue("@querystring", querystring);
                }
                else
                {
                    // Insert new record
                    string insertQuery = "INSERT INTO querystr (useremail, querystring, querydescription) VALUES (@useremail, @querystring, @querydescription)";
                    cmd = new SqlCommand(insertQuery, con);
                    cmd.Parameters.AddWithValue("@useremail", useremail);
                    cmd.Parameters.AddWithValue("@querystring", querystring);
                    cmd.Parameters.AddWithValue("@querydescription", querydescription);
                }

                int a = cmd.ExecuteNonQuery();
                if (a > 0)
                {
                    Response.Redirect("/");
                }
            }
        }


        protected void GridView2_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string querystring = GridView2.DataKeys[e.RowIndex].Value.ToString();

            string connStr = ConfigurationManager.ConnectionStrings["employeeConnectionString4"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "DELETE FROM querystr WHERE querystring = @querystring";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@querystring", querystring);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            GridView2.DataBind();
        }

        protected void GridView2_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView2.EditIndex = e.NewEditIndex;
            GridView2.DataBind();
        }

        protected void GridView2_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView2.EditIndex = -1;
            GridView2.DataBind();
        }

        protected void GridView2_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridView2.Rows[e.RowIndex];
            string querystring = GridView2.DataKeys[e.RowIndex].Value.ToString();
            TextBox txtQueryDesc = (TextBox)row.FindControl("txtDescription");
            string querydescription = txtQueryDesc.Text;

            string connStr = ConfigurationManager.ConnectionStrings["employeeConnectionString4"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "UPDATE querystr SET querydescription = @querydescription WHERE querystring = @querystring";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@querydescription", querydescription);
                cmd.Parameters.AddWithValue("@querystring", querystring);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            GridView2.EditIndex = -1;
            GridView2.DataBind();
        }





        protected void createdatabase(object sender, EventArgs e)
        {
            string databaseName = textbox16.Text.Trim();

            // ✅ Check if textbox is empty
            if (string.IsNullOrEmpty(databaseName))
            {
                Response.Write("<script>alert('Please enter a database name.');</script>");
                return;
            }

            try
            {
                // ✅ Establish connection to master database (to create a new database)
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["employeeConnectionString4"].ToString()))
                {
                    con.Open();

                    // ✅ Create database query
                    string createDatabaseQuery = $"CREATE DATABASE [{databaseName}]";

                    using (SqlCommand cmd = new SqlCommand(createDatabaseQuery, con))
                    {
                        cmd.ExecuteNonQuery(); // ✅ Execute the query
                    }
                }

                // ✅ Show success message and refresh page
                ListBox3.DataBind();
                LoadDatabaseAndTables();
                Response.Write("<script>alert('Database created successfully!');</script>");
                //Response.Redirect(Request.RawUrl);
            }
            catch (SqlException ex)
            {
                Response.Write("<script>alert('SQL Error: " + ex.Message + "');</script>");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }



        protected void droptable(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(textbox17.Text)) // Ensure query is provided
            {
                string dropQuery = textbox17.Text.Trim();
               

                if (!dropQuery.ToUpper().StartsWith("DROP TABLE")) // ✅ Security check to prevent SQL injection
                {
                    Response.Write("<script>alert('Invalid query!');</script>");
                    return;
                }

                try
                {
                    
                    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["employeeConnectionString4"].ToString()))
                    {
                        con.Open();
                        SqlTransaction transaction = con.BeginTransaction(); // ✅ Begin transaction for rollback safety

                        try
                        {
                            using (SqlCommand cmd = new SqlCommand(dropQuery, con, transaction))
                            {
                                cmd.ExecuteNonQuery(); // ✅ Execute DROP TABLE query
                            }

                            transaction.Commit(); // ✅ Commit changes if successful
                            Response.Write("<script>alert('Table dropped successfully!');</script>");
                        }
                        catch (Exception ex)
                        {
                            transaction.Rollback(); // ✅ Rollback if error occurs
                            Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                            return;
                        }
                    }

                    // ✅ Refresh ListBox1 in SiteMaster AFTER successful execution
                    go(this, EventArgs.Empty);

                    // ✅ Delay Redirect to ensure previous scripts execute
                    Response.Write("<script>setTimeout(function(){ window.location.href = '/'; }, 1000);</script>");
                }
                catch (SqlException ex)
                {
                    Response.Write("<script>alert('SQL Error: " + ex.Message + "');</script>");
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('Error: No table selected to drop.');</script>");
            }
        }








        private void LoadDatabaseAndTables()
        {
            Dictionary<string, List<string>> databaseTables = new Dictionary<string, List<string>>();
            string connectionString = ConfigurationManager.ConnectionStrings["employeeConnectionString4"].ToString();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Fetch all database names
                    List<string> databases = new List<string>();
                    string dbQuery = "SELECT name FROM sys.databases WHERE state_desc = 'ONLINE'";

                    using (SqlCommand cmd = new SqlCommand(dbQuery, conn))
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            databases.Add(reader["name"].ToString());
                        }
                    }

                    // Fetch tables for each database
                    foreach (var database in databases)
                    {
                        List<string> tables = new List<string>();
                        string tableQuery = $"SELECT TABLE_NAME FROM {database}.INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE'";

                        using (SqlCommand cmd = new SqlCommand(tableQuery, conn))
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                tables.Add(reader["TABLE_NAME"].ToString());
                            }
                        }

                        databaseTables[database] = tables;
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Database error: " + ex.Message + "');</script>");
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string jsonTables = serializer.Serialize(databaseTables);

            // Store data in localStorage
            Response.Write("<script>localStorage.setItem('databaseTables', '" + jsonTables + "');</script>");
        }



        protected void ButtonLoadAllTables_Click(object sender, EventArgs e)
        {
            string tablesCsv = HiddenTableList.Text;
            if (!string.IsNullOrWhiteSpace(tablesCsv))
            {
                string[] tables = tablesCsv.Split(',');
            
                var allTableData = new List<object>();

                foreach (string tbl in tables)
                {
                    string trimmed = tbl.Trim();
                    var columns = GetColumnsFromTable(trimmed); // your DB logic here
                    allTableData.Add(new { tableName = trimmed, columns = columns });
                }

                string json = Newtonsoft.Json.JsonConvert.SerializeObject(allTableData);

                // Inject localStorage update + design render
                ScriptManager.RegisterStartupScript(this, GetType(), "tablesLoadedScript", $@"
            localStorage.setItem('tablesData', JSON.stringify({json}));
            displayDesignArea1();
            getfield();
        ", true);
            }
        }


        private List<string> GetColumnsFromTable(string tableName)
        {
            List<string> columns = new List<string>();

            // Replace with your actual connection string
            string selectedTable1 = textbox10.Text;


    
            // Update the SelectCommand of SqlDataSource1 to fetch columns for the selected table
            string connStr = $"Data Source=MERIN\\MSSQLSERVER01;Initial Catalog={selectedTable1};Integrated Security=True;";
            string connectionString = connStr;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
            SELECT COLUMN_NAME
            FROM INFORMATION_SCHEMA.COLUMNS
            WHERE TABLE_NAME = @TableName
            ORDER BY ORDINAL_POSITION";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@TableName", tableName);

                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            columns.Add(reader["COLUMN_NAME"].ToString());
                        }
                    }
                }
            }

            return columns;
        }


    }
}