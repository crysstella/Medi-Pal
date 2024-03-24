import 'package:cloud_firestore/cloud_firestore.dart';

class DataService{
  //Firebase instance
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Medicine information
  final medTypeCollection = 'Medicine Types';
  final medBrandCollection = 'Medicine Brands';
  final medicineTypeID = 'ZUFJnzKbBHVcIoSNASDr';
  final medicineBrandID = 'ckRw2atQibDjcQb1ik7z';

  // Food database
  // Set the default document id
  final foodCollection = 'Food Database';
  final foodID = '2O1FKL6tcyXKC8v3GPIS';
  // userDisease get


  /// Read all medicine type
  Future<Map<String, dynamic>> getAllMedicineTypes() async {
    var collection = firestore.collection(medTypeCollection);
    var document = await collection.doc(medicineTypeID).get();

    if (document.exists) {
      return document.data()!;
    } else {
      throw Exception("Document not found");
    }
  }

  /// Read medicine brand
  Future<Map<String, dynamic>> getMedicineBrandInfo() async {
    var collection = firestore.collection(medBrandCollection);
    var document = await collection.doc(medicineBrandID).get();

    if (document.exists) {
      return document.data()!;
    } else {
      throw Exception("Document not found");
    }
  }

  // Get all medicine names.
  Future<List<String>> getMedicineNames() async{
    var collection = firestore.collection(medTypeCollection);
    var document = await collection.doc(medicineTypeID).get();

    if (document.exists) {
      // Extract data from medicine type collection
      Map<String, dynamic> data = document.data()!;
      // A list to store medicine names in each type
      List<String> medicineNames = [];

      // Iterate over the documents and collect the medicine names
      data.forEach((key, value) {
        if (value is List){
          medicineNames.addAll(List<String>.from(value));
        }
      });

      return medicineNames;
    } else {
      throw Exception("Document not found");
    }


  }
  /*Stream<Map<String, dynamic>> streamAllMedicineTypes() {
    return firestore
        .collection(medTypeCollection)
        .doc(medicineTypeID)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return snapshot.data()!;
      } else {
        return <String, dynamic>{};
      }
    });
  }

  Stream<Map<String, dynamic>> streamMedicineBrandInfo() {
    return firestore.collection(medBrandCollection)
        .doc(medicineBrandID)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return snapshot.data()!;
      } else {
        return <String, dynamic>{};
      }
    });
  }*/

}