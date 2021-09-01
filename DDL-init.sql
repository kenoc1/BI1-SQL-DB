CREATE TABLE Produkt
(
    Produkt_Id       NUMBER(10) generated always as identity (start with 1 increment by 1 cache 3) CHECK (Produkt_Id >= '0'),
    Gewicht          NUMBER(10, 4)      CHECK (Gewicht >= '0'),
    Umsatzsteuersatz NUMBER(10, 2)      NOT NULL CHECK (Umsatzsteuersatz >= '0'),
    Bezeichnung      VARCHAR2(128 CHAR) NOT NULL,
    SKU              NUMBER(10)         NOT NULL CHECK (SKU >= '0'),
    Typ              VARCHAR2(15 CHAR)  CHECK ( Typ IN ('gewichtsbasiert', 'stueckbasiert')),
    Produkt_Hoehe    NUMBER(10, 2),
    Produkt_Tiefe    NUMBER(10, 2),
    Produkt_Breite   NUMBER(10, 2),
    Marke_Id         NUMBER(10)         NOT NULL,
    PRIMARY KEY (Produkt_Id)
);

CREATE TABLE Produktkategorie
(
    Produktkategorie_Id NUMBER(10) generated always as identity (start with 1 increment by 1 cache 3) CHECK (Produktkategorie_Id >= '0'),
    Bezeichnung         VARCHAR2(128 CHAR) NOT NULL,
    Alterfreigabe       NUMBER(10) CHECK (Alterfreigabe >= '0'),
    PRIMARY KEY (Produktkategorie_Id)
);

CREATE TABLE Produktoberkategorie
(
    Produktoberkategorie_Id NUMBER(10) generated always as identity (start with 1 increment by 1 cache 3) CHECK (Produktoberkategorie_Id >= '0'),
    Bezeichnung             VARCHAR2(128 CHAR) NOT NULL,
    PRIMARY KEY (Produktoberkategorie_Id)
);

CREATE TABLE Einkauf
(
    Einkaufs_Id    NUMBER(10) generated always as identity (start with 1 increment by 1 cache 3) CHECK (Einkaufs_Id >= '0'),
    Einkaufsdatum  DATE       NOT NULL,
    Einkaufssumme  CHAR(1 CHAR),
    Lieferant_Id   NUMBER(10) NOT NULL,
    Mitarbeiter_Id NUMBER(10) NOT NULL,
    PRIMARY KEY (Einkaufs_Id)
);


CREATE TABLE Verkauf
(
    Verkaufs_Id    NUMBER(10) generated always as identity (start with 1 increment by 1 cache 3) CHECK (Verkaufs_Id >= '0'),
    Verkaufdatum   DATE       NOT NULL,
    Verkaufssumme  CHAR(1 CHAR),
    Steuersumme    CHAR(1 CHAR),
    Mitarbeiter_Id NUMBER(10) NOT NULL,
    Kunden_Id      NUMBER(10),
    PRIMARY KEY (Verkaufs_Id)
);

CREATE TABLE Mitarbeiter
(
    Mitarbeiter_Id NUMBER(10) generated always as identity (start with 1 increment by 1 cache 3) CHECK (Mitarbeiter_Id >= '0'),
    Vorname        VARCHAR2(128 CHAR) NOT NULL,
    Nachnane       VARCHAR2(128 CHAR) NOT NULL,
    Provisionssatz NUMBER(2, 2) CHECK (Provisionssatz >= '0'),
    Adress_Id      NUMBER(10)         NOT NULL,
    PRIMARY KEY (Mitarbeiter_Id)
);

Create TABLE Funktion
(
    Funktions_Id NUMBER(10) generated always as identity (start with 1 increment by 1 cache 3) CHECK (Funktions_Id >= '0'),
    Bezeichnung  VARCHAR2(128 CHAR) NOT NULL,
    PRIMARY KEY (Funktions_Id)
);

CREATE TABLE Zuweisung_Mitarbeiter_Funktion
(
    Funktions_Id   NUMBER(10) NOT NULL,
    Mitarbeiter_Id NUMBER(10) NOT NULL
);

CREATE TABLE Kunde
(
    Kunden_Id            NUMBER(10) generated always as identity (start with 1 increment by 1 cache 3) CHECK (Kunden_Id >= '0'),
    Vorname              VARCHAR2(128 CHAR) NOT NULL,
    Nachname             VARCHAR2(128 CHAR) NOT NULL,
    Geburtsdatum         DATE               NOT NULL,
    Rechnungs_Adresse_Id NUMBER(10)         NOT NULL,
    Liefer_Adresse_Id    NUMBER(10)         NOT NULL,
    PRIMARY KEY (Kunden_Id)
);

CREATE TABLE Adresse
(
    Adress_Id NUMBER(10) generated always as identity (start with 1 increment by 1 cache 3) CHECK (Adress_Id >= '0'),
    Strasse   VARCHAR2(128 CHAR) NOT NULL,
    Ort_Id    NUMBER(10)         NOT NULL,
    PRIMARY KEY (Adress_Id)
);

CREATE TABLE Ort
(
    Ort_Id          NUMBER(10) generated always as identity (start with 1 increment by 1 cache 3) CHECK (Ort_Id >= '0'),
    Ortskennzahl_Id NUMBER(10) CHECK (Ortskennzahl_Id >= '0'),
    Name            VARCHAR2(128 CHAR) NOT NULL,
    Land            VARCHAR2(128 CHAR) NOT NULL,
    PRIMARY KEY (Ort_Id)
);

CREATE TABLE Ortskennzahl
(
    Ortskennzahl_Id NUMBER(10) generated always as identity (start with 1 increment by 1 cache 3) CHECK (Ortskennzahl_Id >= '0'),
    Ortskennzahl    VARCHAR2(30 CHAR),
    PRIMARY KEY (Ortskennzahl_Id)
);

CREATE TABLE Land
(
    Land_Id     NUMBER(10) generated always as identity (start with 1 increment by 1 cache 3) CHECK (Land_Id >= '0'),
    Bezeichnung VARCHAR2(128 CHAR) NOT NULL,
    PRIMARY KEY (Land_Id)
);

CREATE TABLE Preis
(
    Preis_Id           NUMBER(10) generated always as identity (start with 1 increment by 1 cache 3) NOT NULL CHECK (Preis_Id >= '0'),
    Betrag             NUMBER(10, 2)                                                                 NOT NULL CHECK (Betrag >= '0'),
    Gueltigkeits_Beginn DATE                                                                          NOT NULL,
    Gueltigkeits_Ende   DATE,
    Typ                VARCHAR2(15 CHAR) CHECK ( Typ IN ('Einkauf', 'Verkauf')),
    PRIMARY KEY (Preis_Id)
);

CREATE TABLE Lieferant
(
    Lieferant_Id         NUMBER(10) generated always as identity (start with 1 increment by 1 cache 3) CHECK (Lieferant_Id >= '0'),
    Name                 VARCHAR2(128 CHAR) NOT NULL,
    EMail                VARCHAR2(128 CHAR) NOT NULL,
    Name_Ansprechpartner VARCHAR2(128 CHAR) NOT NULL,
    Adress_Id            NUMBER(10)         NOT NULL,
    PRIMARY KEY (Lieferant_Id)
);

CREATE TABLE Filiale
(
    Filiale_Id        NUMBER(10) generated always as identity (start with 1 increment by 1 cache 3) CHECK (Filiale_Id >= '0'),
    Bezeichnung       VARCHAR2(128 CHAR) NOT NULL,
    Adress_Id         NUMBER(10)         NOT NULL,
    IBAN              VARCHAR2(34 CHAR),
    Zahlungsempfaenger VARCHAR2(128 CHAR),
    BIC               VARCHAR2(11 CHAR),
    PRIMARY KEY (Filiale_Id)
);

CREATE TABLE Marke
(
    Marke_Id      NUMBER(10) generated always as identity (start with 1 increment by 1 cache 3) CHECK (Marke_Id >= '0'),
    Hersteller_Id NUMBER(10)         NOT NULL,
    Bezeichnung   VARCHAR2(128 CHAR) NOT NULL,
    PRIMARY KEY (Marke_Id)
);

CREATE TABLE Hersteller
(
    Hersteller_Id NUMBER(10) generated always as identity (start with 1 increment by 1 cache 3) CHECK (Hersteller_Id >= '0'),
    Bezeichnung   VARCHAR2(128 CHAR) NOT NULL,
    PRIMARY KEY (Hersteller_Id)
);

CREATE TABLE Lager_Einheit
(
    Lagerplatz_Id NUMBER(10) generated always as identity (start with 1 increment by 1 cache 3) CHECK (Lagerplatz_Id >= '0'),
    Regal_Nummer  NUMBER(10)    NOT NULL CHECK (Regal_Nummer >= '0'),
    Regalzeile    NUMBER(10)    NOT NULL CHECK (Regalzeile >= '0'),
    Regalspalte   NUMBER(10)    NOT NULL CHECK (Regalspalte >= '0'),
    Regalbreite   NUMBER(10, 2) NOT NULL CHECK (Regalbreite >= '0'),
    Regaltiefe    NUMBER(10, 2) NOT NULL CHECK (Regaltiefe >= '0'),
    Regalhoehe     NUMBER(10, 2) NOT NULL CHECK (Regalhoehe >= '0'),
    Typ           VARCHAR2(15 CHAR) CHECK ( Typ IN ('Lagerflaeche', 'Verkaufsflaeche')),
    PRIMARY KEY (Lagerplatz_Id)
);

CREATE TABLE Bon
(
    Bon_Nummer     NUMBER(10) generated always as identity (start with 1 increment by 1 cache 3) CHECK (Bon_Nummer >= '0'),
    Verkaufs_Id    NUMBER(10)                                                 NOT NULL,
    Gegebenes_Geld VARCHAR2(128 CHAR),
    Zahlungsart    VARCHAR2(15 CHAR) CHECK (Zahlungsart IN ('Bar', 'Karte') ) NOT NULL,
    Rueckgeld      VARCHAR2(128 CHAR),
    PRIMARY KEY (Bon_Nummer)
);

CREATE TABLE Lieferschein
(
    Lieferschein_Nummer NUMBER(10) generated always as identity (start with 1 increment by 1 cache 3) CHECK (Lieferschein_Nummer >= '0'),
    Verkaufs_Id         NUMBER(10) NOT Null,
    Lieferdatum         DATE       Not NULL,
    Liefer_Kosten       NUMBER(10, 2),
    PRIMARY KEY (Lieferschein_Nummer)
);

CREATE TABLE Rechnung
(
    Rechnung_Nummer NUMBER(10) generated always as identity (start with 1 increment by 1 cache 3) CHECK (Rechnung_Nummer >= '0'),
    Verkaufs_Id     NUMBER(10) NOT Null,
    Abgleich_Datum  DATE       NOT NULL,
    PRIMARY KEY (Rechnung_Nummer)
);

CREATE TABLE Stueckzahlbasiertes_Produkt_Im_Einkauf
(
    Einkaufs_Id    NUMBER(10) NOT NULL,
    Produkt_Id     NUMBER(10) NOT NULL,
    Anzahl_Produkt NUMBER(10) NOT NULL CHECK (Anzahl_Produkt >= '1'),
    PRIMARY KEY (Einkaufs_Id, Produkt_Id)
);

CREATE TABLE Stueckzahlbasiertes_Produkt_Im_Verkauf
(
    Produkt_Id      NUMBER(10) NOT NULL,
    Verkaufs_Id     NUMBER(10) NOT NULL,
    Anzahl_Produkte NUMBER(10) NOT NULL CHECK (Anzahl_Produkte >= '1'),
    PRIMARY KEY (Produkt_Id, Verkaufs_Id)
);

CREATE TABLE Zuweisung_Produkt_Produktkategorie
(
    Produkt_Id          NUMBER(10) NOT NULL,
    Produktkategorie_Id NUMBER(10) NOT NULL,
    PRIMARY KEY (Produkt_Id, Produktkategorie_Id)
);

CREATE TABLE Zuweisung_Produkt_Lagerplatz
(
    Produkt_Id    NUMBER(10) NOT NULL,
    Lagerplatz_Id NUMBER(10) NOT NULL,
    PRIMARY KEY (Produkt_Id, Lagerplatz_Id)
);

CREATE TABLE Zuweisung_Kategorie_Oberkategorie
(
    Produktkategorie_Id     NUMBER(10) NOT NULL,
    Produktoberkategorie_Id NUMBER(10) NOT NULL,
    PRIMARY KEY (Produktkategorie_Id, Produktoberkategorie_Id)
);

CREATE TABLE Gewichtbasiertes_Produkt_Im_Einkauf
(
    Einkaufs_Id NUMBER(10)    NOT NULL,
    Produkt_Id  NUMBER(10)    NOT NULL,
    Gewicht     NUMBER(10, 4) NOT NULL CHECK (Gewicht >= '0'),
    PRIMARY KEY (Einkaufs_Id, Produkt_Id)
);

CREATE TABLE Gewichtbasiertes_Produkt_Im_Verkauf
(
    Verkaufs_Id NUMBER(10)    NOT NULL,
    Produkt_Id  NUMBER(10)    NOT NULL,
    Gewicht     NUMBER(10, 4) NOT NULL CHECK (Gewicht >= '0'),
    PRIMARY KEY (Verkaufs_Id, Produkt_Id)
);

ALTER TABLE Produkt
    ADD FOREIGN KEY (Marke_Id) REFERENCES Marke (Marke_Id);

ALTER TABLE Mitarbeiter
    ADD FOREIGN KEY (Adress_Id) REFERENCES Adresse (Adress_Id);

ALTER TABLE Einkauf
    ADD FOREIGN KEY (Lieferant_Id) REFERENCES Lieferant (Lieferant_Id) ON DELETE SET NULL;

ALTER TABLE Einkauf
    ADD FOREIGN KEY (Mitarbeiter_Id) REFERENCES Mitarbeiter (Mitarbeiter_Id) ON DELETE SET NULL;

ALTER TABLE Verkauf
    ADD FOREIGN KEY (Mitarbeiter_Id) REFERENCES Mitarbeiter (Mitarbeiter_Id) ON DELETE SET NULL;

ALTER TABLE Verkauf
    ADD FOREIGN KEY (Kunden_Id) REFERENCES Kunde (Kunden_Id) ON DELETE SET NULL;

ALTER TABLE Adresse
    ADD FOREIGN KEY (Ort_Id) REFERENCES Ort (Ort_Id);

ALTER TABLE Lieferant
    ADD FOREIGN KEY (Adress_Id) REFERENCES Adresse (Adress_Id);

ALTER TABLE Filiale
    ADD FOREIGN KEY (Adress_Id) REFERENCES Adresse (Adress_Id);

ALTER TABLE Stueckzahlbasiertes_Produkt_Im_Einkauf
    ADD FOREIGN KEY (Einkaufs_Id) REFERENCES Einkauf (Einkaufs_Id) ON DELETE CASCADE;

ALTER TABLE Stueckzahlbasiertes_Produkt_Im_Einkauf
    ADD FOREIGN KEY (Produkt_Id) REFERENCES Produkt (Produkt_Id) ON DELETE CASCADE;

ALTER TABLE Stueckzahlbasiertes_Produkt_Im_Verkauf
    ADD FOREIGN KEY (Produkt_Id) REFERENCES Produkt (Produkt_Id) ON DELETE CASCADE;

ALTER TABLE Stueckzahlbasiertes_Produkt_Im_Verkauf
    ADD FOREIGN KEY (Verkaufs_Id) REFERENCES Verkauf (Verkaufs_Id) ON DELETE CASCADE;

ALTER TABLE Zuweisung_Produkt_Produktkategorie
    ADD FOREIGN KEY (Produkt_Id) REFERENCES Produkt (Produkt_Id) ON DELETE CASCADE;

ALTER TABLE Zuweisung_Produkt_Produktkategorie
    ADD FOREIGN KEY (Produktkategorie_Id) REFERENCES Produktkategorie (Produktkategorie_Id) ON DELETE CASCADE;

ALTER TABLE Zuweisung_Produkt_Lagerplatz
    ADD FOREIGN KEY (Produkt_Id) REFERENCES Produkt (Produkt_Id) ON DELETE CASCADE;

ALTER TABLE Zuweisung_Produkt_Lagerplatz
    ADD FOREIGN KEY (Lagerplatz_Id) REFERENCES Lager_Einheit (Lagerplatz_Id) ON DELETE CASCADE;

ALTER TABLE Zuweisung_Kategorie_Oberkategorie
    ADD FOREIGN KEY (Produktkategorie_Id) REFERENCES Produktkategorie (Produktkategorie_Id) ON DELETE CASCADE;

ALTER TABLE Zuweisung_Kategorie_Oberkategorie
    ADD FOREIGN KEY (Produktoberkategorie_Id) REFERENCES Produktoberkategorie (Produktoberkategorie_Id) ON DELETE CASCADE;

ALTER TABLE Gewichtbasiertes_Produkt_Im_Einkauf
    ADD FOREIGN KEY (Einkaufs_Id) REFERENCES Einkauf (Einkaufs_Id) ON DELETE CASCADE;

ALTER TABLE Gewichtbasiertes_Produkt_Im_Einkauf
    ADD FOREIGN KEY (Produkt_Id) REFERENCES Produkt (Produkt_Id) ON DELETE CASCADE;

ALTER TABLE Gewichtbasiertes_Produkt_Im_Verkauf
    ADD FOREIGN KEY (Verkaufs_Id) REFERENCES Verkauf (Verkaufs_Id) ON DELETE CASCADE;

ALTER TABLE Gewichtbasiertes_Produkt_Im_Verkauf
    ADD FOREIGN KEY (Produkt_Id) REFERENCES Produkt (Produkt_Id) ON DELETE CASCADE;

ALTER TABLE Zuweisung_Mitarbeiter_Funktion
    ADD FOREIGN KEY (Mitarbeiter_Id) REFERENCES Mitarbeiter (Mitarbeiter_Id) ON DELETE CASCADE;

ALTER TABLE Zuweisung_Mitarbeiter_Funktion
    ADD FOREIGN KEY (Funktions_Id) REFERENCES Funktion (Funktions_Id) ON DELETE CASCADE;

ALTER TABLE Kunde
    ADD FOREIGN KEY (Rechnungs_Adresse_Id) REFERENCES Adresse (Adress_Id);

ALTER TABLE Kunde
    ADD FOREIGN KEY (Liefer_Adresse_Id) REFERENCES Adresse (Adress_Id);

ALTER TABLE Ort
    ADD FOREIGN KEY (Ortskennzahl_Id) REFERENCES Ortskennzahl (Ortskennzahl_Id);

ALTER TABLE Marke
    ADD FOREIGN KEY (Hersteller_Id) REFERENCES Hersteller (Hersteller_Id);

ALTER TABLE Bon
    ADD FOREIGN KEY (Verkaufs_Id) REFERENCES Verkauf (Verkaufs_Id);

ALTER TABLE Lieferschein
    ADD FOREIGN KEY (Verkaufs_Id) REFERENCES Verkauf (Verkaufs_Id);

ALTER TABLE Rechnung
    ADD FOREIGN KEY (Verkaufs_Id) REFERENCES Verkauf (Verkaufs_Id);


COMMENT ON TABLE Produktkategorie IS 'Eine Subkategorie, die dem Produkt zugeordnet ist.';
COMMENT ON TABLE Produktoberkategorie IS 'fasst verschiedene Prodktkategorien zusammen';
COMMENT ON TABLE Lager_Einheit IS 'Alle Einheiten sind in inch';
COMMENT ON TABLE Produkt IS 'Die Einheit des Gewichts in IBS-lbs (2 IBS-lbs = 1 kg)';
COMMENT ON TABLE Gewichtbasiertes_Produkt_Im_Einkauf IS 'Die Einheit des Gewichts in IBS-lbs (2 IBS-lbs = 1 kg) ';
COMMENT ON TABLE Gewichtbasiertes_Produkt_Im_Verkauf IS 'Die Einheit des Gewichts in IBS-lbs (2 IBS-lbs = 1 kg)';
COMMENT ON TABLE Preis IS 'Die Geldeinheit in IB$ (1 IB$ = 0,5€)';
COMMENT ON TABLE Bon IS 'Die Geldeinheit in IB$ (1 IB$ = 0,5€)';
COMMENT ON TABLE Lieferschein IS 'Die Geldeinheit in IB$ (1 IB$ = 0,5€)';
COMMENT ON TABLE Verkauf IS 'Die Geldeinheit in IB$ (1 IB$ = 0,5€)';
COMMENT ON TABLE Einkauf IS 'Die Geldeinheit in IB$ (1 IB$ = 0,5€)';

