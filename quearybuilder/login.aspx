<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="quearybuilder.login" %>

<!DOCTYPE html>



<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">

</head>
<body>
   



    



    <div class="min-h-screen bg-gray-100 text-gray-900 flex justify-center" style="margin-top:30px">
    <div class="max-w-screen-xl m-0 sm:m-10 bg-white shadow sm:rounded-lg flex justify-center flex-1">
        <div class="lg:w-1/2 xl:w-5/12 p-6 sm:p-12">
            <div>
                <img src="https://cdn.dribbble.com/users/2520294/screenshots/7269423/alaminxyz.gif" class="w-32 mx-auto" />
            </div>
            <div class="mt-12 flex flex-col items-center">
                <h1 class="text-2xl xl:text-3xl font-extrabold">Login</h1>
                <div class="w-full flex-1 mt-8">
                    <div class="mx-auto max-w-xs">
                        <form runat="server">
                            <asp:TextBox
                                runat="server"
                                ID="textbox1"
                                CssClass="w-full px-8 py-4 rounded-lg font-medium bg-gray-100 border border-gray-200 placeholder-gray-500 text-sm focus:outline-none focus:border-gray-400 focus:bg-white"
                                placeholder="Email">
                            </asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter the useremail" ControlToValidate="textbox1" ForeColor="red"></asp:RequiredFieldValidator>

                            <asp:TextBox
                                runat="server"
                                ID="textbox2"
                                TextMode="Password"
                                CssClass="w-full px-8 py-4 rounded-lg font-medium bg-gray-100 border border-gray-200 placeholder-gray-500 text-sm focus:outline-none focus:border-gray-400 focus:bg-white mt-5"
                                placeholder="Password">
                            </asp:TextBox>
                            
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Enter the passsowrd" ControlToValidate="textbox2" ForeColor="red"></asp:RequiredFieldValidator>
                            
                            <asp:Button
                                runat="server"
                                Text="login"
                                onclick="loginin"
                                CssClass="mt-5 tracking-wide font-semibold bg-green-500 text-gray-100 w-full py-4 rounded-lg hover:bg-green-600 transition-all duration-300 ease-in-out flex items-center justify-center focus:shadow-outline focus:outline-none">
                            </asp:Button>
                           <span>Create account</span> <asp:HyperLink Text="Register" ForeColor="Blue" runat="server" NavigateUrl="~/signup.aspx" Target="_self"></asp:HyperLink>

                            <asp:TextBox ID="textbox4" runat="server" CssClass="border-0" ForeColor="red" />
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="flex-1 bg-green-100 text-center hidden lg:flex">
            <div class="m-12 xl:m-16 w-full bg-contain bg-center bg-no-repeat"
                style="background-image:url(https://cdn.dribbble.com/users/2520294/screenshots/7269423/alaminxyz.gif)">
            </div>
        </div>
    </div>
</div>

    </body>
</html>
