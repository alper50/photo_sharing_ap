import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:greenlive/core/data/models/markermodel.dart';
import 'package:greenlive/core/data/models/postmodel.dart';

class PostApiProvider {
  Dio dio = Dio();
  String url = "https://66303722f6a5.ngrok.io";
  
  Future<bool> uploadImage(String file, int category, String title, double latitude, double longitude) async {
    final uri = Uri.parse("https://66303722f6a5.ngrok.io/green_api/api/post/upload_post.php");
    var request = http.MultipartRequest("POST",uri);
    request.fields["latitude"] = "$latitude";
    request.fields["longitude"] = "$longitude";
    request.fields["title"] = title;
    request.fields["category"] = "$category";
    request.fields["sender"] = "alper";
    var img = await http.MultipartFile.fromPath("image", file);
    request.files.add(img);
    var response = await request.send();
    if(response.statusCode==200){
      print("başarılı");
      return true;
    } else{
      return false;
    }
    // String fileName = file.split('/').last;
    // print(fileName);
    // FormData formData = FormData.fromMap({
    //   "image": await MultipartFile.fromFile(
    //     file,
    //     filename: fileName,
    //     contentType: MediaType("image", "jpg"),
    //   ),
    // });
    // var response = await dio.post("https://66303722f6a5.ngrok.io/green_api/api/post/upload_post.php",data: formData).then((value) => print(value)).catchError((error)=>print(error));
    
  }

  // ignore: missing_return
  Future<List<PostModel>> getPosts(double lang, double long,int page, int rowperpage) async {
    List<PostModel> posts = [];
    Response<String> response = await dio.get(
        "https://5631b8a69656.ngrok.io/green_api/api/post/get_posts.php?longitude=$long&latitude=$lang&page=$page&rowperpage=$rowperpage");

    try {
      if (response.statusCode == 200) {
        if (response.data.isNotEmpty) {
          List list = json.decode(response.data);
          print(list);
          posts = list.map((dynamic item) => PostModel.fromJson(item)).toList();
          return posts;
        }
      }
    } catch (e) {
      print("hata  $e");
    }
    return posts;
  }

  Future<List<String>> getUserDetail(String nickname) async {
    List list = [];
    Response<String> response = await dio.get(
        "https://1ae2e61b7db6.ngrok.io/green_api/api/post/get_posts.php?userid=$nickname");

    try {
      if (response.statusCode == 200) {
        if (response.data.isNotEmpty) {
          list = json.decode(response.data);
          return list;
        }
      }
    } catch (e) {
      print("hata  $e");
    }
    return list;
  }

  // ignore: missing_return
  Future<List<MarkerModel>> getMarkers(double lang, double long) async {
    List<MarkerModel> markers = [];
    Response<String> response =
        await dio.get("https://5631b8a69656.ngrok.io/green_api/api/post/get_markers.php?longitude=$long&latitude=$lang");
    try {
      if (response.statusCode == 200) {
        List list = jsonDecode(response.data);
        print(response.data);
        markers= list.map((dynamic item) => MarkerModel.fromJson(item)).toList();
        print("geldi  $markers");
        return markers;
      }
    } catch (e) {
      print(e);
    }
  }
}
