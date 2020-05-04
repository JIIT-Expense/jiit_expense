import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiitexpense/models/order.dart';
import 'package:jiitexpense/models/user_Canteen.dart';

class UserService {

  final CollectionReference _user = Firestore.instance.collection('user');

  Future<void> createNewUser(String uid) async {
    return await _user.document(uid).setData({
      'canteens': []
    });
  }

  Future<void> joinNewCanteen(String userUid, String canteenUid) async {
    return await _user.document(userUid).updateData({'canteens': FieldValue.arrayUnion([{
      'balance': 0,
      'uid': canteenUid,
      'orders': [],
    }])});
  }

  List<UserCanteen> getAllCanteens(String uid) {
    this.getCanteensAsync(uid).then((val) => {
      val.data['canteens'].map((val) => {
        print(val['uid']),
        UserCanteen(uid: val['uid'], balance: val['balance'], orders: _convertToOrder(val['orders']))
      }).toList()
    });
    return [];
  }


  Future<DocumentSnapshot> getCanteensAsync(String uid) async {
    return await _user.document(uid).get();
  }

  _convertToOrder(dynamic orders) {
    return orders.forEach((order) => {
      Order(total: order['total'], canteenUid: order['canteenUid'], dateTime: order['dateTime'], uid: order['uid'])
    }.toList());
  }

}