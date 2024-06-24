import 'package:book_reader/components/button_widget.dart';
import 'package:book_reader/components/title_text.dart';
import 'package:book_reader/models/CartList.dart';
import 'package:book_reader/models/book.dart';
import 'package:book_reader/themes/light_color.dart';
import 'package:book_reader/themes/theme.dart';
import 'package:book_reader/utils/Constants.dart';
import 'package:book_reader/utils/SharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../notifiers/AppNotifier.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late String firstName;
  late String lastName;
  late String address;
  late String city;
  late String country;
  late String postalCode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    firstName = args['firstName'];
    lastName = args['lastName'];
    address = args['address'];
    city = args['city'];
    country = args['country'];
    postalCode = args['postalCode'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.background,
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Consumer<AppNotifier>(builder: (context, value, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                _summarySection(context),
                const SizedBox(height: 20),
                _shippingAddressSection(),
                const SizedBox(height: 20),
                _totalSection(context),
                const SizedBox(height: 20),
                _confirmButton(context),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _summarySection(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: CartList.getInstance()
              .getCartItems()
              .map((x) => _itemSummary(context, x))
              .toList(),
        ),
      ),
    );
  }

  Widget _itemSummary(BuildContext context, Book model) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: LightColor.lightGrey,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Image.network(model.imageLinks['thumbnail'] ?? ''),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TitleText(
                    text: model.title,
                    color: LightColor.black,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    model.description,
                    style: const TextStyle(
                      color: LightColor.darkgrey,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Author: ${model.authors}',
                    style: const TextStyle(
                      color: LightColor.black,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Price: ${AppSharedPreferences().getCurrencySymbol()}${model.pageCount}',
                    style: const TextStyle(
                      color: LightColor.secondaryDarkColor,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Quantity: ${model.quantity}',
                    style: const TextStyle(
                      color: LightColor.black,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(thickness: 1, height: 30),
      ],
    );
  }

  Widget _shippingAddressSection() {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const TitleText(
              text: 'Shipping Address',
              color: LightColor.black,
              fontSize: 20,
            ),
            const SizedBox(height: 10),
            _addressDetail('First Name', firstName ?? ""),
            _addressDetail('Last Name', lastName ?? ""),
            _addressDetail('Address', address ?? ""),
            _addressDetail('City', city ?? ""),
            _addressDetail('Country', country ?? ""),
            _addressDetail('Postal Code', postalCode ?? ""),
          ],
        ),
      ),
    );
  }

  Widget _addressDetail(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          TitleText(
            text: '$title: ',
            color: LightColor.darkgrey,
            fontSize: 16,
          ),
          Text(
            detail,
            style: const TextStyle(
              color: LightColor.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _totalSection(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const TitleText(
              text: 'Total',
              color: LightColor.black,
              fontSize: 20,
            ),
            TitleText(
              text:
                  '${AppSharedPreferences().getCurrencySymbol()}${_calculateTotal()}',
              color: LightColor.secondaryDarkColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }

  double _calculateTotal() {
    double total = 0;
    CartList.getInstance().getCartItems().forEach((book) {
      total += double.parse(book.pageCount.toString()) * book.quantity;
    });
    return total;
  }

  Widget _confirmButton(BuildContext context) {
    return SizedBox(
      width: AppTheme.fullWidth(context) * 0.8,
      height: 40.0,
      child: ButtonWidget(
        text: 'Confirm Order',
        fontSize: 20,
        onPressed: () async {
          // clear cart, Navigate to OrderConfirmationScreen and pass data as arguments
          await Provider.of<AppNotifier>(context, listen: false).checkoutCart();
          Navigator.pushNamedAndRemoveUntil(
              context,
              Constants.orderConfirmation,
              arguments: {
                'firstName': firstName,
                'lastName': lastName,
                'address': address,
                'city': city,
                'country': country,
                'postalCode': postalCode,
              },
              (route) => route.settings.name == Constants.dashboard);
        },
      ),
    );
  }
}
