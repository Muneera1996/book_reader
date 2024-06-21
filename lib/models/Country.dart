// class Country {
//   String success;
//   List<Data> data;
//   String message;
//
//   Country({this.success, this.data, this.message});
//
//   Country.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     if (json['data'] != null) {
//       data = new List<Data>();
//       json['data'].forEach((v) {
//         data.add(new Data.fromJson(v));
//       });
//     }
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     if (this.data != null) {
//       data['data'] = this.data.map((v) => v.toJson()).toList();
//     }
//     data['message'] = this.message;
//     return data;
//   }
// }
//
// class Data {
//   String countryId;
//   String countryName;
//   String countryCode;
//   String isoCode3;
//   String addressFormat;
//   String postcodeRequired;
//   String status;
//
//   Data(
//       {this.countryId,
//         this.countryName,
//         this.countryCode,
//         this.isoCode3,
//         this.addressFormat,
//         this.postcodeRequired,
//         this.status});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     countryId = json['country_id'];
//     countryName = json['country_name'];
//     countryCode = json['country_code'];
//     isoCode3 = json['iso_code_3'];
//     addressFormat = json['address_format'];
//     postcodeRequired = json['postcode_required'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['country_id'] = this.countryId;
//     data['country_name'] = this.countryName;
//     data['country_code'] = this.countryCode;
//     data['iso_code_3'] = this.isoCode3;
//     data['address_format'] = this.addressFormat;
//     data['postcode_required'] = this.postcodeRequired;
//     data['status'] = this.status;
//     return data;
//   }
// }
