import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:greenlive/core/data/models/groupmodel.dart';

class GroupApiProvider {
  Dio dio = Dio();

  Future<List<GroupModel>> getGroups(int page, int rowperpage) async {
    List<GroupModel> groups = [];
    Response<String> response = await dio.get(
        "https://5631b8a69656.ngrok.io/green_api/api/group/get_groups.php?page=$page&rowperpage=$rowperpage");

    try {
      if (response.statusCode == 200) {
        if (response.data.isNotEmpty) {
          List list = json.decode(response.data);
          print(list);
          groups =
              list.map((dynamic item) => GroupModel.fromJson(item)).toList();
          return groups;
        }
      }
    } catch (e) {
      print("hata  $e");
    }
    return groups;
  }

  Future<List<GroupModel>> searchGroup(String text) async {
    List<GroupModel> groups = [];
    Response<String> response = await dio.get(
        "https://5631b8a69656.ngrok.io/green_api/api/group/search_group.php?search=$text");

    try {
      if (response.statusCode == 200 && response.data.isNotEmpty) {
        List list = json.decode(response.data);
        print(list);
        groups = list.map((dynamic item) => GroupModel.fromJson(item)).toList();
        return groups;
      }
    } catch (e) {
      print("hataa $e");
    }
    return groups;
  }
}
