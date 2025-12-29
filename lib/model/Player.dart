import 'dart:ui';

class Player {
  String name;
  int score;
  int subScore1 = 0;
  int subScore2 = 0;
  Color? color ;
  List<String> scoreDetail = [];

  Player({required this.name, required this.score});

  Player.withColor({required this.name, required this.score, required this.color});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'score': score,
      'scoreDetail': scoreDetail,
    };
  }

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(name: json['name'], score: json['score']);
  }
}
