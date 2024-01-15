## Use-case diagram pentru Login si Profile 

![Diagrama](https://github.com/NacuAndrei/Poems_App/blob/main/Login%26Profile_UseCase.png)
- Fiecare chenar reprezinta o pagina din aplicatie, iar fiecare nod este o optiune pe care utilizatorul o poate alege;

- Ramura "Extend" descrie cum nodul urmator poate fi efectuat sau nu, dar daca este efectuat, atunci si nodul anterior a fost efectuat.
De exemplu, dupa ce a intrat in pagina de login, utilizatorul are ca variante sa se logheze cu Google, cu email si parola sau sa isi recupereze parola
insa nu este obligat sa aleaga vreuna dintre aceste variante;

- Pentru ramura "Include", nodul urmator se efectueaza obligatoriu dupa efectuarea celui precedent.
De exemplu, dupa "View profile" se efectueaza si nodul "View poems" deoarece lista de poezii apare automat la vizionarea profilului;

- Baza de date ii da acces utilizatorului pe baza datelor introduse, iar profilul sau este extras tot din baza.
Pentru a ajunge la profil, utilizatorul trebuie sa treaca mai intai prin home page, care este ilustrata in diagrama doar ca o punte de legatura intre cele doua pagini
deoarece scopul diagramei a fost sa ilustreze use case pentru Login si Profile.
