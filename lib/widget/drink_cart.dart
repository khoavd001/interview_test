import 'dart:math';

import 'package:flutter/material.dart';
import 'package:interview_test/application/ultil/convert%20_to_price.dart';
import 'package:interview_test/application/ultil/convert_favorite.dart';
import 'package:interview_test/rsc/color_manager.dart';
import 'package:interview_test/rsc/image_manager.dart';
import 'package:interview_test/rsc/string_manager.dart';

class DrinkCard extends StatelessWidget {
  String? drinkTitle;
  String? image;
  String? description;
  double? favorite;
  double? rating;
  double price;
  VoidCallback? onTap;
  DrinkCard({
    super.key,
    this.drinkTitle,
    this.image,
    this.description,
    this.favorite,
    this.rating,
    this.price = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> selected = ValueNotifier<bool>(false);
    return Container(
      margin: const EdgeInsets.all(16),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _renderHeader(selected),
          const SizedBox(height: 8),
          _renderInfo(),
          _renderRating(),
        ],
      ),
    );
  }

  Stack _renderHeader(ValueNotifier<bool> selected) {
    return Stack(
      children: [
        Image.asset(
          image ?? ImagesApp.traoMixDua,
          fit: BoxFit.cover,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${convertToPrice(price)}đ',
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ),
            ValueListenableBuilder<bool>(
                valueListenable: selected,
                builder: (context, value, child) {
                  return GestureDetector(
                      onTap: () => {
                            selected.value = !selected.value,
                          },
                      child: selected.value == false
                          ? Image.asset(ImagesApp.unSelectedHeart)
                          : Image.asset(ImagesApp.selectedHeart));
                })
          ],
        ),
      ],
    );
  }

  Column _renderInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            drinkTitle ?? StringsApp.traDaoMixDua,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18.2),
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              description ?? StringsApp.traDaoMixDua,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: ColorsApp.ingredientText),
            )),
      ],
    );
  }

  Padding _renderRating() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: [
          Image.asset(ImagesApp.star),
          const SizedBox(width: 4),
          Text(
            rating.toString(),
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: ColorsApp.ingredientText),
          ),
          const SizedBox(width: 24),
          Image.asset(ImagesApp.heart),
          const SizedBox(width: 4),
          Text(
            convertFavorite(favorite ?? 0),
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: ColorsApp.ingredientText),
          ),
          const Spacer(),
          GestureDetector(onTap: onTap, child: Image.asset(ImagesApp.addIcon))
        ],
      ),
    );
  }
}
