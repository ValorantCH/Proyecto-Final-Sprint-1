-- Usando la base de datos
USE ResilientesCuscoDB;
GO

-- Procedimientos para Pacientes
-- Crear Paciente
CREATE PROCEDURE sp_CrearPaciente
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @NumeroDocumento NVARCHAR(20),
    @Correo NVARCHAR(100),
    @Telefono NVARCHAR(15) = NULL,
    @Direccion NVARCHAR(200) = NULL,
    @FechaNacimiento DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        INSERT INTO Pacientes (Nombre, Apellido, NumeroDocumento, Correo, Telefono, Direccion, FechaNacimiento)
        VALUES (@Nombre, @Apellido, @NumeroDocumento, @Correo, @Telefono, @Direccion, @FechaNacimiento);
        SELECT SCOPE_IDENTITY() AS PacienteID;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

-- Leer Todos los Pacientes
CREATE PROCEDURE sp_LeerPacientes
AS
BEGIN
    SET NOCOUNT ON;
    SELECT PacienteID, Nombre, Apellido, NumeroDocumento, Correo, Telefono, Direccion, FechaNacimiento, FechaCreacion
    FROM Pacientes
    ORDER BY Apellido, Nombre;
END;
GO

-- Leer Paciente por ID
CREATE PROCEDURE sp_LeerPacientePorID
    @PacienteID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT PacienteID, Nombre, Apellido, NumeroDocumento, Correo, Telefono, Direccion, FechaNacimiento, FechaCreacion
    FROM Pacientes
    WHERE PacienteID = @PacienteID;
END;
GO

-- Actualizar Paciente
CREATE PROCEDURE sp_ActualizarPaciente
    @PacienteID INT,
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @NumeroDocumento NVARCHAR(20),
    @Correo NVARCHAR(100),
    @Telefono NVARCHAR(15) = NULL,
    @Direccion NVARCHAR(200) = NULL,
    @FechaNacimiento DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        UPDATE Pacientes
        SET Nombre = @Nombre,
            Apellido = @Apellido,
            NumeroDocumento = @NumeroDocumento,
            Correo = @Correo,
            Telefono = @Telefono,
            Direccion = @Direccion,
            FechaNacimiento = @FechaNacimiento
        WHERE PacienteID = @PacienteID;
        IF @@ROWCOUNT = 0
            RAISERROR ('Paciente no encontrado', 16, 1);
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

-- Eliminar Paciente (Eliminación lógica para proteger datos sensibles)
CREATE PROCEDURE sp_EliminarPaciente
    @PacienteID INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Citas WHERE PacienteID = @PacienteID AND Estado != 'Cancelada')
            RAISERROR ('No se puede eliminar el paciente porque tiene citas activas', 16, 1);
        ELSE
            DELETE FROM Pacientes WHERE PacienteID = @PacienteID;
            IF @@ROWCOUNT = 0
                RAISERROR ('Paciente no encontrado', 16, 1);
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

-- Procedimientos para Psicologos
-- Crear Psicologo
CREATE PROCEDURE sp_CrearPsicologo
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @NumeroLicencia NVARCHAR(20),
    @Correo NVARCHAR(100),
    @Telefono NVARCHAR(15) = NULL,
    @Especialidad NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        INSERT INTO Psicologos (Nombre, Apellido, NumeroLicencia, Correo, Telefono, Especialidad)
        VALUES (@Nombre, @Apellido, @NumeroLicencia, @Correo, @Telefono, @Especialidad);
        SELECT SCOPE_IDENTITY() AS PsicologoID;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

-- Leer Todos los Psicologos
CREATE PROCEDURE sp_LeerPsicologos
AS
BEGIN
    SET NOCOUNT ON;
    SELECT PsicologoID, Nombre, Apellido, NumeroLicencia, Correo, Telefono, Especialidad, FechaCreacion
    FROM Psicologos
    ORDER BY Apellido, Nombre;
END;
GO

-- Leer Psicologo por ID
CREATE PROCEDURE sp_LeerPsicologoPorID
    @PsicologoID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT PsicologoID, Nombre, Apellido, NumeroLicencia, Correo, Telefono, Especialidad, FechaCreacion
    FROM Psicologos
    WHERE PsicologoID = @PsicologoID;
END;
GO

-- Actualizar Psicologo
CREATE PROCEDURE sp_ActualizarPsicologo
    @PsicologoID INT,
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @NumeroLicencia NVARCHAR(20),
    @Correo NVARCHAR(100),
    @Telefono NVARCHAR(15) = NULL,
    @Especialidad NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        UPDATE Psicologos
        SET Nombre = @Nombre,
            Apellido = @Apellido,
            NumeroLicencia = @NumeroLicencia,
            Correo = @Correo,
            Telefono = @Telefono,
            Especialidad = @Especialidad
        WHERE PsicologoID = @PsicologoID;
        IF @@ROWCOUNT = 0
            RAISERROR ('Psicólogo no encontrado', 16, 1);
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

-- Eliminar Psicologo (Eliminación lógica)
CREATE PROCEDURE sp_EliminarPsicologo
    @PsicologoID INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM Citas WHERE PsicologoID = @PsicologoID AND Estado != 'Cancelada')
            RAISERROR ('No se puede eliminar el psicólogo porque tiene citas activas', 16, 1);
        ELSE
            DELETE FROM Psicologos WHERE PsicologoID = @PsicologoID;
            IF @@ROWCOUNT = 0
                RAISERROR ('Psicólogo no encontrado', 16, 1);
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

-- Procedimientos para Citas
-- Crear Cita
CREATE PROCEDURE sp_CrearCita
    @PacienteID INT,
    @PsicologoID INT,
    @FechaHoraCita DATETIME,
    @TipoCita NVARCHAR(20),
    @Notas NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- Validar existencia de paciente y psicólogo
        IF NOT EXISTS (SELECT 1 FROM Pacientes WHERE PacienteID = @PacienteID)
            RAISERROR ('Paciente no encontrado', 16, 1);
        IF NOT EXISTS (SELECT 1 FROM Psicologos WHERE PsicologoID = @PsicologoID)
            RAISERROR ('Psicólogo no encontrado', 16, 1);
        -- Validar que no haya conflictos de horario
        IF EXISTS (SELECT 1 FROM Citas WHERE PsicologoID = @PsicologoID AND FechaHoraCita = @FechaHoraCita AND Estado != 'Cancelada')
            RAISERROR ('El psicólogo ya tiene una cita programada en ese horario', 16, 1);
        INSERT INTO Citas (PacienteID, PsicologoID, FechaHoraCita, TipoCita, Estado, Notas)
        VALUES (@PacienteID, @PsicologoID, @FechaHoraCita, @TipoCita, 'Programada', @Notas);
        SELECT SCOPE_IDENTITY() AS CitaID;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

-- Leer Todas las Citas
CREATE PROCEDURE sp_LeerCitas
AS
BEGIN
    SET NOCOUNT ON;
    SELECT C.CitaID, C.PacienteID, P.Nombre + ' ' + P.Apellido AS NombrePaciente, 
           C.PsicologoID, Ps.Nombre + ' ' + Ps.Apellido AS NombrePsicologo, 
           C.FechaHoraCita, C.TipoCita, C.Estado, C.Notas, C.FechaCreacion
    FROM Citas C
    INNER JOIN Pacientes P ON C.PacienteID = P.PacienteID
    INNER JOIN Psicologos Ps ON C.PsicologoID = Ps.PsicologoID
    ORDER BY C.FechaHoraCita DESC;
END;
GO

-- Leer Cita por ID
CREATE PROCEDURE sp_LeerCitaPorID
    @CitaID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT C.CitaID, C.PacienteID, P.Nombre + ' ' + P.Apellido AS NombrePaciente, 
           C.PsicologoID, Ps.Nombre + ' ' + Ps.Apellido AS NombrePsicologo, 
           C.FechaHoraCita, C.TipoCita, C.Estado, C.Notas, C.FechaCreacion
    FROM Citas C
    INNER JOIN Pacientes P ON C.PacienteID = P.PacienteID
    INNER JOIN Psicologos Ps ON C.PsicologoID = Ps.PsicologoID
    WHERE C.CitaID = @CitaID;
END;
GO

-- Actualizar Cita
CREATE PROCEDURE sp_ActualizarCita
    @CitaID INT,
    @PacienteID INT,
    @PsicologoID INT,
    @FechaHoraCita DATETIME,
    @TipoCita NVARCHAR(20),
    @Estado NVARCHAR(20),
    @Notas NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- Validar existencia de paciente y psicólogo
        IF NOT EXISTS (SELECT 1 FROM Pacientes WHERE PacienteID = @PacienteID)
            RAISERROR ('Paciente no encontrado', 16, 1);
        IF NOT EXISTS (SELECT 1 FROM Psicologos WHERE PsicologoID = @PsicologoID)
            RAISERROR ('Psicólogo no encontrado', 16, 1);
        -- Validar que no haya conflictos de horario
        IF EXISTS (SELECT 1 FROM Citas WHERE PsicologoID = @PsicologoID AND FechaHoraCita = @FechaHoraCita AND CitaID != @CitaID AND Estado != 'Cancelada')
            RAISERROR ('El psicólogo ya tiene una cita programada en ese horario', 16, 1);
        UPDATE Citas
        SET PacienteID = @PacienteID,
            PsicologoID = @PsicologoID,
            FechaHoraCita = @FechaHoraCita,
            TipoCita = @TipoCita,
            Estado = @Estado,
            Notas = @Notas
        WHERE CitaID = @CitaID;
        IF @@ROWCOUNT = 0
            RAISERROR ('Cita no encontrada', 16, 1);
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

-- Eliminar Cita (Marcar como Cancelada en lugar de eliminar)
CREATE PROCEDURE sp_EliminarCita
    @CitaID INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        UPDATE Citas
        SET Estado = 'Cancelada'
        WHERE CitaID = @CitaID;
        IF @@ROWCOUNT = 0
            RAISERROR ('Cita no encontrada', 16, 1);
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

-- Procedimientos para HistoriasClinicas
-- Crear Historia Clinica
CREATE PROCEDURE sp_CrearHistoriaClinica
    @PacienteID INT,
    @CitaID INT,
    @Diagnostico NVARCHAR(500) = NULL,
    @PlanTratamiento NVARCHAR(1000) = NULL,
    @Observaciones NVARCHAR(1000) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- Validar existencia de paciente y cita
        IF NOT EXISTS (SELECT 1 FROM Pacientes WHERE PacienteID = @PacienteID)
            RAISERROR ('Paciente no encontrado', 16, 1);
        IF NOT EXISTS (SELECT 1 FROM Citas WHERE CitaID = @CitaID)
            RAISERROR ('Cita no encontrada', 16, 1);
        INSERT INTO HistoriasClinicas (PacienteID, CitaID, Diagnostico, PlanTratamiento, Observaciones)
        VALUES (@PacienteID, @CitaID, @Diagnostico, @PlanTratamiento, @Observaciones);
        SELECT SCOPE_IDENTITY() AS HistoriaID;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

-- Leer Todas las Historias Clinicas
CREATE PROCEDURE sp_LeerHistoriasClinicas
AS
BEGIN
    SET NOCOUNT ON;
    SELECT HC.HistoriaID, HC.PacienteID, P.Nombre + ' ' + P.Apellido AS NombrePaciente, 
           HC.CitaID, HC.Diagnostico, HC.PlanTratamiento, HC.Observaciones, HC.FechaCreacion
    FROM HistoriasClinicas HC
    INNER JOIN Pacientes P ON HC.PacienteID = P.PacienteID
    ORDER BY HC.FechaCreacion DESC;
END;
GO

-- Leer Historia Clinica por ID
CREATE PROCEDURE sp_LeerHistoriaClinicaPorID
    @HistoriaID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT HC.HistoriaID, HC.PacienteID, P.Nombre + ' ' + P.Apellido AS NombrePaciente, 
           HC.CitaID, HC.Diagnostico, HC.PlanTratamiento, HC.Observaciones, HC.FechaCreacion
    FROM HistoriasClinicas HC
    INNER JOIN Pacientes P ON HC.PacienteID = P.PacienteID
    WHERE HC.HistoriaID = @HistoriaID;
END;
GO

-- Actualizar Historia Clinica
CREATE PROCEDURE sp_ActualizarHistoriaClinica
    @HistoriaID INT,
    @PacienteID INT,
    @CitaID INT,
    @Diagnostico NVARCHAR(500) = NULL,
    @PlanTratamiento NVARCHAR(1000) = NULL,
    @Observaciones NVARCHAR(1000) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- Validar existencia de paciente y cita
        IF NOT EXISTS (SELECT 1 FROM Pacientes WHERE PacienteID = @PacienteID)
            RAISERROR ('Paciente no encontrado', 16, 1);
        IF NOT EXISTS (SELECT 1 FROM Citas WHERE CitaID = @CitaID)
            RAISERROR ('Cita no encontrada', 16, 1);
        UPDATE HistoriasClinicas
        SET PacienteID = @PacienteID,
            CitaID = @CitaID,
            Diagnostico = @Diagnostico,
            PlanTratamiento = @PlanTratamiento,
            Observaciones = @Observaciones
        WHERE HistoriaID = @HistoriaID;
        IF @@ROWCOUNT = 0
            RAISERROR ('Historia clínica no encontrada', 16, 1);
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO

-- Eliminar Historia Clinica (Eliminación lógica para cumplir con Ley N° 29733)
CREATE PROCEDURE sp_EliminarHistoriaClinica
    @HistoriaID INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DELETE FROM HistoriasClinicas WHERE HistoriaID = @HistoriaID;
        IF @@ROWCOUNT = 0
            RAISERROR ('Historia clínica no encontrada', 16, 1);
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH
END;
GO