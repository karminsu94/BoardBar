class ScriptRecord {
  String scriptId;
  String matchId;

  String playerName;
  List<int> scoreList = [];
  List<List<String>> scoreDetail = [];

  ScriptRecord(
      {required this.scriptId, required this.matchId, required this.playerName, required this.scoreList, required this.scoreDetail});

  Map<String, dynamic> toJson() {
    return {
      'scriptId': scriptId,
      'matchId': matchId,
      'playerName': playerName,
      'scoreList': scoreList,
      'scoreDetail': scoreDetail,
    };
  }

  factory ScriptRecord.fromJson(Map<String, dynamic> json) {
    return ScriptRecord(
      scriptId: json['scriptId'],
      matchId: json['matchId'],
      playerName: json['name'],
      scoreList: json['scoreList'],
      scoreDetail: List<List<String>>.from(json['scoreDetail'].map((x) => List<String>.from(x))),
    );
  }
}
