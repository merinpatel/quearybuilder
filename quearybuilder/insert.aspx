<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="insert.aspx.cs" Inherits="quearybuilder.select" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

     <script src="Scripts/jquery-3.4.1.min.js"></script>
<div>
  <div class="text-center bg-dark text-light p-3">
    <h1>INSERT</h1>
  </div>
  <br />
  <div>
    <div class="row">
      <div class="col-3 mx-3">
        <asp:Label runat="server" class="form-control bg-light text-dark">INSERT</asp:Label>
      </div>
      <div class="col-3 mx-3">
        <asp:Label runat="server" class="form-control bg-light text-dark">INTO</asp:Label>
      </div>
      <div class="col-3 mx-3 text-center">
        <asp:TextBox ID="textbox11" runat="server" class="form-control" placeholder="Enter Value" />
        <asp:DropDownList class="form-select mt-2" ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="TABLE_NAME" DataValueField="TABLE_NAME" OnSelectedIndexChanged="Indexchange" AutoPostBack="True">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:employeeConnectionString2 %>" SelectCommand="SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_CATALOG = 'employee';">
        </asp:SqlDataSource>
      </div>
      <div class="col">
        <button id="button2" type="button" class="btn btn-danger w-100">ADD</button>
        <asp:TextBox ID="number" runat="server" class="form-control border-0 mt-2" />
      </div>
    </div>
    <br />
    <div class="row">
      <div class="col mx-3" id="one"></div>
    </div>
    <br />
    <div class="row">
      <div class="col-8 mx-3">
        <asp:TextBox ID="textbox6" runat="server" class="form-control" />
      </div>
      <div class="col-2">
        <button id="button1" type="button" class="btn btn-success w-100">QUERY</button>
      </div>
    </div>
  </div>
  <br />
  <div>
    <asp:Button ID="Button4" runat="server" Text="RUN" class="btn btn-success" OnClick="Run" />
  </div>
  <div id="Box" class="container mt-4">
    <div class="card shadow-sm">
      <div class="card-header bg-dark text-white text-center">
        <h4>SAVE QUERY</h4>
      </div>
      <div class="card-body">
        <label class="form-control-label">File Name</label>
        <asp:TextBox runat="server" ID="filename" CssClass="form-control" placeholder="Enter File Name" />
        <div class="mt-3">
          <asp:Button ID="Button3" runat="server" Text="SAVE" CssClass="btn btn-primary mx-3" OnClick="save" />
          <asp:Button ID="Button5" runat="server" Text="CANCEL" CssClass="btn btn-secondary" />
        </div>
      </div>
    </div>
  </div>
</div>

    <script>
        $(document).ready(function () {
            $("input[id$='textbox11']").hide();


            $("input[id$='textbox11']").val(localStorage.getItem("database"));
            var number;
            $("#button2").click(function(){
           
               
                 number=$("input[id$='number']").val(); 
                

                 for (var num = 0; num <number-1;num++) {
                    var val1 = $("<input>").attr("type","text").attr("id", "textbox" + num).addClass("form-control");
                    $("#one").append(val1);
                    $("#one").append("<br />");



                };
            });

            $("#button1").click(function(){ 
               
                var iteamValues = []; 


                console.log(number);
               
                for (var num = 0; num < number-1; num++) {
                    var iteam = $("#textbox" + num).val();
                    
                        iteamValues.push("'" + iteam + "'"); 
                    
                }
                console.log(iteamValues);
                //iteamValues.pop();

                
                var text1 = "INSERT INTO " + $("select[id$='DropDownList1']").val() + "(name,department) "+" VALUES (" + iteamValues.join(", ") + ");";
                console.log(text1);
               
                $("input[id$='textbox6']").val(text1);
            });

         
        }); 
    </script>

</asp:Content>
