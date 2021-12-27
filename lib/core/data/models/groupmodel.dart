class GroupModel {
  String groupId;
  String groupTitle;
  String groupImageUrl;
  String groupName;

  GroupModel(
      {this.groupId, this.groupTitle, this.groupName, this.groupImageUrl});

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
        groupId: json['groupid'],
        groupName: json['groupName'],
        groupTitle: json['groupTitle'],
        groupImageUrl: json['groupImageUrl']);
  }
}
