class Product {
  final String name;
  final String description;
  final int price;
  final String image;
  Product(this.name, this.description, this.price, this.image);
  static List<Product> getProducts() {
    List<Product> items = <Product>[];

    items.add(Product(
        "Cake slice",
        "Mixed flavour (chocolate, red velvet and vanilla)",
        1000,
        "cakeslice.jpg"));
    items.add(
        Product("Cup cake", "Vanilla flavour cupcake ", 60, "cupcake.jpg"));
    items.add(Product(
        "Cup cake", "Red velvet flavour cupcake ", 100, "cupcake_.jpg"));
    items.add(Product(
        "Cup cake", "Chocolate flavour cupcake", 100, "chocolatecupcake.jpg"));
    items.add(Product("Meat Pie", "Sweet Tasty Meat pie", 200, "meatpie.jpg"));
    return items;
  }
}
