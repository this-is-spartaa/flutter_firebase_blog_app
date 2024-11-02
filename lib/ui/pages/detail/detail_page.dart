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
      body: Text('DetailPage'),
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
