class Script {
  String name;
  List<String> fieldList = [];
  List<double> scoreList = [];

  Script(
      {required this.name, required this.fieldList, required this.scoreList});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'fieldList': fieldList,
      'scoreList': scoreList,
    };
  }

  factory Script.fromJson(Map<String, dynamic> json) {
    return Script(
      name: json['name'],
      fieldList: json['score'],
      scoreList: json['scoreList'],
    );
  }
}
