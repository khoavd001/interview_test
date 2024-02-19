class ImagesApp {
  static String background = ImagesPath.getPath('background.png');
  static String mixteaBackground = ImagesPath.getPath('mixtea_background.png');
  static String headerText = ImagesPath.getPath('header_text.png');
  static String shoppingIcon = ImagesPath.getPath('shopping_icon.png');
  static String traoMixDua = ImagesPath.getImages('img_prod_1.png');
  static String trakiwi = ImagesPath.getImages('img_prod_2.png');
  static String traDau = ImagesPath.getImages('img_prod_3.png');
  static String star = ImagesPath.getImages('star.png');
  static String heart = ImagesPath.getImages('heart.png');
  static String addIcon = ImagesPath.getImages('add_icon.png');
  static String backgroundTraDau =
      ImagesPath.getImages('background_tra_dau.png');
  static String backgroundTraKiwi =
      ImagesPath.getImages('background_tra_kiwi.png');
  static String backgroundTraDua =
      ImagesPath.getImages('background_tra_mix_dua.png');
  static String minusIcon = ImagesPath.getImages('minus_icon.png');
  static String addDrink = ImagesPath.getImages('add_drink.png');
  static String cartIcon = ImagesPath.getImages('cart_icon.png');
  static String selectedHeart = ImagesPath.getImages('selected_heart.png');
  static String unSelectedHeart = ImagesPath.getImages('unselected_heart.png');
}

extension ImagesPath on ImagesApp {
  static String getImages(String name) {
    return 'assets/images/$name';
  }

  static String getPath(String name) {
    if (name.contains('.svg')) {
      return 'assets/svg/$name';
    }
    if (name.contains('.png')) {
      return 'assets/png/$name';
    }
    if (name.contains('.jpg')) {
      return 'assets/jpg/$name';
    }
    if (name.contains('.json')) {
      return 'assets/json/$name';
    }
    if (name.contains('.gif')) {
      return 'assets/gif/$name';
    }
    return 'assets/svg/$name';
  }
}
