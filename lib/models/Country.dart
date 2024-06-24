class Country {
  String? status;
  int? statusCode;
  String? message;
  List<Data>? data;

  Country({this.status, this.statusCode, this.message, this.data});

  Country.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? countryName;
  String? countryCode;
  String? icon;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
        this.countryName,
        this.countryCode,
        this.icon,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    countryName = json['country_name'];
    countryCode = json['country_code'];
    icon = json['icon'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['country_name'] = countryName;
    data['country_code'] = countryCode;
    data['icon'] = icon;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}