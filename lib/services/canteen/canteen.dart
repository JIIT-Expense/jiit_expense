
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiitexpense/model/canteen.dart';

class CanteenService {
  Firestore firestore = Firestore.instance;
  String dbPath = 'Canteen';

  Future<List<Canteen>> fetchCanteens() async {
    var result = await firestore.collection(dbPath).getDocuments();
    var canteens = result.documents.map((canteen) => Canteen.fromMap(canteen.data, canteen.documentID))
    .toList();
    return canteens;
  }

}