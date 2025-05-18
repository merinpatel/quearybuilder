<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="quearybuilder._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/jquery-3.4.1.min.js"></script>

    <main>
      <%--   <div class="container">
           <div class="row">

          
             <div class="col-4 bg-dark text-center text-white" style="height:900px">
                 <h1>Menu</h1>
                 <hr />
                 <asp:Image runat="server" src="/image/database.png"  style="width:20px"/>
                 <asp:Label runat="server" class="mx-4">DATABASE</asp:Label>
                 <asp:TextBox class="form-control-sm" id="textbox1" runat="server" />
                 <br />
                 <br />
                 <ul class="list-unstyled " id="ul1">
                     <li>
                          table1<asp:Image runat="server" src="/image/edit-table.png" style="width:20px" class="mx-3"/>
                     </li>
                     <br />
                     <li>
                          table1<asp:Image runat="server" src="/image/edit-table.png" style="width:20px" class="mx-3"/>
                     </li>
                     <br />

                 </ul>
                 <hr />
                 <h2>QUERY OPTION</h2>
                 <hr />

                 <div>
                     <ul class="list-unstyled text-uppercase text-light">
                        <li class="nav-item"><a class="nav-link" runat="server" href="~/select">select</a></li>
                         <br />
                        <li class="nav-item"><a class="nav-link" runat="server" href="~/insert">Insert</a></li>
                         <br />
                        <li class="nav-item"><a class="nav-link" runat="server" href="~/update">update</a></li>
                         <br />
                          <li class="nav-item"><a class="nav-link" runat="server" href="~/delete">delete</a></li>
                         <br />
                        <li class="nav-item"><a class="nav-link" runat="server" href="~/join">join</a></li>
                         <br />
                        <li class="nav-item"><a class="nav-link" runat="server" href="~/groupby">group by</a></li>
                         <br />
                         <li class="nav-item"><a class="nav-link" runat="server" href="~/orderby">order by</a></li>
                         <br />
                           <li class="nav-item"><a class="nav-link" runat="server" href="~/agregration">agregration</a></li>
                         <br />
                    </ul>
                 </div>

                 <hr />
                 <div class="text-center">
                     <h3>
                         QUERY
                     </h3>

                 </div>


                 

             </div>
             <div class="col-8   text-center">
                 <h1>content</h1>
                
             </div>
                </div>

         </div>

        <script>
            
            $(document).ready(function () {
                var items = ["merin", "greni"];
                $.each(items, function (index, val) {
                   
                    var val1 = $("<li></li>").text(val);

                   
                    var val2 = $("<img>")
                        .attr("src", "/image/edit-table.png")
                        .css("width", "20px")
                        .addClass("mx-3")
                        

                    
                    val1.append(val2);
                    

                   
                    $("#ul1").append(val1);
                    $("#ul1").append("<br/>");
                });
            });

        </script>--%>
    </main>

</asp:Content>
