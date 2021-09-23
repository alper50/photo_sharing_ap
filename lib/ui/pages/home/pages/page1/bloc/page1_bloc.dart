import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:greenlive/core/config/storage/storage.dart';
import 'package:greenlive/core/data/models/postmodel.dart';
import 'package:greenlive/core/data/network/post_service.dart';
import 'package:greenlive/core/functions/adhelper.dart';
import 'package:greenlive/ui/pages/home/bloc/homebase_bloc.dart';

part 'page1_event.dart';
part 'page1_state.dart';

class Page1Bloc extends Bloc<Page1Event, Page1State> {
  Page1Bloc() : super(Page1Initial());
  List<bool> selectedCategories = [true, false, false, false, false, false];
  List<String> categories = [
    "Category1",
    "Category2",
    "Category3",
    "Category4",
    "Category5",
    "Category6",
  ];
  List<String> storage = [];
  List<Object> data = [];
  PostApiProvider _repo = PostApiProvider();
  int page = 1;
  bool isloading = false;
  @override
  Stream<Page1State> mapEventToState(
    Page1Event event,
  ) async* {
    if (state is Page1Initial) {
      yield LoadingData();
      storage = await Storage.getStringList("location");
      if (storage.isEmpty) {
        yield StorageError();
      }
      try {
        await getData();
        
        if(data.isEmpty){
          yield FetchError();
        }
        yield Fetched(posts: data,hasreachedmax: false);
      } catch (e) {
        print(e);
      }
    } else {
      if (state is Fetched) {
        Fetched fetched = state as Fetched;
        try {
          List<Object> temporary = [];
          List<PostModel> posts = [];

          posts = await _repo.getPosts(
              double.parse(storage[0]), double.parse(storage[1]), page, 2);
          page++;
          if (posts.isEmpty) {
            yield Fetched(hasreachedmax: true);
          } else {
            temporary = List.from(posts);
            for (int i = temporary.length; i >= 1; i -= 5) {
              temporary.insert(
                  i,
                  BannerAd(
                    size: AdSize.largeBanner,
                    adUnitId: AdHelper.getbannerAdUnitId(),
                    request: AdRequest(),
                    listener: BannerAdListener(
                      onAdLoaded: (_) {
                        print("reklam geldi");
                      },
                      onAdFailedToLoad: (ad, err) {
                        print('Failed to load a banner ad: ${err.message}');
                        ad.dispose();
                      },
                    ),
                  )..load());
            }
            data.addAll(temporary);
          }
          yield DummyState();
          yield Fetched(posts: fetched.posts + temporary, hasreachedmax: false);
        } catch (e) {
          print(e);
        }
      }else{
        yield LoadingData();
        yield await Future.delayed(Duration(seconds: 1),(){
          return StorageError();
        });
      }
    }
  }

  Future<List<Object>> getData() async {
    List<Object> temporary = [];
    List<PostModel> posts = [];

    posts = await _repo.getPosts(
        double.parse(storage[0]), double.parse(storage[1]), page, 3);
    if (posts.isEmpty) {
      return posts;
    } else {
      temporary = List.from(posts);
      for (int i = temporary.length; i >= 1; i -= 2) {
        temporary.insert(
            i,
            BannerAd(
              size: AdSize.largeBanner,
              adUnitId: AdHelper.getbannerAdUnitId(),
              request: AdRequest(),
              listener: BannerAdListener(
                onAdLoaded: (_) {
                  print("reklam geldi");
                },
                onAdFailedToLoad: (ad, err) {
                  print('Failed to load a banner ad: ${err.message}');
                  ad.dispose();
                },
              ),
            )..load());
      }
      data.addAll(temporary);
      List<Object> sending = List.from(data);
      print("DATA LENGTH --- ${data.length}");
    }
  }
  void filterButton(int index){
    for(int i=0;i<selectedCategories.length;i++){
      selectedCategories[i] = i == index;
    }
    
  }
}
