class PostModel {
  String id;
  String senderid;
  String imgurl;
  String title;
  String category;
  String createdtime;

  PostModel(
      {this.id,
      this.senderid,
      this.imgurl,
      this.title,
      this.category,
      this.createdtime});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      senderid: json['senderid'],
      imgurl: json['imgurl'],
      title: json['title'],
      category: json['category'],
      createdtime: json['createdtime'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['senderid'] = this.senderid;
    data['imgurl'] = this.imgurl;
    data['title'] = this.title;
    data['category'] = this.category;
    data['createdtime'] = this.createdtime;
    return data;
  }
}
