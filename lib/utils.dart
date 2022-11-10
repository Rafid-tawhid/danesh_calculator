import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils extends StatelessWidget {
  const Utils({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column();
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Text('Send to',style: TextStyle(fontSize: 12,color: Colors.grey.shade300),),
    //     SizedBox(height: 5,),
    //     Container(
    //         height: 40,
    //         decoration: BoxDecoration(
    //             color: Colors.grey.shade300,
    //             borderRadius: BorderRadius.circular(6),
    //             border: Border.all(
    //                 color: Colors.black,
    //                 width: 2
    //             )
    //         ),
    //         child: Row(
    //           children: [
    //             Container(
    //               child: Image.network(img,fit: BoxFit.fitWidth,),
    //               width: 35,
    //               padding:const EdgeInsets.only(top: 10.0,bottom: 10,left: 6,right: 6),
    //             ),
    //
    //             Expanded(
    //               child: DropdownSearch<CountryModels>(
    //                 selectedItem: _country,
    //                 onChanged: (value){
    //                   setState(() {
    //                     _country=value;
    //                     img=_country!.flag!;
    //                     countryName=value!.name!;
    //                     print(provider.getAllFacilitiesByCountryName(_country!.name!));
    //                     provider.getCurrencyByCountryName(_country!.name!);
    //                     selectService=null;
    //                     countryMarginRate=null;
    //                   });
    //                 },
    //                 items: provider.countryInfoList2,
    //                 dropdownDecoratorProps: DropDownDecoratorProps(
    //                   dropdownSearchDecoration: InputDecoration(
    //                     labelText: countryName,
    //                     hintText: '_country!.name',
    //                     filled: true,
    //
    //                   ),
    //                 ),
    //                 popupProps: PopupProps.menu(
    //                   showSearchBox: true,
    //                   itemBuilder: (context, item, isSelected)  {
    //                     return ListTile(
    //                       title: Text(item.name!),
    //                       leading: Padding(
    //                         padding: const EdgeInsets.only(top: 4.0,bottom: 4),
    //                         child: Image.network(item.flag!),
    //                       ),
    //                     );
    //                   },
    //                   showSelectedItems: false,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         )
    //     ),
    //     SizedBox(height: 25,),
    //     Text('Select Service',style: TextStyle(fontSize: 12,color: Colors.grey),),
    //     SizedBox(height: 5,),
    //     Padding(
    //       padding: const EdgeInsets.all(0.0),
    //       child: DropdownButtonFormField<Facilities>(
    //         decoration: InputDecoration(
    //             hintText: '',
    //             contentPadding: EdgeInsets.symmetric(vertical: 6,horizontal: 6),
    //             fillColor: Colors.grey.shade300,
    //             isDense: true,
    //             filled: true,
    //             border: OutlineInputBorder(
    //               borderRadius: BorderRadius.circular(4),
    //               borderSide: BorderSide(
    //               ),
    //             )
    //         ),
    //
    //         hint: const Text('Select Service'),
    //         value: selectService,
    //         isExpanded: true,
    //         validator: (value) {
    //           if (value == null) {
    //             return 'Please select a services';
    //           }
    //           return null;
    //         },
    //         items: provider
    //             .countryFacilitiesList
    //             .map((catModel) => DropdownMenuItem(
    //             value: catModel,
    //             child: Text(catModel.name!)))
    //             .toList(),
    //         onChanged: (value) {
    //           setState(() {
    //             selectService = value;
    //             countryMarginRate=null;
    //
    //           });
    //
    //         },
    //       ),
    //     ),
    //     SizedBox(height: 25,),
    //     Text('Select Currency',style: TextStyle(fontSize: 12,color: Colors.grey),),
    //     SizedBox(height: 5,),
    //     DropdownButtonFormField<CountryMarginRate>(
    //       decoration: InputDecoration(
    //           hintText: '',
    //           contentPadding: EdgeInsets.symmetric(vertical: 6,horizontal: 6),
    //           fillColor: Colors.grey.shade300,
    //           isDense: true,
    //           filled: true,
    //           border: OutlineInputBorder(
    //             borderRadius: BorderRadius.circular(4),
    //             borderSide: BorderSide(
    //             ),
    //           )
    //       ),
    //       hint: const Text('Select Currency'),
    //       value: countryMarginRate,
    //       isExpanded: true,
    //       validator: (value) {
    //         if (value == null) {
    //           return 'Please select a services';
    //         }
    //         return null;
    //       },
    //       items: provider
    //           .countryCurrencyList2
    //           .map((currency) => DropdownMenuItem(
    //           value: currency,
    //           child: Text(currency.currency!)))
    //           .toList(),
    //       onChanged: (value) async{
    //         await APICalls.getRateByCountryId(myController.text, countryMarginRate!.currencyId, countryMarginRate!.serviceId).then((value) {
    //           rateTxt = value['single_fee'];
    //         });
    //         setState(() {
    //           rateTxt;
    //           countryMarginRate = value;
    //           final_rate= provider.getCurrencyRateByCountryName(_country!.name!);
    //           curencyName=provider.getCurrencyNameCountryName(_country!.name!);
    //         });
    //
    //       },
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.only(top: 8.0),
    //       child: RichText(
    //         text: TextSpan(
    //             style: TextStyle(color: Colors.grey),
    //             text: '1 AUD =',
    //             children: [
    //               TextSpan(text:' $final_rate',style: TextStyle(color: Colors.black)),
    //               TextSpan(text: ' MYR',style: TextStyle(color: Colors.grey))
    //             ]),
    //       ),
    //     ),
    //
    //     SizedBox(height: 40,),
    //     Container(
    //       child: Row(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Expanded(
    //             child: Container(
    //               child: Row(
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   Container(
    //                     child:  Flexible(
    //                       child: Padding(
    //                         padding: const EdgeInsets.only(left: 10.0),
    //                         child: TextField(
    //                           decoration: InputDecoration(
    //                               border: InputBorder.none
    //                           ),
    //                           controller: myController,
    //                           keyboardType: TextInputType.number,
    //                           onChanged: (value) {
    //                             rate=double.parse(value)*final_rate;
    //                             myController2.text=rate.toStringAsFixed(2);
    //                           },
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.all(4.0),
    //                     child: Container(height: 40,width: 2,color: Colors.grey,),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.all(4.0),
    //                     child: Text('AUD',style: TextStyle(fontSize: 20),),
    //                   ),
    //                 ],
    //               ),
    //               decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(6),
    //                   color: Colors.grey.shade300
    //               ),
    //             ),
    //           ),
    //           SizedBox(width: 20,),
    //           Expanded(
    //             child: Container(
    //               child: Row(
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   Container(
    //                     child:  Flexible(
    //                       child: Padding(
    //                         padding: const EdgeInsets.only(left: 10.0),
    //                         child: TextField(
    //                           decoration: InputDecoration(
    //                               border: InputBorder.none
    //                           ),
    //                           controller: myController2,
    //                           onChanged: (value){
    //                             rate=double.parse(value)/final_rate;
    //                             myController.text=rate.toStringAsFixed(2);
    //                           },
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.all(4.0),
    //                     child: Container(height: 40,width: 2,color: Colors.grey,),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.all(4.0),
    //                     child: Text(curencyName,style: TextStyle(fontSize: 20),),
    //                   ),
    //                 ],
    //               ),
    //               decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(6),
    //                   color: Colors.grey.shade300
    //               ),
    //             ),
    //           ),
    //
    //
    //
    //
    //         ],
    //       ),
    //     ),
    //
    //     SizedBox(height: 40,),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Text('Service fee:'),
    //         Text('${rateTxt} AUD')
    //       ],
    //     ),
    //     SizedBox(height: 10,),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Text('Total payable:'),
    //         Text('7.00 AUD')
    //       ],
    //     ),
    //     SizedBox(height: 10,),
    //     ElevatedButton(onPressed: (){
    //
    //     }, child: Text('Send now')),
    //     SizedBox(height: 10,),
    //     ElevatedButton(onPressed: (){}, child: Text('Clear items')),
    //
    //   ],
    // );
  }
}
