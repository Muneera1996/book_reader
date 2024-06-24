import 'package:book_reader/models/Country.dart';
import 'package:book_reader/network/network.dart';
import 'package:book_reader/themes/theme.dart';
import 'package:flutter/material.dart';

class CountryScreen extends StatefulWidget {
  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
   List<Data>? countries;
   List<Data>? filterCountries;

  @override
  void initState() {
    super.initState();
    Network().getCountry().then((Country allCountries) {
      setState(() {
        countries = allCountries.data!;
        filterCountries = allCountries.data!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Country (---Please Select---)")),
        body: Column(
          children: [
            searchView(),
            buildCountry(context),
          ],
        ));
  }

  Widget buildCountry(BuildContext context) {
    return Expanded(

        child: filterCountries != null ? ListView.builder(
            itemCount: filterCountries?.length,
            itemBuilder: (context, index) => buildList(
                  text: filterCountries![index].countryName!,
                  function: () {
                    Navigator.pop(context, filterCountries![index]);
                  },
                )): const Center(
                  child: CircularProgressIndicator(),
                )
    );
  }

  Widget searchView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: TextField(
          decoration: InputDecoration(
              hintText: "Search",
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              border: outlineInputBorder(),
              enabledBorder: outlineInputBorder(),
              focusedBorder: outlineInputBorder(),
              contentPadding: EdgeInsets.all(8)),
          onChanged: (String value) {
            setState(() {
              filterCountries = countries
                  ?.where((country) => country.countryName
                  !.toLowerCase()
                  .contains(value.toLowerCase()))
                  .toList();
            });
          },
        ),
      ),
    );
  }

  OutlineInputBorder outlineInputBorder() {
    return OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(8));
  }
}

class buildList extends StatelessWidget {
  final String text;
  final VoidCallback function;

  const buildList({super.key,
    required this.text,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: AppTheme.h3Style,
            ),
            Divider(
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}
