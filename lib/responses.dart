
class UserDataMessage {
  final List<String> crushes;
  final List<String> crushees;
  UserDataMessage({required this.crushees, required this.crushes});
  factory UserDataMessage.fromJson(Map<String, dynamic> json) {
    return UserDataMessage(
      crushes: List<String>.from(json["crushes"].map((x) => x.toString())),
      crushees: List<String>.from(json["crushees"].map((x) => x.toString())),
    );
  }
}
class NearbyMessage {
  final List<int> amounts;
  NearbyMessage({required this.amounts});
  factory NearbyMessage.fromJson(Map<String, dynamic> json) {
    return NearbyMessage(
      amounts: [json["low"], json["medium"], json["high"]]
    );
  }
}