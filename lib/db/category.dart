import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CategoryService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'categories';
  void createCategory(String name) {
    var id = Uuid();
    String categoryId = id.v1();

    _firestore.collection(ref).doc(categoryId).set({'category': name});
  }

  Future<List<DocumentSnapshot<Map<String,dynamic>>>> getCategories() {
    return _firestore.collection(ref).get().then((snapshots)  {
      return snapshots.docs;
    });
  }
  Future getSuggestions(String suggestion)
  {
   return _firestore.collection(ref).where('category',arrayContains: suggestion).get().then((snap){
     return snap.docs;
   });
  }
}
