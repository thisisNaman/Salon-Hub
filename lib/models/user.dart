class CustomUser {
  bool? isSalon;
  String? salonName;
  String? streetAddress;
  String? district;
  String? state;
  String? pincode;
  String? phoneno;

  CustomUser(
      {this.isSalon,
      required this.streetAddress,
      required this.district,
      required this.state,
      required this.pincode,
      required this.phoneno,
      required this.salonName});

  Map<String, dynamic> toJson() => {
        'isSalon': isSalon,
        'streetAddress': streetAddress,
        'district': district,
        'state': state,
        'pincode': pincode,
        'phoneno': phoneno,
        'salonName': salonName
      };
}
