## Backend Class Diagram

The app uses Firebase for it's backend. The `model` classes are used to represent Firestore objects. The `DataService` contains the logic for retrieving, updating, and deleting the data.

```mermaid
classDiagram
    class FirebaseUser {
      -String userId
      -String userEmail
      -String userName
      -String userPhotoURL
      +FirebaseUser(String userId, String userEmail, String userName, String userPhotoURL)
      +Map < String, dynamic > toMap()
      +FirebaseUser.fromMap(Map < String, dynamic > map)
    }

    class PoemModel {
      -String? id
      -String title
      -String content
      -String? photoURL
      -bool isPublished
      +PoemModel(String? id, String title, String content, String? photoURL, bool isPublished)
      +Map < String, dynamic > toMap()
      +PoemModel.fromDocumentSnapshot(QueryDocumentSnapshot < Map < String, dynamic >> doc)
      +PoemModel.fromMap(Map < String, dynamic > map)
    }

    class PublishedPoemModel {
      -Timestamp publishedDate
      -FirebaseUser user
      +PublishedPoemModel(String? id, String title, String content, String? photoURL, Timestamp publishedDate, FirebaseUser user)
      +Map < String, dynamic > toMap()
      +PublishedPoemModel.fromDocumentSnapshot(QueryDocumentSnapshot < Map < String, dynamic >> doc)
    }

    class DataService {
      -FirebaseFirestore _db
      -FirebaseStorage _storage
      +Future < void > addPoemDraft(String userId, PoemModel poem, File? photo)
      +Stream < QuerySnapshot < Map < String, dynamic >>> getPoemDrafts(String userId)
      +void publishPoem(PoemModel poem, FirebaseUser user)
      +Stream < QuerySnapshot < Map < String, dynamic >>> getPublishedPoems()
      +Future < void > addPoemToFavourites(String userId, String poemId)
      +Future < void > removePoemFromFavourites(String userId, String poemId)
      +Future < bool > isPoemFavourited(String userId, String poemId)
      +Stream < QuerySnapshot < Map < String, dynamic >>> getFavouritedPoems(String userId)
      +Future < void > deleteDraft(String userId, String poemId)
      +Future < void > deletePublishedPoem(String userId, String poemId)
    }

    PoemModel <|-- PublishedPoemModel: Extends
    PublishedPoemModel *-- FirebaseUser: Contains
    DataService --> FirebaseUser: Uses
    DataService --> PoemModel: Uses
    DataService --> PublishedPoemModel: Uses
```
