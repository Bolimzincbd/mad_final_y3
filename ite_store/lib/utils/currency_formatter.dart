class CurrencyFormatter {
  static String format(double amount) {
    // Simple way to show dollars with 2 decimal places (e.g., $10.50)
    return '\$${amount.toStringAsFixed(2)}';
  }
}