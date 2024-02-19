import 'dart:convert';

class Product {
  final int id;
  final String name;
  final String img;
  final String description;
  final double price;
  final double salePrice;
  final double favorite;
  final double rating;

  Product({
    required this.id,
    required this.name,
    required this.img,
    required this.description,
    required this.price,
    required this.salePrice,
    required this.favorite,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      img: json['img'],
      description: json['description'],
      price: json['price'].toDouble(),
      salePrice: json['salePrice'].toDouble(),
      favorite: json['favorite'].toDouble(),
      rating: json['rating'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'img': img,
      'description': description,
      'price': price,
      'salePrice': salePrice,
      'favorite': favorite,
      'rating': rating,
    };
  }
}

List<Product> getProducts() {
  String jsonString = '''
  [
    {
      "id": 1,
      "name": "Trà Đào mix Dứa",
      "img": "assets/images/img_prod_1.png",
      "description": "Đào, chanh Quảng Đông, đường cát, hương dứa tự nhiên.",
      "price": 30000.0,
      "salePrice": 25000.0,
      "favorite": 1500.0,
      "rating": 4.2
    },
    {
      "id": 2,
      "name": "Trà Chanh Kiwi",
      "img": "assets/images/img_prod_2.png",
      "description": "Kiwi, chanh Quảng Đông, đường tinh luyện, hương liệu pha chế.",
      "price": 25000.0,
      "salePrice": 19000.0,
      "favorite": 300.0,
      "rating": 4.5
    },
    {
      "id": 3,
      "name": "Dâu Tây Đá xay",
      "img": "assets/images/img_prod_3.png",
      "description": "Thành phần: Dâu tây Đà Lạt, đá tinh khiết, đường mía nguyên chất",
      "price": 25000.0,
      "salePrice": 20000.0,
      "favorite": 1200.0,
      "rating": 4.9
    }
  ]
  ''';

  List<Product> products = List<Product>.from(
      json.decode(jsonString).map((x) => Product.fromJson(x)));

  return products;
}
