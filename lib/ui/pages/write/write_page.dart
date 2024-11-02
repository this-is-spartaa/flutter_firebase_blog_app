import 'package:flutter/material.dart';

class WritePage extends StatefulWidget {
  const WritePage({super.key});

  @override
  State<StatefulWidget> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  // 1. 작성자, 제목, 내용 TextFormField에 사용할 TextEditingController 만들어주기
  late final writerController = TextEditingController();
  late final titleController = TextEditingController();
  late final contentController = TextEditingController();

  // 2. Form 위젯에 넘겨줄 GlobalKey 만들기
  final formKey = GlobalKey<FormState>();

  // 3. 이 위젯이 사라질 때 호출되는 함수
  //    TextEditingController 사용 끝났다고 알려주기
  @override
  void dispose() {
    writerController.dispose();
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 8. TextField, TextFormField 를 사용할 때 반드시
    //    Scaffold를 GestureDetector 로 감싸서 빈공간 터치했을때
    //    키보드 사라지게 만들어주기!
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          // 9. 나중에 조건에 따라 글쓰기, 글수정으로 바꾸지만 현재는 글쓰기로 고정
          title: Text('글쓰기'),
          actions: [
            // 10. Text 배치하고 터치했을 때 validate 호출!
            GestureDetector(
              onTap: () async {
                // formKey 가 사용되고 있는 Form 위젯(StatefulWidget)의 FormState를 찾아서
                // FormState 내에 구현되어 있는 validate 메서드 호출.
                // FormState 내부에서 자녀위젯들중에 TextFormField 위젯들을 찾아서
                // TextFormField의 validator 메서드 호출하고 화면 업데이트 해줌!
                formKey.currentState!.validate();
              },
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  '완료',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8)
          ],
        ),
        // 4. body Form 으로 감싸기
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                // 5. 작성자 TextFormField 만들기
                TextFormField(
                  controller: writerController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(hintText: '작성자'),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return '작성자를 입력해 주세요';
                    }
                    return null;
                  },
                ),
                // 5. 제목 TextFormField 만들기
                TextFormField(
                  controller: titleController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(hintText: '제목'),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return '제목을 입력해 주세요';
                    }
                    return null;
                  },
                ),
                // 6. 제목 TextFormField 만들기
                //    TextField, TextFormField를 여러줄 입력 받으려면
                //    maxLines 속성을 null로 주면됨
                //    expands는 TextFormField의 크기를 부모위젯의 크기로 하고 싶을 때!
                SizedBox(
                  height: 200,
                  child: TextFormField(
                    controller: contentController,
                    maxLines: null,
                    expands: true,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(hintText: '내용'),
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return '컨텐츠를 입력해 주세요';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                // 7. 사진 업로드 할 위젯
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey,
                    child: Icon(Icons.image),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
