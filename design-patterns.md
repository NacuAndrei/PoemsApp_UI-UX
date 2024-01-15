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

``` dart

```
