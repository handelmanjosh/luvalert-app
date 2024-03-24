

class UserData {
  final String username;
  final String fullName;
  bool selected;
  UserData({required this.username, required this.fullName, required this.selected});
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      username: json['username'],
      fullName: json['full_name'],
      selected: false,
    );
  }
}