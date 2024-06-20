import 'dart:ffi';

import 'package:book_reader/components/button_widget.dart';
import 'package:book_reader/components/title_text.dart';
import 'package:book_reader/models/Book.dart';
import 'package:book_reader/models/Book.dart';
import 'package:book_reader/models/Book.dart';
import 'package:book_reader/models/Book.dart';
import 'package:book_reader/models/Book.dart';
import 'package:book_reader/models/Book.dart';
import 'package:book_reader/models/Book.dart';
import 'package:book_reader/models/Book.dart';
import 'package:book_reader/models/Book.dart';
import 'package:book_reader/models/CartList.dart';
import 'package:book_reader/notifiers/AppNotifier.dart';
import 'package:book_reader/themes/light_color.dart';
import 'package:book_reader/themes/theme.dart';
import 'package:book_reader/utils/SharedPreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({required Key key}) : super(key: key);

  Widget _Books(BuildContext context) {
    return Column(
        children: CartList.getInstance()
            .getCartItems()
            .map((x) => _item(context, x))
            .toList());
  }

  Widget _item(BuildContext context, Book model) {
    return Container(
      height: 270,
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
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
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: LightColor.lightGrey,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Image.network(model.previewLink),
                  ),
                  SizedBox(
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
                              TextSpan(
                                text: 'Price:  ',
                                style: TextStyle(
                                    color: LightColor.black, fontSize: 17),
                              ),
                              TextSpan(
                                text:
                                    '${AppSharedPreferences().getCurrencySymbol()}${model.pageCount} \n',
                                style: TextStyle(
                                    color: LightColor.secondaryDarkColor,
                                    fontSize: 17),
                              ),
                              TextSpan(
                                text: 'Tax:   ',
                                style: TextStyle(
                                    color: LightColor.black, fontSize: 17),
                              ),
                              TextSpan(
                                text:
                                    "${AppSharedPreferences().getCurrencySymbol()}${model.pageCount}\n",
                                style: TextStyle(
                                    color: LightColor.secondaryDarkColor,
                                    fontSize: 17),
                              ),
                              TextSpan(
                                text: 'Licence \n',
                                style: TextStyle(
                                    color: LightColor.black, fontSize: 15),
                              ),
                              TextSpan(
                                text: 'Minimum Quantity: ${model.quantity}',
                                style: TextStyle(
                                    color: LightColor.black, fontSize: 15),
                              )
                            ]))
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        quantitySection(context, model),
                        _getDivider(),
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
                      onTap: () => Provider.of<AppNotifier>(context)
                          .removeCartItem(model.id),
                      child: TitleText(
                        text: "REMOVE",
                        color: Colors.red,
                        fontSize: 17,
                      ),
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
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
              Provider.of<AppNotifier>(context).decrementCartItem(model.id),
          child: Container(
            alignment: Alignment.center,
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
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
              Provider.of<AppNotifier>(context).incrementCartItem(model.id),
          child: Container(
            alignment: Alignment.center,
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              color: LightColor.secondaryColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TitleText(
              text: '+',
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Divider _getDivider() {
    return Divider(
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
            text: "${cartSize.toString()}",
            style: TextStyle(
                color: LightColor.secondaryDarkColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: " Items",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ])),
        RichText(
            text: TextSpan(children: [
          TextSpan(
            text: "Total: ",
            style: TextStyle(
              color: LightColor.black,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text:
                '${AppSharedPreferences().getCurrencySymbol()}${getPrice(CartList.getInstance().getCartItems())}',
            style: TextStyle(
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
    return Expanded(
      child: Container(
        width: AppTheme.fullWidth(context) * 0.8,
        child: ButtonWidget(
          text: 'Next',
          fontSize: 20,
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => ShippingAddress()));
          },
        ),
      ),
    );
  }

  double getPrice(List<Book> cartList) {
    double price = 0;
    cartList.forEach((x) {
      //  price += double.parse(x.productsPrice) * x.productsQuantity;
    });
    return price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: LightColor.background,
        // appBar: appBarWidget(context),
        body: Consumer<AppNotifier>(builder: (context, value, child) {
          return Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: AppTheme.fullHeight(context) * 0.75,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          _Books(context),
                          _getDivider(),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      //mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 10),
                        _price(value.getCartSize()),
                        SizedBox(height: 10),
                        _submitButton(context),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }

  String getTotalItem(List<Book> cartList) {
    int items = 0;
    cartList.forEach((x) {
      //   items +=  x.productsQuantity;
    });
    return items.toString();
  }
}
