class Script {
  String name;
  List<String> fieldList = [];

  Script(
      {required this.name, required this.fieldList});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'fieldList': fieldList,
    };
  }

  factory Script.fromJson(Map<String, dynamic> json) {
    return Script(
      name: json['name'],
      fieldList: json['score'],
    );
  }
}
