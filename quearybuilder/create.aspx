<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="create.aspx.cs" Inherits="quearybuilder.create" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row md-3">

        <div class="col">
            <label class="form-label">Column Name</label>
            <asp:TextBox ID="TextBox1" runat="server" class="form-control"  />

        </div>
        <div class="col">
             <label class="form-label">Type</label>
             

             <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-select">
                 <asp:ListItem></asp:ListItem>
                 <asp:ListItem>nchar(10)</asp:ListItem>
                 <asp:ListItem>int</asp:ListItem>

             </asp:DropDownList>
             

        </div>
        <div class="col">
            <label class="form-label">constrains</label>
            <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-select">
                <asp:ListItem></asp:ListItem>
                <asp:ListItem>null</asp:ListItem>
                <asp:ListItem>not null</asp:ListItem>
                <asp:ListItem>unique</asp:ListItem>
                <asp:ListItem>primary key</asp:ListItem>

             </asp:DropDownList>
            <br />
     <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" OnClick="Addon" Text="Add" />





        </div>

       

    </div>

     <br />
        <br />
       <div class="container mt-3">
    <div class="w-100 border border-2 border-dark  p-3 text-center" style="height:500px">
       
      
        <div>
            <div class="row">
                <div class="col-8">
                    <label class="form-label">Table Name</label>
                    <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control d-grid" />

                </div>
                <div class="col-4">
                       <br />
                              <asp:Button ID="Button2" runat="server" Text="create" CssClass="btn btn-success md-5" OnClick="Create"/>

                </div>

            </div>
        </div>
        <br />
        <br />
         <asp:CheckBoxList ID="CheckBoxList1" runat="server" AutoPostBack="True">
        </asp:CheckBoxList>


    </div>
          
</div>


     <br />
           <br />
            <div class="row ">
               <div class="col-8 mx-3">
                    <asp:TextBox ID="TextBox3" runat="server" Class="form-control" />
                   <asp:TextBox ID="TextBox4" runat="server" Class="form-control" />
                     
                   </div>
                <div class="col-2">
                     
                    <%--<button id="Button5" type="button" class="btn btn-success">query</button>--%>
                </div>
                <div class="col">
                                <button id="Button3" tyepe="button" Class="btn btn-primary" >save</button>

                </div>
             </div>
      <br />
       <br />
       <div>
            
            <asp:Button ID="Button4" runat="server" Text="RUN" class="btn btn-success"/>
           </div>
         
           
       



</asp:Content>
