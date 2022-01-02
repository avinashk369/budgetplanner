import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/models/promotion_model.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/loading_ui.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PromotionalScreen extends StatefulWidget {
  const PromotionalScreen({Key? key}) : super(key: key);

  @override
  _PromotionalScreenState createState() => _PromotionalScreenState();
}

class _PromotionalScreenState extends State<PromotionalScreen> {
  final transactionController = TransactionEntryController.to;
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 1);

  int _currentPage = 0;
  List<Widget> _buildPageIndicator(int limit) {
    List<Widget> list = [];
    for (int i = 0; i < limit; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: 6.0,
      width: isActive ? 20.0 : 6.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.grey[700] : Colors.grey[400],
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => transactionController.isLoading() ||
              transactionController.promotions.isEmpty
          ? SizedBox()
          : Column(
              children: [
                Container(
                  height: Get.height * .22,
                  child: Stack(
                    children: [
                      PageView.builder(
                        itemCount: transactionController.promotions.length,
                        controller: _pageController,
                        pageSnapping: true,
                        itemBuilder: (BuildContext context, int index) {
                          PromotionModel promotionModel =
                              transactionController.promotions[index];

                          return InkWell(
                            onTap: () => _launchURL(promotionModel.srcUrl!),
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: Colors.transparent,
                              child: Container(
                                width: Get.width,
                                child: Stack(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: promotionModel.imgUrl!,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            // colorFilter: ColorFilter.mode(
                                            //     Colors.purple, BlendMode.colorBurn),
                                          ),
                                        ),
                                      ),
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: LoadingUI(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Spacer(
                                            flex: 4,
                                          ),
                                          SizedBox(
                                            width: Get.width * .6,
                                            child: Text(
                                              promotionModel.title!,
                                              style: kLabelStyleBold.copyWith(
                                                  fontSize: 18,
                                                  color: whiteColor),
                                            ),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.favorite,
                              size: 18,
                              color: Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  width: Get.width * .8,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent, width: 0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: _buildPageIndicator(
                        transactionController.promotions.length),
                  ),
                ),
              ],
            ),
    );
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
