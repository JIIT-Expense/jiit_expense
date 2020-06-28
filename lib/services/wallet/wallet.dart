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

  addWallet(String userId, String canteenId) async {
    await firestore.collection(dbPath).document(userId).get().then((value) => {
      value.exists ? value.data.containsKey(canteenId) ? null : firestore.collection(dbPath).document(userId).setData({canteenId : 0}) : firestore.collection(dbPath).document(userId).setData({canteenId : 0})
    });

  }
  
  Future<int> getBalance(String userId, String canteenId) async {
    int balance;
    var doc = firestore.collection(dbPath).document(userId);
    await doc.get().then((document) => {
      balance = (document[canteenId] as int)
    });
    return balance;
  }

  sendMoney(String senderId, String receiverId, String canteenId, int senderBalance, int amount) async {
    await firestore.collection(dbPath).document(senderId).setData({canteenId: senderBalance-amount});
    var receiverBalance = await getBalance(receiverId, canteenId);
    await firestore.collection(dbPath).document(receiverId).setData({canteenId: receiverBalance + amount});
  }

}