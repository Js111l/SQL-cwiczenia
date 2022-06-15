--1. Nale¿y utworzyæ tablicê o nazwie TabLiczba, zawieraj¹c¹ kolumny:

--- identyfikator (autonumeracja),

--- liczba typu liczbowego ca³kowitego (co najmniej z zakresu 0 do 1000),

---slownie typu tekstowego.

CREATE TABLE
TABLICZBA1
(
identyfikator INT IDENTITY(1,1),
liczba INT,
s³ownie varchar(100)
)

INSERT INTO TabLiczba1(liczba, s£ownie) VALUES (1,'jeden');

INSERT INTO TABLICZBA1(liczba, s£ownie) VALUES (2,'dwa');

INSERT INTO TabLiczba1(liczba, s£ownie) VALUES (3,'trzy');



--2. Utworzyæ procedurê o nazwie wyswietlDane, 
--która wyœwietli wszystkie wiersze z tabeli o nazwie Liczba. Zweryfikowaæ dzia³anie procedury.

CREATE PROCEDURE 
WYSWIETLDANE1
AS
BEGIN
	SELECT liczba
	FROM TABLICZBA1
END

EXEC WYSWIETLDANE1


--3. Utworzyæ procedurê o nazwie dodajLiczbe, 
---która przyjmuje dwa argumenty - liczbê oraz jej reprezentacjê s³own¹
---i dodaje te argumenty jako kolejny wiersz tabeli TabLiczba.

CREATE PROCEDURE
DODAJLICZBE_ (@LICZBA INT, @NAZWA VARCHAR(100))
AS
BEGIN
	INSERT INTO TabLiczba1(liczba,s³ownie) VALUES (@LICZBA,@NAZWA)
END

EXEC DODAJLICZBE_ 4,'cztery'

EXEC DODAJLICZBE_ 5,'piêæ'

--4. Dodaæ liczby od 4 do 10 wykorzystuj¹c procedurê dodajLiczbe.

CREATE PROCEDURE 
procedura
AS
	BEGIN


EXEC DODAJLICZBE_  6, 'szeœæ'

EXEC DODAJLICZBE_ 7, 'siedem'

EXEC DODAJLICZBE_ 8, 'osiem'

EXEC DODAJLICZBE_ 9, 'dziewiêæ'

EXEC DODAJLICZBE_ 10, 'dziesiêæ'

	END

	EXEC procedura

	SELECT * FROM TABLICZBA1
	


---5. Utworzyæ procedurê o nazwie procLiczbaSlownie, która za argument przyjmuje wartoœæ liczbow¹ 
-----i wyœwietla reprezentacjê s³own¹ tej liczby na podstawie danych 
----z tabeli o nazwie TabLiczba. Zweryfikowaæ dzia³anie procedury.

CREATE PROCEDURE
procLiczbaSlownie11
(@numer INT)
AS
	BEGIN
		IF @numer>=1 and @numer<=10
			
				SELECT s³ownie FROM  TABLICZBA1
				WHERE liczba=@numer
			
			
	END

	drop proc procLiczbaSlownie11
	exec procLiczbaSlownie11 3




	--6. Utworzyæ funkcjê o nazwie funkcjaLiczbaSlownie,
	----która za argument przyjmuje wartoœæ liczbow¹ i zwraca reprezentacjê 
	----s³own¹ tej liczby w postaci tabeli, na podstawie danych z tabeli o nazwie TabLiczba. 
	----Zweryfikowaæ dzia³anie.

	CREATE FUNCTION funkcjaLiczbaSlownie11(@I INT) 
	RETURNS TABLE
	AS
	 
	RETURN
	(SELECT s³ownie FROM TABLICZBA1 where liczba=@I)
	
	select * from funkcjaliczbaSlownie11(4)

	SELECT * FROM TABLICZBA1


	---7. Napisaæ funkcjê o nazwie LiczbaWierszy, która zwróci liczbê wierszy zapisanych w tabeli o nazwie TabLiczba.
	CREATE FUNCTION
	LiczbaWierszy1()
	RETURNS INT
	AS
	BEGIN
	DECLARE @I INT
	SET @I=
	(SELECT COUNT(*) FROM TABLICZBA1)
	RETURN @I
	END

	DROP FUNCTION LiczbaWierszy1

	SELECT dbo.LiczbaWierszy1()




	
	----8. Napisaæ funkcjê o nazwie WyswietlDuplikatyLiczb, która w postaci tabeli z kolumnami liczba 
	-----oraz liczba_wystapien, 
	----zwróci listê wszystkich duplikatów liczb, jakie wystêpuj¹ w tabeli. Przetestowaæ dzia³anie.

	CREATE FUNCTION
	WyswietlDuplikatyLiczb1()
	RETURNS INT 
	AS
	BEGIN
	DECLARE @I INT
	SET @I = (S)
	
	END


	----9. Napisaæ procedurê UsunLiczbe, usuwaj¹c¹ liczbê podan¹ jako 
	-----argument wywo³ania procedury. Przetestowaæ dzia³anie.
	CREATE PROCEDURE UsunLiczbe1
	(@I INT)
	AS
		BEGIN
		
		DELETE FROM TABLICZBA1 WHERE liczba=@I
		
		
		END

		EXEC UsunLiczbe1 3

		SELECT * FROM TABLICZBA1


