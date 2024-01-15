### Firestore Security Rules

Diagrama evidențiază cum regulile de securitate din Firestore sunt utilizate pentru a controla accesul utilizatorilor la diferite funcții ale aplicației. Fiecare flux începe cu o interacțiune a utilizatorului cu UI-ul, urmată de verificări de securitate în Firestore, care determină dacă acțiunea este permisă sau nu, bazându-se pe id-ul utilizatorului.

1.  **Drafturile Utilizatorului**: Utilizatorul solicită să vadă și să editeze drafturile sale prin UI. Cererea este transmisă la Firestore, unde regulile verifică dacă utilizatorul are permisiunea de a citi/scrie bazat pe autentificarea acestuia. Dacă ID-ul de utilizator corespunde, accesul este acordat; în caz contrar, este refuzat.
    
2.  **Vizualizarea Poeziilor Publice**: Utilizatorul dorește să vadă poeziile publice ale altor utilizatori. UI-ul transmite cererea la Firestore, care permite citirea acestora necondiționa.
    
3.  **Crearea unei Poezii Publice**: Când utilizatorul dorește să publice o poezie, UI-ul trimite o solicitare de creare la Firestore. Aici, regulile verifică dacă utilizatorul curent este cel care a creat poezia. Dacă da, crearea este permisă; dacă nu, este refuzată.
    
4.  **Ștergerea unei Poezii Publice**: Utilizatorul cere să șteargă una dintre poeziile sale publice prin UI. Firestore verifică dacă solicitantul este proprietarul poeziei. Dacă este adevărat, ștergerea este permisă; altfel, este refuzată.
    
5.  **Accesul la Lista de Poezii Favorite**: Utilizatorul dorește să citească și să editeze lista sa de poezii favorite. Solicitarea este inițiată prin UI și trimisă la Firestore, unde regulile verifică dacă utilizatorul are dreptul de a citi și scrie în această secțiune.

```mermaid
sequenceDiagram
    participant User
    participant UI
    participant Firestore
    participant Rules

    User->>UI: Wants to see his drafts and edit them
    UI->>Firestore: Request Access to /Poems/{userId}/Drafts/{draftId}
    Firestore->>Rules: Check read/write
    alt Drafts Access
        Rules->>Firestore: Access Granted (request.auth.uid == userId)
        Firestore->>User: Provide read/write access
    else Unauthorized Access
        Rules->>Firestore: Access Denied
        Firestore->>User: Deny access
    end

    User->>UI: Wants to see public poems from other users
    UI->>Firestore: Request Read /PublicPoems
    Firestore->>Rules: Check read
    alt Public Read Access
        Rules->>Firestore: Read Allowed (Unconditional)
        Firestore->>User: Provide read access
    end

    User->>UI: Wants to turn a poem draft into a public poem
    UI->>Firestore: Request Create in /PublicPoems/{poemId}
    Firestore->>Rules: Check create
    alt Own Poem Creation
        Rules->>Firestore: Create Allowed (request.auth.uid == resource.data.user.userId)
        Firestore->>User: Allow creation
    else Unauthorized Creation
        Rules->>Firestore: Create Denied
        Firestore->>User: Deny creation
    end

    User->>UI: Wants to delete one of his public poems
    UI->>Firestore: Request Delete in /PublicPoems/{poemId}
    Firestore->>Rules: Check delete
    alt Own Poem Deletion
        Rules->>Firestore: Delete Allowed (request.auth.uid == PublicPoems/$(poemId)).data.user.userId)
        Firestore->>User: Allow deletion
    else Unauthorized Deletion
        Rules->>Firestore: Delete Denied
        Firestore->>User: Deny deletion
    end

    User->>UI: Wants to read and edit his favourite poems list
    UI->>Firestore: Request Access to /Poems/{userId}/Favourites/{poemId}
    Firestore->>Rules: Check read/write
    alt Favourites Access
        Rules->>Firestore: Access Granted (request.auth.uid == userId)
        Firestore->>User: Provide read/write access
    else Unauthorized Access
        Rules->>Firestore: Access Denied
        Firestore->>User: Deny access
    end

```
