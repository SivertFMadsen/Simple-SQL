-- Oppgave 2

-- a)

SELECT navn
FROM planet
WHERE stjerne = 'Proxima Centauri';

-- Proxima Centauri b
-- Proxima Centauri d

-- b)

SELECT DISTINCT oppdaget
FROM planet
WHERE stjerne = 'TRAPPIST-1' OR stjerne = 'Kepler-154';

-- 2014
-- 2016
-- 2017
-- 2019


-- c)

SELECT count(navn)
FROM planet
WHERE masse IS NULL;

-- 3424

-- d)

SELECT navn, masse
FROM planet
WHERE masse > (SELECT avg(masse) FROM planet) AND oppdaget = 2020;

-- 19 rader

-- e)

SELECT max(oppdaget) - min(oppdaget) AS periode
FROM planet;

-- 34


-- Oppgave 3

-- a)

SELECT navn
FROM planet p
WHERE masse > 3 AND masse < 10 AND p.navn IN (
    SELECT planet 
    FROM materie 
    WHERE molekyl = 'H2O'
);

-- Kepler-167 e
-- HR 8799 c
-- HR 8799 b
-- MASCARA-2 b/KELT-20 b
-- ROXs 42B (AB) b
-- tau Boo A b

-- b) 

SELECT DISTINCT p.navn
FROM stjerne s 
    INNER JOIN planet p ON (s.navn = p.stjerne)
    INNER JOIN materie m ON (p.navn = m.planet)
WHERE s.avstand < s.masse * 12
    AND molekyl LIKE '%H%';

-- GJ 229 A b
-- GJ 570 D
-- GJ 832 c
-- beta Pic b
-- tau Boo A b

-- c)

SELECT DISTINCT p1.navn AS planet
FROM planet p1
    INNER JOIN planet p2 ON (p1.navn != p2.navn)
    INNER JOIN stjerne s ON (p1.stjerne = s.navn AND p2.stjerne = s.navn)
WHERE s.avstand < 50
    AND p1.masse > 10
    AND p2.masse > 10;

-- HD 82943 b
-- HD 82943 c
-- HIP 75458 b
-- HIP 75458 c


-- Oppgave 4

-- NATURAL JOIN slår sammen to tabeller basert på kolonner med samme navn,
-- og siden ingen stjerner har samme navn som noen planeter, får vi en
-- tom tabell med ingen rader eller kolonner.

-- Her er en versjon som fungerer:

SELECT DISTINCT p.oppdaget
FROM planet p INNER JOIN stjerne s ON (p.stjerne = s.navn)
WHERE avstand > 8000;

-- 2002
-- 2006
-- 2016
-- 2021
-- 2022


-- Oppgave 5

-- a)

INSERT INTO stjerne
VALUES ('Sola', 0, 1);

-- b)

INSERT INTO planet
VALUES ('Jorda', 0.003146, NULL, 'Sola');


-- Oppgave 6

CREATE TABLE observasjon (
    observasjons_id int PRIMARY KEY,
    dato timestamp NOT NULL,
    observasjonsplanet text NOT NULL REFERENCES planet(navn),
    kommentar text
);