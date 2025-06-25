-- Usando la base de datos
USE ResilientesCuscoDB;
GO

-- Insertando 10 datos en la tabla Pacientes
INSERT INTO Pacientes (Nombre, Apellido, NumeroDocumento, Correo, Telefono, Direccion, FechaNacimiento)
VALUES 
    ('Ana', 'Mamani Quispe', '71234567', 'ana.mamani@gmail.com', '984123456', 'Av. Sol 123, Cusco', '1990-05-15'),
    ('Juan', 'P�rez Condori', '72345678', 'juan.perez@hotmail.com', '987654321', 'Calle T�pac Amaru 456, Cusco', '1985-08-20'),
    ('Mar�a', 'Huanca Rojas', '73456789', 'maria.huanca@outlook.com', '982345678', 'Urb. Magisterio 789, Cusco', '1995-03-10'),
    ('Pedro', 'Choque Lazo', '74567890', 'pedro.choque@gmail.com', '985678123', 'Av. Cultura 101, Cusco', '1988-11-25'),
    ('Sofia', 'Cusi Vargas', '75678901', 'sofia.cusi@yahoo.com', '981234567', 'Calle Pumacurco 202, Cusco', '1992-07-30'),
    ('Luis', 'Aguilar Paredes', '76789012', 'luis.aguilar@gmail.com', '986543210', 'Urb. Santa Rosa 303, Cusco', '1990-01-12'),
    ('Carmen', 'Yucra Ttito', '77890123', 'carmen.yucra@outlook.com', '983456789', 'Av. El Sol 404, Cusco', '1987-09-05'),
    ('Diego', 'Flores Huam�n', '78901234', 'diego.flores@hotmail.com', '980123456', 'Calle San Agust�n 505, Cusco', '1993-04-18'),
    ('Elena', 'Salas Quispe', '79012345', 'elena.salas@gmail.com', '988765432', 'Urb. Ttio 606, Cusco', '1989-12-22'),
    ('Ra�l', 'G�mez Ccama', '70123456', 'raul.gomez@yahoo.com', '984567890', 'Av. Pardo 707, Cusco', '1991-06-14');
GO

-- Insertando 10 datos en la tabla Psicologos
INSERT INTO Psicologos (Nombre, Apellido, NumeroLicencia, Correo, Telefono, Especialidad)
VALUES 
    ('Claudia', 'Ramos Torres', 'LIC123456', 'claudia.ramos@resilientes.pe', '984000111', 'Psicolog�a Cl�nica'),
    ('Andr�s', 'Vega Salazar', 'LIC234567', 'andres.vega@resilientes.pe', '987000222', 'Terapia Cognitivo-Conductual'),
    ('Valeria', 'Cruz Mamani', 'LIC345678', 'valeria.cruz@resilientes.pe', '982000333', 'Psicolog�a Infantil'),
    ('Ricardo', 'L�pez Quispe', 'LIC456789', 'ricardo.lopez@resilientes.pe', '985000444', 'Terapia de Pareja'),
    ('Patricia', 'Garc�a Condori', 'LIC567890', 'patricia.garcia@resilientes.pe', '981000555', 'Psicolog�a Organizacional'),
    ('Gabriel', 'Mendoza Rojas', 'LIC678901', 'gabriel.mendoza@resilientes.pe', '986000666', 'Neuropsicolog�a'),
    ('Laura', 'P�rez Huanca', 'LIC789012', 'laura.perez@resilientes.pe', '983000777', 'Psicolog�a Educativa'),
    ('Mario', 'Choque Ttito', 'LIC890123', 'mario.choque@resilientes.pe', '980000888', 'Terapia Familiar'),
    ('Isabel', 'Flores Vargas', 'LIC901234', 'isabel.flores@resilientes.pe', '988000999', 'Psicolog�a Deportiva'),
    ('Javier', 'Huam�n Aguilar', 'LIC012345', 'javier.huaman@resilientes.pe', '984001000', 'Psicolog�a Social');
GO

-- Insertando 10 datos en la tabla Citas (fechas ajustadas para ser futuras)
-- Usando fechas claramente futuras (ej. 2025)
INSERT INTO Citas (PacienteID, PsicologoID, FechaHoraCita, TipoCita, Estado, Notas)
VALUES 
    (1, 1, '2025-07-19 10:00:00', 'Presencial', 'Programada', 'Primera consulta para evaluaci�n inicial.'),
    (2, 2, '2025-07-19 11:30:00', 'Virtual', 'Programada', 'Sesi�n de seguimiento TCC.'),
    (3, 3, '2025-07-20 09:00:00', 'Presencial', 'Programada', 'Consulta infantil por problemas escolares.'),
    (4, 4, '2025-07-20 14:00:00', 'Virtual', 'Programada', 'Terapia de pareja.'),
    (5, 5, '2025-07-21 15:30:00', 'Presencial', 'Programada', 'Evaluaci�n organizacional.'),
    (6, 6, '2025-07-21 16:00:00', 'Virtual', 'Programada', 'Evaluaci�n neuropsicol�gica.'),
    (7, 7, '2025-07-22 10:30:00', 'Presencial', 'Programada', 'Consulta por dificultades acad�micas.'),
    (8, 8, '2025-07-22 12:00:00', 'Virtual', 'Programada', 'Terapia familiar.'),
    (9, 9, '2025-07-23 08:30:00', 'Presencial', 'Programada', 'Consulta por rendimiento deportivo.'),
    (10, 10, '2025-07-23 11:00:00', 'Virtual', 'Programada', 'Consulta comunitaria.');
GO

-- Insertando 10 datos en la tabla HistoriasClinicas (despu�s de crear las citas)
INSERT INTO HistoriasClinicas (PacienteID, CitaID, Diagnostico, PlanTratamiento, Observaciones)
VALUES 
    (1, 1, 'Ansiedad generalizada', 'Terapia cognitivo-conductual, 8 sesiones semanales.', 'Paciente refiere estr�s laboral.'),
    (2, 2, 'Depresi�n leve', 'Continuar TCC, incorporar ejercicios de mindfulness.', 'Progreso moderado en sesiones previas.'),
    (3, 3, 'Dificultades de aprendizaje', 'Intervenci�n psicopedag�gica, sesiones quincenales.', 'Colaboraci�n con docentes recomendada.'),
    (4, 4, 'Conflictos de pareja', 'Terapia de pareja, enfoque en comunicaci�n.', 'Ambos c�nyuges comprometidos.'),
    (5, 5, 'Estr�s laboral', 'T�cnicas de manejo de estr�s, 6 sesiones.', 'Paciente en ambiente laboral competitivo.'),
    (6, 6, 'Sospecha de TDAH', 'Evaluaci�n neuropsicol�gica completa.', 'Derivaci�n a especialista si necesario.'),
    (7, 7, 'Baja autoestima', 'Terapia educativa, enfoque en fortalezas.', 'Paciente adolescente.'),
    (8, 8, 'Din�mica familiar disfuncional', 'Terapia sist�mica, 10 sesiones.', 'Incluir a todos los miembros familiares.'),
    (9, 9, 'Ansiedad por rendimiento', 'T�cnicas de relajaci�n, 4 sesiones.', 'Paciente es deportista amateur.'),
    (10, 10, 'Aislamiento social', 'Intervenci�n comunitaria, talleres grupales.', 'Paciente participa en programa comunitario.');
GO