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

}