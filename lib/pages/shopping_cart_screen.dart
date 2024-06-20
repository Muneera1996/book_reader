
import 'package:book_reader/components/button_widget.dart';
import 'package:book_reader/components/title_text.dart';
import 'package:book_reader/models/CartList.dart';
import 'package:book_reader/notifiers/AppNotifier.dart';
import 'package:book_reader/pages/empty_screen.dart';
import 'package:book_reader/themes/light_color.dart';
import 'package:book_reader/themes/theme.dart';
import 'package:book_reader/utils/SharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';


class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

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
    return SizedBox(
      height: 270,
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 8,
              ),
              TitleText(
                text: model.title,
                color: LightColor.black,
                fontWeight: FontWeight.w700,
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: LightColor.lightGrey,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Image.network(model.imageLinks['thumbnail'] ?? ''),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        _getDivider(),
                        Row(
                          children: <Widget>[
                            RichText(
                                text: TextSpan(children: [
                              const TextSpan(
                                text: 'Price:  ',
                                style: TextStyle(
                                    color: LightColor.black, fontSize: 17),
                              ),
                              TextSpan(
                                text:
                                    '${AppSharedPreferences().getCurrencySymbol()}${model.pageCount} \n',
                                style: const TextStyle(
                                    color: LightColor.secondaryDarkColor,
                                    fontSize: 17),
                              ),
                              const TextSpan(
                                text: 'Tax:   ',
                                style: TextStyle(
                                    color: LightColor.black, fontSize: 17),
                              ),
                              TextSpan(
                                text:
                                    "${AppSharedPreferences().getCurrencySymbol()}${model.pageCount}\n",
                                style: const TextStyle(
                                    color: LightColor.secondaryDarkColor,
                                    fontSize: 17),
                              ),
                              const TextSpan(
                                text: 'Licence \n',
                                style: TextStyle(
                                    color: LightColor.black, fontSize: 15),
                              ),
                              // TextSpan(
                              //   text: 'Minimum Quantity: ${model.quantity}',
                              //   style: const TextStyle(
                              //       color: LightColor.black, fontSize: 15),
                              // )
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () => Provider.of<AppNotifier>(context,listen: false)
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
                        style: TextStyle(color: LightColor.black, fontSize: 18),
                      ),
                      TextSpan(
                        text:
                            '${AppSharedPreferences().getCurrencySymbol()} ${int.parse(model.pageCount.toString()) * model.quantity}',
                        style: TextStyle(color: LightColor.black, fontSize: 20),
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
          onTap: () =>
              Provider.of<AppNotifier>(context,listen: false).decrementCartItem(model.id),
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
          onTap: () =>
              Provider.of<AppNotifier>(context,listen: false).incrementCartItem(model.id),
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
      return Container(
        width: AppTheme.fullWidth(context) * 0.8,
        height: 40.0,
        child: ButtonWidget(
          text: 'Next',
          fontSize: 20,
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => ShippingAddress()));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: LightColor.background,
        appBar: AppBar(title: const Text("Cart"),),
        body: Consumer<AppNotifier>(builder: (context, value, child) {
          if(value.getCartSize()>0){
            return Column(
              children: <Widget>[
                SizedBox(
                  height: AppTheme.fullHeight(context) * 0.75,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
          }
          else{
            return const EmptyCartScreen();
          }
        }));
  }

  String getTotalItem(List<Book> cartList) {
    int items = 0;
    for (var x in cartList) {
        items +=  x.quantity;
    }
    return items.toString();
  }
}
