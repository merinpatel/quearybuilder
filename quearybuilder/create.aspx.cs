using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace quearybuilder
{
    public partial class create : System.Web.UI.Page
    {
        //string[] field = { };
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }


        protected void Addon(object sender, EventArgs e)
        {
            var column = DropDownList1.SelectedValue;
            var type = DropDownList2.SelectedValue;
            var value = TextBox1.Text;


            CheckBoxList1.Items.Add(value+" "+ column+" "+type);
            //field.Append(TextBox1.Text +" "+column+" "+type+",");
          
            DropDownList1.ClearSelection();
            DropDownList2.ClearSelection();
            TextBox1.Text = " ";


        }


        protected void Create(object sender, EventArgs e)
        {
            List<string> items = new List<string>();


           
            foreach (ListItem item in CheckBoxList1.Items)
            {
               
                    items.Add(item.Text);
                
            }

            var tablename = TextBox2.Text.Trim();

            
            if (!string.IsNullOrEmpty(tablename) && items.Count > 0)
            {
                var statement = "CREATE TABLE " + tablename + " ("+ string.Join(",", items) + ");";
                TextBox3.Text = statement;
            }
            else
            {
                TextBox3.Text = "Please enter a valid table name and select columns.";
            }
        }



       

    }
}