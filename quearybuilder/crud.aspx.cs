using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace quearybuilder
{
    public partial class crud : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

           
        }





        


        protected void go(object sender, EventArgs e)
        {
            string selectedDatabase = textbox1.Text.Trim(); // Get the database named

            // ✅ Debugging: Check if database name is coming
         

            if (!string.IsNullOrEmpty(selectedDatabase))
            {
                string selectedTable = textbox1.Text.Trim();



                // Update the SelectCommand of SqlDataSource1 to fetch columns for the selected table
                string connStr = $"Data Source=MERIN\\MSSQLSERVER01;Initial Catalog={selectedTable};Integrated Security=True;";
                SqlDataSource2.ConnectionString = connStr;

                //Response.Write("<script>alert('Selected Database: " + selectedDatabase + "');</script>");
                // ✅ Fetch Table Names from the Selected Database
                SqlDataSource2.SelectCommand = $@"
                        SELECT TABLE_NAME 
                        FROM INFORMATION_SCHEMA.TABLES 
                        WHERE TABLE_TYPE = 'BASE TABLE' 
                        AND TABLE_CATALOG = '{selectedDatabase}'";

                DropDownList1.DataBind();
               
            }
        }

        protected void run(object sender, EventArgs e)
        {
            if (DropDownList1.SelectedItem != null)
            {
                string tablename = DropDownList1.SelectedItem.Text;
                string selectedTable = textbox1.Text.Trim();



                // Update the SelectCommand of SqlDataSource1 to fetch columns for the selected table
                string connStr = $"Data Source=MERIN\\MSSQLSERVER01;Initial Catalog={selectedTable};Integrated Security=True;";
                SqlDataSource1.ConnectionString = connStr;

                if (!string.IsNullOrEmpty(tablename))
                {
                    // ✅ Update the query dynamically
                    SqlDataSource1.SelectCommand = $"SELECT * FROM [{tablename}]";
                    GridView3.DataBind(); // ✅ Update GridView
                    getfiled(sender, e);
                }
                else
                {
                    // ✅ Set the query to an empty state if no table is selected
                    SqlDataSource1.SelectCommand = "SELECT * FROM []";
                    GridView3.DataBind();
                }
            }
        }




        protected void delete(object sender, EventArgs e)
        {
            string tableName = DropDownList1.SelectedItem.Text;
            if (string.IsNullOrEmpty(tableName))
            {
                Response.Write("<script>alert('Please select a table.');</script>");
                return;
            }

            string condition = "";
            foreach (string key in Request.Form.Keys)
            {
                if (key.StartsWith("column_")) // Identify dynamically added fields
                {
                    string columnName = key.Replace("column_", "").Trim();
                    string columnValue = Request.Form[key].Trim();

                    if (!string.IsNullOrEmpty(columnValue))
                    {
                        if (!string.IsNullOrEmpty(condition))
                            condition += " AND ";

                        condition += $"[{columnName}] = '{columnValue}'";
                    }
                }
            }

            if (string.IsNullOrEmpty(condition))
            {
                Response.Write("<script>alert('Please provide values for deletion.');</script>");
                return;
            }

            string query = $"DELETE FROM [{tableName}] WHERE {condition}";

            ExecuteQuery(query,sender,e);
        }

        protected void update(object sender, EventArgs e)
        {
            string tableName = DropDownList1.SelectedItem.Text;
            if (string.IsNullOrEmpty(tableName))
            {
                Response.Write("<script>alert('Please select a table.');</script>");
                return;
            }

            string setClause = "";
            string condition = "";
            bool firstConditionSet = false;

            // ✅ Extract dynamically added input values
            foreach (string key in Request.Form.Keys)
            {
                if (key.StartsWith("column_")) // Identify dynamically added fields
                {
                    string columnName = key.Replace("column_", "").Trim(); // Remove "column_" prefix
                    string columnValue = Request.Form[key].Trim(); // Get value from input field
                   

                    if (!string.IsNullOrEmpty(columnValue))
                    {
                        if (!firstConditionSet)
                        {
                            condition = $"[{columnName}] = '{columnValue}'"; // ✅ Use first field for WHERE
                            firstConditionSet = true;
                        }
                        else
                        {
                            if (!string.IsNullOrEmpty(setClause))
                                setClause += ", ";

                            setClause += $"[{columnName}] = '{columnValue}'"; // ✅ Add to SET clause
                        }
                    }
                }
            }

            // ✅ Prevent running an invalid query
            if (string.IsNullOrEmpty(setClause) || string.IsNullOrEmpty(condition))
            {
                Response.Write("<script>alert('Please provide values for updating.');</script>");
                return;
            }

            // ✅ Final Update Query
            string query = $"UPDATE [{tableName}] SET {setClause} WHERE {condition}";

            // ✅ Execute Query and Refresh Grid
            ExecuteQuery(query, sender, e);
        }


        private void ExecuteQuery(string query, object sender, EventArgs e)
        {
            string selectedTable = textbox1.Text.Trim();



            // Update the SelectCommand of SqlDataSource1 to fetch columns for the selected table
            string connStr = $"Data Source=MERIN\\MSSQLSERVER01;Initial Catalog={selectedTable};Integrated Security=True;";
            //string connString = System.Configuration.ConfigurationManager.ConnectionStrings["employeeConnectionString6"].ConnectionString;

            string connString = connStr;

            using (SqlConnection con = new SqlConnection(connString))
            {
                try
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand(query, con);
                    int result = cmd.ExecuteNonQuery();

                    if (result > 0)
                    {
                        run(sender, e);
                    }
                    else
                    {
                        Response.Write("<script>alert('No matching records found. Check table name and data.');</script>");
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                }
            }
        }





        protected void insert(object sender, EventArgs e)
        {
            string tableName = DropDownList1.SelectedItem.Text;

            if (string.IsNullOrEmpty(tableName))
            {
                Response.Write("<script>alert('Please select a table.');</script>");
                return;
            }

            string columns = "";
            string values = "";
            bool firstColumn = true;

            // ✅ Extract dynamically added input values
            foreach (string key in Request.Form.Keys)
            {
                if (key.StartsWith("column_")) // Identify dynamically added fields
                {
                    string columnName = key.Replace("column_", "").Trim(); // Remove "column_" prefix
                    string columnValue = Request.Form[key].Trim(); // Get value from input field

                    if (!string.IsNullOrEmpty(columnValue))
                    {
                        if (!firstColumn)
                        {
                            columns += ", ";
                            values += ", ";
                        }

                        columns += $"[{columnName}]"; // ✅ Add column name
                        values += $"'{columnValue}'"; // ✅ Add column value
                        firstColumn = false;
                    }
                }
            }

            // ✅ Prevent running an invalid query
            if (string.IsNullOrEmpty(columns) || string.IsNullOrEmpty(values))
            {
                Response.Write("<script>alert('Please provide values for insertion.');</script>");
                return;
            }

            // ✅ Final Insert Query
            string query = $"INSERT INTO [{tableName}] ({columns}) VALUES ({values})";
          
            ExecuteQuery(query, sender, e);
        }






        protected void alter(object sender, EventArgs e)
        {
            string alterType = DropDownList2.SelectedValue;
            string tableName = DropDownList1.SelectedValue;
            string columnName = txtColumnName.Text.Trim();
            string columnType = ddlColumnType.SelectedValue;
            string constraint = ddlConstraint.SelectedValue;

            string alterQuery = "";

            // Construct ALTER query
            if (alterType == "ADD")
            {
                if (!string.IsNullOrEmpty(columnName) && !string.IsNullOrEmpty(columnType))
                {
                    alterQuery = $"ALTER TABLE {tableName} ADD {columnName} {columnType}";

                    if (!string.IsNullOrEmpty(constraint))
                    {
                        // Special handling for PRIMARY KEY
                        if (constraint == "PRIMARY KEY")
                        {
                            alterQuery += $"; ALTER TABLE {tableName} ADD CONSTRAINT PK_{tableName}_{columnName} PRIMARY KEY({columnName})";
                        }
                        // For default, prompt user to alter manually or handle in UI
                        else if (constraint == "DEFAULT")
                        {
                            alterQuery += " DEFAULT 'your_default_value'"; // Customize or get from another input
                        }
                        else
                        {
                            alterQuery += $" {constraint}";
                        }
                    }

                    alterQuery += ";";
                }
            }
            else if (alterType == "DROP")
            {
                alterQuery = $"ALTER TABLE {tableName} DROP COLUMN {DropDownList3.SelectedValue};";
            }
            else if (alterType == "MODIFY")

            {

                alterQuery = $"EXEC sp_rename '{tableName}.{DropDownList5.SelectedValue}', '{TextBox2.Text}', 'COLUMN';";


                Response.Write("<script>alert('"+alterQuery+"')</script>");
            }

            if (string.IsNullOrEmpty(alterQuery))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid ALTER command.');", true);
                return;
            }

            // Execute query
            try
            {
                string selectedTable = textbox1.Text.Trim();



                // Update the SelectCommand of SqlDataSource1 to fetch columns for the selected table
                string connStr = $"Data Source=MERIN\\MSSQLSERVER01;Initial Catalog={selectedTable};Integrated Security=True;";
                //string connString = ConfigurationManager.ConnectionStrings["employeeConnectionString6"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand(alterQuery, conn))
                    {
                        cmd.ExecuteNonQuery();
                    }

                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Table altered successfully!');", true);
                    run(sender, e); // Refresh grid or whatever function you call to reload
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {ex.Message}');", true);
            }
        }



        protected void GridView3_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#28a745");
                e.Row.ForeColor = System.Drawing.Color.White;
                e.Row.Font.Bold = true;
            }
        }


        protected void getfiled(object sender, EventArgs e)
        {
            string selectedTable = DropDownList1.SelectedItem?.ToString().Trim();
            string selectedDatabase = textbox1.Text.Trim();

            if (!string.IsNullOrEmpty(selectedTable) && !string.IsNullOrEmpty(selectedDatabase))
            {
                string query = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableName";

                string connStr = $"Data Source=MERIN\\MSSQLSERVER01;Initial Catalog={selectedDatabase};Integrated Security=True;";

                using (SqlConnection con = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@TableName", selectedTable);

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        // Bind DropDownList3
                        DropDownList3.DataSource = dt;
                        DropDownList3.DataTextField = "COLUMN_NAME";
                        DropDownList3.DataValueField = "COLUMN_NAME";
                        DropDownList3.DataBind();

                        // Bind DropDownList5
                        DropDownList5.DataSource = dt.Copy(); // reuse with a copy
                        DropDownList5.DataTextField = "COLUMN_NAME";
                        DropDownList5.DataValueField = "COLUMN_NAME";
                        DropDownList5.DataBind();
                    }
                }
            }
        }




    }
}
