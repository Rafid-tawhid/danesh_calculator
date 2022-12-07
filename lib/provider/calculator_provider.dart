import 'package:danesh_calculator/api_calls.dart';
import 'package:danesh_calculator/models/Country_margin_rate.dart';
import 'package:danesh_calculator/models/country_models.dart';
import 'package:flutter/material.dart';


class CalculatorProvider extends ChangeNotifier{
List<CountryModels> countryInfoList=[];
List<CountryModels> countryInfoList2=[];
List<CountryModels> featuredcountryInfo=[];
CountryMarginRate? minMaxofCountry;
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
    // countryNameList.clear();
    featuredcountryInfo.clear();
    countryInfoList=await APICalls.getAllCountriesInfo();
    countryInfoList.forEach((element) {
      if(element.status=='1'){
        countryNameList.add(element.name!);
        countryInfoList2.add(element);
        if(element.featured=="1"){
          featuredcountryInfo.add(element);
        }
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
  notifyListeners();
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
  notifyListeners();
  print('countryCurrencyList ${countryCurrencyList.length}');
  return countryCurrencyList;
}



Future<CountryMarginRate?> getMinAndMaxRateByCountryTblId(String country_id,String service) async{

  var allCountryRate=await APICalls.getAllCountriesCurrency();
  allCountryRate.forEach((element) {
    if(element.countryTableId==country_id&&element.serviceName==service){
      minMaxofCountry=element;
    }
  });
  notifyListeners();

  return minMaxofCountry;
}

double getCurrencyRateByCountryNameServiceCurrency(String name,String serviceName,String currency) {
  double currencyRate=0.0;
 countryCurrencyList.forEach((element){
   if(element.country==name&&element.serviceName==serviceName&&element.currency==currency){
     currencyRate=  double.parse(element.finalRate!);
     notifyListeners();
   }
 });
 notifyListeners();
  return currencyRate;
}

String getCurrencyNameCountryName(String name) {

  String currencyName='MYR';
  countryCurrencyList.forEach((element){
    if(element.country==name){
      currencyName=element.currency!;
    }
  });
  notifyListeners();
  return currencyName;
}



Future<Map<String, dynamic>> getRateByCountryId(amount,country_id,service_id)=>
    APICalls.getRateByCountryId(amount, country_id, service_id);






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