import 'package:danesh_calculator/api_calls.dart';
import 'package:danesh_calculator/models/Country_margin_rate.dart';
import 'package:danesh_calculator/models/country_models.dart';
import 'package:flutter/material.dart';


class CalculatorProvider extends ChangeNotifier{
List<CountryModels> countryInfoList=[];
List<CountryModels> countryInfoList2=[];
List<String> countryNameList=[];
List<Facilities> countryFacilitiesList=[];
List<CountryMarginRate> countryCurrencyList=[];
List<CountryMarginRate> countryCurrencyList2=[];
bool callOnce=true;


Future<List<CountryModels>> getAllCountryInfo() async{
  print('getAllCountryInfo $callOnce');
  if(callOnce){
    countryInfoList.clear();
    countryInfoList2.clear();
    countryNameList.clear();
    countryInfoList=await APICalls.getAllCountriesInfo();
    countryInfoList.forEach((element) {
      if(element.status=='1'){
        countryNameList.add(element.name!);
        countryInfoList2.add(element);
      }
    });

  }
  callOnce=false;

 // print(countryNameList.length);

  return countryInfoList;
}

List<Facilities> getAllFacilitiesByCountryName(String name) {

  countryFacilitiesList.clear();
  countryInfoList.forEach((element) {
    if(element.name==name){
      countryFacilitiesList.addAll(element.facilities!);
    }
  });
  print('countryInfoList ${countryInfoList.length}');
  return countryFacilitiesList;
}

Future<List<CountryMarginRate>> getCurrencyByCountryName(String name) async{

  countryCurrencyList.clear();
  countryCurrencyList2.clear();
  countryCurrencyList=await APICalls.getAllCountriesCurrency();
  countryCurrencyList.forEach((element) {
    if(element.country==name&&!doesCurrencyExists(element.currency!)){
      countryCurrencyList2.add(element);
    }
  });
  print('countryCurrencyList ${countryCurrencyList.length}');
  return countryCurrencyList;
}

double getCurrencyRateByCountryName(String name) {

  double currencyRate=0.0;
 countryCurrencyList.forEach((element){
   if(element.country==name){
     currencyRate=  double.parse(element.finalRate!);
   }
 });
  return currencyRate;
}

String getCurrencyNameCountryName(String name) {

  String currencyName='MYR';
  countryCurrencyList.forEach((element){
    if(element.country==name){
      currencyName=element.currency!;
    }
  });
  return currencyName;
}






bool doesCurrencyExists(String name) {
  bool tag = false;
  for (var n in countryCurrencyList2) {
    if(name == n.currency) {
      tag = true;
      break;
    }
  }
  return tag;
}
}