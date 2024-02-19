import 'package:flutter/material.dart';
import 'package:interview_test/application/enum/type_drink_enum.dart';
import 'package:interview_test/data/class/drink_dart.dart';
import 'package:interview_test/presentation/drink_detail_screen.dart';
import 'package:interview_test/rsc/color_manager.dart';
import 'package:interview_test/rsc/image_manager.dart';
import 'package:interview_test/rsc/string_manager.dart';
import 'package:interview_test/widget/cart_button.dart';
import 'package:interview_test/widget/drink_cart.dart';

List<DropdownMenuItem<TypeDrinkEnum>> listType = [
  DropdownMenuItem<TypeDrinkEnum>(
    value: TypeDrinkEnum.popular,
    child: Text(StringsApp.phoBien),
  ),
  DropdownMenuItem<TypeDrinkEnum>(
    value: TypeDrinkEnum.bestSeller,
    child: Text(StringsApp.muaNhieu),
  ),
  DropdownMenuItem<TypeDrinkEnum>(
    value: TypeDrinkEnum.cheap,
    child: Text(StringsApp.giaRe),
  ),
];

Product product = Product(
    id: 0,
    name: '',
    img: '',
    description: '',
    price: 0,
    salePrice: 0,
    favorite: 0,
    rating: 0);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> listproduct = [];
  @override
  void initState() {
    listproduct = getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.height;
    final ValueNotifier<TypeDrinkEnum> selectedValue =
        ValueNotifier<TypeDrinkEnum>(TypeDrinkEnum.popular);
    final ValueNotifier<Product> selectProduct =
        ValueNotifier<Product>(product);
    return Scaffold(
        body: Stack(children: [
      _renderBackground(),
      _renderBody(screenSize, selectedValue, selectProduct, context),
    ]));
  }

  Column _renderBody(
      double screenSize,
      ValueNotifier<TypeDrinkEnum> selectedValue,
      ValueNotifier<Product> selectProduct,
      BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _renderInfo(screenSize, selectedValue, selectProduct, context),
        _renderList(selectedValue, selectProduct)
      ],
    );
  }

  Widget _renderList(ValueNotifier<TypeDrinkEnum> selectedValue,
      ValueNotifier<Product> selectProduct) {
    return Expanded(
      child: SingleChildScrollView(
        child: ValueListenableBuilder<TypeDrinkEnum>(
            valueListenable: selectedValue,
            builder: (context, value, child) {
              switch (value) {
                case TypeDrinkEnum.popular:
                  listproduct.sort((a, b) => b.favorite.compareTo(a.favorite));
                  break;
                case TypeDrinkEnum.cheap:
                  listproduct
                      .sort((a, b) => a.salePrice.compareTo(b.salePrice));

                  break;
                case TypeDrinkEnum.bestSeller:
                  listproduct.sort((a, b) => b.rating.compareTo(a.rating));
                  break;
                default:
              }
              return Column(
                children: listproduct
                    .map((e) => DrinkCard(
                          drinkTitle: e.name,
                          description: e.description,
                          image: e.img,
                          rating: e.rating,
                          favorite: e.favorite,
                          price: e.salePrice,
                          onTap: () {
                            selectProduct.value = e;
                            const snackBar =
                                SnackBar(content: Text('Đã thêm vào giỏ hàng'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                        ))
                    .toList(),
              );
            }),
      ),
    );
  }

  Widget _renderInfo(
      double screenSize,
      ValueNotifier<TypeDrinkEnum> selectedValue,
      ValueNotifier<Product> selectProduct,
      BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(ImagesApp.mixteaBackground),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenSize / 9),
                    Image.asset(ImagesApp.headerText),
                    const SizedBox(height: 6),
                    Text(
                      StringsApp.suluachon,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: ColorsApp.noteText),
                    ),
                    SizedBox(height: screenSize / 9),
                    _searchRow(selectedValue, selectProduct, context),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Row _searchRow(ValueNotifier<TypeDrinkEnum> selectedValue,
      ValueNotifier<Product> selectProduct, BuildContext context) {
    return Row(
      children: [
        Text(
          StringsApp.timKiemTheo,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        Stack(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ValueListenableBuilder<TypeDrinkEnum>(
                    valueListenable: selectedValue,
                    builder: (context, value, child) {
                      return Text(
                        value.getName,
                        style:
                            TextStyle(fontSize: 14, color: ColorsApp.selected),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: DropdownButton<TypeDrinkEnum>(
                underline: Container(),
                alignment: Alignment.bottomLeft,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                ),
                value: null,
                items: listType,
                onChanged: (TypeDrinkEnum? newValue) {
                  selectedValue.value = newValue!;
                },
              ),
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DrinkDetail(
                      id: selectProduct.value.id,
                      descript: selectProduct.value.description,
                      name: selectProduct.value.name,
                      price: selectProduct.value.price,
                      sellPrice: selectProduct.value.salePrice,
                      rating: selectProduct.value.rating,
                    )),
          ),
          child: ValueListenableBuilder<Product>(
              valueListenable: selectProduct,
              builder: (context, value, child) {
                return CartButton(
                  selected: value.id != 0,
                );
              }),
        )
      ],
    );
  }

  Widget _renderBackground() {
    return Image.asset(
      ImagesApp.background,
      width: double.infinity,
      fit: BoxFit.fitWidth,
    );
  }
}
