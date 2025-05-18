<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="createtable.aspx.cs" Inherits="quearybuilder.createtable" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <div class="container mt-4 p-4 bg-white shadow rounded border border-2 border-light-subtle">
        <h2 class="text-primary d-flex align-items-center mb-4">
            <a href="~/" runat="server" class="btn btn-outline-secondary me-3">
             
                 <asp:Image runat="server" src="image/back-icon.png" alt="Back" Width="24" Height="24" class="me-2" />
    
            </a>
            <i class="bi bi-table me-2"></i> Create Table - Query Generator
        </h2>

        <div class="mb-4 d-inline">
            <label class="form-label fw-semibold text-dark"><i class="bi bi-pencil-square me-2"></i>Table Name</label>
            <input type="text" id="txtTableName" class="form-control border border-secondary-subtle shadow-sm d-inline" placeholder="Enter table name" required />
               
        </div>
       <div class="d-flex justify-content-end">
    <asp:Button ID="Button1" runat="server" Text="Save" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#saveFileModal" />
</div>

        <%--//--%>
  <div class="modal fade" id="saveFileModal" tabindex="-1" aria-labelledby="saveFileLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg rounded-4 border-0">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title fw-bold" id="saveFileLabel">Save Query</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body bg-light p-4">
                <label class="form-label fw-semibold">Enter File Name</label>
                <asp:TextBox ID="textbox14" runat="server" CssClass="form-control rounded-3 shadow-sm" placeholder="Enter file name..." />
            </div>
            <div class="modal-footer d-flex justify-content-center">
                <asp:Button ID="Button6" runat="server" Text="Save" class="btn btn-primary fw-bold px-4" OnClick="Savequery" />
                <button type="button" class="btn btn-secondary fw-bold px-4 w-auto" data-bs-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
      </div>
           <%--//--%>

        <hr class="my-4" />

        <h4 class="text-secondary mb-3"><i class="bi bi-columns-gap me-2"></i>Columns</h4>
        <div id="columnContainer" class="mb-4">
            <div class="column-row d-flex align-items-center mb-3 gap-2">
                <input type="text" name="columnName[]" class="form-control border shadow-sm" placeholder="Column Name" required />
                <select name="dataType[]" class="form-select border shadow-sm">
                    <option value="INT">INT</option>
                    <option value="VARCHAR(255)">VARCHAR(255)</option>
                    <option value="DATE">DATE</option>
                    <option value="TEXT">TEXT</option>
                </select>
                <select name="constraint[]" class="form-select border shadow-sm">
                    <option value="">None</option>
                    <option value="PRIMARY KEY">PRIMARY KEY</option>
                    <option value="NOT NULL">NOT NULL</option>
                    <option value="UNIQUE">UNIQUE</option>
                </select>
                <button type="button" class="btn btn-outline-danger removeColumn"><i class="bi bi-trash"></i></button>
            </div>
        </div>

        <div class="mb-4">
            <button type="button" id="addColumn" class="btn btn-info text-white me-2 shadow-sm">
                <i class="bi bi-plus-circle me-1"></i> Add Column
            </button>
            <button type="button" id="btnGenerate" class="btn btn-success text-white shadow-sm">
                <i class="bi bi-code-slash me-1"></i> Create Table
            </button>
        </div>

        <h5 class="text-info"><i class="bi bi-terminal me-2"></i>Generated SQL Query</h5>
        <pre id="lblQuery" class="alert alert-light shadow-sm border border-primary rounded p-3"></pre>

        <asp:TextBox ID="textbox16" runat="server" CssClass="d-none" />
        <asp:Button runat="server" ID="button16" CssClass="d-none" OnClick="button16_Click" />


        <asp:HiddenField ID="hiddenDbName" runat="server" />

    </div>

    <style>
        .column-row input,
        .column-row select {
            max-width: 200px;
        }

        .column-row .btn {
            width: 45px;
        }

        #btnGenerate:hover,
        #addColumn:hover {
            transform: scale(1.02);
            transition: 0.2s;
        }

        #lblQuery code {
            white-space: pre-wrap;
            font-family: 'Courier New', monospace;
        }
    </style>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {

            var dbname = localStorage.getItem("database");
            if (dbname) {
                $("#<%= hiddenDbName.ClientID %>").val(dbname);
        }


            $("#addColumn").click(function () {
                var newField = `
                    <div class="column-row d-flex align-items-center mb-3 gap-2">
                        <input type="text" name="columnName[]" class="form-control border shadow-sm" placeholder="Column Name" required />
                        <select name="dataType[]" class="form-select border shadow-sm">
                            <option value="INT">INT</option>
                            <option value="VARCHAR(255)">VARCHAR(255)</option>
                            <option value="DATE">DATE</option>
                            <option value="TEXT">TEXT</option>
                        </select>
                        <select name="constraint[]" class="form-select border shadow-sm">
                            <option value="">None</option>
                            <option value="PRIMARY KEY">PRIMARY KEY</option>
                            <option value="NOT NULL">NOT NULL</option>
                            <option value="UNIQUE">UNIQUE</option>
                        </select>
                        <button type="button" class="btn btn-outline-danger removeColumn"><i class="bi bi-trash"></i></button>
                    </div>`;
                $("#columnContainer").append(newField);
            });

            $(document).on("click", ".removeColumn", function () {
                $(this).closest(".column-row").remove();
            });

            $("#btnGenerate").click(function () {
                var tableName = $("#txtTableName").val().trim();
                if (tableName === "") {
                    $("#lblQuery").html("<span class='text-danger fw-semibold'>Error: Please enter a table name.</span>");
                    return;
                }

                var columns = [];
                var isValid = true;
                $(".column-row").each(function () {
                    var columnName = $(this).find("input[name='columnName[]']").val().trim();
                    var dataType = $(this).find("select[name='dataType[]']").val();
                    var constraint = $(this).find("select[name='constraint[]']").val();

                    if (columnName === "") {
                        $("#lblQuery").html("<span class='text-danger fw-semibold'>Error: Column name cannot be empty.</span>");
                        isValid = false;
                        return false;
                    }

                    var columnDef = `${columnName} ${dataType}`;
                    if (constraint && constraint !== "None") {
                        columnDef += ` ${constraint}`;
                    }

                    columns.push(columnDef);
                });

                if (!isValid || columns.length === 0) return;

                var query = `CREATE TABLE ${tableName} (\n  ${columns.join(",\n  ")}\n);`;

                $("#lblQuery").html(`<code>${query}</code>`);
                $("#<%=textbox16.ClientID %>").val(query);
                $("#<%= button16.ClientID %>").click();
            });
        });
    </script>
</asp:Content>
