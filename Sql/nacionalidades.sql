-- Validation table de nacionalidades para FutbolWebApp (Sprint 4).
-- CodeType y CodeMast son las tablas de validación de DataFlex, convertidas a MySQL.
-- Se ejecuta una vez en la base de datos de la aplicación, desde MySQL Workbench.

-- 1. El código de CodeMast es lo que se guarda en jugador/entrenador.Nacionalidad.
--    Por defecto mide 10 caracteres y «Mozambiqueño» tiene 12: se amplía al tamaño
--    de la columna Nacionalidad. Comprobar antes cómo está definida:
SHOW COLUMNS FROM CodeMast;
ALTER TABLE CodeMast MODIFY Code VARCHAR(50) NOT NULL;

-- 2. El tipo de código. Type mide 10 caracteres, de ahí 'NACION'.
INSERT INTO CodeType (Type, Description, Comment)
VALUES ('NACION', 'Nacionalidades', 'Nacionalidad de jugadores y entrenadores');

-- 3. Solo las nacionalidades que ya tienen los jugadores y entrenadores.
--    Código y descripción iguales: el combo enseña la descripción y guarda el código,
--    así los datos que ya hay no cambian.
INSERT INTO CodeMast (Type, Code, Description)
SELECT DISTINCT 'NACION', n.Nacionalidad, n.Nacionalidad
FROM (SELECT Nacionalidad FROM jugador
      UNION
      SELECT Nacionalidad FROM entrenador) AS n
WHERE n.Nacionalidad IS NOT NULL AND n.Nacionalidad <> ''
ORDER BY n.Nacionalidad;

-- 4. Comprobación.
SELECT Code, Description FROM CodeMast WHERE Type = 'NACION' ORDER BY Code;
