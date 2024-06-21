import 'package:book_reader/components/button_widget.dart';
import 'package:book_reader/components/text_field_widget.dart';
import 'package:book_reader/components/title_text.dart';
import 'package:book_reader/utils/Constants.dart';
import 'package:book_reader/utils/SharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({super.key});

  @override
  _ShippingAddressState createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController addressController1 = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  final _shippingKey = GlobalKey<FormState>();
  String? country;
  AppSharedPreferences? sharedPreferences;

  @override
  void initState() {
    super.initState();
    // Load saved data when widget initializes
    AppSharedPreferences.getPreferencesInstance().then((value) {
      sharedPreferences = value;
      loadSavedData();
    });
  }

  void loadSavedData() async {
    // Example of loading saved data from SharedPreferences
    print("user2 ${sharedPreferences?.getFirstName()}");

    firstnameController.text = sharedPreferences?.getFirstName() ?? '';
    lastnameController.text = sharedPreferences?.getLastName() ?? '';
    addressController1.text = sharedPreferences?.getAddress1() ?? '';
    emailController.text = sharedPreferences?.getEmail() ?? '';
    cityController.text = sharedPreferences?.getCity() ?? '';
    countryController.text = sharedPreferences?.getCountry() ?? '';
    codeController.text = sharedPreferences?.getPostalCode() ?? '';
  }

  Future<void> saveData() async {
    print("user ${firstnameController.text.toString()}");
    sharedPreferences?.setFirstName(firstnameController.text);
    sharedPreferences?.setLastName(lastnameController.text);
    sharedPreferences?.setAddress1(addressController1.text);
    sharedPreferences?.setEmail(emailController.text);
    sharedPreferences?.setCity(cityController.text);
    sharedPreferences?.setCountry(countryController.text);
    sharedPreferences?.setPostalCode(codeController.text);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipping Address'),
      ),
      body: Builder(
        builder: (context) => Form(
          key: _shippingKey,
          child: Center(
            // color: LightColor.background,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ListView(
                children: <Widget>[
                  const SizedBox(height: 10),
                  const TitleText(
                    text: 'Please fill the below form to continue.',
                    fontSize: 17,
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    textEditingController: firstnameController,
                    labelText: 'First Name',
                    iconData: FontAwesomeIcons.userCircle,
                  ),
                  const SizedBox(height: 4),
                  TextFieldWidget(
                    textEditingController: lastnameController,
                    labelText: 'Last Name',
                    iconData: FontAwesomeIcons.users,
                  ),
                  const SizedBox(height: 4),
                  TextFieldWidget(
                    textEditingController: addressController1,
                    labelText: 'Address',
                    iconData: FontAwesomeIcons.addressCard,
                  ),
                  const SizedBox(height: 4),
                  TextFieldWidget(
                    textEditingController: countryController,
                    labelText: 'Country',
                    iconData: FontAwesomeIcons.city,
                    readOnly: true,
                    function: () async {
                      // country = await Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => CountryScreen()),
                      // );
                      if (country != null) {
                        countryController.text = country!;
                      }
                      //countryController.text = country.countryName;
                    },
                  ),
                  const SizedBox(height: 4),
                  TextFieldWidget(
                    type: TextInputType.text,
                    textEditingController: cityController,
                    labelText: 'City',
                    iconData: FontAwesomeIcons.city,
                  ),
                  const SizedBox(height: 4),
                  TextFieldWidget(
                    textEditingController: codeController,
                    labelText: 'Postal Code',
                    iconData: FontAwesomeIcons.code,
                  ),
                  const SizedBox(height: 20),
                  ButtonWidget(
                    text: 'Continue',
                    onPressed: () async {
                      await saveData(); // Save data before navigating
                      Navigator.pushReplacementNamed(
                        context,
                        Constants.checkout,
                        arguments: {
                          'firstName': firstnameController.text,
                          'lastName': lastnameController.text,
                          'address': addressController1.text,
                          'city': cityController.text,
                          'country': countryController.text,
                          'postalCode': codeController.text,
                        },
                      );
                      },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
