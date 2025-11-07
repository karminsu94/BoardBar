class Player {
  String name;
  int score;
  List<String> scoreDetail = [];

  Player({required this.name, required this.score});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'score': score,
      'scoreDetail': scoreDetail,
    };
  }

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['name'],
      score: json['score']
    );
  }
}