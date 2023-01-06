class UserChat{
  String id;
  String bio;
  String userName;
  String photoUrl;
  bool isOnline;
  String lastTime;

  UserChat(
      {this.id,
      this.bio,
      this.userName,
      this.photoUrl,
      this.isOnline,
      this.lastTime});
  Map<String, dynamic> toMap(){
    return {
      'id': this.id,
      'bio' : this.bio,
      'userName' : this.userName
    }
  }
}