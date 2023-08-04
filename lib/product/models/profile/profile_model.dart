import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'ipdata.dart';
import 'reviews.dart';
part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel with EquatableMixin {
  Ipdata? ipdata;
  bool? scc;
  String? id;
  String? backPhotoID;
  double? balance;
  String? dateOfBirth;
  String? deliveryAddress;
  String? email;
  String? fullName;
  bool? idVerified;
  String? ipraw;
  double? lastTimeLoggedIn;
  double? lat;
  double? long;
  String? password;
  String? phoneNumber;
  String? photoOfId;
  String? profileImage;
  List<Reviews>? reviews;
  String? thirdParty;

  ProfileModel({
    this.ipdata,
    this.scc,
    this.id,
    this.backPhotoID,
    this.balance,
    this.dateOfBirth,
    this.deliveryAddress,
    this.email,
    this.fullName,
    this.idVerified,
    this.ipraw,
    this.lastTimeLoggedIn,
    this.lat,
    this.long,
    this.password,
    this.phoneNumber,
    this.photoOfId,
    this.profileImage,
    this.reviews,
    this.thirdParty,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  @override
  List<Object?> get props => [
        ipdata,
        scc,
        id,
        backPhotoID,
        balance,
        dateOfBirth,
        deliveryAddress,
        email,
        fullName,
        idVerified,
        ipraw,
        lastTimeLoggedIn,
        lat,
        long,
        password,
        phoneNumber,
        photoOfId,
        profileImage,
        reviews,
        thirdParty
      ];

  ProfileModel copyWith({
    Ipdata? ipdata,
    bool? scc,
    String? id,
    String? backPhotoID,
    double? balance,
    String? dateOfBirth,
    String? deliveryAddress,
    String? email,
    String? fullName,
    bool? idVerified,
    String? ipraw,
    double? lastTimeLoggedIn,
    double? lat,
    double? long,
    String? password,
    String? phoneNumber,
    String? photoOfId,
    String? profileImage,
    List<Reviews>? reviews,
    String? thirdParty,
  }) {
    return ProfileModel(
      ipdata: ipdata ?? this.ipdata,
      scc: scc ?? this.scc,
      id: id ?? this.id,
      backPhotoID: backPhotoID ?? this.backPhotoID,
      balance: balance ?? this.balance,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      idVerified: idVerified ?? this.idVerified,
      ipraw: ipraw ?? this.ipraw,
      lastTimeLoggedIn: lastTimeLoggedIn ?? this.lastTimeLoggedIn,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoOfId: photoOfId ?? this.photoOfId,
      profileImage: profileImage ?? this.profileImage,
      reviews: reviews ?? this.reviews,
      thirdParty: thirdParty ?? this.thirdParty,
    );
  }
}
