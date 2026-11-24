-- Num. de equipos de cada liga (Sprint 4, ampliación).
-- Desde ahora lo mantiene la clase DD del equipo al crear, cambiar de liga o borrar.
-- Este script solo cuadra los valores actuales para que la cuenta empiece bien.
-- Se ejecuta una vez desde MySQL Workbench.

-- 1. Cómo está ahora frente a la cuenta real.
SELECT l.ID, l.Nombre, l.Equipos, l.EquiposMax,
       (SELECT COUNT(*) FROM equipo e WHERE e.LigaID = l.ID) AS EquiposReales
FROM liga l
ORDER BY l.ID;

-- 2. Recalcular. El WHERE sobre la clave es para el «safe update mode» de Workbench.
UPDATE liga l
SET l.Equipos = (SELECT COUNT(*) FROM equipo e WHERE e.LigaID = l.ID)
WHERE l.ID > 0;

-- 3. Comprobación: ninguna liga debe pasar del máximo.
SELECT ID, Nombre, Equipos, EquiposMax
FROM liga
WHERE Equipos > EquiposMax;
