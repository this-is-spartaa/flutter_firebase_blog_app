import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_blog_app/data/model/post.dart';

class PostRepository {
  const PostRepository();
  // 2. data List<Post>로 가공
  Future<List<Post>> getAll() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // 컬렉션 레퍼런스 타입의 이름이 기억이 안나요! 혹은 매번 타입 치기 번거로워요! 할땐 final or var!!!
    final collectionRef = firestore.collection('posts');
    final snapshot = await collectionRef.get();
    final documentSnaphots = snapshot.docs;
    // List의 map 을 호출하면 MappedIterable 클래스가 리턴됨
    // list -> MappedIterable : 내가가진 자료를 가공할건데 가공할 방식(함수) 던저줄게 잘 가지고 있어!
    final iterable = documentSnaphots.map((e) {
      final map = {
        'id': e.id, // id는 date에 없기 때문에 직접 가공
        ...e.data(),
      };
      return Post.fromJson(map);
    });

    // MappedIterable야! 내가 주문한 방식으로 리스트 가공해!
    final list = iterable.toList();
    return list;
  }

  // 1. insert 구현하기
  Future<void> insert({
    required String title,
    required String content,
    required String writer,
  }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // 컬렉션 레퍼런스 타입의 이름이 기억이 안나요! 혹은 매번 타입 치기 번거로워요! 할땐 final or var!!!
    final collectionRef = firestore.collection('posts');
    // 새로운 문서를 생성할거니 id 비우고 문서참조 생성!
    final docRef = collectionRef.doc();

    // 생성할 데이터 만들기!
    final map = {
      'title': title,
      'content': content,
      'writer': writer,
      'createdAt': DateTime.now().toIso8601String(),
    };
    // 저장!
    await docRef.set(map);
  }

  Future<Post?> getOne(String id) async {
    // data가 null 일경우 catch문 타게.
    // 네트워크 오류일때도 catch문!
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('post').doc(id).get();
      return Post.fromJson({
        'id': snapshot.id,
        ...snapshot.data()!,
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> delete(String id) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('post').doc(id);
      await docRef.delete();
      return true;
    } catch (e) {
      print('$e');
      return false;
    }
  }

  Future<bool> update(String id) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('post').doc(id);
      await docRef.delete();
      return true;
    } catch (e) {
      print('$e');
      return false;
    }
  }
}
