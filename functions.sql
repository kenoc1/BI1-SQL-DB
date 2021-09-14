create or replace type verkaufs_summen_typ As OBJECT
(
    GESAMT_STEUER number(10, 2),
    NETTO_SUMME   number(10, 2),
    BRUTTO_SUMME  number(10, 2)
);

create or replace function Verkaufs_Summen_Berechnen(verkaufId number) return verkaufs_summen_typ deterministic
    is
    GESAMT_STEUER number(10, 2);
    NETTO_SUMME   number(10, 2);
    summen        verkaufs_summen_typ;
begin
    FOR produkt IN
        (SELECT PRODUKT.PRODUKT_ID,
                PREIS.BETRAG,
                PRODUKT.UMSATZSTEUERSATZ,
                GEWICHTBASIERTES_PRODUKT_IM_VERKAUF.GEWICHT
         FROM PRODUKT,
              GEWICHTBASIERTES_PRODUKT_IM_VERKAUF,
              PREIS
         WHERE (verkaufId = GEWICHTBASIERTES_PRODUKT_IM_VERKAUF.VERKAUFS_ID and
                GEWICHTBASIERTES_PRODUKT_IM_VERKAUF.PRODUKT_ID = PRODUKT.PRODUKT_ID and
                PREIS.PRODUKT_ID = PRODUKT.PRODUKT_ID and
                Preis.TYP = 'Verkauf' AND Preis.GUELTIGKEITS_ENDE IS NULL))
        LOOP
            GESAMT_STEUER :=
                        GESAMT_STEUER + (produkt.BETRAG * produkt.UMSATZSTEUERSATZ * produkt.GEWICHT * 0.01);
            NETTO_SUMME := NETTO_SUMME + (produkt.BETRAG * produkt.GEWICHT);
        END LOOP;

    FOR produkt IN
        ( SELECT PRODUKT.PRODUKT_ID,
                 PREIS.BETRAG,
                 PRODUKT.UMSATZSTEUERSATZ,
                 STUECKZAHLBASIERTES_PRODUKT_IM_VERKAUF.ANZAHL_PRODUKTE
          FROM PRODUKT,
               STUECKZAHLBASIERTES_PRODUKT_IM_VERKAUF,
               PREIS
          WHERE (verkaufId = STUECKZAHLBASIERTES_PRODUKT_IM_VERKAUF.VERKAUFS_ID and
                 STUECKZAHLBASIERTES_PRODUKT_IM_VERKAUF.PRODUKT_ID = PRODUKT.PRODUKT_ID and
                 PREIS.PRODUKT_ID = PRODUKT.PRODUKT_ID and
                 Preis.TYP = 'Verkauf' AND Preis.GUELTIGKEITS_ENDE IS NULL))
        LOOP
            GESAMT_STEUER := GESAMT_STEUER +
                             (produkt.BETRAG * produkt.UMSATZSTEUERSATZ * produkt.ANZAHL_PRODUKTE * 0.01);
            NETTO_SUMME := NETTO_SUMME + (produkt.BETRAG * produkt.ANZAHL_PRODUKTE);
        END LOOP;
    summen.BRUTTO_SUMME := 10;
    summen.NETTO_SUMME := 10;
    summen.GESAMT_STEUER := 10;
    return summen;
end;


alter
    table
    VERKAUF
    add STEUERSUMME number(10, 2) GENERATED always as (Verkaufs_Summen_Berechnen(VERKAUF.VERKAUFS_ID).GESAMT_STEUER);
alter
    table
    VERKAUF
    add NETTOSUMME number(10, 2) GENERATED always as (Verkaufs_Summen_Berechnen(VERKAUF.VERKAUFS_ID).NETTO_SUMME);
alter
    table
    VERKAUF
    add BRUTTOSUMME number(10, 2) GENERATED always as (Verkaufs_Summen_Berechnen(VERKAUF.VERKAUFS_ID).BRUTTO_SUMME);
/