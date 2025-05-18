<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="crud.aspx.cs" Inherits="quearybuilder.crud" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
    .top-controls {
        background-color: #f8f9fa;
        border-radius: 8px;
        padding: 20px;
        margin-bottom: 20px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    .top-controls .form-label {
        margin-right: 10px;
    }

    .top-controls .form-select,
    .top-controls .form-control {
        display: inline-block;
        width: auto;
        vertical-align: middle;
    }

    .field {
        background-color: #ffffff;
        padding: 15px;
        border-radius: 10px;
        margin-bottom: 20px;
        box-shadow: 0 0 5px rgba(0,0,0,0.1);
    }

    .modal-content {
        border-radius: 10px;
    }

    .btn-primary {
        background-color: #4CAF50;
        border-color: #4CAF50;
    }

    .btn-primary:hover {
        background-color: #45a049;
        border-color: #45a049;
    }

    .modal-title {
        font-weight: bold;
    }

    .operation-section {
        transition: all 0.3s ease-in-out;
    }

    .grid-header th {
        background-color: #007BFF !important;
        color: white;
        text-align: center;
    }

    #field h1 {
        background-color: #343a40;
        color: white;
        padding: 10px;
        border-radius: 10px;
    }

    .btn-fancy {
        font-weight: bold;
        padding: 8px 16px;
        border-radius: 25px;
        margin-right: 10px;
    }

     .form-label {
        font-size: 1rem;
        color: #333;
    }

    .form-control {
        border-radius: 8px;
        border: 1px solid #ced4da;
        transition: border-color 0.3s, box-shadow 0.3s;
    }

    .form-control:focus {
        border-color: #4CAF50;
        box-shadow: 0 0 0 0.2rem rgba(76, 175, 80, 0.25);
    }

    .gridview-custom thead {
        background-color: aqua;
        color: white;
        font-weight: bold;
    }
</style>

    <div class="top-controls mb-4">
         
             <a href="~/" runat="server" class="btn align-items-center">
                 <asp:Image runat="server" src="image/back-icon.png" alt="Back" Width="24" Height="24" class="me-2" />
    
             </a>

                              <label class="form-label d-inline fw-bold" >select Table </label>
                                  <asp:TextBox runat="server" ID="textbox1" />
                                   <asp:Button ID="button1" runat="server" OnClick="go" />

                            <asp:DropDownList ID="DropDownList1" runat="server" 
    DataSourceID="SqlDataSource2" DataTextField="TABLE_NAME" 
    DataValueField="TABLE_NAME" CssClass="form-select d-inline" 
    style="width:auto" AutoPostBack="true" 
    OnSelectedIndexChanged="run">
</asp:DropDownList>
                            
           
              <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:employeeConnectionString2 %>" SelectCommand=" SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_CATALOG = '';"></asp:SqlDataSource>
                 
             <hr />

               <div id="field" runat="server" class="field">

         <h1 class="text-center bg-dark text-light rounded-2" style="width:785px">Table Filed </h1>

                    <br />
             </div>
            
      


             
       </div>
             
     <div class="border border-1 position-relative bg-light shadow-lg rounded p-3" style="height: 500px; overflow: auto;">

   <div class="card shadow-sm mb-4">
    <div class="card-body" style="height: 500px; overflow: auto;">
        <asp:GridView ID="GridView3" runat="server" DataSourceID="SqlDataSource1" 
            AutoGenerateColumns="True" AutoGenerateSelectButton="True"
            CssClass="table table-striped table-bordered table-hover text-center align-middle  gridview-custom"
            OnRowCreated="GridView3_RowCreated"
            CellPadding="4" ForeColor="#333333" GridLines="None">

        </asp:GridView>
    </div>
</div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:employeeConnectionString6 %>" 
        ProviderName="<%$ ConnectionStrings:employeeConnectionString6.ProviderName %>" 
          SelectCommand="">
    </asp:SqlDataSource>

</div>

   
    <br />

   <div class="text-end mb-4">
        <asp:Button ID="button2" runat="server" CssClass="btn btn-primary d-inline mx-3 fw-bold" Text="Insert" OnClick="insert" />
          <asp:Button ID="button3" runat="server" CssClass="btn btn-primary d-inline mx-3 fw-bold" Text="Update" OnClick="update" />
          <asp:Button ID="button4" runat="server" CssClass="btn btn-primary d-inline mx-3 fw-bold" Text="Delete" OnClick="delete" OnClientClick="return confirm('Are you sure you want to delete this item?');" />
         <asp:Button ID="button5" runat="server" CssClass="btn btn-primary d-inline mx-3 fw-bold"  Text="Alter" OnClientClick="openaltermodel(); return false;" />
   

    </div>


<div id="alterModal" class="modal fade" tabindex="-1" aria-labelledby="alterModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="alterModalLabel">Alter Table</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <label class="fw-bold">Operation</label>
                <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-select" AutoPostBack="false">
                    <asp:ListItem Value="" Text="Select Operation"></asp:ListItem>
                    <asp:ListItem Value="ADD" Text="Add Column"></asp:ListItem>
                    <asp:ListItem Value="DROP" Text="Drop Column"></asp:ListItem>
                    <asp:ListItem Value="MODIFY" Text="Modify Column"></asp:ListItem>
                </asp:DropDownList>

                <!-- Add Column Section -->
                <div id="addColumnSection" class="operation-section" style="display: none;">
                    <label class="fw-bold">Column Name</label>
                    <asp:TextBox ID="txtColumnName" runat="server" CssClass="form-control mb-2" Placeholder="Enter Column Name"></asp:TextBox>

                    <label class="fw-bold">Column Type</label>
                    <asp:DropDownList ID="ddlColumnType" runat="server" CssClass="form-select mb-2">
                        <asp:ListItem Value="" Text="Select Type"></asp:ListItem>
                        <asp:ListItem Value="INT" Text="Integer"></asp:ListItem>
                        <asp:ListItem Value="nvarchar(50)" Text="Text"></asp:ListItem>
                        <asp:ListItem Value="DATETIME" Text="DateTime"></asp:ListItem>
                        <asp:ListItem Value="FLOAT" Text="Float"></asp:ListItem>
                    </asp:DropDownList>

                    <!-- Constraint Type -->
<label class="fw-bold">Constraint</label>
<asp:DropDownList ID="ddlConstraint" runat="server" CssClass="form-select mb-2">
    <asp:ListItem Value="" Text="Select Constraint"></asp:ListItem>
    <asp:ListItem Value="NOT NULL" Text="Not Null"></asp:ListItem>
    <asp:ListItem Value="NULL" Text="Nullable"></asp:ListItem>
    <asp:ListItem Value="UNIQUE" Text="Unique"></asp:ListItem>
    <asp:ListItem Value="PRIMARY KEY" Text="Primary Key"></asp:ListItem>
   <%-- <asp:ListItem Value="DEFAULT" Text="Default (you must handle value manually)"></asp:ListItem>--%>
</asp:DropDownList>

                </div>

                <!-- Drop Column Section -->
                <div id="dropColumnSection" class="operation-section" style="display: none;">
                    <label class="fw-bold">Column Name</label>
                    <asp:DropDownList ID="DropDownList3" runat="server" CssClass="form-select mb-2">
                    </asp:DropDownList>
                </div>

                <!-- Modify Column Section -->
                <div id="modifyColumnSection" class="operation-section" style="display: none;">
                    <label class="fw-bold">Column Name</label>
                    <asp:DropDownList ID="DropDownList5" runat="server" CssClass="form-select mb-2">
                        <asp:ListItem>----Select----</asp:ListItem>
                    </asp:DropDownList>


                     <label class="fw-bold">Column Name</label>
                      <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control mb-2" Placeholder="Select column name"></asp:TextBox>
                      
                     

                    <label class="fw-bold">Column Type</label>
                    <asp:DropDownList ID="DropDownList4" runat="server" CssClass="form-select mb-2">
                        <asp:ListItem Value="" Text="Select Type"></asp:ListItem>
                        <asp:ListItem Value="INT" Text="Integer"></asp:ListItem>
                        <asp:ListItem Value="NVARCHAR(50)" Text="Text"></asp:ListItem>
                        <asp:ListItem Value="DATETIME" Text="DateTime"></asp:ListItem>
                        <asp:ListItem Value="FLOAT" Text="Float"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>

            <div class="modal-footer">
                <asp:Button ID="btnExecuteAlter" runat="server" CssClass="btn btn-success" Text="Execute" OnClick="alter" />
                <button type="button" class="btn btn-secondary w-auto" data-bs-dismiss="modal" >Close</button>
            </div>
        </div>
    </div>
</div>



    <script>

        $(document).ready(function () {

            $("#<%= button1.ClientID %>").hide();
            $("#<%= textbox1.ClientID %>").hide();

            //$("#add").hide();
            //$("#drop").hide();
            //$("#modify").hide();




            $("#<%= DropDownList2.ClientID %>").change(function () {
        var selectedValue = $(this).val();
        
        // Hide all sections initially
        $(".operation-section").hide();

        // Show relevant section based on selection
        if (selectedValue === "ADD") {
            $("#addColumnSection").show();
        } else if (selectedValue === "DROP") {
            $("#dropColumnSection").show();
        } else if (selectedValue === "MODIFY") {
            $("#modifyColumnSection").show();
        }
    });

    // Function to open the Alter modal
            $("#<%= button5.ClientID %>").click(function (event) {
                $("#alterModal").modal("show");
                event.preventDefault();
            });



            $("#<%= DropDownList5.ClientID %>").change(function () {
                var selectedText = $("#<%= DropDownList5.ClientID %> option:selected").text();
               $("#<%= TextBox2.ClientID %>").val(selectedText);
           });



            $("#<%= button5.ClientID %>").click(function (event) { 
                $("#alterModal").modal("show");
                event.preventDefault();
            });

            if (localStorage.getItem("database") && $("#<%= DropDownList1.ClientID %> option").length === 0) {
                $("#<%= textbox1.ClientID %>").val(localStorage.getItem("database"));
                $("#<%= button1.ClientID %>").click();

                
            }

            waitForGridView();



                    $(document).on("click", "#<%= GridView3.ClientID %> tbody tr", function (event) {
                        var selectedRow = $(this);

                       

                        populateFields(selectedRow);
                        //event.preventDefault();
                        event.preventDefault();
                    });
                

        // Function to populate input fields with selected row values
            function populateFields(selectedRow) {
                

                        selectedRow.find("td").each(function (index) {
                            var cellValue = $(this).text().trim();

                           

                            // Find corresponding input field by index and update its value
                            $(".field div.mb-3 input").eq(index - 1).val(cellValue);

                            
                        });

                        
                    
                    }










            function getfield() {
              

                

                var gridView = $("#<%= GridView3.ClientID %>");

               if (gridView.length === 0) {
                
                   return; // Stop execution if GridView doesn't exist
               }

                var thead = gridView.find("tr:first th");


               if (thead.length === 0) {
                  
                   return; // Stop execution if no headers found
               }

            

               // Extract column names from GridView header
               thead.each(function () {
                   var columnName = $(this).text().trim(); // Get column name
                  
                   if (columnName === "") return; // Skip empty columns

                   var textBox = `
<div class="mb-3">
    <div class="d-flex align-items-center justify-content-between">
        <label class="form-label fw-semibold me-3 mb-0" style="min-width: 150px;">${columnName}</label>
        <input 
            type="text" 
            class="form-control ms-2" 
            name="column_${columnName}"  
            placeholder="Enter ${columnName}" 
            style="flex: 1;"
        />
    </div>
</div>`;


                   $(".field").append(textBox);
               });

              
           }
// Use setTimeout to check repeatedly if GridView is loaded
            function waitForGridView() {
                if ($("#<%= GridView3.ClientID %> tbody tr").length > 0) {
                   
                    getfield(); // Run function when GridView is loaded
                } else {
                
                    setTimeout(waitForGridView, 300); // Check again after 300ms
                }
            }

            
                $("label").each(function () { // Loop through all labels
                    if ($(this).text().trim().toLowerCase() === "id") {
                        $(this).closest(".mb-2").hide(); // Hide the entire div containing label & input
                    }
                });
           
        });

    </script>

</asp:Content>
