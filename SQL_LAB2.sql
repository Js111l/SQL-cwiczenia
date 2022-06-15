


--1. Zadeklarowaæ dwie zmienne tekstowe: imie i nazwisko oraz jedn¹ zmienn¹ liczbow¹ o nazwie numer porz¹dkowy. Przypisaæ wartoœci zmiennym:
--Jan, Kowalski, 100
--i wyœwietliæ je.


DECLARE @imie VARCHAR(20)='Jan'
PRINT @imie
DECLARE @nazwisko1 VARCHAR(20)='Kowalski'
PRINT @nazwisko1
DECLARE @numerporzadkowy INT=100
PRINT @numerporzadkowy

---2. Napisaæ program, który z wykorzystaniem instrukcji EXEC policzy liczbê wierszy w dowolnej tabeli, 
----a nastêpnie utworzy tabelê o nazwie Raport4 wstawiaj¹c
----liczbê wczeœniej wyliczonych wierszy. Zapytania musz¹ byæ przechowywane w zmiennych tekstowych.


DECLARE @zapytanie1 AS VARCHAR(159)
BEGIN
	SET @zapytanie1='SELECT COUNT(*) AS nrwierszy INTO Raport4 FROM Pracownik'
	EXEC (@zapytanie1)
END

SELECT * FROM RAPORT4


--3. Napisaæ program, który wyœwietli wszystkie parzyste liczby z zakresu od 1 do 10.
---Dodatkowo po wykonaniu kodu nale¿y wstrzymaæ program na 2 sekundy przed wyœwietleniem danych.
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
--4. Napisaæ program, który wyœwietli wszystkie liczby z 
--zakresu od 1 do 10. Je¿eli liczba jest podzielna przez 3 to wypisze stosown¹ informacjê.

BEGIN
DECLARE @i INT =1
WHILE @i<=10
	BEGIN
		IF @i % 3 =0
		PRINT 'LICZBA ' + ' ' +CAST(@i as VARCHAR(50)) +' ' +'JEST PODZIELNA PRZEZ 3'
		SET @i=@i+1
	END
END

----5. Wygenerowaæ tabelê o nazwie Dane, która bêdzie zawiera³a dwie kolumny: 
----opis oraz wartoœæ. W tabeli powinny byæ zamieszczone opisy: A, B, C, D i E 
----oraz przyporz¹dkowane im liczby z zakresu od 1 do 100. Nale¿y wype³niæ 2000 wierszy tablicy.
----Je¿eli kolejny dodawany wiersz jest podzielny przez 5 to powinien otrzymaæ opis E, przez 4: D, 
-----przez 3: C, przez 2: B oraz przez 1: A. PodpowiedŸ: funkcja RAND() s³u¿y do generowania liczby 
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

--6. Wyœwietliæ utworzon¹ wczeœniej tabelê wypisuj¹c w trzech kolumnach nastêpuj¹ce wartoœci:
---Klasa wielkoœci
---Opis 
---£¹czna wartoœæ  
---gdzie:
--- klasa wielkoœci ma reprezentowaæ przedzia³y:
---ma³e: 1 do 30
---œrednie: 31 do 70
---du¿e: 71 do 100
---- ³¹czna wartoœæ to funkcja agreguj¹ca SUM
----Wyniki maj¹ byæ koniecznie pogrupowane wed³ug klas wielkoœci i opisu.

SELECT 
CASE	
	WHEN wartosc<=30 THEN 'ma³e'
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
	WHEN wartosc<=30 THEN 'ma³e'
	WHEN wartosc between 31 and 70 then 'srednie'
	else 
	'duze'
END,opis
ORDER BY suma asc







WITH cte as(
SELECT 
CASE
	WHEN wartosc<=30 THEN 'ma³e'
	WHEN wartosc between 31 and 70 THEN 'œrednie'
	ELSE 'du¿e'
END as Klasa_wielkosci ,
opis,wartosc
FROM DANE
)
SELECT klasa_wielkosci,opis,sum(wartosc) as suma FROM cte 
GROUP BY
Klasa_wielkosci,opis
ORDER BY suma asc