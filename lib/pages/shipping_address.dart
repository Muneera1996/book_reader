import 'package:book_reader/components/button_widget.dart';
import 'package:book_reader/components/text_field_widget.dart';
import 'package:book_reader/components/title_text.dart';
import 'package:book_reader/models/Country.dart';
import 'package:book_reader/pages/choose_country.dart';
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
  Data? country;
  AppSharedPreferences? sharedPreferences;

  // Focus Nodes
  final FocusNode firstnameFocusNode = FocusNode();
  final FocusNode lastnameFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode cityFocusNode = FocusNode();
  final FocusNode countryFocusNode = FocusNode();
  final FocusNode codeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Load saved data when widget initializes
    AppSharedPreferences.getPreferencesInstance().then((value) {
      sharedPreferences = value;
      loadSavedData();
    });

    // Add focus listeners to clear errors
    addFocusListeners();
  }

  void addFocusListeners() {
    firstnameFocusNode.addListener(() {
      if (firstnameFocusNode.hasFocus) {
        _shippingKey.currentState?.validate();
      }
    });
    lastnameFocusNode.addListener(() {
      if (lastnameFocusNode.hasFocus) {
        _shippingKey.currentState?.validate();
      }
    });
    addressFocusNode.addListener(() {
      if (addressFocusNode.hasFocus) {
        _shippingKey.currentState?.validate();
      }
    });
    emailFocusNode.addListener(() {
      if (emailFocusNode.hasFocus) {
        _shippingKey.currentState?.validate();
      }
    });
    cityFocusNode.addListener(() {
      if (cityFocusNode.hasFocus) {
        _shippingKey.currentState?.validate();
      }
    });
    countryFocusNode.addListener(() {
      if (countryFocusNode.hasFocus) {
        _shippingKey.currentState?.validate();
      }
    });
    codeFocusNode.addListener(() {
      if (codeFocusNode.hasFocus) {
        _shippingKey.currentState?.validate();
      }
    });
  }

  void loadSavedData() async {
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
  void dispose() {
    // Dispose FocusNodes
    firstnameFocusNode.dispose();
    lastnameFocusNode.dispose();
    addressFocusNode.dispose();
    emailFocusNode.dispose();
    cityFocusNode.dispose();
    countryFocusNode.dispose();
    codeFocusNode.dispose();
    super.dispose();
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
            child: Padding(
              padding: const EdgeInsets.all(20),
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
                    focusNode: firstnameFocusNode,
                  ),
                  const SizedBox(height: 4),
                  TextFieldWidget(
                    textEditingController: lastnameController,
                    labelText: 'Last Name',
                    iconData: FontAwesomeIcons.users,
                    focusNode: lastnameFocusNode,
                  ),
                  const SizedBox(height: 4),
                  TextFieldWidget(
                    textEditingController: addressController1,
                    labelText: 'Address',
                    iconData: FontAwesomeIcons.addressCard,
                    focusNode: addressFocusNode,
                  ),
                  const SizedBox(height: 4),
                  TextFieldWidget(
                    textEditingController: countryController,
                    labelText: 'Country',
                    type: TextInputType.text,
                    iconData: FontAwesomeIcons.city,
                    focusNode: countryFocusNode,
                    function: () async {
                      country = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CountryScreen()),
                      );
                      if(country!=null) {
                        countryController.text = country!.countryName!;
                      }
                    },
                  ),
                  const SizedBox(height: 4),
                  TextFieldWidget(
                    type: TextInputType.text,
                    textEditingController: cityController,
                    labelText: 'City',
                    iconData: FontAwesomeIcons.city,
                    focusNode: cityFocusNode,
                  ),
                  const SizedBox(height: 4),
                  TextFieldWidget(
                    textEditingController: codeController,
                    labelText: 'Postal Code',
                    iconData: FontAwesomeIcons.code,
                    focusNode: codeFocusNode,
                  ),
                  const SizedBox(height: 20),
                  ButtonWidget(
                    text: 'Continue',
                    onPressed: () async {
                      if (_shippingKey.currentState?.validate() ?? false) {
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
                      }
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
