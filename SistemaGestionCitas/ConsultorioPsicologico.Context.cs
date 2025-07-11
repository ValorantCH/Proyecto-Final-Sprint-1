﻿//------------------------------------------------------------------------------
// <auto-generated>
//    Este código se generó a partir de una plantilla.
//
//    Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//    Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SistemaGestionCitas
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Objects;
    using System.Data.Objects.DataClasses;
    using System.Linq;
    
    public partial class ResilientesCuscoEntities : DbContext
    {
        public ResilientesCuscoEntities()
            : base("name=ResilientesCuscoEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public DbSet<Citas> Citas { get; set; }
        public DbSet<HistoriasClinicas> HistoriasClinicas { get; set; }
        public DbSet<Pacientes> Pacientes { get; set; }
        public DbSet<Psicologos> Psicologos { get; set; }
    
        public virtual int sp_ActualizarCita(Nullable<int> citaID, Nullable<int> pacienteID, Nullable<int> psicologoID, Nullable<System.DateTime> fechaHoraCita, string tipoCita, string estado, string notas)
        {
            var citaIDParameter = citaID.HasValue ?
                new ObjectParameter("CitaID", citaID) :
                new ObjectParameter("CitaID", typeof(int));
    
            var pacienteIDParameter = pacienteID.HasValue ?
                new ObjectParameter("PacienteID", pacienteID) :
                new ObjectParameter("PacienteID", typeof(int));
    
            var psicologoIDParameter = psicologoID.HasValue ?
                new ObjectParameter("PsicologoID", psicologoID) :
                new ObjectParameter("PsicologoID", typeof(int));
    
            var fechaHoraCitaParameter = fechaHoraCita.HasValue ?
                new ObjectParameter("FechaHoraCita", fechaHoraCita) :
                new ObjectParameter("FechaHoraCita", typeof(System.DateTime));
    
            var tipoCitaParameter = tipoCita != null ?
                new ObjectParameter("TipoCita", tipoCita) :
                new ObjectParameter("TipoCita", typeof(string));
    
            var estadoParameter = estado != null ?
                new ObjectParameter("Estado", estado) :
                new ObjectParameter("Estado", typeof(string));
    
            var notasParameter = notas != null ?
                new ObjectParameter("Notas", notas) :
                new ObjectParameter("Notas", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_ActualizarCita", citaIDParameter, pacienteIDParameter, psicologoIDParameter, fechaHoraCitaParameter, tipoCitaParameter, estadoParameter, notasParameter);
        }
    
        public virtual int sp_ActualizarHistoriaClinica(Nullable<int> historiaID, Nullable<int> pacienteID, Nullable<int> citaID, string diagnostico, string planTratamiento, string observaciones)
        {
            var historiaIDParameter = historiaID.HasValue ?
                new ObjectParameter("HistoriaID", historiaID) :
                new ObjectParameter("HistoriaID", typeof(int));
    
            var pacienteIDParameter = pacienteID.HasValue ?
                new ObjectParameter("PacienteID", pacienteID) :
                new ObjectParameter("PacienteID", typeof(int));
    
            var citaIDParameter = citaID.HasValue ?
                new ObjectParameter("CitaID", citaID) :
                new ObjectParameter("CitaID", typeof(int));
    
            var diagnosticoParameter = diagnostico != null ?
                new ObjectParameter("Diagnostico", diagnostico) :
                new ObjectParameter("Diagnostico", typeof(string));
    
            var planTratamientoParameter = planTratamiento != null ?
                new ObjectParameter("PlanTratamiento", planTratamiento) :
                new ObjectParameter("PlanTratamiento", typeof(string));
    
            var observacionesParameter = observaciones != null ?
                new ObjectParameter("Observaciones", observaciones) :
                new ObjectParameter("Observaciones", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_ActualizarHistoriaClinica", historiaIDParameter, pacienteIDParameter, citaIDParameter, diagnosticoParameter, planTratamientoParameter, observacionesParameter);
        }
    
        public virtual int sp_ActualizarPaciente(Nullable<int> pacienteID, string nombre, string apellido, string numeroDocumento, string correo, string telefono, string direccion, Nullable<System.DateTime> fechaNacimiento)
        {
            var pacienteIDParameter = pacienteID.HasValue ?
                new ObjectParameter("PacienteID", pacienteID) :
                new ObjectParameter("PacienteID", typeof(int));
    
            var nombreParameter = nombre != null ?
                new ObjectParameter("Nombre", nombre) :
                new ObjectParameter("Nombre", typeof(string));
    
            var apellidoParameter = apellido != null ?
                new ObjectParameter("Apellido", apellido) :
                new ObjectParameter("Apellido", typeof(string));
    
            var numeroDocumentoParameter = numeroDocumento != null ?
                new ObjectParameter("NumeroDocumento", numeroDocumento) :
                new ObjectParameter("NumeroDocumento", typeof(string));
    
            var correoParameter = correo != null ?
                new ObjectParameter("Correo", correo) :
                new ObjectParameter("Correo", typeof(string));
    
            var telefonoParameter = telefono != null ?
                new ObjectParameter("Telefono", telefono) :
                new ObjectParameter("Telefono", typeof(string));
    
            var direccionParameter = direccion != null ?
                new ObjectParameter("Direccion", direccion) :
                new ObjectParameter("Direccion", typeof(string));
    
            var fechaNacimientoParameter = fechaNacimiento.HasValue ?
                new ObjectParameter("FechaNacimiento", fechaNacimiento) :
                new ObjectParameter("FechaNacimiento", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_ActualizarPaciente", pacienteIDParameter, nombreParameter, apellidoParameter, numeroDocumentoParameter, correoParameter, telefonoParameter, direccionParameter, fechaNacimientoParameter);
        }
    
        public virtual int sp_ActualizarPsicologo(Nullable<int> psicologoID, string nombre, string apellido, string numeroLicencia, string correo, string telefono, string especialidad)
        {
            var psicologoIDParameter = psicologoID.HasValue ?
                new ObjectParameter("PsicologoID", psicologoID) :
                new ObjectParameter("PsicologoID", typeof(int));
    
            var nombreParameter = nombre != null ?
                new ObjectParameter("Nombre", nombre) :
                new ObjectParameter("Nombre", typeof(string));
    
            var apellidoParameter = apellido != null ?
                new ObjectParameter("Apellido", apellido) :
                new ObjectParameter("Apellido", typeof(string));
    
            var numeroLicenciaParameter = numeroLicencia != null ?
                new ObjectParameter("NumeroLicencia", numeroLicencia) :
                new ObjectParameter("NumeroLicencia", typeof(string));
    
            var correoParameter = correo != null ?
                new ObjectParameter("Correo", correo) :
                new ObjectParameter("Correo", typeof(string));
    
            var telefonoParameter = telefono != null ?
                new ObjectParameter("Telefono", telefono) :
                new ObjectParameter("Telefono", typeof(string));
    
            var especialidadParameter = especialidad != null ?
                new ObjectParameter("Especialidad", especialidad) :
                new ObjectParameter("Especialidad", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_ActualizarPsicologo", psicologoIDParameter, nombreParameter, apellidoParameter, numeroLicenciaParameter, correoParameter, telefonoParameter, especialidadParameter);
        }
    
        public virtual ObjectResult<Nullable<decimal>> sp_CrearCita(Nullable<int> pacienteID, Nullable<int> psicologoID, Nullable<System.DateTime> fechaHoraCita, string tipoCita, string notas)
        {
            var pacienteIDParameter = pacienteID.HasValue ?
                new ObjectParameter("PacienteID", pacienteID) :
                new ObjectParameter("PacienteID", typeof(int));
    
            var psicologoIDParameter = psicologoID.HasValue ?
                new ObjectParameter("PsicologoID", psicologoID) :
                new ObjectParameter("PsicologoID", typeof(int));
    
            var fechaHoraCitaParameter = fechaHoraCita.HasValue ?
                new ObjectParameter("FechaHoraCita", fechaHoraCita) :
                new ObjectParameter("FechaHoraCita", typeof(System.DateTime));
    
            var tipoCitaParameter = tipoCita != null ?
                new ObjectParameter("TipoCita", tipoCita) :
                new ObjectParameter("TipoCita", typeof(string));
    
            var notasParameter = notas != null ?
                new ObjectParameter("Notas", notas) :
                new ObjectParameter("Notas", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Nullable<decimal>>("sp_CrearCita", pacienteIDParameter, psicologoIDParameter, fechaHoraCitaParameter, tipoCitaParameter, notasParameter);
        }
    
        public virtual ObjectResult<Nullable<decimal>> sp_CrearHistoriaClinica(Nullable<int> pacienteID, Nullable<int> citaID, string diagnostico, string planTratamiento, string observaciones)
        {
            var pacienteIDParameter = pacienteID.HasValue ?
                new ObjectParameter("PacienteID", pacienteID) :
                new ObjectParameter("PacienteID", typeof(int));
    
            var citaIDParameter = citaID.HasValue ?
                new ObjectParameter("CitaID", citaID) :
                new ObjectParameter("CitaID", typeof(int));
    
            var diagnosticoParameter = diagnostico != null ?
                new ObjectParameter("Diagnostico", diagnostico) :
                new ObjectParameter("Diagnostico", typeof(string));
    
            var planTratamientoParameter = planTratamiento != null ?
                new ObjectParameter("PlanTratamiento", planTratamiento) :
                new ObjectParameter("PlanTratamiento", typeof(string));
    
            var observacionesParameter = observaciones != null ?
                new ObjectParameter("Observaciones", observaciones) :
                new ObjectParameter("Observaciones", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Nullable<decimal>>("sp_CrearHistoriaClinica", pacienteIDParameter, citaIDParameter, diagnosticoParameter, planTratamientoParameter, observacionesParameter);
        }
    
        public virtual ObjectResult<Nullable<decimal>> sp_CrearPaciente(string nombre, string apellido, string numeroDocumento, string correo, string telefono, string direccion, Nullable<System.DateTime> fechaNacimiento)
        {
            var nombreParameter = nombre != null ?
                new ObjectParameter("Nombre", nombre) :
                new ObjectParameter("Nombre", typeof(string));
    
            var apellidoParameter = apellido != null ?
                new ObjectParameter("Apellido", apellido) :
                new ObjectParameter("Apellido", typeof(string));
    
            var numeroDocumentoParameter = numeroDocumento != null ?
                new ObjectParameter("NumeroDocumento", numeroDocumento) :
                new ObjectParameter("NumeroDocumento", typeof(string));
    
            var correoParameter = correo != null ?
                new ObjectParameter("Correo", correo) :
                new ObjectParameter("Correo", typeof(string));
    
            var telefonoParameter = telefono != null ?
                new ObjectParameter("Telefono", telefono) :
                new ObjectParameter("Telefono", typeof(string));
    
            var direccionParameter = direccion != null ?
                new ObjectParameter("Direccion", direccion) :
                new ObjectParameter("Direccion", typeof(string));
    
            var fechaNacimientoParameter = fechaNacimiento.HasValue ?
                new ObjectParameter("FechaNacimiento", fechaNacimiento) :
                new ObjectParameter("FechaNacimiento", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Nullable<decimal>>("sp_CrearPaciente", nombreParameter, apellidoParameter, numeroDocumentoParameter, correoParameter, telefonoParameter, direccionParameter, fechaNacimientoParameter);
        }
    
        public virtual ObjectResult<Nullable<decimal>> sp_CrearPsicologo(string nombre, string apellido, string numeroLicencia, string correo, string telefono, string especialidad)
        {
            var nombreParameter = nombre != null ?
                new ObjectParameter("Nombre", nombre) :
                new ObjectParameter("Nombre", typeof(string));
    
            var apellidoParameter = apellido != null ?
                new ObjectParameter("Apellido", apellido) :
                new ObjectParameter("Apellido", typeof(string));
    
            var numeroLicenciaParameter = numeroLicencia != null ?
                new ObjectParameter("NumeroLicencia", numeroLicencia) :
                new ObjectParameter("NumeroLicencia", typeof(string));
    
            var correoParameter = correo != null ?
                new ObjectParameter("Correo", correo) :
                new ObjectParameter("Correo", typeof(string));
    
            var telefonoParameter = telefono != null ?
                new ObjectParameter("Telefono", telefono) :
                new ObjectParameter("Telefono", typeof(string));
    
            var especialidadParameter = especialidad != null ?
                new ObjectParameter("Especialidad", especialidad) :
                new ObjectParameter("Especialidad", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Nullable<decimal>>("sp_CrearPsicologo", nombreParameter, apellidoParameter, numeroLicenciaParameter, correoParameter, telefonoParameter, especialidadParameter);
        }
    
        public virtual int sp_EliminarCita(Nullable<int> citaID)
        {
            var citaIDParameter = citaID.HasValue ?
                new ObjectParameter("CitaID", citaID) :
                new ObjectParameter("CitaID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_EliminarCita", citaIDParameter);
        }
    
        public virtual int sp_EliminarHistoriaClinica(Nullable<int> historiaID)
        {
            var historiaIDParameter = historiaID.HasValue ?
                new ObjectParameter("HistoriaID", historiaID) :
                new ObjectParameter("HistoriaID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_EliminarHistoriaClinica", historiaIDParameter);
        }
    
        public virtual int sp_EliminarPaciente(Nullable<int> pacienteID)
        {
            var pacienteIDParameter = pacienteID.HasValue ?
                new ObjectParameter("PacienteID", pacienteID) :
                new ObjectParameter("PacienteID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_EliminarPaciente", pacienteIDParameter);
        }
    
        public virtual int sp_EliminarPsicologo(Nullable<int> psicologoID)
        {
            var psicologoIDParameter = psicologoID.HasValue ?
                new ObjectParameter("PsicologoID", psicologoID) :
                new ObjectParameter("PsicologoID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_EliminarPsicologo", psicologoIDParameter);
        }
    
        public virtual ObjectResult<sp_LeerCitaPorID_Result> sp_LeerCitaPorID(Nullable<int> citaID)
        {
            var citaIDParameter = citaID.HasValue ?
                new ObjectParameter("CitaID", citaID) :
                new ObjectParameter("CitaID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_LeerCitaPorID_Result>("sp_LeerCitaPorID", citaIDParameter);
        }
    
        public virtual ObjectResult<sp_LeerCitas_Result> sp_LeerCitas()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_LeerCitas_Result>("sp_LeerCitas");
        }
    
        public virtual ObjectResult<sp_LeerHistoriaClinicaPorID_Result> sp_LeerHistoriaClinicaPorID(Nullable<int> historiaID)
        {
            var historiaIDParameter = historiaID.HasValue ?
                new ObjectParameter("HistoriaID", historiaID) :
                new ObjectParameter("HistoriaID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_LeerHistoriaClinicaPorID_Result>("sp_LeerHistoriaClinicaPorID", historiaIDParameter);
        }
    
        public virtual ObjectResult<sp_LeerHistoriasClinicas_Result> sp_LeerHistoriasClinicas()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_LeerHistoriasClinicas_Result>("sp_LeerHistoriasClinicas");
        }
    
        public virtual ObjectResult<sp_LeerPacientePorID_Result> sp_LeerPacientePorID(Nullable<int> pacienteID)
        {
            var pacienteIDParameter = pacienteID.HasValue ?
                new ObjectParameter("PacienteID", pacienteID) :
                new ObjectParameter("PacienteID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_LeerPacientePorID_Result>("sp_LeerPacientePorID", pacienteIDParameter);
        }
    
        public virtual ObjectResult<sp_LeerPacientes_Result> sp_LeerPacientes()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_LeerPacientes_Result>("sp_LeerPacientes");
        }
    
        public virtual ObjectResult<sp_LeerPsicologoPorID_Result> sp_LeerPsicologoPorID(Nullable<int> psicologoID)
        {
            var psicologoIDParameter = psicologoID.HasValue ?
                new ObjectParameter("PsicologoID", psicologoID) :
                new ObjectParameter("PsicologoID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_LeerPsicologoPorID_Result>("sp_LeerPsicologoPorID", psicologoIDParameter);
        }
    
        public virtual ObjectResult<sp_LeerPsicologos_Result> sp_LeerPsicologos()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_LeerPsicologos_Result>("sp_LeerPsicologos");
        }
    }
}
