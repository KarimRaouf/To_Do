import 'package:FlutterApplications/modules/shop_app/login/shop_login_screen.dart';
import 'package:FlutterApplications/shared/components/components.dart';
import 'package:FlutterApplications/shared/network/local/cache_helper.dart';
import 'package:FlutterApplications/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.body,
    required this.title,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'WELCOME !',
      body: ' I\'m happy to serve you 😀',
    ),
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'HELLO !',
      body: 'Enjoy our products 😍',
    ),
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'FEEL FREE !',
      body: 'We have many offers 😎',
    ),
  ];

  var boardController = PageController();

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true);
    navigateAndFinish(
      context,
      ShopLoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            text: 'SKIP',
            onPressed: () {
              submit();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    isLast = true;
                  } else {
                    isLast = false;
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5.0,
                  ),
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            model.title,
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            model.body,
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          SizedBox(height: 30.0),
        ],
      );
}
