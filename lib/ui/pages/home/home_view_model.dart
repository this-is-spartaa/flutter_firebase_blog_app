import 'dart:async';

import 'package:flutter_firebase_blog_app/data/model/post.dart';
import 'package:flutter_firebase_blog_app/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 상태 클래스 => List<Post> 로 사용
// 2. ViewModel 구현
class HomeViewModel extends Notifier<List<Post>> {
  HomeViewModel();

  @override
  List<Post> build() {
    fetchData();
    return [];
  }

  final postRepository = const PostRepository();

  Future<void> fetchData() async {
    state = await postRepository.getAll();
  }
}

// 2. ViewModel 관리자 구현
final homeViewModel =
    NotifierProvider<HomeViewModel, List<Post>>(() => HomeViewModel());
