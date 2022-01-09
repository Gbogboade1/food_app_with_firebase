class FoodItem {
  final String imageUrl;
  final String name;
  final String description;
  final String unitOfMeasurement;
  final int volume;

  FoodItem({
    this.imageUrl,
    this.name,
    this.description = "",
    this.unitOfMeasurement = "cups",
    this.volume = 0,
  });
}
