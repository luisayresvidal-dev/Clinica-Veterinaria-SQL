-- ==========================================================
-- EVALUACIÓN FINAL MÓDULO 3: CLÍNICA VETERINARIA
-- ==========================================================

-- 1. CREACIÓN DE LA BASE DE DATOS 
CREATE DATABASE IF NOT EXISTS clinica_veterinaria;
USE clinica_veterinaria;

-- 2. LIMPIEZA DE TABLAS (Para evitar errores de "Table already exists")
-- Se borran en orden inverso a su creación por las llaves foráneas.
DROP TABLE IF EXISTS Atencion;
DROP TABLE IF EXISTS Mascota;
DROP TABLE IF EXISTS Profesional;
DROP TABLE IF EXISTS Dueno;

-- 3. CREACIÓN DE TABLAS CON INTEGRIDAD REFERENCIAL [cite: 27]

-- Tabla Dueño 
CREATE TABLE Dueno (
    id_dueno INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    direccion VARCHAR(200),
    telefono VARCHAR(20)
);

-- Tabla Mascota [cite: 33]
CREATE TABLE Mascota (
    id_mascota INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    tipo VARCHAR(50), -- Perro, Gato, etc. 
    fecha_nacimiento DATE,
    id_dueno INT,
    FOREIGN KEY (id_dueno) REFERENCES Dueno(id_dueno) ON DELETE CASCADE 
);

-- Tabla Profesional
CREATE TABLE Profesional (
    id_profesional INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    especialidad VARCHAR(100)
);

-- Tabla Atención 
CREATE TABLE Atencion (
    id_atencion INT PRIMARY KEY AUTO_INCREMENT,
    fecha_atencion DATE,
    descripcion TEXT,
    id_mascota INT,
    id_profesional INT,
    FOREIGN KEY (id_mascota) REFERENCES Mascota(id_mascota), 
    FOREIGN KEY (id_profesional) REFERENCES Profesional(id_profesional) 
);

-- 4. INSERCIÓN DE DATOS DE EJEMPLO 

INSERT INTO Dueno (id_dueno, nombre, direccion, telefono) VALUES 
(1, 'Juan Pérez', 'Calle Falsa 123', '555-1234'),
(2, 'Ana Gómez', 'Avenida Siempre Viva 456', '555-5678'),
(3, 'Carlos Ruiz', 'Calle 8 de Octubre 789', '555-8765'); 

INSERT INTO Mascota (id_mascota, nombre, tipo, fecha_nacimiento, id_dueno) VALUES 
(1, 'Rex', 'Perro', '2020-05-10', 1),
(2, 'Luna', 'Gato', '2019-02-20', 2),
(3, 'Fido', 'Perro', '2021-03-15', 3); 

INSERT INTO Profesional (id_profesional, nombre, especialidad) VALUES 
(1, 'Dr. Martínez', 'Veterinario'),
(2, 'Dr. Pérez', 'Especialista en dermatología'),
(3, 'Dr. López', 'Cardiólogo veterinario'); 

INSERT INTO Atencion (id_atencion, fecha_atencion, descripcion, id_mascota, id_profesional) VALUES 
(1, '2025-03-01', 'Chequeo general', 1, 1),
(2, '2025-03-05', 'Tratamiento dermatológico', 2, 2),
(3, '2025-03-07', 'Consulta cardiológica', 3, 3); 

-- 5. CONSULTAS REQUERIDAS 

-- Obtener todos los dueños y sus mascotas 
SELECT D.nombre AS Dueno, M.nombre AS Mascota 
FROM Dueno D 
JOIN Mascota M ON D.id_dueno = M.id_dueno;

-- Obtener atenciones con detalles del profesional 
SELECT A.fecha_atencion, M.nombre AS Mascota, P.nombre AS Profesional, A.descripcion 
FROM Atencion A
JOIN Mascota M ON A.id_mascota = M.id_mascota
JOIN Profesional P ON A.id_profesional = P.id_profesional;

-- Contar atenciones por profesional 
SELECT P.nombre, COUNT(A.id_atencion) AS total_atenciones 
FROM Profesional P 
LEFT JOIN Atencion A ON P.id_profesional = A.id_profesional 
GROUP BY P.nombre;

-- Actualizar dirección de Juan Pérez 
UPDATE Dueno SET direccion = 'Nueva Dirección 123' WHERE id_dueno = 1;

-- Eliminar la atención con id 2 
DELETE FROM Atencion WHERE id_atencion = 2;

-- 6. TRANSACCIÓN PARA AGREGAR NUEVA MASCOTA Y ATENCIÓN
START TRANSACTION;
    -- Agregar mascota
    INSERT INTO Mascota (nombre, tipo, fecha_nacimiento, id_dueno) 
    VALUES ('Simba', 'Gato', '2023-01-10', 2);
    
    SET @nueva_mascota = LAST_INSERT_ID();

    -- Registrar atención
    INSERT INTO Atencion (fecha_atencion, descripcion, id_mascota, id_profesional) 
    VALUES (CURDATE(), 'Control preventivo', @nueva_mascota, 1);

    -- Actualizar info del dueño
    UPDATE Dueno SET telefono = '555-9999' WHERE id_dueno = 2;
COMMIT;
