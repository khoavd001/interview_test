String convertFavorite(double fav) {
  if (fav >= 1000) {
    return '${(fav / 1000).toString()}M';
  }
  return '${(fav.toInt()).toString()}k';
}
