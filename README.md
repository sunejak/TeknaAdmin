# Tekna Administrator

Noen enkle script for å forenkle automatiseringen av Tekna medlemmer i din bedriftsgruppe.
For å kunne lage statistikk og gjøre spørringer, så brukes ansattnummeret som unik identifikator.

* På siden https://www.tekna.no/minside/tekna-gruppe/ kan du se dine medlemmer. Der er også en knapp for å "Eksportere valgt visning" og når du trykker på den så gir den deg en CSV fil med medlemsdata.
* Denne fila kan så konverteres til SQL, og legges inn i din database. **_NB_**, det er viktig at du bruker feltet "Ansattnummer" aktivt hos Tekna.
* Kjør scriptet "Insert_Tekna.sh filnavn tabellnavn" og den gir deg SQL koden du trenger.
* Kjør SQL koden i din favoritt database.

```bash
./Insert_Tekna.sh Medlemsliste.csv tekna_apr_2022 | mysql -p 
```

* Tilsvarende har du et medlemsregister som inneholder medlemmene i bedriftsgruppa. Denne får du tilsendt fra administrasjonen og avhengig av formatet, så konverterer du den til en CVS fil.
* Denne fila konverteres til SQL og legges inn i din database.

```bash
./Insert_Trekkliste.sh Trekkliste.csv tekna_apr_2022 | mysql -p 
```

