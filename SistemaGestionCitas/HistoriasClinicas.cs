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
    using System.Collections.Generic;
    
    public partial class HistoriasClinicas
    {
        public int HistoriaID { get; set; }
        public int PacienteID { get; set; }
        public int CitaID { get; set; }
        public string Diagnostico { get; set; }
        public string PlanTratamiento { get; set; }
        public string Observaciones { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
    
        public virtual Citas Citas { get; set; }
        public virtual Pacientes Pacientes { get; set; }
    }
}
