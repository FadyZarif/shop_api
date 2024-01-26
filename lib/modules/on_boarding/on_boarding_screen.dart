import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  late final String image ;

  late final String title;

  late final String body;

  BoardingModel( {required this.image,required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(image: 'assets/onboarding.png',title: 'Choose Product', body: 'You Can Easily Find The Product You Want From Our Various Products!'),
    BoardingModel(image: 'assets/onBoarding2.png',title: 'Choose a Payment Method', body: 'We Have Many Payment Methods Supported', ),
    BoardingModel(image: 'assets/onboarding3.png',title: 'Get Your Order', body: 'Open The Doors, Your Order is Now Ready For You!'),
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
              child: Text('SKIP',style: TextStyle(color: Colors.deepOrange),))
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
                    child: const Icon(Icons.arrow_forward,color: Colors.white),
                    backgroundColor: Colors.deepOrange,
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
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.deepOrange),
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
