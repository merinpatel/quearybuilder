<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="tempinsert.aspx.cs" Inherits="quearybuilder.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/jquery-3.4.1.min.js"></script>

   <div>
       <div class="text-center bg-dark text-light">
           <h1>INSERT</h1>

       </div>
       <br />
       <br />
       <div>
           <div class="row ">
               <div class="col-3 mx-3">
                     <asp:Label  runat="server" class="form-control" Text="insert"> INSERT</asp:Label>
               </div>
               <div class="col-3 mx-3">
                      <asp:Label  runat="server" class="form-control" Text="into"> INTO</asp:Label>
               </div>
               <div  class="col-3 mx-3 text-center">


                   
                   <asp:CheckBoxList CssClass="text-center " ID="CheckBoxList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="COLUMN_NAME" DataValueField="COLUMN_NAME" BorderWidth="2px">
           </asp:CheckBoxList>
                   <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:employeeConnectionString %>" SelectCommand="
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE  TABLE_NAME = 'employee';

"></asp:SqlDataSource>

                   
                   

               

               </div>
               <div class="col">
                    <button id="button2" type="button" class="btn btn-danger">ADD</button>
               </div>



           </div>

           

           <br />
           <br />

           
            <div class="row ">
               <div class="col mx-3" id="one">
                  
                     
               </div>
               


           </div>
           <br />
           <br />
            <div class="row ">
               <div class="col-8 mx-3">
                   <asp:TextBox ID="textbox4" runat="server" Class="form-control" />
                     
                   </div>
                <div class="col-2">
                    <%--<asp:Button ID="button1" Class="btn btn-success" runat="server" Text="RUN"/>--%>
                    <button id="button1" type="button" class="btn btn-success">RUN</button>
                </div>
             </div>

         
           
       </div>
       


      
      
   </div>
    <script>
        $(document).ready(function () {
            var number;
            $("#button2").click(function(){
               
                number = $("#<%= CheckBoxList1.ClientID %> input[type='checkbox']:checked").length;
               

                for (var num = 0; num <number;num++) {
                    var val1 = $("<input>").attr("type","text").attr("id", "textbox" + num).addClass("form-control");
                    $("#one").append(val1);
                    $("#one").append("<br />");



                };
            });

            $("#button1").click(function(){ 
               
                var iteamValues = []; 


                console.log(number);
               
                for (var num = 0; num < number; num++) {
                    var iteam = $("#textbox" + num).val();
                    
                        iteamValues.push("'" + iteam + "'"); 
                    
                }
                console.log(iteamValues);

                
                var text1 = "INSERT INTO employee VALUES (" + iteamValues.join(", ") + ");";
                console.log(text1);
               

                $("#textbox4").val(text1);
                alert(text1);
            });

         
        }); 
    </script>
</asp:Content>
