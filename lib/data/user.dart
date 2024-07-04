class User {
  const User(
      {required this.number,
      required this.password,
      required this.favorites,
      required this.cart});

  User.fromMap(final Map<String, dynamic> map)
      : number = map['number'],
        password = map['password'],
        favorites = map['favorites'].split('`,`'),
        cart = _parseCart(map['cart']);

  static const sql = 'CREATE TABLE users(number, password, favorites, cart)';

  final String number;
  final String password;
  final List<String> favorites;
  final List<MapEntry<String, int>> cart;

  Map<String, dynamic> toMap() => {
        'number': number,
        'password': password,
        'favorites': favorites.join('`,`'),
        'cart':
            cart.map((entry) => "${entry.key}`!`${entry.value}").join('`,`'),
      };
}

List<MapEntry<String, int>> _parseCart(final String string) {
  final split = string.split('`,`');
  if (split.length == 1 && split.first.isEmpty) {
    return [];
  }
  return split.map((item) {
    final split2 = item.split('`!`');
    return MapEntry(split2.first, int.parse(split2.last));
  }).toList();
}
