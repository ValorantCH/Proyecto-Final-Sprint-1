//------------------------------------------------------------------------------
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
    
    public partial class sp_LeerCitaPorID_Result
    {
        public int CitaID { get; set; }
        public int PacienteID { get; set; }
        public string NombrePaciente { get; set; }
        public int PsicologoID { get; set; }
        public string NombrePsicologo { get; set; }
        public System.DateTime FechaHoraCita { get; set; }
        public string TipoCita { get; set; }
        public string Estado { get; set; }
        public string Notas { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
    }
}
