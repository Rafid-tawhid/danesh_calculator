class CountryMarginRate {
  CountryMarginRate({
      this.id, 
      this.country, 
      this.countryTableId, 
      this.serviceId, 
      this.serviceName, 
      this.currencyId, 
      this.currency, 
      this.margin, 
      this.marginType, 
      this.rateMethod, 
      this.manualRate, 
      this.finalRate, 
      this.minimumLimit, 
      this.maximumLimit, 
      this.createdAt, 
      this.updatedAt,});

  CountryMarginRate.fromJson(dynamic json) {
    id = json['id'];
    country = json['country'];
    countryTableId = json['country_table_id'];
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    currencyId = json['currency_id'];
    currency = json['currency'];
    margin = json['margin'];
    marginType = json['margin_type'];
    rateMethod = json['rate_method'];
    manualRate = json['manual_rate'];
    finalRate = json['final_rate'];
    minimumLimit = json['minimum_limit'];
    maximumLimit = json['maximum_limit'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  String? id;
  String? country;
  String? countryTableId;
  String? serviceId;
  String? serviceName;
  String? currencyId;
  String? currency;
  String? margin;
  String? marginType;
  String? rateMethod;
  String? manualRate;
  String? finalRate;
  String? minimumLimit;
  String? maximumLimit;
  String? createdAt;
  String? updatedAt;
CountryMarginRate copyWith({  String? id,
  String? country,
  String? countryTableId,
  String? serviceId,
  String? serviceName,
  String? currencyId,
  String? currency,
  String? margin,
  String? marginType,
  String? rateMethod,
  String? manualRate,
  String? finalRate,
  String? minimumLimit,
  String? maximumLimit,
  String? createdAt,
  String? updatedAt,
}) => CountryMarginRate(  id: id ?? this.id,
  country: country ?? this.country,
  countryTableId: countryTableId ?? this.countryTableId,
  serviceId: serviceId ?? this.serviceId,
  serviceName: serviceName ?? this.serviceName,
  currencyId: currencyId ?? this.currencyId,
  currency: currency ?? this.currency,
  margin: margin ?? this.margin,
  marginType: marginType ?? this.marginType,
  rateMethod: rateMethod ?? this.rateMethod,
  manualRate: manualRate ?? this.manualRate,
  finalRate: finalRate ?? this.finalRate,
  minimumLimit: minimumLimit ?? this.minimumLimit,
  maximumLimit: maximumLimit ?? this.maximumLimit,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['country'] = country;
    map['country_table_id'] = countryTableId;
    map['service_id'] = serviceId;
    map['service_name'] = serviceName;
    map['currency_id'] = currencyId;
    map['currency'] = currency;
    map['margin'] = margin;
    map['margin_type'] = marginType;
    map['rate_method'] = rateMethod;
    map['manual_rate'] = manualRate;
    map['final_rate'] = finalRate;
    map['minimum_limit'] = minimumLimit;
    map['maximum_limit'] = maximumLimit;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }


  @override
  String toString() {
    return 'CountryMarginRate{currency: $currency}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryMarginRate &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}