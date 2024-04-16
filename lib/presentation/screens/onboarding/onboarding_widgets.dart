import 'package:flutter/material.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String body;
  OnBoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

List<OnBoardingModel> boardingList = [
    OnBoardingModel(
      image: 'assets/images/one.png',
      title: 'Choose Products',
      body: 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
    OnBoardingModel(
      image: 'assets/images/two.png',
      title: 'Make Payment',
      body: 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
    OnBoardingModel(
      image: 'assets/images/three.png',
      title: 'Get Your Order',
      body: 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
  ];

  Widget buildBoardingItem(OnBoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(model.image),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          model.title,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          model.body,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );