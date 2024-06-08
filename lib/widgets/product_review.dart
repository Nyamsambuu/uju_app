import 'package:flutter/material.dart';

class Review extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                '리뷰 2',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Spacer(),
              Text(
                '리뷰쓰기',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Text(
                      '5.0',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.blue,
                      size: 24,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('5 оноо'),
                          SizedBox(width: 8),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: 1.0,
                              backgroundColor: Colors.grey[300],
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text('2'),
                        ],
                      ),
                      Row(
                        children: [
                          Text('4 оноо'),
                          SizedBox(width: 8),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: 0.0,
                              backgroundColor: Colors.grey[300],
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text('0'),
                        ],
                      ),
                      Row(
                        children: [
                          Text('3 оноо'),
                          SizedBox(width: 8),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: 0.0,
                              backgroundColor: Colors.grey[300],
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text('0'),
                        ],
                      ),
                      Row(
                        children: [
                          Text('2 оноо'),
                          SizedBox(width: 8),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: 0.0,
                              backgroundColor: Colors.grey[300],
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text('0'),
                        ],
                      ),
                      Row(
                        children: [
                          Text('1 оноо'),
                          SizedBox(width: 8),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: 0.0,
                              backgroundColor: Colors.grey[300],
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text('0'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(),
        ListTile(
          leading: Image.network('https://via.placeholder.com/100'),
          title: Text('초록좋아다'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('2023.08.01 • 오늘의집 구매'),
              Text('색상: 핑크 / 사이즈: 100x150cm'),
              Text('생각보다 색이 좀 진하긴한데 이쁘네요'),
            ],
          ),
        ),
        Divider(),
        ListTile(
          leading: Image.network('https://via.placeholder.com/100'),
          title: Text('푸르미세상에서제일귀여워'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('2023.03.18 • 오늘의집 구매'),
              Text('6달 사용기'),
              Text('작은방 햇빛가리개로 샀는데 흰색보다 회색이 더 질이 좋아보여요'),
            ],
          ),
        ),
      ],
    );
  }
}
