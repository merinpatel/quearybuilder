<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signup.aspx.cs" Inherits="quearybuilder.signup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
                <h1 class="text-2xl xl:text-3xl font-extrabold">Sign In</h1>
                <div class="w-full flex-1 mt-8">
                    <div class="mx-auto max-w-xs">
                        <form runat="server">
                            <asp:TextBox
                                runat="server"
                                ID="textbox1"
                                CssClass="w-full px-8 py-4 rounded-lg font-medium bg-gray-100 border border-gray-200 placeholder-gray-500 text-sm focus:outline-none focus:border-gray-400 focus:bg-white"
                                placeholder="Email">
                            </asp:TextBox>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter the user name" ControlToValidate="textbox1" ForeColor="Red" ValidateRequestMode="Enabled"></asp:RequiredFieldValidator>
                            <asp:TextBox
                                runat="server"
                                ID="textbox2"
                                TextMode="Password"
                                CssClass="w-full px-8 py-4 rounded-lg font-medium bg-gray-100 border border-gray-200 placeholder-gray-500 text-sm focus:outline-none focus:border-gray-400 focus:bg-white mt-5"
                                placeholder="Password">
                            </asp:TextBox>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Enter the password" ControlToValidate="textbox2" ForeColor="Red"></asp:RequiredFieldValidator>
                          
                             <asp:TextBox
                                runat="server"
                                ID="textbox3"
                                TextMode="Password"
                                CssClass="w-full px-8 py-4 rounded-lg font-medium bg-gray-100 border border-gray-200 placeholder-gray-500 text-sm focus:outline-none focus:border-gray-400 focus:bg-white mt-5"
                                placeholder="Conform Password">
                            </asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter the conform password" ControlToValidate="textbox3" ForeColor="Red"></asp:RequiredFieldValidator>
                            <br />
                               <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="confrom password not match" ControlToValidate="textbox3" ForeColor="Red" ValueToCompare="textbox2" ControlToCompare="textbox2"></asp:CompareValidator>
                            <asp:Button
                                runat="server"
                                Text="Register"
                                onclick="register"

                                CssClass="mt-5 tracking-wide font-semibold bg-green-500 text-gray-100 w-full py-4 rounded-lg hover:bg-green-600 transition-all duration-300 ease-in-out flex items-center justify-center focus:shadow-outline focus:outline-none">
                            </asp:Button>

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
