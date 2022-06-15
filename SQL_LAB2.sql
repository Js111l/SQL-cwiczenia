


--1. Zadeklarowa� dwie zmienne tekstowe: imie i nazwisko oraz jedn� zmienn� liczbow� o nazwie numer porz�dkowy. Przypisa� warto�ci zmiennym:
--Jan, Kowalski, 100
--i wy�wietli� je.


DECLARE @imie VARCHAR(20)='Jan'
PRINT @imie
DECLARE @nazwisko1 VARCHAR(20)='Kowalski'
PRINT @nazwisko1
DECLARE @numerporzadkowy INT=100
PRINT @numerporzadkowy

---2. Napisa� program, kt�ry z wykorzystaniem instrukcji EXEC policzy liczb� wierszy w dowolnej tabeli, 
----a nast�pnie utworzy tabel� o nazwie Raport4 wstawiaj�c
----liczb� wcze�niej wyliczonych wierszy. Zapytania musz� by� przechowywane w zmiennych tekstowych.


DECLARE @zapytanie1 AS VARCHAR(159)
BEGIN
	SET @zapytanie1='SELECT COUNT(*) AS nrwierszy INTO Raport4 FROM Pracownik'
	EXEC (@zapytanie1)
END

SELECT * FROM RAPORT4


--3. Napisa� program, kt�ry wy�wietli wszystkie parzyste liczby z zakresu od 1 do 10.
---Dodatkowo po wykonaniu kodu nale�y wstrzyma� program na 2 sekundy przed wy�wietleniem danych.
BEGIN
waitfor delay '00:00:02'
DECLARE @i INT=1

WHILE @i<11 
	BEGIN	
		IF @i % 2 =0
		PRINT @i
		SET @i = @i+1
	END
END
--4. Napisa� program, kt�ry wy�wietli wszystkie liczby z 
--zakresu od 1 do 10. Je�eli liczba jest podzielna przez 3 to wypisze stosown� informacj�.

BEGIN
DECLARE @i INT =1
WHILE @i<=10
	BEGIN
		IF @i % 3 =0
		PRINT 'LICZBA ' + ' ' +CAST(@i as VARCHAR(50)) +' ' +'JEST PODZIELNA PRZEZ 3'
		SET @i=@i+1
	END
END

----5. Wygenerowa� tabel� o nazwie Dane, kt�ra b�dzie zawiera�a dwie kolumny: 
----opis oraz warto��. W tabeli powinny by� zamieszczone opisy: A, B, C, D i E 
----oraz przyporz�dkowane im liczby z zakresu od 1 do 100. Nale�y wype�ni� 2000 wierszy tablicy.
----Je�eli kolejny dodawany wiersz jest podzielny przez 5 to powinien otrzyma� opis E, przez 4: D, 
-----przez 3: C, przez 2: B oraz przez 1: A. Podpowied�: funkcja RAND() s�u�y do generowania liczby 
----losowej zmiennoprzecinkowej z zakresu od 0 do 1.

DECLARE @iterator INT =1
DECLARE @tabela VARCHAR(55)
DECLARE @opis VARCHAR(2)
DECLARE @liczba INT
DECLARE @wstawianie VARCHAR(45)

BEGIN
SET @tabela = 'CREATE TABLE Dane(
opis varchar(1),
wartosc INT
)'
EXEC(@tabela)

WHILE @iterator <=2000
	
	BEGIN
		SET @liczba = CEILING(RAND()*100)
		IF @liczba % 5 =0
		SET @opis = 'E'
		ELSE IF @liczba % 4 =0
		SET @opis = 'D'
		ELSE IF @liczba % 3 = 0
		SET @opis ='C'
		ELSE IF @liczba % 2 = 0
		SET @opis = 'B'
		ELSE 
		SET @opis = 'A'

		SET @wstawianie = 'insert into dane values ('''+@opis+''','+cast(@liczba as varchar(3))+')'
		EXEC(@wstawianie)
		SET @iterator=@iterator+1
	END

END
SELECT * FROM Dane

--6. Wy�wietli� utworzon� wcze�niej tabel� wypisuj�c w trzech kolumnach nast�puj�ce warto�ci:
---Klasa wielko�ci
---Opis 
---��czna warto��  
---gdzie:
--- klasa wielko�ci ma reprezentowa� przedzia�y:
---ma�e: 1 do 30
---�rednie: 31 do 70
---du�e: 71 do 100
---- ��czna warto�� to funkcja agreguj�ca SUM
----Wyniki maj� by� koniecznie pogrupowane wed�ug klas wielko�ci i opisu.

SELECT 
CASE	
	WHEN wartosc<=30 THEN 'ma�e'
	WHEN wartosc between 31 and 70 then 'srednie'
	else 
	'duze'
END
AS
Klasa_wielkosci,
opis,sum(wartosc)
as suma
from dane
group by CASE	
	WHEN wartosc<=30 THEN 'ma�e'
	WHEN wartosc between 31 and 70 then 'srednie'
	else 
	'duze'
END,opis
ORDER BY suma asc







WITH cte as(
SELECT 
CASE
	WHEN wartosc<=30 THEN 'ma�e'
	WHEN wartosc between 31 and 70 THEN '�rednie'
	ELSE 'du�e'
END as Klasa_wielkosci ,
opis,wartosc
FROM DANE
)
SELECT klasa_wielkosci,opis,sum(wartosc) as suma FROM cte 
GROUP BY
Klasa_wielkosci,opis
ORDER BY suma asc