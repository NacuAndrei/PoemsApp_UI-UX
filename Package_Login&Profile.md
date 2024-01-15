## Package diagram pentru Login si Profile

![Imagine](https://github.com/NacuAndrei/Poems_App/blob/main/Login%26Profile_Package.png)
- Reprezinta structurarea logica a fisierelor legate de Login Si Profile;

- Pachetele Models, Widgets si Services grupeaza mai eficient unele fisiere;

- Sageata dintre doua pachete arata faptul ca un pachet il importa pe altul(cel cu sageata inspre el). De exemplu, "PoemList" foloseste "Poem". M-am orientat dupa importurile de la inceputul fiecarui fisier pentru a trasa corect sagetile;

- Nu am inclus pachete default, doar cele create in aplicatie de noi. SIngurul exemplu inclus este "firebase_options" pentru a arata conexiunea cu Firebase;

- Pentru variabile, simbolul "+" semnifica faptul ca variabila este publica, iar "-" este pentru variabilele private;

- Am aranjat ierarhic si orientarea pachetelor in diagrama: Paginile principale se afla cel mai jos, in timp ce modelele sunt cel mai sus.
