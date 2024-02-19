String convertToPrice(double price) {
  price = price / 1000;
  // Chuyển số thành chuỗi
  if (price == 0) return '${price.toInt()}';
  String numberString = price.toString();

  // Tách phần nguyên và phần thập phân
  List<String> parts = numberString.split('.');

  // Lấy số sau dấu chấm
  String decimalPart = parts.length > 1 ? parts[1] : '';
  if (decimalPart == '0') return '${price.toInt()}.000';
  return '${price.toInt()}.${decimalPart}';
}
