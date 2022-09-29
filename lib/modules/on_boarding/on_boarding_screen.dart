import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image = 'assets/onboarding.png';

  late final String title;

  late final String body;

  BoardingModel({required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(title: 'Title One', body: 'Body One'),
    BoardingModel(title: 'Title Two', body: 'Body Two'),
    BoardingModel(title: 'Title Three', body: 'Body Three'),
  ];

  PageController pageViewController = PageController();

    void submit(){
      CacheHelper.saveData(key:'onBoarding', value: true).then((value) {
        if(value==true) {
          navigateToReplacement(context, LoginScreen());
        }
      });

    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submit,
              child: Text('SKIP'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, i) => buildOnBoarding(boarding[i]),
                physics: const BouncingScrollPhysics(),
                controller: pageViewController,
                itemCount: boarding.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageViewController,
                  count: boarding.length,
                  onDotClicked: (i) {
                    pageViewController.animateToPage(i,
                        duration: Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn);
                  },
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Colors.deepOrange,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                    child: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      if (pageViewController.page?.ceil() == boarding.length - 1) {
                        submit();
                      } else {
                        pageViewController.nextPage(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    })
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildOnBoarding(BoardingModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage(model.image),
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          model.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          model.body,
          style: const TextStyle(fontSize: 18),
        )
      ],
    );
  }


}
