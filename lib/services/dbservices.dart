import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/carModel.dart';

class DatabaseService {
  // declaration et init

  CollectionReference _cars = FirebaseFirestore.instance.collection('cars');

  FirebaseStorage _storage = FirebaseStorage.instance;

  // uplpod l'image vers le cloud

  Future<String> uploadFile(file) async {
    Reference reference = _storage.ref().child('cars/${DateTime.now()}.png');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  // ajout de la voiture sur firestore

  void addCar(Car car) {
    _cars.add({
      "carName": car.carName,
      "carUrlImg": car.carUrlImg,
      "carUsrID": car.carUserID,
      "carUserName": car.carUserName,
      "carTimestamp": FieldValue.serverTimestamp(),
      "carFavoriteCount": 0,
    });
  }

  // recuperation des données en temps réel

  Stream<List<Car>> get cars {
    Query queryCars = _cars.orderBy('carTimestamp', descending: true);
    return queryCars.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Car(
            carID: doc.id,
            carName: doc.get('carName'),
            carUrlImg: doc.get('carUrlImg'),
            carUserID: doc.get('carUserID'),
            carUserName: doc.get('carUserName'),
            carFavoriteCount: doc.get('carFavoriteCount'),
            carTimestamp: doc.get('carTimestamp'),
            );
      }).toList();
    });
  }
}
