class User {
  int? id;
  String name;
  String quantity;
  String addToCart;

  User({this.id, required this.name, required this.quantity, required this.addToCart});

  User.fromMap(Map<String, dynamic> response)
      : id = response["id"],
        name = response["name"],
        quantity = response["quantity"],
        addToCart = response["addToCart"];

  Map<String, Object?> toMap() {
    return {'id': id, 'name': name, 'quantity': quantity, 'addToCart': addToCart};
  }
}