class SizeOption {
  final int id;
  final String name;
  final double price;

  SizeOption({
    required this.id,
    required this.name,
    required this.price,
  });

  factory SizeOption.fromJson(Map<String, dynamic> json) {
    return SizeOption(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
    );
  }
}

List<SizeOption> getSize() {
  List<SizeOption> sizeOptions = [
    SizeOption(id: 1, name: 'S', price: 0.0),
    SizeOption(id: 2, name: 'M', price: 5000.0),
    SizeOption(id: 3, name: 'L', price: 10000.0),
  ];

  // Accessing the data
  for (SizeOption option in sizeOptions) {
    print('ID: ${option.id}');
    print('Name: ${option.name}');
    print('Price: ${option.price}');
    print('-----------------------');
  }
  return sizeOptions;
}
