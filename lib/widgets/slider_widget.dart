import 'package:flutter/material.dart';
import 'package:uju_app/api/api_url.dart';

class SliderWidget extends StatefulWidget {
  final List<String> imageIds;

  SliderWidget({required this.imageIds});

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.imageIds.length,
            itemBuilder: (context, index) {
              final imageId = widget.imageIds[index];
              final imageUrl = '${getBaseURL()}/api/file/download?ID=$imageId';
              return Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              );
            },
          ),
          Positioned(
            bottom: 8.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                '${_currentPage + 1}/${widget.imageIds.length}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
