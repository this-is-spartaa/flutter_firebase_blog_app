import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog_app/ui/pages/detail/detail_page.dart';

class HomeListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      // 8. ListView.separated 생성자로 변경
      //    ListView.builder와 사용방법은 동일하나
      //    각 아이템 사이에 뭔가를 넣고 싶을 때 사용
      //    separatorBuilder 필수 구현해야되며 separatorBuilder 내에서
      //    각 위젯 사이에 들어갈 위젯들 리면해주면 됨!
      child: ListView.separated(
        itemCount: 50,
        separatorBuilder: (context, index) => SizedBox(height: 10),
        itemBuilder: (context, index) {
          return item();
        },
      ),
    );
  }

  // 0. 위젯 함수화
  Widget item() {
    // GestureDetactor 내에서 화면 전환을 위해서 context가 필요한데
    // Builder 위젯을 사용하면 BuildContext를 item함수의 파라미터로 받지 않을 수 있음
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return DetailPage();
            },
          ));
        },
        // 7. Container는 여러 속성이 많아서 Container에서 제공하는 속성을
        // 사용하지 않을거라면 SizedBox 사용하는게 성능에 좋음!
        child: SizedBox(
          height: 120,
          width: double.infinity,
          // 1. Stack 배치
          child: Stack(
            children: [
              // 3. 오른쪽 영역
              // AspectRatio 는 부모위젯 크기를 물려받는 위젯
              // Positioned 는 크기가 자녀위젯 크기 따라감
              // 자녀위젯의 크기가 없다면 width, height 속성으로 크기를 정해줘야함!!!
              // 이미지 위에 컨테이너가 와야되니 Stack에서 컨테이너보다 앞에 위치해야함
              Positioned(
                right: 0,
                width: 120,
                height: 120,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      'https://picsum.photos/200/300',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // 2. 왼쪽영역 구현
              Container(
                width: double.infinity,
                height: double.infinity,
                margin: EdgeInsets.only(right: 100),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                // 5. padding 설정
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  // 6. 정렬 조정
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 4. Container 자녀요소 배치
                    Text(
                      'Today I Learned',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Flutter의 그리드뷰를 배웠습니다.Flutter의 그리드뷰를 배웠습니다.Flutter의 그리드뷰를 배웠습니다.Flutter의 그리드뷰를 배웠습니다.Flutter의 그리드뷰를 배웠습니다.',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '2024.9.9 20:80',
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
