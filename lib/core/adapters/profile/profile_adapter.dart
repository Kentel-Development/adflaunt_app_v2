import 'package:hive/hive.dart';
part 'profile_adapter.g.dart';

@HiveType(typeId: 0)
class ProfileAdapter {
  ProfileAdapter({
    this.id,
    this.dateOfBirth,
    this.email,
    this.fullName,
    this.idVerified,
    this.password,
    this.phoneNumber,
    this.photoOfId,
    this.profileImage,
    this.thirdParty,
  });
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? dateOfBirth;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? fullName;
  @HiveField(4)
  bool? idVerified;
  @HiveField(5)
  String? password;
  @HiveField(6)
  String? phoneNumber;
  @HiveField(7)
  String? photoOfId;
  @HiveField(8)
  dynamic profileImage;
  @HiveField(9)
  String? thirdParty;
}
