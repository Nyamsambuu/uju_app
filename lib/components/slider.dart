import 'package:flutter/material.dart';
import 'dart:async';
import '../api/api_service.dart';
import '../api/api_url.dart';

class SliderWidget extends StatefulWidget {
  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  final ApiService apiService = ApiService();
  PageController _pageController = PageController(initialPage: 0);
  Timer? _timer;
  int _currentPage = 0;
  List<dynamic> images = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoPlay();
    });
    _fetchImages();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = _currentPage + 1;
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      }
    });
  }

  void _fetchImages() async {
    try {
      final fetchedImages = await apiService.fetchSliderImages();
      if (mounted) {
        setState(() {
          images = fetchedImages;
          isLoading = false;
        });
        // Start in the middle to facilitate infinite scrolling
        _pageController = PageController(initialPage: images.length * 500);
        _currentPage = images.length * 500;
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (hasError) {
      return Center(child: Text('Error loading images'));
    } else if (images.isEmpty) {
      return Center(child: Text('No images available'));
    }

    return Container(
      height: 140, // Adjust height as needed
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo is ScrollEndNotification) {
                _handlePageChange();
              }
              return false;
            },
            child: PageView.builder(
              controller: _pageController,
              itemCount:
                  images.length * 1000, // Infinite loop by large itemCount
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                final imageId = images[index % images.length]['id'];
                final imageUrl =
                    '${getBaseURL()}/api/file/download?ID=$imageId';
                return Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                );
              },
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '${(_currentPage % images.length) + 1}/${images.length}',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _handlePageChange() {
    // Loop back to the middle when reaching the start or end
    if (_currentPage == 0) {
      _pageController.jumpToPage(images.length * 500);
      setState(() {
        _currentPage = images.length * 500;
      });
    } else if (_currentPage == images.length * 1000 - 1) {
      _pageController.jumpToPage(images.length * 500);
      setState(() {
        _currentPage = images.length * 500;
      });
    }
  }
}
