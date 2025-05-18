<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="orderby.aspx.cs" Inherits="quearybuilder.orderby" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    
       <script src="Scripts/jquery-3.4.1.min.js"></script>

 <div>
   <div class="text-center bg-dark text-light">
       <h1>ORDERBY</h1>
   </div>
   <br />
   <br />
   <div>
       <div class="row ">
           <div class="col-3 mx-3">
               <label class="form-label fw-bold">Select</label>
               <asp:Label runat="server" class="form-control" Text="SELECT"></asp:Label>
           </div>
           <div class="col-3 mx-3">
               <asp:TextBox ID="textbox11" runat="server" Class="form-control" placeholder="Enter value" />
               <label class="form-label fw-bold">Table List</label>
               <asp:DropDownList class="form-select" ID="DropDownList2" runat="server" DataSourceID="SqlDataSource2" DataTextField="TABLE_NAME" DataValueField="TABLE_NAME" AutoPostBack="True" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged">
               </asp:DropDownList>
               <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:employeeConnectionString2 %>" SelectCommand="SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_CATALOG = 'employee';"></asp:SqlDataSource>
           </div>
           <div class="col-3 mx-3 text-center">
               <label class="form-label fw-bold">Field List</label>
               <asp:CheckBoxList CssClass="text-center form-control" ID="CheckBoxList2" runat="server" DataSourceID="SqlDataSource1" DataTextField="COLUMN_NAME" DataValueField="COLUMN_NAME" BorderWidth="2px">
               </asp:CheckBoxList>
               <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:employeeConnectionString %>" SelectCommand="SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '';"></asp:SqlDataSource>
           </div>
           <div class="col"></div>
       </div>

       <br />
       <hr />
       <br />
       
       <div class="row ">
           <div class="col mx-3">
               <label class="form-label fw-bold">where</label>
               <asp:Label runat="server" class="form-control" Text="WHERE"></asp:Label>
           </div>
           <div class="col mx-3">
               <label class="form-label fw-bold">Field</label>
               <asp:DropDownList class="form-select" ID="DropDownList3" runat="server" DataSourceID="SqlDataSource3" DataTextField="COLUMN_NAME" DataValueField="COLUMN_NAME" AutoPostBack="false" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged">
                   <asp:ListItem></asp:ListItem>
               </asp:DropDownList>
               <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:employeeConnectionString2 %>" SelectCommand="SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '';"></asp:SqlDataSource>
           </div>
           <div class="col mx-3">
               <asp:TextBox ID="textbox7" runat="server" Class="form-control" placeholder="Enter value" />
               <%--<label class="form-label fw-bold">Filter</label>--%>
               <asp:DropDownList ID="DropDownList4" AutoPostBack="True" runat="server" CssClass="form-select" OnSelectedIndexChanged="additeam">
                   <asp:ListItem>Filter</asp:ListItem>
                   <asp:ListItem>AND</asp:ListItem>
                   <asp:ListItem>OR</asp:ListItem>
               </asp:DropDownList>
               <asp:TextBox ID="textbox9" runat="server" Class="form-control border-0" placeholder="Filter value" />
           </div>
       </div>

       <br />
       <hr />
       <br />
       
       <div class="row">
           <div class="col mx-3">
               <label class="form-label fw-bold">Order by</label>
               <asp:Label runat="server" ID="label2" Text="ORDERBY" CssClass="form-control"></asp:Label>
           </div>
           <div class="col mx-3">
               <label class="form-label fw-bold">Field</label>
               <asp:DropDownList ID="DropDownList5" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3" class="form-select" DataTextField="COLUMN_NAME" DataValueField="COLUMN_NAME">
               </asp:DropDownList>
           </div>
           <div class="col mx-3">
               <label class="form-label fw-bold">Order</label>
               <asp:DropDownList ID="DropDownList1" AutoPostBack="True" runat="server" CssClass="form-select" OnSelectedIndexChanged="additeam1">
                   <asp:ListItem></asp:ListItem>
                   <asp:ListItem>ASC</asp:ListItem>
                   <asp:ListItem>DESC</asp:ListItem>
               </asp:DropDownList>
               <asp:TextBox ID="textbox1" runat="server" Class="form-control border-0" placeholder="Order value" />
           </div>
       </div>

       <br />
       <br />
       <hr />
       <br />
       <br />
       
       <div class="row">
           <div class="col-8 mx-3">
               <asp:TextBox ID="textbox8" runat="server" Class="form-control" placeholder="Enter query" />
           </div>
           <div class="col-2">
               <button id="button8" type="button" class="btn btn-success">Query</button>
           </div>
       </div>
       
       <br />
       <hr />
       <br />
       <div>
           <asp:Button ID="Button4" runat="server" Text="RUN" class="btn btn-success" OnClick="run"/>
           <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
               <AlternatingRowStyle BackColor="#CCCCCC" />
               <FooterStyle BackColor="#CCCCCC" />
               <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
               <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
               <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
               <SortedAscendingCellStyle BackColor="#F1F1F1" />
               <SortedAscendingHeaderStyle BackColor="#808080" />
               <SortedDescendingCellStyle BackColor="#CAC9C9" />
               <SortedDescendingHeaderStyle BackColor="#383838" />
           </asp:GridView>
       </div>

       <div id="Box" class="container mt-4">
           <div class="card shadow-sm">
               <div class="card-header bg-dark text-white text-center">
                   <h4>SAVE QUERY</h4>
               </div>
               <div class="card-body align-content-center">
                   <label class="form-control-label">File Name</label>
                   
                   <asp:TextBox runat="server" ID="filename" CssClass="form-control" placeholder="Enter file name" />
                   <br />
                   <asp:Button ID="Button2" runat="server" Text="Save" CssClass="btn btn-primary mx-3" OnClick="save" />
                   <asp:Button ID="Button3" runat="server" Text="Cancel" CssClass="btn btn-primary" />
               </div>
           </div>
       </div>
   </div>
</div>

    <script>
        $(document).ready(function () {
            $("input[id$='textbox11']").hide();


            $("input[id$='textbox11']").val(localStorage.getItem("database"));
            $("#button8").click(function () {
       
                var list = [];

             
                var checkedItems = $("#<%= CheckBoxList2.ClientID %> input[type='checkbox']:checked");

            
               checkedItems.each(function () {
                   list.push($(this).val());
               });

            
                alert(list.join(", "));

                var field = $("select[id$='DropDownList3']").val();
                var value = $("input[id$='textbox7']").val();

                var text2;
                if (value != "" && $("#<%= DropDownList1.ClientID%>").val() == "") {

                    text2 = "select " + list.join(",") + " from " + $("select[id$='DropDownList2']").val() + " where " + field + "=" + "'" + value + "'" + $("input[id$='textbox9']").val() + ";";

                } else if ($("#<%= DropDownList1.ClientID%>").val() != "" && value != "") {

                    text2 = "select " + list.join(",") + " from " + $("select[id$='DropDownList2']").val() + " where " + field + "=" + "'" + value + "'" + $("input[id$='textbox9']").val() + " order by " + $("#<%=textbox1.ClientID %>").val() + ";";
                }
                else if ($("#<%= DropDownList1.ClientID%>").val() != "") {

                    text2 = "select " + list.join(",") + " from " + $("select[id$='DropDownList2']").val() + " order by " + $("#<%=textbox1.ClientID %>").val() + ";";


                } else {

                    text2 = "select " + list.join(",") + " from " + $("select[id$='DropDownList2']").val() + ";";
                }
                alert(text2);
                $("input[id$='textbox8']").val(text2);


            });

           

        });
    </script>
</asp:Content>
