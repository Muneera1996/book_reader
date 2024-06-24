import 'package:book_reader/components/button_widget.dart';
import 'package:book_reader/components/title_text.dart';
import 'package:book_reader/models/CartList.dart';
import 'package:book_reader/notifiers/AppNotifier.dart';
import 'package:book_reader/pages/empty_screen.dart';
import 'package:book_reader/themes/light_color.dart';
import 'package:book_reader/themes/theme.dart';
import 'package:book_reader/utils/Constants.dart';
import 'package:book_reader/utils/SharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  void initState() {
    super.initState();
    //_loadCart();
  }

  Future<void> _loadCart() async {
    await Provider.of<AppNotifier>(context, listen: false)
        .loadCartFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: LightColor.background,
        appBar: AppBar(
          title: const Text("Cart"),
        ),
        body: Consumer<AppNotifier>(builder: (context, value, child) {
          if (value.getCartSize() > 0) {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: AppTheme.fullHeight(context) * 0.75,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          _Books(context),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 10),
                        _price(value.getCartSize()),
                        const SizedBox(height: 10),
                        _submitButton(context),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const EmptyCartScreen();
          }
        }));
  }

  Widget _Books(BuildContext context) {
    return SafeArea(
      child: Column(
          children: CartList.getInstance()
              .getCartItems()
              .map((x) => _item(context, x))
              .toList()),
    );
  }

  Widget _item(BuildContext context, Book model) {
    String descriptionText =
        model.description.isNotEmpty ? model.description : "No Description";
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 8,
              ),
              TitleText(
                text: model.title,
                color: LightColor.black,
                fontWeight: FontWeight.w700,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(
                height: 4,
              ),
              TitleText(
                text: descriptionText,
                overflow: TextOverflow.ellipsis,
                fontSize: 12,
                maxLines: 2,
                color: LightColor.darkgrey,
                textAlign: TextAlign.start,
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 4, top: 20),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: LightColor.lightGrey,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Image.network(model.imageLinks['thumbnail'] ?? ''),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _getDivider(),
                        const SizedBox(
                          height: 2,
                        ),
                        TitleText(
                          text: model.authors.isNotEmpty ? model.authors.first : "",
                          color: LightColor.black,
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          fontSize: 12,
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: <Widget>[
                            RichText(
                                text: TextSpan(children: [
                              const TextSpan(
                                text: 'Price:   ',
                                style: TextStyle(
                                    color: LightColor.black, fontSize: 12),
                              ),
                              TextSpan(
                                text:
                                    "${AppSharedPreferences().getCurrencySymbol()}${model.pageCount}\n",
                                style: const TextStyle(
                                    color: LightColor.secondaryDarkColor,
                                    fontSize: 12),
                              ),
                            ]))
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        quantitySection(context, model),
                      ],
                    ),
                  ),
                  Container(
                    width: 35,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: LightColor.lightGrey.withAlpha(150),
                        borderRadius: BorderRadius.circular(10)),
                    child: TitleText(
                      text: 'x${model.quantity}',
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () =>
                          Provider.of<AppNotifier>(context, listen: false)
                              .removeCartItem(model.id),
                      child: const TitleText(
                        text: "REMOVE",
                        color: Colors.red,
                        fontSize: 17,
                      ),
                    ),
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                        text: 'Total:   ',
                        style: TextStyle(color: LightColor.black, fontSize: 12),
                      ),
                      TextSpan(
                        text:
                            '${AppSharedPreferences().getCurrencySymbol()} ${int.parse(model.pageCount.toString()) * model.quantity}',
                        style: const TextStyle(
                            color: LightColor.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      )
                    ]))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row quantitySection(BuildContext context, Book model) {
    return Row(
      children: <Widget>[
        const TitleText(
          text: 'Quantity:    ',
          fontSize: 17,
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.start,
        ),
        InkWell(
          onTap: () => Provider.of<AppNotifier>(context, listen: false)
              .decrementCartItem(model.id),
          child: Container(
            alignment: Alignment.center,
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: LightColor.secondaryColor,
            ),
            child: const TitleText(
              text: '-',
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: TitleText(
            color: LightColor.black,
            text: ' ${model.quantity}  ',
          ),
        ),
        InkWell(
          onTap: () => Provider.of<AppNotifier>(context, listen: false)
              .incrementCartItem(model.id),
          child: Container(
            alignment: Alignment.center,
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              color: LightColor.secondaryColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const TitleText(
              text: '+',
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Divider _getDivider() {
    return const Divider(
      thickness: 1,
      height: 30,
    );
  }

  Widget _price(int cartSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        RichText(
            text: TextSpan(children: [
          TextSpan(
            text: cartSize.toString(),
            style: const TextStyle(
                color: LightColor.secondaryDarkColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const TextSpan(
            text: " Items",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ])),
        RichText(
            text: TextSpan(children: [
          const TextSpan(
            text: "Total: ",
            style: TextStyle(
              color: LightColor.black,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text:
                '${AppSharedPreferences().getCurrencySymbol()}${getPrice(CartList.getInstance().getCartItems())}',
            style: const TextStyle(
              color: LightColor.secondaryDarkColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ])),
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    return SizedBox(
      width: AppTheme.fullWidth(context) * 0.8,
      height: 40.0,
      child: ButtonWidget(
        text: 'Next',
        fontSize: 20,
        onPressed: () {
          Navigator.pushNamed(context, Constants.shippingAddress);
        },
      ),
    );
  }

  double getPrice(List<Book> cartList) {
    double price = 0;
    cartList.forEach((x) {
      price += double.parse(x.pageCount.toString()) * x.quantity;
    });
    return price;
  }

  String getTotalItem(List<Book> cartList) {
    int items = 0;
    for (var x in cartList) {
      items += x.quantity;
    }
    return items.toString();
  }
}
