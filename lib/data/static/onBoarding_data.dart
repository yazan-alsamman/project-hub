import 'package:junior/core/constant/imageassets.dart';
import 'package:junior/data/Models/onBoarding.dart';

List<onBoardingModel> onBoardingList = [
  onBoardingModel(
    //page one
    title: "Create Your Task",
    body: "Create your task to make sure every task is completed on time.",
    image: AppImageAsset.onBoardingImageOne,
  ),
  //page two
  onBoardingModel(
    title: "Track Your Progress",
    body:
        "Track your progress to make sure you are on track to complete your tasks.",
    image: AppImageAsset.onBoardingImageTwo,
  ),
  //page three
  onBoardingModel(
    title: "Get Rewarded",
    body:
        "Get rewarded for completing your tasks and get closer to your goals.",
    image: AppImageAsset.onBoardingImageThree,
  ),
  //page four
  /*onBoardingModel(
    title: "Fast Delivery",
    body:
        "Reliable And Fast Delivery.We\nDeliver your product the fastest\nway possible.",
    image: AppImageAsset.onBoardingImageFour,
  ),
  */
];
