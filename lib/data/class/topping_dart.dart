class Topping {
  final int id;
  final String name;
  final double price;

  Topping({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Topping.fromJson(Map<String, dynamic> json) {
    return Topping(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
    );
  }
}

List<Topping> getTopping() {
  List<Topping> products = [
    Topping(id: 1, name: 'Bánh quy', price: 5000.0),
    Topping(id: 2, name: 'Bánh bông lan trứng muối', price: 15000.0),
    Topping(id: 3, name: 'Bơ sữa', price: 10000.0),
    Topping(id: 4, name: 'Thạch rau câu', price: 8000.0),
  ];

  // Accessing the data
  for (Topping product in products) {
    print('ID: ${product.id}');
    print('Name: ${product.name}');
    print('Price: ${product.price}');
    print('-----------------------');
  }
  return products;
}
