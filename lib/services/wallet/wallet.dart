import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiitexpense/model/wallet.dart';

class WalletService {

  Firestore firestore = Firestore.instance;
  String db_path = 'Wallet';
  int balance;

  Stream<Wallet>getWalletBalanceStream(String canteenId, String userId) {
    return firestore.collection(db_path).document(userId).snapshots().map((item) {
      return Wallet(canteenId: canteenId, balance: item.data[canteenId]);
    });
  }

  updateAmount(int newAmount, String canteenId, String userId) async {
    await firestore.collection(db_path).document(userId).setData({canteenId: newAmount});
  }

}