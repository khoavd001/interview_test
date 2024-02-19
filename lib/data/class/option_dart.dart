class BeverageOption {
  final int id;
  final String name;
  final double price;

  BeverageOption({
    required this.id,
    required this.name,
    required this.price,
  });

  factory BeverageOption.fromJson(Map<String, dynamic> json) {
    return BeverageOption(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
    );
  }
}

List<BeverageOption> getOption() {
  List<BeverageOption> beverageOptions = [
    BeverageOption(id: 1, name: 'Không đường', price: 0.0),
    BeverageOption(id: 2, name: 'Ít đường', price: 0.0),
    BeverageOption(id: 3, name: 'Nhiều đường', price: 0.0),
    BeverageOption(id: 4, name: 'Không đá', price: 0.0),
    BeverageOption(id: 5, name: 'Ít đá', price: 0.0),
    BeverageOption(id: 6, name: 'Nhiều đá', price: 0.0),
  ];

  // Accessing the data
  for (BeverageOption option in beverageOptions) {
    print('ID: ${option.id}');
    print('Name: ${option.name}');
    print('Price: ${option.price}');
    print('-----------------------');
  }
  return beverageOptions;
}
