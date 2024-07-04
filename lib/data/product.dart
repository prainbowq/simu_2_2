class Product {
  const Product({
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
  });

  Product.fromMap(final Map<String, dynamic> map, this.category)
      : name = map['name'],
        imageUrl = "https://img.pchome.com.tw/cs${map['picS']}",
        price = map['price'];

  final String name;
  final String imageUrl;
  final String category;
  final int price;
}
