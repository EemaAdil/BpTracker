import 'package:bptracker/utils/export.dart';

class UnbordingContent {
  String? image;
  String? title;
  String? subTitle;

  UnbordingContent({
    this.image,
    this.title,
    this.subTitle,
  });
}

List<UnbordingContent> contents = [
  UnbordingContent(
    image: AppAssets().imgOnBoarding1,
    title: AppConstants().onBoardingTitle1,
    subTitle: AppConstants().onBoardingSub1,
  ),
  UnbordingContent(
    image: AppAssets().imgOnBoarding2,
    title: AppConstants().onBoardingTitle2,
    subTitle: AppConstants().onBoardingSub2,
  ),
  UnbordingContent(
    image: AppAssets().imgOnBoarding3,
    title: AppConstants().onBoardingTitle3,
    subTitle: AppConstants().onBoardingSub3,
  ),
];
