import 'dart:async';

import 'package:flutter_firebase_blog_app/data/model/post.dart';
import 'package:flutter_firebase_blog_app/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 상태 생성
class WritePageState {
  const WritePageState(
    this.isWriting,
  );
  final bool isWriting;
}

// 2. 뷰모델 생성. Post null이면 생성, 아니면 수정!
class WriteViewModel extends AutoDisposeFamilyNotifier<WritePageState, Post?> {
  final postRepository = const PostRepository();

  @override
  WritePageState build(Post? arg) {
    return WritePageState(false);
  }

  // insert 성공 값 리턴
  Future<bool> insert({
    required String writer,
    required String title,
    required String content,
  }) async {
    if (arg?.content == content &&
        arg?.title == title &&
        writer == arg?.writer) {
      return false;
    }
    state = WritePageState(true);
    final result = arg == null
        ? await postRepository.insert(
            writer: writer,
            title: title,
            content: content,
          )
        : await postRepository.update(
            id: arg!.id,
            writer: writer,
            title: title,
            content: content,
          );

    await Future.delayed(Duration(seconds: 1));
    state = WritePageState(false);
    return result;
  }
}

final writeViewModel = NotifierProvider.family
    .autoDispose<WriteViewModel, WritePageState, Post?>(() => WriteViewModel());
