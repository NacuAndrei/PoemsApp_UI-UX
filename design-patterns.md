# Design Patterns

### Service Locator / Singleton

Un Service Locator este un design pattern care permite obținerea de referințe către diverse servicii sau componente fără a necesita o cuplare strânsă între clase. Practic, oferă un punct centralizat unde obiectele pot fi înregistrate și ulterior accesate. Acest model este folosit pentru a crește flexibilitatea și modularitatea în aplicații, facilitând în același timp testarea și mentenanța codului.

`get_it` este un pachet pentru Flutter care funcționează ca un Service Locator. Este esențial în Flutter pentru a separa interfețele de implementările concrete și pentru a facilita accesul la aceste implementări în întreaga aplicație. Acest lucru este util în special pentru accesarea serviciilor. 

Aplicatia noastra utilizeaza `get_it` pentru a inregistra servicii care lucreaza cu baza de date si se cupa de autentificarea userilor:

``` dart
// Register services
GetIt.instance.registerSingleton<AuthService>(AuthService());
GetIt.instance.registerSingleton<DataService>(DataService());
```

Aceste servicii se pot folosii apoi din orice componenta, avand ca avantaj ca nu este nevoie sa pasezi o instanta de la parinte la copii.


### Data Transfer Object (DTO)

Un Data Transfer Object (DTO) este un design pattern utilizat pentru a transfera date între subsisteme ale unei aplicații. Acestea sunt deosebit de utile în scenarii cum ar fi lucrul cu baze de date Firestore, pentru a modela datele primite și pentru a trimite date înapoi.

Un exemplu de DTO este clasa `PoemModel`:

```dart
class PoemModel {
  final String? id;
  final String title;
  final String content;
  String? photoURL;
  bool isPublished;

  PoemModel({
    this.id,
    required this.title,
    required this.content,
    this.photoURL,
    this.isPublished = false
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'photoURL': photoURL,
      'isPublished': isPublished
    };
  }

  PoemModel.fromDocumentSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        title = doc.data()["title"],
        content = doc.data()["content"] ?? "",
        photoURL = doc.data()["photoURL"],
        isPublished = doc.data()["isPublished"] ?? false;
}
```

Un alt avantaj este  Separarea Concern-urilor. DTO permite separarea reprezentării datelor de logica de afaceri.
