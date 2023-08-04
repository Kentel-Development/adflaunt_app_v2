import 'dart:convert';

UserCheckModel userCheckModelFromJson(String str) =>
    UserCheckModel.fromJson(json.decode(str) as Map<String, dynamic>);

String userCheckModelToJson(UserCheckModel data) => json.encode(data.toJson());

class UserCheckModel {
  bool? scc;
  bool? emailExists;
  bool? phoneNumberExists;

  UserCheckModel({
    this.scc,
    this.emailExists,
    this.phoneNumberExists,
  });

  factory UserCheckModel.fromJson(Map<String, dynamic> json) => UserCheckModel(
        scc: json["SCC"] as bool?,
        emailExists: json["emailExists"] as bool?,
        phoneNumberExists: json["phoneNumberExists"] as bool?,
      );

  Map<String, dynamic> toJson() => {
        "SCC": scc,
        "emailExists": emailExists,
        "phoneNumberExists": phoneNumberExists,
      };
}
