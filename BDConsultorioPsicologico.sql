-- Creando la base de datos
CREATE DATABASE ResilientesCuscoDB;
GO

USE ResilientesCuscoDB;
GO

-- Tabla para Pacientes
CREATE TABLE Pacientes (
    PacienteID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(50) NOT NULL,
    Apellido NVARCHAR(50) NOT NULL,
    NumeroDocumento NVARCHAR(20) UNIQUE NOT NULL,
    Correo NVARCHAR(100) UNIQUE,
    Telefono NVARCHAR(15),
    Direccion NVARCHAR(200),
    FechaNacimiento DATE,
    FechaCreacion DATETIME DEFAULT GETDATE(),
    CONSTRAINT CHK_NumeroDocumento CHECK (LEN(NumeroDocumento) >= 8),
    CONSTRAINT CHK_Correo CHECK (Correo LIKE '%@%.%')
);
GO

-- Tabla para Psicólogos
CREATE TABLE Psicologos (
    PsicologoID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(50) NOT NULL,
    Apellido NVARCHAR(50) NOT NULL,
    NumeroLicencia NVARCHAR(20) UNIQUE NOT NULL,
    Correo NVARCHAR(100) UNIQUE,
    Telefono NVARCHAR(15),
    Especialidad NVARCHAR(100),
    FechaCreacion DATETIME DEFAULT GETDATE(),
    CONSTRAINT CHK_NumeroLicencia CHECK (LEN(NumeroLicencia) >= 6)
);
GO

-- Tabla para Citas
CREATE TABLE Citas (
    CitaID INT PRIMARY KEY IDENTITY(1,1),
    PacienteID INT NOT NULL,
    PsicologoID INT NOT NULL,
    FechaHoraCita DATETIME NOT NULL,
    TipoCita NVARCHAR(20) NOT NULL, -- 'Presencial' o 'Virtual'
    Estado NVARCHAR(20) NOT NULL DEFAULT 'Programada', -- 'Programada', 'Completada', 'Cancelada'
    Notas NVARCHAR(500),
    FechaCreacion DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Citas_Pacientes FOREIGN KEY (PacienteID) REFERENCES Pacientes(PacienteID),
    CONSTRAINT FK_Citas_Psicologos FOREIGN KEY (PsicologoID) REFERENCES Psicologos(PsicologoID),
    CONSTRAINT CHK_TipoCita CHECK (TipoCita IN ('Presencial', 'Virtual')),
    CONSTRAINT CHK_Estado CHECK (Estado IN ('Programada', 'Completada', 'Cancelada')),
    CONSTRAINT CHK_FechaHoraCita CHECK (FechaHoraCita >= GETDATE())
);
GO

-- Tabla para Historias Clínicas (Confidencial bajo la Ley N° 29733)
CREATE TABLE HistoriasClinicas (
    HistoriaID INT PRIMARY KEY IDENTITY(1,1),
    PacienteID INT NOT NULL,
    CitaID INT NOT NULL,
    Diagnostico NVARCHAR(500),
    PlanTratamiento NVARCHAR(1000),
    Observaciones NVARCHAR(1000),
    FechaCreacion DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_HistoriasClinicas_Pacientes FOREIGN KEY (PacienteID) REFERENCES Pacientes(PacienteID),
    CONSTRAINT FK_HistoriasClinicas_Citas FOREIGN KEY (CitaID) REFERENCES Citas(CitaID)
);
GO

-- Índices para mejorar el rendimiento
CREATE INDEX IX_Citas_FechaHoraCita ON Citas(FechaHoraCita);
CREATE INDEX IX_Citas_PacienteID ON Citas(PacienteID);
CREATE INDEX IX_Citas_PsicologoID ON Citas(PsicologoID);
GO