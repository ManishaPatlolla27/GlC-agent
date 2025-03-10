class FilterResponse {
  final List<SoilType> soilTypes;
  final List<CropType> cropTypes;
  final List<Facility> facilities;

  FilterResponse({
    required this.soilTypes,
    required this.cropTypes,
    required this.facilities,
  });

  factory FilterResponse.fromJson(Map<String, dynamic> json) {
    return FilterResponse(
      soilTypes: (json['soil_types'] as List)
          .map((item) => SoilType.fromJson(item))
          .toList(),
      cropTypes: (json['crop_types'] as List)
          .map((item) => CropType.fromJson(item))
          .toList(),
      facilities: (json['facilities'] as List)
          .map((item) => Facility.fromJson(item))
          .toList(),
    );
  }
}

class SoilType {
  final String id;
  final String label;
  final String? code;

  SoilType({required this.id, required this.label, this.code});

  factory SoilType.fromJson(Map<String, dynamic> json) {
    return SoilType(
      id: json['id'],
      label: json['label'],
      code: json['code'],
    );
  }
}

class CropType {
  final String id;
  final String label;
  final String? code;

  CropType({required this.id, required this.label, this.code});

  factory CropType.fromJson(Map<String, dynamic> json) {
    return CropType(
      id: json['id'],
      label: json['label'],
      code: json['code'],
    );
  }
}

class Facility {
  final String id;
  final String label;
  final String? code;

  Facility({required this.id, required this.label, this.code});

  factory Facility.fromJson(Map<String, dynamic> json) {
    return Facility(
      id: json['id'],
      label: json['label'],
      code: json['code'],
    );
  }
}
