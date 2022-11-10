import 'package:danesh_calculator/calculator_provider.dart';
import 'package:danesh_calculator/models/country_models.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/Country_margin_rate.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName='/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  CountryModels? _country;
  Facilities? selectService;
  double final_rate=3.0279;
  double rate=1.0;
  String curencyName='MYR';
  CountryMarginRate? countryMarginRate;
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  var img='https://remit.daneshexchange.com/staging/assets/uploads/country/6347faed94d991665661677.jpg';
  @override
  void didChangeDependencies() {

   // provider.getAllCountryInfo();
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
      body: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Align(alignment: Alignment.center,child: Text('Danesh',style: TextStyle(fontSize: 22),)),
            SizedBox(height: 20,),
            Consumer<CalculatorProvider>(
                builder: (context,provider,_)=>FutureBuilder(
                  future: provider.getAllCountryInfo(),
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                       return Column(
                         children: [
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Container(
                               height: 60,
                               color: Colors.grey.shade400,
                               margin: EdgeInsets.only(top: 100),
                               child: Row(
                                 children: [
                                   Padding(
                                     padding: const EdgeInsets.all(3.0),
                                     child: Image.network(img,fit: BoxFit.cover,),
                                   ),
                                   Expanded(
                                     child: DropdownSearch<CountryModels>(
                                       selectedItem: _country,
                                       onChanged: (value){
                                         setState(() {
                                           _country=value;
                                           img=_country!.flag!;
                                           print(_country!.name);
                                           print(provider.getAllFacilitiesByCountryName(_country!.name!));
                                           print(provider.getCurrencyByCountryName(_country!.name!));
                                           selectService=null;
                                           countryMarginRate=null;
                                         });
                                       },
                                       items: provider.countryInfoList2,
                                       dropdownDecoratorProps: DropDownDecoratorProps(
                                         dropdownSearchDecoration: InputDecoration(
                                           labelText: "Select country",
                                           hintText: "Malaysia",
                                           filled: true,
                                         ),
                                       ),
                                       popupProps: PopupProps.menu(
                                         showSearchBox: true,
                                         itemBuilder: (context, item, isSelected)  {
                                           return ListTile(
                                             title: Text(item.name!),
                                             leading: Padding(
                                               padding: const EdgeInsets.only(top: 4.0,bottom: 4),
                                               child: Image.network(item.flag!),
                                             ),
                                           );
                                         },
                                         showSelectedItems: false,
                                       ),
                                     ),
                                   ),
                                 ],
                               )
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: DropdownButtonFormField<Facilities>(
                               hint: const Text('Select Service'),
                               value: selectService,
                               isExpanded: true,
                               validator: (value) {
                                 if (value == null) {
                                   return 'Please select a services';
                                 }
                                 return null;
                               },
                               items: provider
                                   .countryFacilitiesList
                                   .map((catModel) => DropdownMenuItem(
                                   value: catModel,
                                   child: Text(catModel.name!)))
                                   .toList(),
                               onChanged: (value) {
                                 setState(() {
                                   selectService = value;
                                   countryMarginRate=null;

                                 });

                               },
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: DropdownButtonFormField<CountryMarginRate>(
                               hint: const Text('Select Currency'),
                               value: countryMarginRate,
                               isExpanded: true,
                               validator: (value) {
                                 if (value == null) {
                                   return 'Please select a services';
                                 }
                                 return null;
                               },
                               items: provider
                                   .countryCurrencyList2
                                   .map((currency) => DropdownMenuItem(
                                   value: currency,
                                   child: Text(currency.currency!)))
                                   .toList(),
                               onChanged: (value) {
                                 setState(() {
                                   countryMarginRate = value;
                                  final_rate= provider.getCurrencyRateByCountryName(_country!.name!);
                                  curencyName=provider.getCurrencyNameCountryName(_country!.name!);

                                 });

                               },
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text('1 AUD = $final_rate'),
                           ),
                           SizedBox(height: 40,),
                           Row(
                             mainAxisSize: MainAxisSize.min,
                             children: [
                               Row(
                                 mainAxisSize: MainAxisSize.min,
                                 children: [
                                   Container(
                                     width: 100,
                                     child:  TextField(
                                       controller: myController,
                                       keyboardType: TextInputType.number,
                                       onChanged: (value) {
                                          rate=double.parse(value)*final_rate;
                                          myController2.text=rate.toString();
                                       },
                                       decoration: InputDecoration(
                                           border: OutlineInputBorder(
                                               borderRadius: BorderRadius.circular(5,),
                                               borderSide: BorderSide(
                                                   width: .01
                                               )
                                           )
                                       ),
                                     ),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.all(4.0),
                                     child: Container(height: 40,width: 2,color: Colors.grey,),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.all(4.0),
                                     child: Text('AUD',style: TextStyle(fontSize: 20),),
                                   ),
                                 ],
                               ),
                               Row(
                                 mainAxisSize: MainAxisSize.min,
                                 children: [
                                   Container(
                                     width: 100,
                                     child:  TextField(
                                       controller: myController2,
                                       onChanged: (value){
                                         rate=double.parse(value)/final_rate;
                                         myController.text=rate.toString();
                                       },
                                       keyboardType: TextInputType.number,
                                       decoration: InputDecoration(
                                           border: OutlineInputBorder(
                                               borderRadius: BorderRadius.circular(5,),
                                               borderSide: BorderSide(
                                                   width: .01
                                               )
                                           )
                                       ),
                                     ),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.all(4.0),
                                     child: Container(height: 40,width: 2,color: Colors.grey,),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.all(4.0),
                                     child: Text(curencyName,style: TextStyle(fontSize: 20),),
                                   ),
                                 ],
                               )
                             ],
                           )
                         ],
                       );
                    }
                    else {
                      return Center(
                        child: Container(
                          width: 60,
                            height: 60,
                            child: CircularProgressIndicator()),
                      );
                    }
                  },
                )
              ,)

          ],
        ),
      ),
    );
  }
}
