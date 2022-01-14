class CustomUser {
  bool? isSalon;
  String? salonName;
  String? address;
  String? phoneno;

  CustomUser(
      {this.isSalon,
      required this.address,
      required this.phoneno,
      required this.salonName});

  Map<String, dynamic> toJson() => {
        'isSalon': isSalon,
        'address': address,
        'phoneno': phoneno,
        'salonName': salonName
      };
}
