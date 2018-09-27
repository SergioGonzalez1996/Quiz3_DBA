--
---- Parte I
--

-- Numeral 1, tablespace
CREATE TABLESPACE quiz DATAFILE 
    'quiz01.dbf' SIZE 15M,
    'quiz02.dbf' SIZE 15M,
    'quiz03.dbf' SIZE 15M;
    
-- Numeral 2, crear perfil
CREATE PROFILE student LIMIT
	IDLE_TIME			20;
    
-- Numeral 3, crear usuario 1 con sus respectivos permisos
CREATE USER usuario_1 
	IDENTIFIED BY usuario_1
	DEFAULT TABLESPACE quiz
	QUOTA 10M ON quiz
	PROFILE student;

GRANT CONNECT TO usuario_1;
GRANT CREATE TABLE TO usuario_1;

-- Numeral 4, crear usuario 2 con sus permisos
CREATE USER usuario_2
	IDENTIFIED BY usuario_2
	DEFAULT TABLESPACE quiz
	QUOTA 10M ON quiz
	PROFILE student;
    
GRANT CONNECT TO usuario_2;

--
---- Parte II
--

-- Numeral 1, creación de tabla.
CREATE TABLE ATTACKS (
	ID INTEGER,
	URL VARCHAR2(2048),
	IP_ADDRESS VARCHAR2(255),
	NUMBER_OF_ATTACKS INTEGER,
	TIME_OF_LAST_ATTACK TIMESTAMP
);

-- Numeral 2, exportar los datos.
-- OK

-- Numeral 3, dar permisos a usuario_2
GRANT SELECT ON attacks TO usuario_2;

--
---- Parte III
--

-- 1. Count the urls which have been attacked and have the protocol 'https'
SELECT COUNT(URL) FROM ATTACKS WHERE URL LIKE 'https%';

-- 2. List the records where the URL attacked matches with google (it does not matter if it is google.co.jp, google.es, google.pt, etc) order by number of attacks ascendent
SELECT * FROM ATTACKS WHERE URL LIKE '%google%' ORDER BY number_of_attacks ASC;

-- 3. List the ip addresses and the time of the last attack if the attack has been produced the last year (2017) (Hint: https://stackoverflow.com/a/30071091)
SELECT IP_ADDRESS, TIME_OF_LAST_ATTACK FROM ATTACKS
WHERE TIME_OF_LAST_ATTACK BETWEEN TO_DATE ('2017-01-01T00:00:00', 'YYYY-MM-DD"T"HH24:MI:SS') AND TO_DATE('2017-12-31T23:59:59', 'YYYY-MM-DD"T"HH24:MI:SS');

-- 4. Show the first IP Adress which has been registered with the minimum number of attacks 
SELECT MIN(NUMBER_OF_ATTACKS) FROM ATTACKS;

-- 5. Show the ip address and the number of attacks if instagram has been attack using https protocol
SELECT IP_ADDRESS, NUMBER_OF_ATTACKS FROM ATTACKS WHERE URL LIKE '%instagram%' AND URL LIKE 'https%';

