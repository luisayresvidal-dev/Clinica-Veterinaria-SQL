
Este proyecto forma parte de la **Evaluación Final del Módulo 3**. Consiste en el diseño, implementación y manipulación de una base de datos relacional para una clínica veterinaria. El sistema permite gestionar la relación entre dueños, sus mascotas, los profesionales de la salud y las atenciones médicas realizadas.

El objetivo principal es demostrar habilidades en:
- Modelamiento de datos relacionales.
- Aplicación de integridad referencial.
- Manipulación de datos (DML).
- Gestión de transacciones y consistencia de datos.

##  Tecnologías Utilizadas
- **Motor de Base de Datos:** MySQL 8.0
- **Lenguaje:** SQL (DDL y DML)
- **Herramienta de Modelado:** dbdiagram.io / MySQL Workbench

##  Estructura de la Base de Datos
La base de datos `clinica_veterinaria` se compone de las siguientes tablas interconectadas:

1.  **Dueno:** Registro de clientes (nombre, dirección, teléfono).
2.  **Mascota:** Registro de pacientes, vinculados a un dueño mediante una relación de uno a muchos.
3.  **Profesional:** Especialistas veterinarios disponibles en la clínica.
4.  **Atencion:** Registro histórico de las consultas médicas, vinculando mascotas con profesionales.



##  Características Destacadas
- **Integridad Referencial:** Uso de `ON DELETE CASCADE` para asegurar que no queden registros huérfanos.
- **Transacciones Seguras:** Implementación de bloques `START TRANSACTION`, `COMMIT` y `ROLLBACK` para operaciones críticas.
- **Validación de Datos:** Restricciones de claves primarias y campos obligatorios.

##  Instrucciones de Instalación
1. Clona este repositorio.
2. Abre tu cliente MySQL favorito (ej. MySQL Workbench).
3. Ejecuta el archivo `script.sql` incluido en este repositorio.
4. El script limpiará versiones previas (si existen) y creará la estructura con datos de prueba automáticamente.

##  Autor
- **Luis Ayres e IA gémini** - [luisayresvidal-dev]
