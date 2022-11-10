class CountryModels {
  CountryModels({
      this.id, 
      this.name, 
      this.slug, 
      this.code, 
      this.minimumAmount, 
      this.image, 
      this.continentId, 
      this.facilities, 
      this.rate, 
      this.rateMethod, 
      this.manualRate, 
      this.finalRate, 
      this.featured, 
      this.sortingOrder, 
      this.status, 
      this.sendFrom, 
      this.sendTo, 
      this.details, 
      this.createdAt, 
      this.updatedAt, 
      this.flag,});

  CountryModels.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    code = json['code'];
    minimumAmount = json['minimum_amount'];
    image = json['image'];
    continentId = json['continent_id'];
    if (json['facilities'] != null) {
      facilities = [];
      json['facilities'].forEach((v) {
        facilities?.add(Facilities.fromJson(v));
      });
    }
    rate = json['rate'];
    rateMethod = json['rate_method'];
    manualRate = json['manual_rate'];
    finalRate = json['Final_rate'];
    featured = json['featured'];
    sortingOrder = json['sorting_order'];
    status = json['status'];
    sendFrom = json['send_from'];
    sendTo = json['send_to'];
    details = json['details'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    flag = json['flag'];
  }
  num? id;
  String? name;
  String? slug;
  String? code;
  String? minimumAmount;
  String? image;
  String? continentId;
  List<Facilities>? facilities;
  String? rate;
  dynamic rateMethod;
  String? manualRate;
  String? finalRate;
  dynamic featured;
  dynamic sortingOrder;
  String? status;
  String? sendFrom;
  String? sendTo;
  String? details;
  dynamic createdAt;
  String? updatedAt;
  String? flag;
CountryModels copyWith({  num? id,
  String? name,
  String? slug,
  String? code,
  String? minimumAmount,
  String? image,
  String? continentId,
  List<Facilities>? facilities,
  String? rate,
  dynamic rateMethod,
  String? manualRate,
  String? finalRate,
  dynamic featured,
  dynamic sortingOrder,
  String? status,
  String? sendFrom,
  String? sendTo,
  String? details,
  dynamic createdAt,
  String? updatedAt,
  String? flag,
}) => CountryModels(  id: id ?? this.id,
  name: name ?? this.name,
  slug: slug ?? this.slug,
  code: code ?? this.code,
  minimumAmount: minimumAmount ?? this.minimumAmount,
  image: image ?? this.image,
  continentId: continentId ?? this.continentId,
  facilities: facilities ?? this.facilities,
  rate: rate ?? this.rate,
  rateMethod: rateMethod ?? this.rateMethod,
  manualRate: manualRate ?? this.manualRate,
  finalRate: finalRate ?? this.finalRate,
  featured: featured ?? this.featured,
  sortingOrder: sortingOrder ?? this.sortingOrder,
  status: status ?? this.status,
  sendFrom: sendFrom ?? this.sendFrom,
  sendTo: sendTo ?? this.sendTo,
  details: details ?? this.details,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  flag: flag ?? this.flag,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['code'] = code;
    map['minimum_amount'] = minimumAmount;
    map['image'] = image;
    map['continent_id'] = continentId;
    if (facilities != null) {
      map['facilities'] = facilities?.map((v) => v.toJson()).toList();
    }
    map['rate'] = rate;
    map['rate_method'] = rateMethod;
    map['manual_rate'] = manualRate;
    map['Final_rate'] = finalRate;
    map['featured'] = featured;
    map['sorting_order'] = sortingOrder;
    map['status'] = status;
    map['send_from'] = sendFrom;
    map['send_to'] = sendTo;
    map['details'] = details;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['flag'] = flag;
    return map;
  }

  @override
  String toString() {
    return name!;
  }
}

class Facilities {
  Facilities({
      this.id, 
      this.name,});

  Facilities.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  num? id;
  String? name;
Facilities copyWith({  num? id,
  String? name,
}) => Facilities(  id: id ?? this.id,
  name: name ?? this.name,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

  @override
  String toString() {
    return 'Facilities{id: $id, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Facilities && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}