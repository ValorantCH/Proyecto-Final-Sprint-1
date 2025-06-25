using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaGestionCitas
{
    public partial class Principal : System.Web.UI.Page
    {
        private string connectionString = "Data Source=.;Initial Catalog=ResilientesCuscoDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MostrarPanel("pnlCitas"); // Mostrar citas por defecto
                CargarPacientes();
                CargarPsicologos();
                CargarCitas();
                CargarHistorias();
            }
        }

        #region Métodos de Navegación
        protected void lnkPacientes_Click(object sender, EventArgs e)
        {
            MostrarPanel("pnlPacientes");
            CargarPacientes();
        }

        protected void lnkPsicologos_Click(object sender, EventArgs e)
        {
            MostrarPanel("pnlPsicologos");
            CargarPsicologos();
        }

        protected void lnkCitas_Click(object sender, EventArgs e)
        {
            MostrarPanel("pnlCitas");
            CargarCitas();
        }

        protected void lnkHistorias_Click(object sender, EventArgs e)
        {
            MostrarPanel("pnlHistorias");
            CargarHistorias();
        }

        private void MostrarPanel(string panelID)
        {
            pnlPacientes.Visible = panelID == "pnlPacientes";
            pnlPsicologos.Visible = panelID == "pnlPsicologos";
            pnlCitas.Visible = panelID == "pnlCitas";
            pnlHistorias.Visible = panelID == "pnlHistorias";
        }
        #endregion

        #region Métodos para Pacientes
        private void CargarPacientes()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_LeerPacientes", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    gvPacientes.DataSource = reader;
                    gvPacientes.DataBind();
                }
            }
        }

        protected void btnNuevoPaciente_Click(object sender, EventArgs e)
        {
            LimpiarFormularioPaciente();
            pnlFormPaciente.Visible = true;
            ViewState["ModoEdicionPaciente"] = false;
        }

        protected void btnGuardarPaciente_Click(object sender, EventArgs e)
        {
            bool modoEdicion = ViewState["ModoEdicionPaciente"] != null && (bool)ViewState["ModoEdicionPaciente"];

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    if (modoEdicion)
                    {
                        using (SqlCommand cmd = new SqlCommand("sp_ActualizarPaciente", con))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@PacienteID", ViewState["PacienteID"]);
                            cmd.Parameters.AddWithValue("@Nombre", txtNombrePaciente.Text);
                            cmd.Parameters.AddWithValue("@Apellido", txtApellidoPaciente.Text);
                            cmd.Parameters.AddWithValue("@NumeroDocumento", txtDocumentoPaciente.Text);
                            cmd.Parameters.AddWithValue("@Correo", txtCorreoPaciente.Text);
                            cmd.Parameters.AddWithValue("@Telefono", txtTelefonoPaciente.Text);
                            cmd.Parameters.AddWithValue("@Direccion", txtDireccionPaciente.Text);
                            cmd.Parameters.AddWithValue("@FechaNacimiento", string.IsNullOrEmpty(txtFechaNacimientoPaciente.Text) ? (object)DBNull.Value : txtFechaNacimientoPaciente.Text);
                            con.Open();
                            cmd.ExecuteNonQuery();
                        }
                        MostrarMensaje("Paciente actualizado correctamente", true);
                    }
                    else
                    {
                        using (SqlCommand cmd = new SqlCommand("sp_CrearPaciente", con))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@Nombre", txtNombrePaciente.Text);
                            cmd.Parameters.AddWithValue("@Apellido", txtApellidoPaciente.Text);
                            cmd.Parameters.AddWithValue("@NumeroDocumento", txtDocumentoPaciente.Text);
                            cmd.Parameters.AddWithValue("@Correo", txtCorreoPaciente.Text);
                            cmd.Parameters.AddWithValue("@Telefono", txtTelefonoPaciente.Text);
                            cmd.Parameters.AddWithValue("@Direccion", txtDireccionPaciente.Text);
                            cmd.Parameters.AddWithValue("@FechaNacimiento", string.IsNullOrEmpty(txtFechaNacimientoPaciente.Text) ? (object)DBNull.Value : txtFechaNacimientoPaciente.Text);
                            con.Open();
                            cmd.ExecuteNonQuery();
                        }
                        MostrarMensaje("Paciente creado correctamente", true);
                    }
                }
                pnlFormPaciente.Visible = false;
                CargarPacientes();
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al guardar paciente: " + ex.Message, false);
            }
        }

        protected void btnCancelarPaciente_Click(object sender, EventArgs e)
        {
            pnlFormPaciente.Visible = false;
        }

        protected void gvPacientes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int pacienteID = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Editar")
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_LeerPacientePorID", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@PacienteID", pacienteID);
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            txtNombrePaciente.Text = reader["Nombre"].ToString();
                            txtApellidoPaciente.Text = reader["Apellido"].ToString();
                            txtDocumentoPaciente.Text = reader["NumeroDocumento"].ToString();
                            txtCorreoPaciente.Text = reader["Correo"].ToString();
                            txtTelefonoPaciente.Text = reader["Telefono"].ToString();
                            txtDireccionPaciente.Text = reader["Direccion"].ToString();
                            txtFechaNacimientoPaciente.Text = reader["FechaNacimiento"] != DBNull.Value ? Convert.ToDateTime(reader["FechaNacimiento"]).ToString("yyyy-MM-dd") : "";

                            ViewState["PacienteID"] = pacienteID;
                            ViewState["ModoEdicionPaciente"] = true;
                            pnlFormPaciente.Visible = true;
                        }
                    }
                }
            }
            else if (e.CommandName == "Eliminar")
            {
                try
                {
                    using (SqlConnection con = new SqlConnection(connectionString))
                    {
                        using (SqlCommand cmd = new SqlCommand("sp_EliminarPaciente", con))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@PacienteID", pacienteID);
                            con.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }
                    MostrarMensaje("Paciente eliminado correctamente", true);
                    CargarPacientes();
                }
                catch (Exception ex)
                {
                    MostrarMensaje("Error al eliminar paciente: " + ex.Message, false);
                }
            }
        }

        private void LimpiarFormularioPaciente()
        {
            txtNombrePaciente.Text = "";
            txtApellidoPaciente.Text = "";
            txtDocumentoPaciente.Text = "";
            txtCorreoPaciente.Text = "";
            txtTelefonoPaciente.Text = "";
            txtDireccionPaciente.Text = "";
            txtFechaNacimientoPaciente.Text = "";
        }
        #endregion

        #region Métodos para Psicólogos
        private void CargarPsicologos()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_LeerPsicologos", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    gvPsicologos.DataSource = reader;
                    gvPsicologos.DataBind();
                }
            }
        }

        protected void btnNuevoPsicologo_Click(object sender, EventArgs e)
        {
            LimpiarFormularioPsicologo();
            pnlFormPsicologo.Visible = true;
            ViewState["ModoEdicionPsicologo"] = false;
        }

        protected void btnGuardarPsicologo_Click(object sender, EventArgs e)
        {
            bool modoEdicion = ViewState["ModoEdicionPsicologo"] != null && (bool)ViewState["ModoEdicionPsicologo"];

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    if (modoEdicion)
                    {
                        using (SqlCommand cmd = new SqlCommand("sp_ActualizarPsicologo", con))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@PsicologoID", ViewState["PsicologoID"]);
                            cmd.Parameters.AddWithValue("@Nombre", txtNombrePsicologo.Text);
                            cmd.Parameters.AddWithValue("@Apellido", txtApellidoPsicologo.Text);
                            cmd.Parameters.AddWithValue("@NumeroLicencia", txtLicenciaPsicologo.Text);
                            cmd.Parameters.AddWithValue("@Correo", txtCorreoPsicologo.Text);
                            cmd.Parameters.AddWithValue("@Telefono", txtTelefonoPsicologo.Text);
                            cmd.Parameters.AddWithValue("@Especialidad", txtEspecialidadPsicologo.Text);
                            con.Open();
                            cmd.ExecuteNonQuery();
                        }
                        MostrarMensaje("Psicólogo actualizado correctamente", true);
                    }
                    else
                    {
                        using (SqlCommand cmd = new SqlCommand("sp_CrearPsicologo", con))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@Nombre", txtNombrePsicologo.Text);
                            cmd.Parameters.AddWithValue("@Apellido", txtApellidoPsicologo.Text);
                            cmd.Parameters.AddWithValue("@NumeroLicencia", txtLicenciaPsicologo.Text);
                            cmd.Parameters.AddWithValue("@Correo", txtCorreoPsicologo.Text);
                            cmd.Parameters.AddWithValue("@Telefono", txtTelefonoPsicologo.Text);
                            cmd.Parameters.AddWithValue("@Especialidad", txtEspecialidadPsicologo.Text);
                            con.Open();
                            cmd.ExecuteNonQuery();
                        }
                        MostrarMensaje("Psicólogo creado correctamente", true);
                    }
                }
                pnlFormPsicologo.Visible = false;
                CargarPsicologos();
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al guardar psicólogo: " + ex.Message, false);
            }
        }

        protected void btnCancelarPsicologo_Click(object sender, EventArgs e)
        {
            pnlFormPsicologo.Visible = false;
        }

        protected void gvPsicologos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int psicologoID = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Editar")
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_LeerPsicologoPorID", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@PsicologoID", psicologoID);
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            txtNombrePsicologo.Text = reader["Nombre"].ToString();
                            txtApellidoPsicologo.Text = reader["Apellido"].ToString();
                            txtLicenciaPsicologo.Text = reader["NumeroLicencia"].ToString();
                            txtCorreoPsicologo.Text = reader["Correo"].ToString();
                            txtTelefonoPsicologo.Text = reader["Telefono"].ToString();
                            txtEspecialidadPsicologo.Text = reader["Especialidad"].ToString();

                            ViewState["PsicologoID"] = psicologoID;
                            ViewState["ModoEdicionPsicologo"] = true;
                            pnlFormPsicologo.Visible = true;
                        }
                    }
                }
            }
            else if (e.CommandName == "Eliminar")
            {
                try
                {
                    using (SqlConnection con = new SqlConnection(connectionString))
                    {
                        using (SqlCommand cmd = new SqlCommand("sp_EliminarPsicologo", con))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@PsicologoID", psicologoID);
                            con.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }
                    MostrarMensaje("Psicólogo eliminado correctamente", true);
                    CargarPsicologos();
                }
                catch (Exception ex)
                {
                    MostrarMensaje("Error al eliminar psicólogo: " + ex.Message, false);
                }
            }
        }

        private void LimpiarFormularioPsicologo()
        {
            txtNombrePsicologo.Text = "";
            txtApellidoPsicologo.Text = "";
            txtLicenciaPsicologo.Text = "";
            txtCorreoPsicologo.Text = "";
            txtTelefonoPsicologo.Text = "";
            txtEspecialidadPsicologo.Text = "";
        }
        #endregion

        #region Métodos para Citas
        private void CargarCitas()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_LeerCitas", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    gvCitas.DataSource = reader;
                    gvCitas.DataBind();
                }
            }
        }

        protected void btnNuevaCita_Click(object sender, EventArgs e)
        {
            LimpiarFormularioCita();
            CargarListaPacientes(ddlPacienteCita);
            CargarListaPsicologos(ddlPsicologoCita);
            pnlFormCita.Visible = true;
            ViewState["ModoEdicionCita"] = false;
        }

        protected void btnGuardarCita_Click(object sender, EventArgs e)
        {
            bool modoEdicion = ViewState["ModoEdicionCita"] != null && (bool)ViewState["ModoEdicionCita"];

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    if (modoEdicion)
                    {
                        using (SqlCommand cmd = new SqlCommand("sp_ActualizarCita", con))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@CitaID", ViewState["CitaID"]);
                            cmd.Parameters.AddWithValue("@PacienteID", ddlPacienteCita.SelectedValue);
                            cmd.Parameters.AddWithValue("@PsicologoID", ddlPsicologoCita.SelectedValue);
                            cmd.Parameters.AddWithValue("@FechaHoraCita", txtFechaCita.Text);
                            cmd.Parameters.AddWithValue("@TipoCita", ddlTipoCita.SelectedValue);
                            cmd.Parameters.AddWithValue("@Estado", ddlEstadoCita.SelectedValue);
                            cmd.Parameters.AddWithValue("@Notas", txtNotasCita.Text);
                            con.Open();
                            cmd.ExecuteNonQuery();
                        }
                        MostrarMensaje("Cita actualizada correctamente", true);
                    }
                    else
                    {
                        using (SqlCommand cmd = new SqlCommand("sp_CrearCita", con))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@PacienteID", ddlPacienteCita.SelectedValue);
                            cmd.Parameters.AddWithValue("@PsicologoID", ddlPsicologoCita.SelectedValue);
                            cmd.Parameters.AddWithValue("@FechaHoraCita", txtFechaCita.Text);
                            cmd.Parameters.AddWithValue("@TipoCita", ddlTipoCita.SelectedValue);
                            cmd.Parameters.AddWithValue("@Notas", txtNotasCita.Text);
                            con.Open();
                            cmd.ExecuteNonQuery();
                        }
                        MostrarMensaje("Cita creada correctamente", true);
                    }
                }
                pnlFormCita.Visible = false;
                CargarCitas();
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al guardar cita: " + ex.Message, false);
            }
        }

        protected void btnCancelarCita_Click(object sender, EventArgs e)
        {
            pnlFormCita.Visible = false;
        }

        protected void gvCitas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int citaID = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Editar")
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_LeerCitaPorID", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@CitaID", citaID);
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            ddlPacienteCita.SelectedValue = reader["PacienteID"].ToString();
                            ddlPsicologoCita.SelectedValue = reader["PsicologoID"].ToString();
                            txtFechaCita.Text = Convert.ToDateTime(reader["FechaHoraCita"]).ToString("yyyy-MM-ddTHH:mm");
                            ddlTipoCita.SelectedValue = reader["TipoCita"].ToString();
                            ddlEstadoCita.SelectedValue = reader["Estado"].ToString();
                            txtNotasCita.Text = reader["Notas"].ToString();

                            ViewState["CitaID"] = citaID;
                            ViewState["ModoEdicionCita"] = true;
                            pnlFormCita.Visible = true;
                        }
                    }
                }
            }
            else if (e.CommandName == "Eliminar")
            {
                try
                {
                    using (SqlConnection con = new SqlConnection(connectionString))
                    {
                        using (SqlCommand cmd = new SqlCommand("sp_EliminarCita", con))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@CitaID", citaID);
                            con.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }
                    MostrarMensaje("Cita cancelada correctamente", true);
                    CargarCitas();
                }
                catch (Exception ex)
                {
                    MostrarMensaje("Error al cancelar cita: " + ex.Message, false);
                }
            }
        }

        private void LimpiarFormularioCita()
        {
            ddlPacienteCita.SelectedIndex = 0;
            ddlPsicologoCita.SelectedIndex = 0;
            txtFechaCita.Text = "";
            ddlTipoCita.SelectedIndex = 0;
            ddlEstadoCita.SelectedIndex = 0;
            txtNotasCita.Text = "";
        }

        private void CargarListaPacientes(DropDownList ddl)
        {
            ddl.Items.Clear();
            ddl.Items.Add(new ListItem("-- Seleccionar Paciente --", ""));

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_LeerPacientes", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        ddl.Items.Add(new ListItem(reader["Nombre"].ToString() + " " + reader["Apellido"].ToString(), reader["PacienteID"].ToString()));
                    }
                }
            }
        }

        private void CargarListaPsicologos(DropDownList ddl)
        {
            ddl.Items.Clear();
            ddl.Items.Add(new ListItem("-- Seleccionar Psicólogo --", ""));

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_LeerPsicologos", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        ddl.Items.Add(new ListItem(reader["Nombre"].ToString() + " " + reader["Apellido"].ToString(), reader["PsicologoID"].ToString()));
                    }
                }
            }
        }
        #endregion

        #region Métodos para Historias Clínicas
        private void CargarHistorias()
        {
            CargarListaPacientes(ddlPacienteHistoria);

            if (ddlPacienteHistoria.SelectedValue != "")
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_LeerHistoriasClinicasPorPaciente", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@PacienteID", ddlPacienteHistoria.SelectedValue);
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        gvHistorias.DataSource = reader;
                        gvHistorias.DataBind();
                    }
                }
            }
        }

        protected void ddlPacienteHistoria_SelectedIndexChanged(object sender, EventArgs e)
        {
            CargarHistorias();
        }

        protected void btnGuardarHistoria_Click(object sender, EventArgs e)
        {
            bool modoEdicion = ViewState["ModoEdicionHistoria"] != null && (bool)ViewState["ModoEdicionHistoria"];

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    if (modoEdicion)
                    {
                        using (SqlCommand cmd = new SqlCommand("sp_ActualizarHistoriaClinica", con))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@HistoriaID", ViewState["HistoriaID"]);
                            cmd.Parameters.AddWithValue("@PacienteID", ddlPacienteHistoria.SelectedValue);
                            cmd.Parameters.AddWithValue("@CitaID", ddlCitaHistoria.SelectedValue);
                            cmd.Parameters.AddWithValue("@Diagnostico", txtDiagnostico.Text);
                            cmd.Parameters.AddWithValue("@PlanTratamiento", txtPlanTratamiento.Text);
                            cmd.Parameters.AddWithValue("@Observaciones", txtObservaciones.Text);
                            con.Open();
                            cmd.ExecuteNonQuery();
                        }
                        MostrarMensaje("Historia clínica actualizada correctamente", true);
                    }
                    else
                    {
                        using (SqlCommand cmd = new SqlCommand("sp_CrearHistoriaClinica", con))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@PacienteID", ddlPacienteHistoria.SelectedValue);
                            cmd.Parameters.AddWithValue("@CitaID", ddlCitaHistoria.SelectedValue);
                            cmd.Parameters.AddWithValue("@Diagnostico", txtDiagnostico.Text);
                            cmd.Parameters.AddWithValue("@PlanTratamiento", txtPlanTratamiento.Text);
                            cmd.Parameters.AddWithValue("@Observaciones", txtObservaciones.Text);
                            con.Open();
                            cmd.ExecuteNonQuery();
                        }
                        MostrarMensaje("Historia clínica creada correctamente", true);
                    }
                }
                pnlFormHistoria.Visible = false;
                CargarHistorias();
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al guardar historia clínica: " + ex.Message, false);
            }
        }

        protected void btnCancelarHistoria_Click(object sender, EventArgs e)
        {
            pnlFormHistoria.Visible = false;
        }

        protected void gvHistorias_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int historiaID = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Editar")
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_LeerHistoriaClinicaPorID", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@HistoriaID", historiaID);
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            ddlPacienteHistoria.SelectedValue = reader["PacienteID"].ToString();
                            ddlCitaHistoria.SelectedValue = reader["CitaID"].ToString();
                            txtDiagnostico.Text = reader["Diagnostico"].ToString();
                            txtPlanTratamiento.Text = reader["PlanTratamiento"].ToString();
                            txtObservaciones.Text = reader["Observaciones"].ToString();

                            ViewState["HistoriaID"] = historiaID;
                            ViewState["ModoEdicionHistoria"] = true;
                            pnlFormHistoria.Visible = true;
                        }
                    }
                }
            }
            else if (e.CommandName == "Eliminar")
            {
                try
                {
                    using (SqlConnection con = new SqlConnection(connectionString))
                    {
                        using (SqlCommand cmd = new SqlCommand("sp_EliminarHistoriaClinica", con))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@HistoriaID", historiaID);
                            con.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }
                    MostrarMensaje("Historia clínica eliminada correctamente", true);
                    CargarHistorias();
                }
                catch (Exception ex)
                {
                    MostrarMensaje("Error al eliminar historia clínica: " + ex.Message, false);
                }
            }
            else if (e.CommandName == "Ver")
            {
                Response.Redirect($"DetalleHistoria.aspx?id={historiaID}");
            }
        }

        private void LimpiarFormularioHistoria()
        {
            txtDiagnostico.Text = "";
            txtPlanTratamiento.Text = "";
            txtObservaciones.Text = "";
        }
        #endregion

        #region Métodos Auxiliares
        private void MostrarMensaje(string mensaje, bool esExito)
        {
            pnlMensaje.Visible = true;
            lblMensaje.Text = mensaje;
            pnlMensaje.CssClass = esExito ? "alert alert-success" : "alert alert-danger";
        }
        #endregion
    }
}