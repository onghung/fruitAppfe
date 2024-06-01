import 'package:flutter/material.dart';

import '../models/fruit_model.dart';
import '../server/tab_response.dart';
import '../utils/routes.dart';

class VegetableDetailScreen extends StatefulWidget {
  final Fruit fruit;
  const VegetableDetailScreen({Key? key, required this.fruit}) : super(key: key);

  @override
  State<VegetableDetailScreen> createState() => _VegetableDetailScreenState();
}

class _VegetableDetailScreenState extends State<VegetableDetailScreen> {
  int itemCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffF3F5F7),
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 140.0))),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Image.asset(
                            "assets/images/back_icon.png",
                            width: 44,
                            height: 44,
                          ),
                        ),
                        Image.asset(
                          "assets/images/search_icon.png",
                          width: 44,
                          height: 44,
                          color: Colors.transparent,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  FractionallySizedBox(
                    alignment: Alignment.center,
                    widthFactor: 0.6,
                    child: Container(
                      child: Image.network(
                        widget.fruit.imgurl??"",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                ]),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.fruit.name??"",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              InkWell(
                                onTap: (() {
                                  setState(() {
                                    itemCount++;
                                  });
                                }),
                                child: Image.asset(
                                  "assets/images/add_icon.png",
                                  width: 32,
                                  height: 32,
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                "$itemCount",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (itemCount > 1) itemCount--;
                                  });
                                },
                                child: Image.asset(
                                  "assets/images/remove_icon.png",
                                  width: 32,
                                  height: 32,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text("1kg, ${widget.fruit.price} nghìn",
                        style: TextStyle(
                            color: Color(0xffFF324B),
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      widget.fruit.discription??"",
                      style: TextStyle(
                          color: Color(0xff979899),
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Row(
                      children: [
                        _itemKeyPointsView(
                            "assets/images/organic.png", "${widget.fruit.organic}", "Organic"),
                        SizedBox(
                          width: 8,
                        ),
                        _itemKeyPointsView("assets/images/expiration.png",
                            "${widget.fruit.baoquan}", "Expiration")
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        _itemKeyPointsView(
                            "assets/images/reviews.png", "${widget.fruit.start}", "Reviews"),
                        SizedBox(
                          width: 8,
                        ),
                        _itemKeyPointsView(
                            "assets/images/calories.png", "80", "100 Gram")
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FractionallySizedBox(
                      widthFactor: 1,
                      child: ElevatedButton(
                          onPressed: () async {
                            try {
                              // Assuming you have access to the user's email address
                              // and the fruit object
                              await TabRepository().addCart(user_email, widget.fruit, itemCount);
                              // Navigate to the cart screen or show a success message
                              Navigator.pushNamed(context, MyRoutes.cartRoute);
                            } catch (e) {
                              // Handle errors, such as displaying an error message
                              print('Error adding item to cart: $e');
                            }
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            textStyle: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                            shape: StadiumBorder(),
                            backgroundColor: Color(0xff23AA49),
                          ),
                          child: Text("Add to cart")),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemKeyPointsView(String imagePath, String title, String desc) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            border: Border.all(color: Color(0xffF1F1F5))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 40,
              height: 40,
            ),
            SizedBox(
              width: 16,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff23AA49)),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(desc,
                    style: TextStyle(fontSize: 14, color: Color(0xff979899))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
