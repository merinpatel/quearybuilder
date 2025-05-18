<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="query.aspx.cs" Inherits="quearybuilder.query" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <div class="container">

         <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AllowSorting="True" 
    AutoGenerateColumns="False" DataSourceID="SqlDataSource4" 
    CssClass="table table-bordered table-hover table-striped">
    <Columns>
        <asp:CommandField ShowSelectButton="True" />
        
        <asp:BoundField DataField="querystring" HeaderText="Query String" 
            SortExpression="querystring" ItemStyle-CssClass="text-center" />
            
        <asp:BoundField DataField="querydescription" HeaderText="Query Description" 
            SortExpression="querydescription" ItemStyle-CssClass="text-center" />
        
        <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
                <asp:Button ID="btnEdit" runat="server" Text="Edit" 
                    CssClass="btn btn-warning btn-sm mx-1" CommandName="Edit" />
                <asp:Button ID="btnDelete" runat="server" Text="Delete" 
                    CssClass="btn btn-danger btn-sm mx-1" CommandName="Delete" />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

                     <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:employeeConnectionString4 %>" ProviderName="<%$ ConnectionStrings:employeeConnectionString4.ProviderName %>" SelectCommand="SELECT [querystring], [querydescription] FROM [querystr]"></asp:SqlDataSource>

    </div>
</asp:Content>
