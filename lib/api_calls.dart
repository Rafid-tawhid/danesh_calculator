import 'dart:convert';

import 'package:danesh_calculator/models/Country_margin_rate.dart';
import 'package:danesh_calculator/models/country_models.dart';
import 'package:http/http.dart' as http;

class APICalls{

  static List<CountryModels> countryInfoList=[];
  static List<CountryMarginRate> countryCourencyRateList=[];

  static Future<List<CountryModels>> getAllCountriesInfo() async{
    final response=await http.get(Uri.parse('http://remit.daneshexchange.com/staging/api/country'));
    final data=jsonDecode(response.body.toString());
    for(Map i in data){
      countryInfoList.add(CountryModels.fromJson(i));
    }
    return countryInfoList;
  }

  static Future<List<CountryMarginRate>> getAllCountriesCurrency() async{
    final response=await http.get(Uri.parse('http://remit.daneshexchange.com/staging/api/margin_rate'));
    final data=jsonDecode(response.body.toString());
    for(Map i in data){
      countryCourencyRateList.add(CountryMarginRate.fromJson(i));
    }
    return countryCourencyRateList;
  }



}