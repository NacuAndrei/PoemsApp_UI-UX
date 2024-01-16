## Use-case diagram pentru Compose page

![Diagrama](https://github.com/NacuAndrei/Poems_App/assets/61271003/655c3efd-31bd-4291-aa56-4e442933f21e)

-Diagrama a fost creata cu ideea de a urmarii modul in care un poem este creat, salvat si accesat din aplicatie;

- Fiecare chenar reprezinta o pagina din aplicatie, iar fiecare nod este o optiune pe care utilizatorul o poate alege;

- Ramura "Extend" descrie cum nodul urmator poate fi efectuat sau nu, dar daca este efectuat, atunci si nodul anterior a fost efectuat.
  De exemplu, cand utilizatorul scrie un poem poate sa adauge o imagine, dar nu este obligatoriu;

- Pentru ramura "Include", nodul urmator se efectueaza obligatoriu dupa efectuarea celui precedent.
  De exemplu, cand utilizatorul scrie un poem trebuie sa adauge titlu si body;

- Baza de date permite vizualizarea poemelor salvate in aceasta.
  Din pagina de compose utilizatorul poate salva un draft, care poate fii vizualizat si publicat din pagina de profil.
  Toate poemele publicate pot fii vizualizate in home page,de unde pot fii marcate ca favorite, putand fii vizualizate in pagina de favorite mai tarziu.
