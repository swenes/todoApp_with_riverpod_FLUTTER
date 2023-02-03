// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CatModel {
  final String name;
  final int lenght;

  CatModel(
    this.name,
    this.lenght,
  );

  CatModel copyWith({
    String? name,
    int? lenght,
  }) {
    return CatModel(
      name ?? this.name,
      lenght ?? this.lenght,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'lenght': lenght,
    };
  }

  factory CatModel.fromMap(Map<String, dynamic> map) {
    return CatModel(
      map['name'] as String,
      map['lenght'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CatModel.fromJson(String source) =>
      CatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CatModel(name: $name, lenght: $lenght)';

  @override
  bool operator ==(covariant CatModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.lenght == lenght;
  }

  @override
  int get hashCode => name.hashCode ^ lenght.hashCode;
}
