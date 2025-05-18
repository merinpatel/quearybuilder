<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="select.aspx.cs" Inherits="quearybuilder.select1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server" >



       <script src="Scripts/jquery-3.4.1.min.js"></script>
  

  <div>
    <div class="text-center bg-dark text-light py-3">
        <h1>SELECT QUERY </h1>
    </div>

    <div class="container mt-5">
        <div class="row">
            <div class="col-md-3">
                <label class="form-label fw-bold">Select</label>
                <asp:Label runat="server" class="form-control" Text="Select"></asp:Label>
            </div>
            <div class="col-md-3">
                <label class="form-label fw-bold">Into</label>
                <asp:TextBox ID="textbox11" runat="server" Class="form-control" />
                <asp:DropDownList class="form-select mt-2" ID="DropDownList2" runat="server" DataSourceID="SqlDataSource2" DataTextField="TABLE_NAME" DataValueField="TABLE_NAME" AutoPostBack="True" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged"></asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:employeeConnectionString2 %>" SelectCommand="SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_CATALOG = 'employee';"></asp:SqlDataSource>
            </div>
            <div class="col-md-3">
                <label class="form-label fw-bold">Available Columns</label>
                <asp:CheckBoxList CssClass="form-control" ID="CheckBoxList2" runat="server" DataSourceID="SqlDataSource1" DataTextField="COLUMN_NAME" DataValueField="COLUMN_NAME" BorderWidth="2px"></asp:CheckBoxList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:employeeConnectionString %>" SelectCommand="SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '';"></asp:SqlDataSource>
            </div>
        </div>

        <hr class="my-4" />

        <div class="row">
            <div class="col-md-3">
                <label class="form-label fw-bold">Where Condition</label>
                <asp:Label runat="server" class="form-control" Text="Where"></asp:Label>
            </div>
            <div class="col-md-3">
                <asp:DropDownList class="form-select" ID="DropDownList3" runat="server" DataSourceID="SqlDataSource3" DataTextField="COLUMN_NAME" DataValueField="COLUMN_NAME" AutoPostBack="false" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged"></asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:employeeConnectionString2 %>" SelectCommand="SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '';"></asp:SqlDataSource>
            </div>
            <div class="col-md-3">
                <asp:TextBox ID="textbox7" runat="server" Class="form-control" />
                <asp:DropDownList ID="DropDownList4" AutoPostBack="True" runat="server" CssClass="form-select mt-2">
                    <asp:ListItem>Filter</asp:ListItem>
                    <asp:ListItem>AND</asp:ListItem>
                    <asp:ListItem>OR</asp:ListItem>
                </asp:DropDownList>
                <asp:TextBox ID="textbox9" runat="server" Class="form-control mt-2 border-0" />
            </div>
        </div>

        <div class="mt-4">
            <div class="row">
                <div class="col-md-8">
                    <asp:TextBox ID="textbox8" runat="server" Class="form-control" />
                </div>
                <div class="col-md-2">
                    <button id="button8" type="button" class="btn btn-success w-100">Query</button>
                </div>
                <div class="col-md-2">
                    <button id="Button1" type="button" class="btn btn-primary w-100">Save</button>
                </div>
            </div>
        </div>

        <hr class="my-4" />

        <div>
            <asp:Button ID="Button4" runat="server" Text="RUN" class="btn btn-success mb-3" OnClick="run" />
            <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" class="table table-bordered mt-3">
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

        <div id="Box" class="container mt-5">
            <div class="card shadow-sm">
                <div class="card-header bg-dark text-white text-center">
                    <h4>SAVE QUERY</h4>
                </div>
                <div class="card-body">
                    <label class="form-control-label fw-bold">File Name</label>
                    <asp:TextBox runat="server" ID="filename" CssClass="form-control" />
                    <div class="mt-3">
                        <asp:Button ID="Button2" runat="server" Text="Save" CssClass="btn btn-primary me-2" OnClick="save" />
                        <asp:Button ID="Button3" runat="server" Text="Cancel" CssClass="btn btn-secondary" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

    <script>
        $(document).ready(function () {
            $("input[id$='textbox11']").hide();

     


            $("input[id$='textbox11']").val(localStorage.getItem("database"));

            //$("#Button1").click(function () {
            //    $("#Box").show().css("display", "block");
            //});

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
                if (value != "") {
                    text2 = "select " + list.join(",") + " from " + $("select[id$='DropDownList2']").val() + " where " + field + "=" + "'" + value + "'" + $("input[id$='textbox9']").val()+ ";";

                } else {
                     text2 = "select " + list.join(",") + " from " + $("select[id$='DropDownList2']").val()+";";


                }
                alert(text2);
                $("input[id$='textbox8']").val(text2);


            });


            $("#<%= Button3.ClientID %>").click(function () {

                $("#Box").hide();

            });

           

        });
    </script>


</asp:Content>
