import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:sky_printing/modules/dashboard/domain/entities/location.dart';

part 'location_response.freezed.dart';
part 'location_response.g.dart';

@freezed
class LocationResponse with _$LocationResponse {
  const factory LocationResponse({
    double? latitude,
    double? longitude,
    double? accuracy,
    double? verticalAccuracy,
    double? altitude,
    double? speed,
    double? speedAccuracy,
    double? heading,
    double? time,
    bool? isMock,
    double? headingAccuracy,
    double? elapsedRealtimeNanos,
    double? elapsedRealtimeUncertaintyNanos,
    int? satelliteNumber,
    String? provider,
    @JsonKey(fromJson: _placemarksFromJson, toJson: _placemarksToJson)
    List<Placemark>? placemarks,
  }) = _LocationResponse;

  const LocationResponse._();

  factory LocationResponse.fromJson(Map<String, dynamic> json) =>
      _$LocationResponseFromJson(json);

  Location toEntity() {
    return Location(
      latitude: latitude,
      longitude: longitude,
      accuracy: accuracy,
      verticalAccuracy: verticalAccuracy,
      altitude: altitude,
      speed: speed,
      speedAccuracy: speedAccuracy,
      heading: heading,
      time: time,
      isMock: isMock,
      headingAccuracy: headingAccuracy,
      elapsedRealtimeNanos: elapsedRealtimeNanos,
      elapsedRealtimeUncertaintyNanos: elapsedRealtimeUncertaintyNanos,
      satelliteNumber: satelliteNumber,
      provider: provider,
      placemarks: placemarks,
    );
  }
}

List<Placemark> _placemarksFromJson(List<dynamic> jsonList) {
  return jsonList
      .map((json) => _placemarkFromJson(json as Map<String, dynamic>))
      .toList();
}

List<dynamic> _placemarksToJson(List<Placemark>? placemarks) {
  return placemarks?.map((placemark) => _placemarkToJson(placemark)).toList() ??
      [];
}

Placemark _placemarkFromJson(Map<String, dynamic> json) {
  return Placemark(
    name: json['name'] as String?,
    street: json['street'] as String?,
    isoCountryCode: json['isoCountryCode'] as String?,
    country: json['country'] as String?,
    postalCode: json['postalCode'] as String?,
    administrativeArea: json['administrativeArea'] as String?,
    subAdministrativeArea: json['subAdministrativeArea'] as String?,
    locality: json['locality'] as String?,
    subLocality: json['subLocality'] as String?,
    thoroughfare: json['thoroughfare'] as String?,
    subThoroughfare: json['subThoroughfare'] as String?,
  );
}

Map<String, dynamic> _placemarkToJson(Placemark instance) {
  return <String, dynamic>{
    'name': instance.name,
    'street': instance.street,
    'isoCountryCode': instance.isoCountryCode,
    'country': instance.country,
    'postalCode': instance.postalCode,
    'administrativeArea': instance.administrativeArea,
    'subAdministrativeArea': instance.subAdministrativeArea,
    'locality': instance.locality,
    'subLocality': instance.subLocality,
    'thoroughfare': instance.thoroughfare,
    'subThoroughfare': instance.subThoroughfare,
  };
}
