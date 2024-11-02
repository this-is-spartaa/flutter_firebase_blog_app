import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog_app/ui/pages/write/write_page.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          button(Icons.delete, () async {
            print("DELETE");
          }),
          button(Icons.edit, () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return WritePage();
              },
            ));
          }),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(bottom: 300),
        children: [
          Image.network(
            'https://picsum.photos/200/300',
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          // 이미지에는 패딩이 적용되지 않기 때문에 아래 영역만 Padding 위젯
          // 감싸서 패딩 지정!
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today I Learned',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  '이지원',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  '2024.09.09 20:20',
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  'Flutter GridView를 배웠습니다.Flutter GridView를 배웠습니다.Flutter GridView를 배웠습니다.Flutter GridView를 배웠습니다.Flutter GridView를 배웠습니다.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector button(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // Icon 크기가 기본 24 이기 때문에 컨테이너 색상을 지정해주지 않으면
        // 터치 반경 24x24 됨
        color: Colors.transparent,
        width: 50,
        height: 50, // 중요!!! 사람이 터치할때 터치 잘되게 하는 최소 반경이 44 디바이스 픽셀!
        child: Icon(icon),
      ),
    );
  }
}
