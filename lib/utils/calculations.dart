class Calculations {

  static String calculateDiscountedPrice(priceString, discountString) {
    double price = double.parse(priceString);
    double discount = double.parse(discountString);

    if (price <= 0 || discount < 0 || discount >= 100) {
      return priceString;
    }

    double discountAmount = price * (discount / 100);
    double discountedPrice = price - discountAmount;
    return discountedPrice.toString();
  }

}