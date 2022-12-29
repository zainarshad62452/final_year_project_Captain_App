class Users {
  String uid;
  final String? email;
  final String? name;
  final String? phone;
  final bool? isVerified;
  final bool? isPending;
  final bool? isBlocked;
  final String? profileImage;
  // final String carModel;
  // final String carNumber;
  // final String carColor;
  // final String carTax;
  // final String cnic;
  // final String licenseNumber;
  // final String cityOfLicense;
  // final String expiry;
  Users(

      {this.uid = '',
         this.name,
         this.email,
         this.phone,
         this.isVerified,
         this.isPending,
        this.isBlocked,
        this.profileImage,
        // required this.carModel,
        // required this.carNumber,
        // required this.carColor,
        // required this.carTax,
        // required this.cnic,
        // required this.licenseNumber,
        // required this.cityOfLicense,
        // required this.expiry,


      });

  Map<String, dynamic> toJson() =>
      {
        'uid': uid,
        'name': name,
        'email': email,
        'phone': phone,
        'isVerified':isVerified,
        'isPending':isPending,
        'isBlocked':isBlocked,
        'profileImage':profileImage,
        // 'carModel':carModel,
        // 'carNumber':carNumber,
        // 'carNumber':carColor,
        // 'carTax':carTax,
        // 'cnic':cnic,
        // 'licenseNumber':licenseNumber,
        // 'cityOfLicense':cityOfLicense,
        // 'expiry':expiry

      };
  static Users fromJson(Map<String, dynamic> json) => Users(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    isVerified: json['isVerified'],
    isPending: json['isPending'],
    isBlocked: json['isBlocked'],
      profileImage:json['profileImage'],
    // carModel: json['carModel'],
    // carNumber: json['carNumber'],
    // carColor: json['carColor'],
    // carTax: json['carTax'],
    // cnic: json['cnic'],
    // licenseNumber: json['licenseNumber'],
    // cityOfLicense: json['cityOfLicense'],
    // expiry: json['expiry']
  );
}