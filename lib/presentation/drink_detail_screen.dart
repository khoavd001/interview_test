// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:interview_test/application/ultil/convert%20_to_price.dart';
import 'package:interview_test/data/class/option_dart.dart';
import 'package:interview_test/data/class/size_dart.dart';
import 'package:interview_test/data/class/topping_dart.dart';

import 'package:interview_test/rsc/color_manager.dart';
import 'package:interview_test/rsc/image_manager.dart';
import 'package:interview_test/widget/cart_button.dart';

class DrinkDetail extends StatefulWidget {
  String? image;
  String? name;
  String? descript;
  double price;
  double sellPrice;
  double? rating;
  DrinkDetail(
      {Key? key,
      this.image,
      this.descript,
      this.name,
      this.price = 0,
      this.sellPrice = 0,
      this.rating})
      : super(key: key);

  @override
  State<DrinkDetail> createState() => _DrinkDetailState();
}

class _DrinkDetailState extends State<DrinkDetail> {
  List<Topping> topping = [];
  List<BeverageOption> option = [];
  List<SizeOption> size = [];
  double additionPrice = 0;
  double countPrice = 0;
  @override
  void initState() {
    topping = getTopping();
    option = getOption();
    size = getSize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final ValueNotifier<SizeOption> selectedSize =
        ValueNotifier<SizeOption>(SizeOption(id: 0, name: '', price: 0));
    final ValueNotifier<BeverageOption> selectedOption =
        ValueNotifier<BeverageOption>(
            BeverageOption(id: 0, name: '', price: 0));
    final ValueNotifier<Topping> selectedToping =
        ValueNotifier<Topping>(Topping(id: 0, name: '', price: 0));
    final ValueNotifier<double> price = ValueNotifier<double>(widget.sellPrice);
    final ValueNotifier<int> count = ValueNotifier<int>(1);
    if (widget.name == '') {
      return const Text('chưa chọn đơn hàng');
    }
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Image.asset(
                  ImagesApp.backgroundTraDau,
                  fit: BoxFit.fitWidth,
                  width: screenSize.width,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 45),
                      _renderHeader(),
                      const SizedBox(height: 200),
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24))),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Text(
                                widget.name ?? '',
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.descript ?? '',
                                style: TextStyle(
                                    color: ColorsApp.ingredientText,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Image.asset(ImagesApp.star),
                                  const SizedBox(width: 4),
                                  Text(
                                    widget.rating.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: ColorsApp.ingredientText),
                                  ),
                                  const Spacer(),
                                  Text('${convertToPrice(widget.price)}đ ',
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: ColorsApp.ingredientText,
                                      )),
                                  Text('${convertToPrice(widget.sellPrice)}đ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 24,
                                          color: ColorsApp.selected))
                                ],
                              ),
                              const SizedBox(height: 30),
                              SizedBox(
                                height: screenSize.height / 3,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      _renderTitle('Chọn size ', false),
                                      _renderSizeOption(
                                          selectedSize,
                                          size,
                                          price,
                                          selectedOption,
                                          selectedToping,
                                          selectedSize),
                                      const SizedBox(height: 16),
                                      _renderTitle('Món ăn kèm ', true),
                                      _renderSizeOption(
                                          selectedToping,
                                          topping,
                                          price,
                                          selectedOption,
                                          selectedToping,
                                          selectedSize),
                                      const SizedBox(height: 16),
                                      _renderTitle('Yêu cầu thành phần ', true),
                                      _renderSizeOption(
                                          selectedOption,
                                          option,
                                          price,
                                          selectedOption,
                                          selectedToping,
                                          selectedSize),
                                      const SizedBox(height: 16),
                                      _renderTitle(
                                          'Thêm lưu ý cho quán ', true),
                                      const SizedBox(height: 10),
                                      TextFormField(
                                        maxLines: 5,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: ColorsApp.noteColor,
                                          hintText: 'Ghi chú ở đây',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                        cursorHeight: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ValueListenableBuilder<dynamic>(
                                  valueListenable: count,
                                  builder: (context, value, child) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                            onTap: () => {
                                                  if (value > 0)
                                                    {
                                                      count.value = value - 1,
                                                      countPrice =
                                                          widget.sellPrice *
                                                              (count.value - 1),
                                                      price.value =
                                                          widget.sellPrice +
                                                              countPrice +
                                                              additionPrice
                                                    }
                                                },
                                            child: Image.asset(
                                                ImagesApp.minusIcon)),
                                        const SizedBox(width: 10),
                                        Text(
                                          '${value >= 10 ? '' : '0'}${value.toString()}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(width: 10),
                                        GestureDetector(
                                            onTap: () => {
                                                  count.value = value + 1,
                                                  countPrice =
                                                      widget.sellPrice *
                                                          (count.value - 1),
                                                  price.value =
                                                      widget.sellPrice +
                                                          countPrice +
                                                          additionPrice,
                                                  print(widget.sellPrice),
                                                  print(value),
                                                  print(price.value),
                                                  print(additionPrice)
                                                },
                                            child: Image.asset(
                                                ImagesApp.addDrink)),
                                      ],
                                    );
                                  }),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(12),
                                    child: ValueListenableBuilder<dynamic>(
                                        valueListenable: price,
                                        builder: (context, value, child) {
                                          return ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              primary: ColorsApp.selected,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                      ImagesApp.cartIcon),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    'Thêm vào đơn - ${convertToPrice(value)}đ',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderSizeOption(
      ValueNotifier<dynamic> selected,
      List<dynamic> list,
      ValueNotifier<double> price,
      ValueNotifier<BeverageOption> option,
      ValueNotifier<Topping> topping,
      ValueNotifier<SizeOption> size) {
    return ValueListenableBuilder<dynamic>(
        valueListenable: selected,
        builder: (context, value, child) {
          return Column(
            children: list
                .map((e) => Column(
                      children: [
                        RadioListTile<String>(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(e.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.black,
                                  )),
                              Text(
                                  '${e.price != 0 ? '+' : ''} ${convertToPrice(e.price)}đ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ))
                            ],
                          ),
                          value: e.name,
                          groupValue: selected.value.name,
                          onChanged: (value) {
                            selected.value = e;
                            additionPrice = size.value.price +
                                topping.value.price +
                                option.value.price;
                            price.value =
                                widget.sellPrice + additionPrice + countPrice;

                            print(size.value.price);
                            print(price);
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Divider(),
                        )
                      ],
                    ))
                .toList(),
          );
        });
  }

  Row _renderTitle(String title, bool isOptional) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(isOptional ? '( Không bắt buộc )' : '( Bắt buộc )',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: ColorsApp.ingredientText,
            )),
      ],
    );
  }

  Padding _renderHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.only(left: 8.0, bottom: 8, top: 8),
                  child: Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
              )),
          CartButton(
            selected: true,
          )
        ],
      ),
    );
  }
}
