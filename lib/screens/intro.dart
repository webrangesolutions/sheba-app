import 'package:flutter/material.dart';
import 'package:sheba_financial/utils/color_constants.dart';
import 'package:sheba_financial/utils/route_helper.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int _currentSlide = 0;

  final List<IntroSlider> _slides = [
    IntroSlider(
      image: 'assets/images/receipts.png',
      text: 'Say goodbye to paper receipts and bank statements',
    ),
    IntroSlider(
      image: 'assets/images/chart.png',
      text: 'Monitor your daily spending',
    ),
    IntroSlider(
      image: 'assets/images/location.png',
      text: 'Easily access your receipts anywhere',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: PageView.builder(
                itemCount: _slides.length,
                itemBuilder: (BuildContext context, int index) {
                  return _slides[index % _slides.length];
                },
                onPageChanged: (int index) {
                  setState(() {
                    _currentSlide = index;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                _slides.length,
                (int index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: 10.0,
                    width: 10,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: _currentSlide == index
                          ? Colors.white
                          : Color.fromARGB(255, 175, 175, 175),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RouteHelper.homeRoute);
                          },
                          child: Text(
                            'Get Started',
                            style: TextStyle(color: AppColors.primaryColor),
                          ),
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteHelper.loginRoute);
                          },
                          child: const Text('Login'),
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.primaryColor),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(
                                  color: Colors.white,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IntroSlider extends StatelessWidget {
  final String image;
  final String text;

  IntroSlider({required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 60,
          ),
          Image.asset(
            height: 200,
            image,
          ),
          const SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 80.0,
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
