import 'package:greenlive/core/data/models/markermodel.dart';
import 'package:greenlive/core/data/models/postmodel.dart';
import 'package:greenlive/core/data/network/post_service.dart';

class PostRepository{
  PostApiProvider provider = PostApiProvider();

  // Future<bool> uploadimage(file){
  //   return provider.uploadImage(file);
  // }

  Future<List<PostModel>> getpost(double lang,double long,int page,int rowperpage)async{
    List<PostModel> temp = [];
    try{
      temp = await provider.getPosts(lang, long,page,rowperpage);
    }catch(e){
      print(e);
    }
    return temp;
  }

  Future<List<MarkerModel>?> getmarker(double lang,double long){
    return provider.getMarkers(lang, long);
  }
}