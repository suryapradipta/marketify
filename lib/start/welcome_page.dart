import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketify/routes/route_helper.dart';


import '../../utils/colors.dart';
import '../controllers/popular_product_controller.dart';
import '../controllers/recommended_product_controller.dart';
import 'widgets/app_large_text.dart';
import 'widgets/app_text.dart';
import 'widgets/responsive_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  var images = {
    "assets/image/welcome1.png":"Develop an iOS-based application that assists reduce food loss and waste by streamlining the food supply chain.",
    "assets/image/welcome2.png":"This app will connect retailers to customers with overstock, product that isn't \"beautiful\" enough for the shelves, and products with damaged packaging that is still securely closed.",
    "assets/image/welcome3.png":"Through this application, retailers and customers may perform sales, purchases, payments, and shipment.",
  };

  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  void initState() {
    super.initState();
    _loadResource();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          onPageChanged: (index){

          },
          scrollDirection: Axis.vertical,
          itemCount: images.length,
          itemBuilder: (_, index){
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          images.keys.elementAt(index)
                      ),
                      fit: BoxFit.cover
                  )
              ),
              child: Container(
                  margin: const EdgeInsets.only(top:150, left: 20, right: 20),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppLargeText(text: "Our"),
                          AppText(text: "Aims & Objectives", size: 30,),
                          SizedBox(height: 20,),
                          Container(
                            width: 250,
                            child: AppText(
                              text:images.values.elementAt(index),
                              color:AppColors.textColor,
                              size: 14,
                            ),
                          ),
                          SizedBox(height: 40,),
                          GestureDetector(
                            onTap: (){
                              Get.toNamed(RouteHelper.getInitial());
                            },
                            child: Container(
                                width: 200,
                                child: Row(children:[ ResponsiveButton(width: 120,)])
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: List.generate(3, (indexDots){
                          return Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            width: 8,
                            height: index==indexDots?25:8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color:index==indexDots?AppColors.mainColor:AppColors.mainColor.withOpacity(0.3)
                            ),
                          );
                        }),
                      )
                    ],
                  )
              ),
            );
          }),
    );
  }
}