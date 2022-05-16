import 'dart:convert';

class MountainModel {
  final String name;
  final String cover;
  final String pdf;
  MountainModel({
    this.name,
   this.cover,
    this.pdf,
  });

  MountainModel copyWith({
    String name,
    String cover,
    String pdf,
  }) {
    return MountainModel(
      name: name ?? this.name,
      cover: cover ?? this.cover,
      pdf: pdf ?? this.pdf,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'cover': cover});
    result.addAll({'pdf': pdf});

    return result;
  }

  factory MountainModel.fromMap(Map<String, dynamic> map) {
    return MountainModel(
      name: map['name'] ?? '',
      cover: map['cover'] ?? '',
      pdf: map['pdf'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MountainModel.fromJson(String source) =>
      MountainModel.fromMap(json.decode(source));

  @override
  String toString() => 'MountainModel(name: ${name}, cover: $cover, pdf: $pdf)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MountainModel &&
        other.name == name &&
        other.cover == cover &&
        other.pdf == pdf;
  }

  @override
  int get hashCode => null.hashCode ^ cover.hashCode ^ pdf.hashCode;
}
