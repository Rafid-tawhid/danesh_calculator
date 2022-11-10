import 'package:danesh_calculator/api_calls.dart';
import 'package:danesh_calculator/provider/calculator_provider.dart';
import 'package:danesh_calculator/models/country_models.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  // late CalculatorProvider provider;
  Facilities? selectService;
  double final_rate=3.0279;
  double rate=1.0;
  String curencyName='MYR';
  String rateTxt='2.00';
  String countryName='Malaysia';
  CountryMarginRate? countryMarginRate;
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  var img='https://remit.daneshexchange.com/staging/assets/uploads/country/6347faed94d991665661677.jpg';
  @override
  void didChangeDependencies() {

    // provider=Provider.of<CalculatorProvider>(context,listen: true);
    // provider.getAllCountryInfo().then((value) {
    //   _country=value.first;
    // });
    //
    // print(_country.toString());
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
        backgroundColor: Colors.white,
       title: Padding(
         padding: const EdgeInsets.all(3.0),
         child: Image.asset("images/top_icon.png",height: 45,),
       ),
        leading: Icon(Icons.menu,color: Colors.blue,),
        elevation: 0.0,
      ),
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
                    child: Text('International Money Transfer',style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Consumer<CalculatorProvider>(
                builder: (context,provider,_)=>FutureBuilder(
                  future: provider.getAllCountryInfo(),
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                       return Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text('Send to',style: TextStyle(fontSize: 12,color: Colors.grey.shade300),),
                           SizedBox(height: 5,),
                           Container(
                             height: 40,
                               decoration: BoxDecoration(
                                 color: Colors.grey.shade300,
                                 borderRadius: BorderRadius.circular(6),
                                 border: Border.all(
                                   color: Colors.black,
                                   width: 2
                                 )
                               ),
                             child: Row(
                               children: [
                                 Container(
                                       child: Image.network(img,fit: BoxFit.fitWidth,),
                                     width: 35,
                                   padding:const EdgeInsets.only(top: 10.0,bottom: 10,left: 6,right: 6),
                                   ),

                                 Expanded(
                                   child: DropdownSearch<CountryModels>(
                                     selectedItem: _country,
                                     onChanged: (value){
                                       selectService=null;
                                       countryMarginRate=null;
                                       setState(() {
                                         _country=value;
                                         img=_country!.flag!;
                                         countryName=value!.name!;
                                         print(provider.getAllFacilitiesByCountryName(_country!.name!));
                                         provider.getCurrencyByCountryName(_country!.name!);

                                       });
                                     },
                                     items: provider.countryInfoList2,
                                     dropdownDecoratorProps: DropDownDecoratorProps(
                                       dropdownSearchDecoration: InputDecoration(
                                         labelText: countryName,
                                         hintText: '_country!.name',
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
                           SizedBox(height: 25,),
                           Text('Select Service',style: TextStyle(fontSize: 12,color: Colors.grey),),
                           SizedBox(height: 5,),
                           Padding(
                             padding: const EdgeInsets.all(0.0),
                             child: DropdownButtonFormField<Facilities>(
                               decoration: InputDecoration(
                                   hintText: '',
                                 contentPadding: EdgeInsets.symmetric(vertical: 6,horizontal: 6),
                                 fillColor: Colors.grey.shade300,
                                 isDense: true,
                                 filled: true,
                                 border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(4),
                                   borderSide: BorderSide(
                                   ),
                                 )
                               ),

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
                                 countryMarginRate=null;
                                 setState(() {
                                   selectService = value;
                                 });

                               },
                             ),
                           ),
                           SizedBox(height: 25,),
                           Text('Select Currency',style: TextStyle(fontSize: 12,color: Colors.grey),),
                           SizedBox(height: 5,),


                           DropdownButtonFormField<CountryMarginRate?>(
                             decoration: InputDecoration(
                                 hintText: '',
                               contentPadding: EdgeInsets.symmetric(vertical: 6,horizontal: 6),
                               fillColor: Colors.grey.shade300,
                               isDense: true,
                               filled: true,
                                 border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(4),
                                   borderSide: BorderSide(
                                   ),
                                 )
                             ),
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
                             onChanged: (value) async{
                              await APICalls.getRateByCountryId(myController.text, countryMarginRate!.currencyId, countryMarginRate!.serviceId).then((value) {
                               rateTxt = value['single_fee'];
                               });
                               setState(() {
                                 rateTxt;
                                 countryMarginRate = value;
                                final_rate= provider.getCurrencyRateByCountryName(_country!.name!);
                                curencyName=provider.getCurrencyNameCountryName(_country!.name!);
                               });

                             },
                           ),


                           Padding(
                             padding: const EdgeInsets.only(top: 8.0),
                             child: RichText(
                               text: TextSpan(
                                   style: TextStyle(color: Colors.grey),
                                   text: '1 AUD =',
                                   children: [
                                 TextSpan(text:' $final_rate',style: TextStyle(color: Colors.black)),
                                 TextSpan(text: ' MYR',style: TextStyle(color: Colors.grey))
                               ]),
                             ),
                           ),

                           SizedBox(height: 40,),
                           Container(
                             child: Row(
                               mainAxisSize: MainAxisSize.min,
                               children: [
                                 Expanded(
                                   child: Container(
                                     child: Row(
                                       mainAxisSize: MainAxisSize.min,
                                       children: [
                                         Container(
                                           child:  Flexible(
                                             child: Padding(
                                               padding: const EdgeInsets.only(left: 10.0),
                                               child: TextField(
                                                 decoration: InputDecoration(
                                                   border: InputBorder.none
                                                 ),
                                                 controller: myController,
                                                 keyboardType: TextInputType.number,
                                                 onChanged: (value) {
                                                    rate=double.parse(value)*final_rate;
                                                    myController2.text=rate.toStringAsFixed(2);
                                                 },
                                               ),
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
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(6),
                                       color: Colors.grey.shade300
                                     ),
                                   ),
                                 ),
                                 SizedBox(width: 20,),
                                 Expanded(
                                   child: Container(
                                     child: Row(
                                       mainAxisSize: MainAxisSize.min,
                                       children: [
                                         Container(
                                           child:  Flexible(
                                             child: Padding(
                                               padding: const EdgeInsets.only(left: 10.0),
                                               child: TextField(
                                                 decoration: InputDecoration(
                                                     border: InputBorder.none
                                                 ),
                                                 controller: myController2,
                                                 onChanged: (value){
                                                   rate=double.parse(value)/final_rate;
                                                   myController.text=rate.toStringAsFixed(2);
                                                 },
                                               ),
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
                                     ),
                                     decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(6),
                                         color: Colors.grey.shade300
                                     ),
                                   ),
                                 ),




                               ],
                             ),
                           ),

                           SizedBox(height: 40,),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text('Service fee:'),
                               Text('${rateTxt} AUD')
                             ],
                           ),
                           SizedBox(height: 10,),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text('Total payable:'),
                               Text('7.00 AUD')
                             ],
                           ),
                           SizedBox(height: 10,),
                           ElevatedButton(onPressed: (){

                           }, child: Text('Send now')),
                           SizedBox(height: 10,),
                           ElevatedButton(onPressed: (){}, child: Text('Clear items')),

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
              ,),

          ],
        ),
      ),
    );
  }
}
