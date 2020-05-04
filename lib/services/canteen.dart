import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiitexpense/models/canteen.dart';
import 'package:jiitexpense/models/menu_item.dart';
import 'package:jiitexpense/services/user.dart';

class CanteenService {

  final CollectionReference _canteen = Firestore.instance.collection('canteen');
  final UserService userService = UserService();

  Stream<List<Canteen>> canteens() {
    return _canteen.snapshots().map(
          (qs) => qs.documents.map(_canteenFromQuerySnapshot).toList()
    );
  }

  Canteen _canteenFromQuerySnapshot(DocumentSnapshot data) {
    return data == null ? null : Canteen(
        name: data.data['name'],
        contact: data.data['contact'],
        location: data.data['location'],
        menuItems: _convertMapToMenuItemList(data.data['menuItem']),
        uid: data.documentID
    );
  }

  List<MenuItem> _convertMapToMenuItemList(dynamic data) {
    List<MenuItem> lis = [];
    data.forEach((val) => lis.add(MenuItem(name: val['name'], price: val['price'], availability: val['availability'])));
    return lis;
  }

  // Create new Canteen
  Future<void> createNewCanteen (String name, String contact, String location, List<MenuItem> menuItems) async {
    await _canteen.add({
      'name': name,
      'contact': contact,
      'location': location,
      'menuItems': menuItems
    });
  }

  // get all canteens
  Future<List<Canteen>> getAllCanteens() async {
    QuerySnapshot querySnapshot = await _canteen.getDocuments();
    List<Canteen> res = [];
    querySnapshot.documents.forEach((document) => {
      res.add(_canteenFromQuerySnapshot(document))
    });
    return res;
  }

  // join a canteen
  Future<void> joinNewCanteen(String userUid, String canteenUid) async {
    await userService.joinNewCanteen(userUid, canteenUid);
  }

}