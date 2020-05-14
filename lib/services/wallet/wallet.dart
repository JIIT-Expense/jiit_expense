import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiitexpense/model/wallet.dart';

class WalletService {

  Firestore firestore = Firestore.instance;
  String dbPath = 'Wallet';
  int balance;

  Stream<Wallet>getWalletBalanceStream(String canteenId, String userId) {
    return firestore.collection(dbPath).document(userId).snapshots().map((item) {
      return Wallet(canteenId: canteenId, balance: item.data[canteenId]);
    });
  }

  updateAmount(int newAmount, String canteenId, String userId) async {
    await firestore.collection(dbPath).document(userId).setData({canteenId: newAmount});
  }

}