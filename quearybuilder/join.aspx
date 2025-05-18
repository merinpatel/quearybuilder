<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="join.aspx.cs" Inherits="quearybuilder.join" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

     <script src="Scripts/jquery-3.4.1.min.js"></script>

   <div>
       <div class="text-center bg-dark text-light">
           <h1>JOIN</h1>

       </div>
       <br />
       <br />
       <div>
           <div class="row ">
               <div class="col-3 mx-3">
                     <%--<asp:Label  runat="server" class="form-control" Text="insert"> SELECT</asp:Label>--%>
                   <label class="form-label fw-bold">Join Type</label>
                    <asp:DropDownList class="form-select" ID="DropDownList1" runat="server" AutoPostBack="True"  >
                        <asp:ListItem>INNER JOIN</asp:ListItem>
                          <asp:ListItem>LEFT JOIN</asp:ListItem>
                          <asp:ListItem>RIGHT JOIN</asp:ListItem>
                          <asp:ListItem>FULL OUTER JOIN</asp:ListItem>
                       
                   </asp:DropDownList>


               </div>
               <div class="col-3 mx-3">
                      <%--<asp:Label  runat="server" class="form-control" Text="into"> INTO</asp:Label>--%>
                    <asp:TextBox ID="textbox11" runat="server" Class="form-control" />

                   <label class="form-label fw-bold">Select Left Table</label>
                    <asp:DropDownList class="form-select" ID="DropDownList2" runat="server" DataSourceID="SqlDataSource2" DataTextField="TABLE_NAME" DataValueField="TABLE_NAME" AutoPostBack="True"  OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged" >
                       
                   </asp:DropDownList>
                   <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:employeeConnectionString2 %>" SelectCommand=
                       "SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_CATALOG = 'employee';
"></asp:SqlDataSource>
                     




               </div>
               <div  class="col-3 mx-3 text-center">
                     <asp:CheckBoxList CssClass="text-center form-control " ID="CheckBoxList2" runat="server" DataSourceID="SqlDataSource1" DataTextField="COLUMN_NAME" DataValueField="COLUMN_NAME" BorderWidth="2px">
           </asp:CheckBoxList>
                   <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:employeeConnectionString %>" SelectCommand="
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE  TABLE_NAME = '';

"></asp:SqlDataSource>


               </div>
               <div class="col">
                    
                 
  

                  
               </div>



           </div>

           

           <br />
           <hr />
           <br />

             <div class="row ">
               <div class="col-3 mx-3">
                   
                  

               </div>
               <div class="col-3 mx-3">
                      <%--<asp:Label  runat="server" class="form-control" Text="into"> INTO</asp:Label>--%>
                    

                   <label class="form-label fw-bold">Select Right Table</label>
                    <asp:DropDownList class="form-select" ID="DropDownList6" runat="server" DataSourceID="SqlDataSource4" DataTextField="TABLE_NAME" DataValueField="TABLE_NAME" AutoPostBack="True"  OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" >
                       
                   </asp:DropDownList>
                     <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:employeeConnectionString2 %>" SelectCommand=
                       "SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_CATALOG = 'employee';
"></asp:SqlDataSource>
               
                     




               </div>
               <div  class="col-3 mx-3 text-center">
                     <asp:CheckBoxList CssClass="text-center form-control " ID="CheckBoxList9" runat="server" DataSourceID="SqlDataSource5" DataTextField="COLUMN_NAME" DataValueField="COLUMN_NAME" BorderWidth="2px">
           </asp:CheckBoxList>
                   <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:employeeConnectionString %>" SelectCommand="
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE  TABLE_NAME = '';

"></asp:SqlDataSource>


               </div>
                 </div>
           <br />
           <hr />
           <br />
           
            <div class="row ">
               <div class="col mx-3 " >
                   <label class="form-label fw-bold">condition</label>
                    <asp:Label  runat="server" class="form-control" Text="where"> ON</asp:Label>
                   
                  
                     
               </div> 
                <div class="col mx-3 " >
                    <label class="form-label fw-bold">Left Table</label>
                      <asp:DropDownList class="form-select" ID="DropDownList3" runat="server"  DataSourceID="SqlDataSource3" DataTextField="COLUMN_NAME" DataValueField="COLUMN_NAME" AutoPostBack="false"  >
                          <asp:ListItem></asp:ListItem>
                   </asp:DropDownList>
                   <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:employeeConnectionString2 %>" SelectCommand="SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE  TABLE_NAME = '';"
                       
></asp:SqlDataSource>

                   
                   
                  
                     
               </div>
                  <div class="col mx-3 " >
                        
                        <label class="form-label fw-bold">Right Table</label>
                      
                      <asp:DropDownList class="form-select" ID="DropDownList4" runat="server"  DataSourceID="SqlDataSource6" DataTextField="COLUMN_NAME" DataValueField="COLUMN_NAME" AutoPostBack="false"  >
                          <asp:ListItem></asp:ListItem>
                   </asp:DropDownList>
                   <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:employeeConnectionString2 %>" SelectCommand="SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE  TABLE_NAME = '';"
                       
></asp:SqlDataSource>

                      
                   
                  
                     
               </div>

               


           </div>


           
           <br />
           <hr />
           <br />
            <div class="row ">
               <div class="col-8 mx-3">
                   <asp:TextBox ID="textbox8" runat="server" Class="form-control" />
                     
                   </div>
                <div class="col-2">
                   
                    <button id="button8" type="button" class="btn btn-success">query</button>
                </div>
             </div>

         
           
       </div>
       <br />
       <br />
       <div>
            
            <asp:Button ID="Button4" runat="server" Text="RUN" class="btn btn-success" OnClick="run" />
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
       

        <div id="Box" class="container mt-4"  >
  <div  class="card shadow-sm">
    <div class="card-header bg-dark text-white text-center">
      <h4 >SAVE QUERY</h4>
    </div>
    <div class="card-body  align-content-center">
        <label class="form-control-label" >File Name</label>
        <asp:TextBox runat="server" ID="filename" CssClass="form-control" />
        <br />
          <asp:Button ID="Button2" runat="server" Text="save" CssClass="btn btn-primary mx-3" OnClick="save" />
          <asp:Button ID="Button3" runat="server" Text="cancel" CssClass="btn btn-primary" />


    </div>
  </div>
      
      
   </div>
    <script>
        $(document).ready(function () {
            $("input[id$='textbox11']").hide();


            $("input[id$='textbox11']").val(localStorage.getItem("database"));
            $("#button8").click(function () {
       
                var list = [];
                var list1 = [];

             
                var checkedItems = $("#<%= CheckBoxList2.ClientID %> input[type='checkbox']:checked");
                var dropiteam = $("#<%=DropDownList2.ClientID %>").val();



                var checkedItems1 = $("#<%= CheckBoxList9.ClientID %> input[type='checkbox']:checked");
                var dropiteam1 = $("#<%=DropDownList6.ClientID %>").val();
                

            
               checkedItems.each(function () {
                   list.push("e"+"."+$(this).val());
               });

                checkedItems1.each(function () {
                    list1.push("p"+ "." + $(this).val());
                });


                alert(list.join(", ") + list1.join(","));
                

                

                var text2;
                if ($("#<%= DropDownList3.ClientID%>").val() != " " && $("#<%= DropDownList4.ClientID%>").val() != " ") {
                    text2 = "select " + list.join(",") + "," + list1.join(",") + " from " + dropiteam+ " as e " + $("#<%= DropDownList1.ClientID%>").val()+" " + dropiteam1 +" as p"+ " on " + "e"+ "." + $("#<%= DropDownList3.ClientID%>").val() + " = " + "p" + "." + $("#<%= DropDownList4.ClientID%>").val() + ";";

                }
              
                alert(text2);
                $("input[id$='textbox8']").val(text2);


            });

           

        });
    </script>
</asp:Content>
