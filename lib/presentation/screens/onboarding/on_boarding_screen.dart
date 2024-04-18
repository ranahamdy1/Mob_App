import 'package:flutter/material.dart';
import 'package:shop_app/constants/shard.dart';
import 'package:shop_app/data/shared_pref/cash_helper.dart';
import 'package:shop_app/presentation/screens/auth/login_screen.dart';
import 'package:shop_app/presentation/screens/onboarding/onboarding_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  bool isLast = false;
  void submit() {
    CashHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        //navigateAndFinish(context, ShopLoginScreen());
        navigateTo(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            TextButton(
                onPressed: () {
                  submit();
                },
                child: const Text(
                  'SKIP',
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boardingList[index]),
                  controller: boardController,
                  onPageChanged: (int index) {
                    if (index == boardingList.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  physics: const BouncingScrollPhysics(),
                  itemCount: boardingList.length,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boardingList.length,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: Colors.purple,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 2,
                      dotWidth: 15,
                      spacing: 6,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    backgroundColor: Colors.purple,
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
