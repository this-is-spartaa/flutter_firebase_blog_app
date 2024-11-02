import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BLOG'),
      ),
      // 6. Scaffold body 영역의 색상
      backgroundColor: Colors.grey[200],
      // 7. 패딩 적용
      body: Padding(
        padding: EdgeInsets.all(20),
        // 1. 레이아웃 배치
        child: Column(
          // 5. Expanded를 배치하면 Column의 크기는 정해지기 때문에
          //    CrossAxisAlignment 설정해주기!
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 2. 텍스트 배치
            Text(
              '최근 글',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            // 3. 리스트뷰 배치
            // ListView는 부모위젯의 크기가 있어야 하므로
            // Column 내에서 사용 시 Expanded 배치!
            // (Column은 디폴트로 크기가 정해지지 않은 위젯!)
            Expanded(
                child: ListView(
              children: [
                // 4. ListView 내 위젯 배치
                // ListView 내 위젯은 반드시 높이를 가져야함!
                // 가로 스크롤 시에는 너비를 가져야함!
                Container(
                  height: 120,
                  width: double.infinity,
                  color: Colors.blue,
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
