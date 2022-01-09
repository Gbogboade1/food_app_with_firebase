class FoodStuff {
  final String name;
  final List<String> availableTypes;
  final String metric;
  final String imageUrl;

  FoodStuff({
    this.name,
    this.availableTypes=const [],
    this.metric  = "Congo",
    this.imageUrl = "assets/food5.jpeg",
  });
}
