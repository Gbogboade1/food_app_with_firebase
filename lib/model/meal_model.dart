class Meal {
  final String name;
  final String description;
  final List<String> addOnList;
  final int price;
  final String imageUrl;

  Meal(
      {this.name,
      this.description = "Delicious soup",
      this.addOnList = const [],
      this.price = 2000,
      this.imageUrl});

  String addOnsToStrng(){
    String list = "";
    for (var item in addOnList) {
      list += item + " ";
    }
    return list;
  }
}
