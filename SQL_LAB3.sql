--1. Nale�y utworzy� tablic� o nazwie TabLiczba, zawieraj�c� kolumny:

--- identyfikator (autonumeracja),

--- liczba typu liczbowego ca�kowitego (co najmniej z zakresu 0 do 1000),

---slownie typu tekstowego.

CREATE TABLE
TABLICZBA1
(
identyfikator INT IDENTITY(1,1),
liczba INT,
s�ownie varchar(100)
)

INSERT INTO TabLiczba1(liczba, s�ownie) VALUES (1,'jeden');

INSERT INTO TABLICZBA1(liczba, s�ownie) VALUES (2,'dwa');

INSERT INTO TabLiczba1(liczba, s�ownie) VALUES (3,'trzy');



--2. Utworzy� procedur� o nazwie wyswietlDane, 
--kt�ra wy�wietli wszystkie wiersze z tabeli o nazwie Liczba. Zweryfikowa� dzia�anie procedury.

CREATE PROCEDURE 
WYSWIETLDANE1
AS
BEGIN
	SELECT liczba
	FROM TABLICZBA1
END

EXEC WYSWIETLDANE1


--3. Utworzy� procedur� o nazwie dodajLiczbe, 
---kt�ra przyjmuje dwa argumenty - liczb� oraz jej reprezentacj� s�own�
---i dodaje te argumenty jako kolejny wiersz tabeli TabLiczba.

CREATE PROCEDURE
DODAJLICZBE_ (@LICZBA INT, @NAZWA VARCHAR(100))
AS
BEGIN
	INSERT INTO TabLiczba1(liczba,s�ownie) VALUES (@LICZBA,@NAZWA)
END

EXEC DODAJLICZBE_ 4,'cztery'

EXEC DODAJLICZBE_ 5,'pi��'

--4. Doda� liczby od 4 do 10 wykorzystuj�c procedur� dodajLiczbe.

CREATE PROCEDURE 
procedura
AS
	BEGIN


EXEC DODAJLICZBE_  6, 'sze��'

EXEC DODAJLICZBE_ 7, 'siedem'

EXEC DODAJLICZBE_ 8, 'osiem'

EXEC DODAJLICZBE_ 9, 'dziewi��'

EXEC DODAJLICZBE_ 10, 'dziesi��'

	END

	EXEC procedura

	SELECT * FROM TABLICZBA1
	


---5. Utworzy� procedur� o nazwie procLiczbaSlownie, kt�ra za argument przyjmuje warto�� liczbow� 
-----i wy�wietla reprezentacj� s�own� tej liczby na podstawie danych 
----z tabeli o nazwie TabLiczba. Zweryfikowa� dzia�anie procedury.

CREATE PROCEDURE
procLiczbaSlownie11
(@numer INT)
AS
	BEGIN
		IF @numer>=1 and @numer<=10
			
				SELECT s�ownie FROM  TABLICZBA1
				WHERE liczba=@numer
			
			
	END

	drop proc procLiczbaSlownie11
	exec procLiczbaSlownie11 3




	--6. Utworzy� funkcj� o nazwie funkcjaLiczbaSlownie,
	----kt�ra za argument przyjmuje warto�� liczbow� i zwraca reprezentacj� 
	----s�own� tej liczby w postaci tabeli, na podstawie danych z tabeli o nazwie TabLiczba. 
	----Zweryfikowa� dzia�anie.

	CREATE FUNCTION funkcjaLiczbaSlownie11(@I INT) 
	RETURNS TABLE
	AS
	 
	RETURN
	(SELECT s�ownie FROM TABLICZBA1 where liczba=@I)
	
	select * from funkcjaliczbaSlownie11(4)

	SELECT * FROM TABLICZBA1


	---7. Napisa� funkcj� o nazwie LiczbaWierszy, kt�ra zwr�ci liczb� wierszy zapisanych w tabeli o nazwie TabLiczba.
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




	
	----8. Napisa� funkcj� o nazwie WyswietlDuplikatyLiczb, kt�ra w postaci tabeli z kolumnami liczba 
	-----oraz liczba_wystapien, 
	----zwr�ci list� wszystkich duplikat�w liczb, jakie wyst�puj� w tabeli. Przetestowa� dzia�anie.

	CREATE FUNCTION
	WyswietlDuplikatyLiczb1()
	RETURNS INT 
	AS
	BEGIN
	DECLARE @I INT
	SET @I = (S)
	
	END


	----9. Napisa� procedur� UsunLiczbe, usuwaj�c� liczb� podan� jako 
	-----argument wywo�ania procedury. Przetestowa� dzia�anie.
	CREATE PROCEDURE UsunLiczbe1
	(@I INT)
	AS
		BEGIN
		
		DELETE FROM TABLICZBA1 WHERE liczba=@I
		
		
		END

		EXEC UsunLiczbe1 3

		SELECT * FROM TABLICZBA1


