// ignore_for_file: unused_local_variable

class Partner {
  int id;
  String name;
  String address;
  String phoneNo;
  String email;
  String ownerPhoneNo;

  Partner(
      {required this.id,
      required this.name,
      required this.address,
      required this.phoneNo,
      required this.email,
      required this.ownerPhoneNo});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phoneNo': phoneNo,
      'email': email,
      'ownerPhoneNo': ownerPhoneNo,
    };
  }

  factory Partner.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'email': String email,
        'address': String address,
        'phoneNo': String phoneNo,
        'ownerPhoneNo': String ownerPhoneNo,
      } =>
        Partner(
          id: json['id'],
          name: json['name'],
          email: json['email'],
          address: json['address'],
          phoneNo: json['phoneNo'],
          ownerPhoneNo: json['ownerPhoneNo'],
        ),
      _ => throw const FormatException('Unexpected JSON type for Partner'),
    };
  }

  @override
  String toString() {
    return 'Partner{id: $id, name: $name, address: $address, phoneNo: $phoneNo, email: $email, ownerPhoneNo: $ownerPhoneNo}';
  }
}
