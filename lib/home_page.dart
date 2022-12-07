import 'package:danesh_calculator/api_calls.dart';
import 'package:danesh_calculator/provider/calculator_provider.dart';
import 'package:danesh_calculator/models/country_models.dart';
import 'package:danesh_calculator/utils/utils.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'models/Country_margin_rate.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CountryModels? _country;
  // late CalculatorProvider provider;
  Facilities? selectService;
  double? final_rate;
  double rate = 1.0;
  String curencyName = 'GBP';
  double totallCost = 0.00;
  String fees = '0.00';
  double? initialRate ;
  String? initialService;
  String? initialCurrency;
  String maxLimit = '0.00';
  String minLimit = '0.00';
  String countryName = 'Malaysia';
  CountryMarginRate? countryMarginRate;

  bool showMax = false;
  bool showMin = false;
  bool callOnce=true;

  final myController = TextEditingController();
  final myController2 = TextEditingController();
  var img = 'https://remit.daneshexchange.com/staging/assets/uploads/country/6347faed94d991665661677.jpg';


  @override
  void didChangeDependencies() {
    if(callOnce){
      // APICalls.getFirstCountryByName("Malaysia").then((value) {
      //   setState(() {
      //     initialRate=double.parse('${value.rate}');
      //     initialService=value.facilities!.first!.name;
      //     initialCurrency=value.code;
      //     final_rate=double.parse(initialCurrency!);
      //     // curencyName=value.code!;
      //   });
      //   print('$initialCurrency$initialRate!$initialService!');
      // });
      callOnce=false;
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    myController.dispose();
    myController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        primary: true,
        iconTheme: IconThemeData(color: Colors.blue),
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Image.asset(
            "images/top_icon.png",
            height: 45,
          ),
        ),
        // leading: Icon(
        //   Icons.menu,
        //   color: Colors.blue,
        // ),
        elevation: 0.0,
      ),
      drawer: MyDrawer(),
      body: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(25),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'International Money Transfer',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Consumer<CalculatorProvider>(
              builder: (context, provider, _) => FutureBuilder(
                future: provider.getAllCountryInfo(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Send to',
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(6),
                              // border:
                              //     Border.all(color: Colors.black, width: 2)
                            ),
                            child: Row(
                              children: [
                                Container(
                                  child: Image.network(
                                    img,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  width: 35,
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 10, left: 6, right: 6),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          bottomLeft: Radius.circular(8)),
                                      color: Color(0xffD9D9D9)),
                                ),
                                Expanded(
                                  child: Container(
                                    child: DropdownSearch<CountryModels>(
                                      selectedItem: _country,
                                      onChanged: (value) {
                                        selectService = null;
                                        countryMarginRate = null;
                                        initialRate=null;
                                        initialCurrency=null;
                                        initialCurrency=null;
                                        setState(() {
                                          _country = value;
                                          img = _country!.flag!;
                                          countryName = value!.name!;

                                          print(provider
                                              .getAllFacilitiesByCountryName(
                                                  _country!.name!));
                                          provider.getCurrencyByCountryName(
                                              _country!.name!);
                                        });
                                      },
                                      items: provider.countryInfoList2,
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          labelText: countryName,
                                          // enabledBorder: OutlineInputBorder(
                                          //     borderRadius: BorderRadius.circular(6),
                                          //     borderSide: BorderSide(color: Colors.grey.shade300,),
                                          // ),
                                              enabledBorder: InputBorder.none,
                                                 filled: true,
                                              hintText: countryName,
                                        ),
                                      ),
                                      popupProps: PopupProps.menu(
                                        showSearchBox: true,
                                        itemBuilder:
                                            (context, item, isSelected) {
                                          return ListTile(
                                            title: Text(item.name!),
                                            leading: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0, bottom: 4),
                                              child: Image.network(item.flag!),
                                            ),
                                          );
                                        },
                                        showSelectedItems: false,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Select Service',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 7.0, bottom: 7, left: 6, right: 6),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(6),
                            // border:
                            //     Border.all(color: Colors.black, width: 2)
                          ),
                          child: DropdownButtonFormField<Facilities>(

                            decoration: InputDecoration.collapsed(
                              hintText: '',
                            ),
                            hint:  initialService==null?Text('Select Service'):Text('$initialService'),
                            value: selectService,
                            isExpanded: true,
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a services';
                              }
                              return null;
                            },
                            items: provider.countryFacilitiesList
                                .map((catModel) => DropdownMenuItem(
                                    value: catModel,
                                    child: Text(catModel.name!)))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectService = value;
                                countryMarginRate = null;
                                myController.clear();
                                myController2.clear();
                                final_rate==0.0;
                              });
                            },

                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Select Currency',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 7.0, bottom: 7, left: 6, right: 6),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(6),
                            // border:
                            //     Border.all(color: Colors.black, width: 2),
                          ),
                          child: DropdownButtonFormField<CountryMarginRate>(
                            decoration: InputDecoration.collapsed(
                              hintText: '',
                            ),
                            hint: initialCurrency==null?Text('Select Currency'):Text('$initialCurrency'),
                            value: countryMarginRate,
                            isExpanded: true,
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a services';
                              }
                              return null;
                            },
                            items: provider.countryCurrencyList2
                                .map((currency) => DropdownMenuItem(
                                    value: currency,
                                    child: Text(currency.currency!)))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                countryMarginRate = value;
                                final_rate =
                                    provider.getCurrencyRateByCountryNameServiceCurrency(
                                        _country!.name!,selectService!.name!,countryMarginRate!.currency!);
                                curencyName =
                                    provider.getCurrencyNameCountryName(
                                        _country!.name!);
                                // myController.text=3000.toString();
                                myController.text=3000.toString();
                                myController2.text=(final_rate!*3000).toString();

                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.grey),
                                text: '1 AUD =',
                                children: [
                                  TextSpan(
                                      text: ' $final_rate ',
                                      style: TextStyle(color: Colors.black)),
                                  TextSpan(
                                      text: curencyName,
                                      style: TextStyle(color: Colors.grey))
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('You send',style: TextStyle(
                                        fontSize: 12, color: Colors.grey.shade600),),
                                    SizedBox(height: 5,),
                                    Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            child: Flexible(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none),
                                                  controller: myController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChanged: (value) async {
                                                    rate = double.parse(value) *
                                                        final_rate!;
                                                    myController2.text =
                                                        rate.toStringAsFixed(2);
                                                    // EasyLoading.show();
                                                    await provider
                                                        .getRateByCountryId(
                                                            myController.text,
                                                            countryMarginRate!
                                                                .currencyId
                                                                .toString(),
                                                        countryMarginRate!.serviceId.toString())
                                                        .then((value) {
                                                      print(value['single_fee']);
                                                      print(myController.text+countryMarginRate!.currencyId
                                                          .toString()+countryMarginRate!.serviceId!);

                                                      setState(() {
                                                        fees = value['single_fee'];
                                                        totallCost = double.parse(
                                                                fees) +
                                                            double.parse(
                                                                myController.text);
                                                      });
                                                    });
                                                    await provider
                                                        .getMinAndMaxRateByCountryTblId(
                                                            countryMarginRate!
                                                                .countryTableId
                                                                .toString(),
                                                            countryMarginRate!
                                                                .serviceName
                                                                .toString())
                                                        .then((value) {
                                                      if (double.parse(value!
                                                              .maximumLimit!) <
                                                          double.parse(
                                                              myController.text)) {
                                                        setState(() {
                                                          maxLimit =
                                                              value!.maximumLimit!;
                                                          print(
                                                              'maxLimit ${value!.maximumLimit!}');
                                                          showMax = true;
                                                          showMin = false;
                                                        });
                                                      } else {
                                                        minLimit =
                                                            value!.minimumLimit!;
                                                        setState(() {
                                                          print(
                                                              'minLimit $minLimit');
                                                          showMin = true;
                                                          showMax = false;
                                                        });
                                                      }

                                                      // EasyLoading.dismiss();
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Container(
                                              height: 40,
                                              width: 2,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              'AUD',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(6),
                                          color: Colors.grey.shade300),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Receiver gets',style: TextStyle(
                                        fontSize: 12, color: Colors.grey.shade600),),
                                    SizedBox(height: 5,),
                                    Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            child: Flexible(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: TextField(
                                                  keyboardType:
                                                  TextInputType.number,
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none),
                                                  controller: myController2,

                                                  onChanged: (value) {
                                                    rate = double.parse(value) /
                                                        final_rate!;
                                                    myController.text =
                                                        rate.toStringAsFixed(2);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Container(
                                              height: 40,
                                              width: 2,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              curencyName,
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(6),
                                          color: Colors.grey.shade300),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Stack(
                          children: [
                            if (showMax)
                              Text(
                                'Maximum Limit: $maxLimit $curencyName',
                                style: TextStyle(color: Colors.red),
                              ),
                            if (showMin)
                              Text(
                                'Minimum Limit: $minLimit $curencyName',
                                style: TextStyle(color: Colors.red),
                              ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Service fee:'), Text('${fees} AUD')],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total payable:'),
                            Text('${totallCost} AUD')
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          child: ElevatedButton(
                              onPressed: () {
                              }, child: Text('Send now')),
                          alignment: Alignment.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          child: ElevatedButton(
                            onPressed: () {
                              myController.clear();
                              myController2.clear();
                              setState(() {
                                fees==0.00;
                                totallCost==0.00;
                              });
                            },
                            child: Text('Clear items'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                          ),
                          alignment: Alignment.center,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Popular countries our customers send money to',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.blue),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 80,
                          color: Colors.white.withOpacity(.5),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: provider.featuredcountryInfo.length,
                              itemBuilder: (context, index) {
                                var country =
                                    provider.featuredcountryInfo[index];
                                return Container(
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        country.flag!,
                                        height: 35,
                                        width: 40,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        country.name!,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Container(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 2,
      child: Container(
        color: Color(0xff26A6DE),
        child: ListView(
          primary: true,
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 150,
              child: DrawerHeader(
                margin: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Color(0xff26A6DE),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      alignment: Alignment.topRight,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border:
                                    Border.all(color: Colors.white, width: 2)),
                            child: Image.asset(
                              'images/danesh.png',
                              height: 50,
                              width: 50,
                              fit: BoxFit.contain,
                            )))
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Calculator',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.info_outline,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'About us',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.add_card_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Send Money',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.add_card_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Receiving',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.transfer_within_a_station_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Track a Transfer',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.help_outline,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Help Center',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.headset_mic_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Contact us',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.white, width: 1)),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.login,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.white, width: 1)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
