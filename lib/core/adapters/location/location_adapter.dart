import 'package:hive/hive.dart';
part 'location_adapter.g.dart';

@HiveType(typeId: 1)
class LocationAdapter {
  LocationAdapter({
    this.lat,
    this.lng,
    this.placemark,
  });
  @HiveField(0)
  double? lat;
  @HiveField(1)
  double? lng;
  @HiveField(2)
  String? placemark;
}
