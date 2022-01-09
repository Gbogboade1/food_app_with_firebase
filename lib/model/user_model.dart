import 'dart:convert';

class User {
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String address;
  final String emailAddr;
  final String securityPin;

  User({
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.address,
    this.emailAddr,
    this.securityPin,
  });

  User.fromMap(Map snapshot)
      : phoneNumber = snapshot['phoneNumber'] ?? "",
        firstName = snapshot['firstName'] ?? "",
        lastName = snapshot['lastName'] ?? "",
        address = snapshot['address'] ?? "",
        emailAddr = snapshot['emailAddr'] ?? "",
        securityPin = snapshot['securityPin'] ?? "";

  toJson() {
    return {
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'emailAddr': emailAddr,
      'securityPin': securityPin
    };
  }
}
