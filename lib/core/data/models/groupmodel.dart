class GroupModel {
  // TODO jsona gore group model yapılcak
  String title;
  String imgUrl;
  String groupName;

  GroupModel({this.title, this.groupName, this.imgUrl});

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
        groupName: json['groupName'],
        title: json['groupTitle'],
        imgUrl: json['groupImageUrl']);
  }
}
