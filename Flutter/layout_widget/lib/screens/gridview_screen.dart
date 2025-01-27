import 'package:flutter/material.dart';
import 'package:layout_widget/models/product.dart';
import 'package:layout_widget/screens/detail_screen.dart';

class GridViewScreen extends StatefulWidget {
  const GridViewScreen({super.key});

  @override
  State<GridViewScreen> createState() => _GridViewScreenState();
}

class _GridViewScreenState extends State<GridViewScreen> {
  List<Widget> productWidgetList = [
    Card(
        elevation: 10, // Card 위젯의 그림자 효과 크기
        child: GridTile(
          header: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.more_vert),
              )
            ],
          ),
          footer: Column(
            children: [Text("상품 제목"), Text("상품 설명입니다.")],
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Padding(
                  padding: EdgeInsets.only(bottom: 50.0),
                  child: Image.asset(
                    "image/product1.png",
                    fit: BoxFit.cover,
                  ))),
        ))
  ];

  // 동적 상품 객체 리스트
  final List<Product> productList = List.generate(
      10,
      (index) => Product(
          image: index == 1 ? null : "image/product${index + 1}.png",
          title: "상품 제목 ${index + 1}",
          description: "${index + 1}번째 상품 설명입니다."));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("그리드 뷰"),
      ),
      body: Container(
        child: Center(
            child:
                // GridView(
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 2, // 열의 개수
                //       crossAxisSpacing: 10.0, // 열 간격
                //       mainAxisSpacing: 10.0), // 행 간격
                //   children: productWidgetList,
                // ),
                // 동적 그리드 뷰
                GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0),
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      final product = productList[index];
                      return GestureDetector(
                        onTap: () {
                          // 상세 화면으로 이동
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(product: product)));
                        },
                        child: Card(
                            elevation: 10, // Card 위젯의 그림자 효과 크기
                            child: GridTile(
                              header: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Icon(Icons.more_vert),
                                  )
                                ],
                              ),
                              footer: Column(
                                children: [
                                  Text(product.title ?? "상품 제목"),
                                  Text(product.description ?? "상품 설명입니다.")
                                ],
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Padding(
                                      padding: EdgeInsets.only(bottom: 50.0),
                                      child: Image.asset(
                                        product.image ?? "image/logo.png",
                                        fit: BoxFit.cover,
                                      ))),
                            )),
                      );
                    })),
      ),
    );
  }
}
