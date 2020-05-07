class Canteen {
  final String name;
  final String number;
  final String address;
  final String uid;

  Canteen({this.uid, this.name, this.address, this.number});

  Canteen.fromMap(Map snapshot, String id) :
      uid = id ?? '',
      name = snapshot['name'],
      address = snapshot['address'],
      number = snapshot['number'];

}