class CharacterModel{
  int? charId;
  String? name;
  String? birthday;
  List? jobs;
  late String img;
  String? statusIfDead;
  String? nickName;
  List? breakingBadAppearance;
  String? actorName;
  String? category;
  List? betterCallSaulAppearance;
  CharacterModel.fromJson(Map<String,dynamic>json){
    charId = json['char_id'];
    name = json['name'];
    birthday = json['birthday'];
    jobs = json['occupation'];
    img = json['img'];
    statusIfDead = json['status'];
    nickName = json['nickname'];
    breakingBadAppearance = json['appearance'];
    actorName = json['portrayed'];
    category = json['category'];
    betterCallSaulAppearance = json['better_call_saul_appearance'];

  }
}