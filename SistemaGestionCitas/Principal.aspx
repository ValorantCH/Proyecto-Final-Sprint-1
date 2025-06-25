<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Principal.aspx.cs" Inherits="SistemaGestionCitas.Principal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Resilientes Cusco - Gestión de Citas</title>
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        .container {
            width: 90%;
            margin: 0 auto;
            padding: 20px;
        }
        .header {
            background-color: #4b6cb7;
            color: white;
            padding: 15px;
            text-align: center;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .menu {
            background-color: #333;
            overflow: hidden;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .menu a {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }
        .menu a:hover {
            background-color: #4b6cb7;
        }
        .content {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .gridView {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }
        .gridView th {
            background-color: #4b6cb7;
            color: white;
            padding: 10px;
            text-align: left;
        }
        .gridView td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        .gridView tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-control {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn {
            background-color: #4b6cb7;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }
        .btn:hover {
            background-color: #3a5a9b;
        }
        .btn-danger {
            background-color: #d9534f;
        }
        .btn-danger:hover {
            background-color: #c9302c;
        }
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
        }
        .alert-success {
            color: #3c763d;
            background-color: #dff0d8;
            border-color: #d6e9c6;
        }
        .alert-danger {
            color: #a94442;
            background-color: #f2dede;
            border-color: #ebccd1;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="header">
                <h1>Resilientes Cusco</h1>
                <h2>Sistema de Gestión de Citas Psicológicas</h2>
            </div>

            <div class="menu">
                <asp:LinkButton ID="lnkPacientes" runat="server" OnClick="lnkPacientes_Click">Pacientes</asp:LinkButton>
                <asp:LinkButton ID="lnkPsicologos" runat="server" OnClick="lnkPsicologos_Click">Psicólogos</asp:LinkButton>
                <asp:LinkButton ID="lnkCitas" runat="server" OnClick="lnkCitas_Click">Citas</asp:LinkButton>
                <asp:LinkButton ID="lnkHistorias" runat="server" OnClick="lnkHistorias_Click">Historias Clínicas</asp:LinkButton>
            </div>

            <div class="content">
                <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="alert">
                    <asp:Label ID="lblMensaje" runat="server" Text=""></asp:Label>
                </asp:Panel>

                <!-- Panel de Pacientes -->
                <asp:Panel ID="pnlPacientes" runat="server" Visible="false">
                    <h3>Gestión de Pacientes</h3>
                    <div class="form-group">
                        <asp:Button ID="btnNuevoPaciente" runat="server" Text="Nuevo Paciente" CssClass="btn" OnClick="btnNuevoPaciente_Click" />
                    </div>
                    
                    <asp:Panel ID="pnlFormPaciente" runat="server" Visible="false">
                        <div class="form-group">
                            <label for="txtNombrePaciente">Nombre:</label>
                            <asp:TextBox ID="txtNombrePaciente" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtApellidoPaciente">Apellido:</label>
                            <asp:TextBox ID="txtApellidoPaciente" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtDocumentoPaciente">Número de Documento:</label>
                            <asp:TextBox ID="txtDocumentoPaciente" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtCorreoPaciente">Correo:</label>
                            <asp:TextBox ID="txtCorreoPaciente" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtTelefonoPaciente">Teléfono:</label>
                            <asp:TextBox ID="txtTelefonoPaciente" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtDireccionPaciente">Dirección:</label>
                            <asp:TextBox ID="txtDireccionPaciente" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtFechaNacimientoPaciente">Fecha de Nacimiento:</label>
                            <asp:TextBox ID="txtFechaNacimientoPaciente" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Button ID="btnGuardarPaciente" runat="server" Text="Guardar" CssClass="btn" OnClick="btnGuardarPaciente_Click" />
                            <asp:Button ID="btnCancelarPaciente" runat="server" Text="Cancelar" CssClass="btn btn-danger" OnClick="btnCancelarPaciente_Click" />
                        </div>
                    </asp:Panel>

                    <asp:GridView ID="gvPacientes" runat="server" CssClass="gridView" AutoGenerateColumns="False" 
                        OnRowCommand="gvPacientes_RowCommand" DataKeyNames="PacienteID">
                        <Columns>
                            <asp:BoundField DataField="PacienteID" HeaderText="ID" />
                            <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                            <asp:BoundField DataField="Apellido" HeaderText="Apellido" />
                            <asp:BoundField DataField="NumeroDocumento" HeaderText="Documento" />
                            <asp:BoundField DataField="Correo" HeaderText="Correo" />
                            <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkEditarPaciente" runat="server" CommandName="Editar" CommandArgument='<%# Eval("PacienteID") %>' Text="Editar"></asp:LinkButton>
                                    <asp:LinkButton ID="lnkEliminarPaciente" runat="server" CommandName="Eliminar" CommandArgument='<%# Eval("PacienteID") %>' Text="Eliminar" OnClientClick="return confirm('¿Está seguro de eliminar este paciente?');"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </asp:Panel>

                <!-- Panel de Psicólogos -->
                <asp:Panel ID="pnlPsicologos" runat="server" Visible="false">
                    <h3>Gestión de Psicólogos</h3>
                    <div class="form-group">
                        <asp:Button ID="btnNuevoPsicologo" runat="server" Text="Nuevo Psicólogo" CssClass="btn" OnClick="btnNuevoPsicologo_Click" />
                    </div>
                    
                    <asp:Panel ID="pnlFormPsicologo" runat="server" Visible="false">
                        <div class="form-group">
                            <label for="txtNombrePsicologo">Nombre:</label>
                            <asp:TextBox ID="txtNombrePsicologo" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtApellidoPsicologo">Apellido:</label>
                            <asp:TextBox ID="txtApellidoPsicologo" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtLicenciaPsicologo">Número de Licencia:</label>
                            <asp:TextBox ID="txtLicenciaPsicologo" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtCorreoPsicologo">Correo:</label>
                            <asp:TextBox ID="txtCorreoPsicologo" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtTelefonoPsicologo">Teléfono:</label>
                            <asp:TextBox ID="txtTelefonoPsicologo" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtEspecialidadPsicologo">Especialidad:</label>
                            <asp:TextBox ID="txtEspecialidadPsicologo" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Button ID="btnGuardarPsicologo" runat="server" Text="Guardar" CssClass="btn" OnClick="btnGuardarPsicologo_Click" />
                            <asp:Button ID="btnCancelarPsicologo" runat="server" Text="Cancelar" CssClass="btn btn-danger" OnClick="btnCancelarPsicologo_Click" />
                        </div>
                    </asp:Panel>

                    <asp:GridView ID="gvPsicologos" runat="server" CssClass="gridView" AutoGenerateColumns="False" 
                        OnRowCommand="gvPsicologos_RowCommand" DataKeyNames="PsicologoID">
                        <Columns>
                            <asp:BoundField DataField="PsicologoID" HeaderText="ID" />
                            <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                            <asp:BoundField DataField="Apellido" HeaderText="Apellido" />
                            <asp:BoundField DataField="NumeroLicencia" HeaderText="Licencia" />
                            <asp:BoundField DataField="Especialidad" HeaderText="Especialidad" />
                            <asp:BoundField DataField="Correo" HeaderText="Correo" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkEditarPsicologo" runat="server" CommandName="Editar" CommandArgument='<%# Eval("PsicologoID") %>' Text="Editar"></asp:LinkButton>
                                    <asp:LinkButton ID="lnkEliminarPsicologo" runat="server" CommandName="Eliminar" CommandArgument='<%# Eval("PsicologoID") %>' Text="Eliminar" OnClientClick="return confirm('¿Está seguro de eliminar este psicólogo?');"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </asp:Panel>

                <!-- Panel de Citas -->
                <asp:Panel ID="pnlCitas" runat="server" Visible="false">
                    <h3>Gestión de Citas</h3>
                    <div class="form-group">
                        <asp:Button ID="btnNuevaCita" runat="server" Text="Nueva Cita" CssClass="btn" OnClick="btnNuevaCita_Click" />
                    </div>
                    
                    <asp:Panel ID="pnlFormCita" runat="server" Visible="false">
                        <div class="form-group">
                            <label for="ddlPacienteCita">Paciente:</label>
                            <asp:DropDownList ID="ddlPacienteCita" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label for="ddlPsicologoCita">Psicólogo:</label>
                            <asp:DropDownList ID="ddlPsicologoCita" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label for="txtFechaCita">Fecha y Hora:</label>
                            <asp:TextBox ID="txtFechaCita" runat="server" CssClass="form-control" TextMode="DateTimeLocal"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="ddlTipoCita">Tipo de Cita:</label>
                            <asp:DropDownList ID="ddlTipoCita" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Presencial" Value="Presencial"></asp:ListItem>
                                <asp:ListItem Text="Virtual" Value="Virtual"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label for="ddlEstadoCita">Estado:</label>
                            <asp:DropDownList ID="ddlEstadoCita" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Programada" Value="Programada"></asp:ListItem>
                                <asp:ListItem Text="Completada" Value="Completada"></asp:ListItem>
                                <asp:ListItem Text="Cancelada" Value="Cancelada"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label for="txtNotasCita">Notas:</label>
                            <asp:TextBox ID="txtNotasCita" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Button ID="btnGuardarCita" runat="server" Text="Guardar" CssClass="btn" OnClick="btnGuardarCita_Click" />
                            <asp:Button ID="btnCancelarCita" runat="server" Text="Cancelar" CssClass="btn btn-danger" OnClick="btnCancelarCita_Click" />
                        </div>
                    </asp:Panel>

                    <asp:GridView ID="gvCitas" runat="server" CssClass="gridView" AutoGenerateColumns="False" 
                        OnRowCommand="gvCitas_RowCommand" DataKeyNames="CitaID">
                        <Columns>
                            <asp:BoundField DataField="CitaID" HeaderText="ID" />
                            <asp:BoundField DataField="NombrePaciente" HeaderText="Paciente" />
                            <asp:BoundField DataField="NombrePsicologo" HeaderText="Psicólogo" />
                            <asp:BoundField DataField="FechaHoraCita" HeaderText="Fecha y Hora" DataFormatString="{0:g}" />
                            <asp:BoundField DataField="TipoCita" HeaderText="Tipo" />
                            <asp:BoundField DataField="Estado" HeaderText="Estado" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkEditarCita" runat="server" CommandName="Editar" CommandArgument='<%# Eval("CitaID") %>' Text="Editar"></asp:LinkButton>
                                    <asp:LinkButton ID="lnkEliminarCita" runat="server" CommandName="Eliminar" CommandArgument='<%# Eval("CitaID") %>' Text="Cancelar" OnClientClick="return confirm('¿Está seguro de cancelar esta cita?');"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </asp:Panel>

                <!-- Panel de Historias Clínicas -->
                <asp:Panel ID="pnlHistorias" runat="server" Visible="false">
                    <h3>Historias Clínicas</h3>
                    <div class="form-group">
                        <label for="ddlPacienteHistoria">Seleccionar Paciente:</label>
                        <asp:DropDownList ID="ddlPacienteHistoria" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlPacienteHistoria_SelectedIndexChanged"></asp:DropDownList>
                    </div>
                    
                    <asp:Panel ID="pnlFormHistoria" runat="server" Visible="false">
                        <div class="form-group">
                            <label for="ddlCitaHistoria">Cita asociada:</label>
                            <asp:DropDownList ID="ddlCitaHistoria" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label for="txtDiagnostico">Diagnóstico:</label>
                            <asp:TextBox ID="txtDiagnostico" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtPlanTratamiento">Plan de Tratamiento:</label>
                            <asp:TextBox ID="txtPlanTratamiento" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtObservaciones">Observaciones:</label>
                            <asp:TextBox ID="txtObservaciones" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <asp:Button ID="btnGuardarHistoria" runat="server" Text="Guardar" CssClass="btn" OnClick="btnGuardarHistoria_Click" />
                            <asp:Button ID="btnCancelarHistoria" runat="server" Text="Cancelar" CssClass="btn btn-danger" OnClick="btnCancelarHistoria_Click" />
                        </div>
                    </asp:Panel>

                    <asp:GridView ID="gvHistorias" runat="server" CssClass="gridView" AutoGenerateColumns="False" 
                        OnRowCommand="gvHistorias_RowCommand" DataKeyNames="HistoriaID">
                        <Columns>
                            <asp:BoundField DataField="HistoriaID" HeaderText="ID" />
                            <asp:BoundField DataField="NombrePaciente" HeaderText="Paciente" />
                            <asp:BoundField DataField="CitaID" HeaderText="Cita ID" />
                            <asp:BoundField DataField="FechaCreacion" HeaderText="Fecha" DataFormatString="{0:d}" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkVerHistoria" runat="server" CommandName="Ver" CommandArgument='<%# Eval("HistoriaID") %>' Text="Ver"></asp:LinkButton>
                                    <asp:LinkButton ID="lnkEditarHistoria" runat="server" CommandName="Editar" CommandArgument='<%# Eval("HistoriaID") %>' Text="Editar"></asp:LinkButton>
                                    <asp:LinkButton ID="lnkEliminarHistoria" runat="server" CommandName="Eliminar" CommandArgument='<%# Eval("HistoriaID") %>' Text="Eliminar" OnClientClick="return confirm('¿Está seguro de eliminar esta historia clínica?');"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </asp:Panel>
            </div>
        </div>
    </form>
</body>
</html>