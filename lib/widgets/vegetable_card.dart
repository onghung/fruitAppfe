import 'package:flutter/material.dart';

import '../controller/fruit_controller.dart';
import '../models/fruit_model.dart';
import '../screens/vegetable_detail.dart';

class FruitSection extends StatelessWidget {
  final Controller _controller = Controller();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: null,
            child: FutureBuilder<List<Fruit>>(
              future: _controller.fetchFruits(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Fruit fruit = snapshot.data![index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => VegetableDetailScreen(
                              fruit: fruit,
                            ),
                          ),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      blurRadius: 5,
                                      offset: Offset(8, 8),
                                      spreadRadius: 1,
                                    )
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    fruit.imgurl ?? "",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                fruit.name ?? "",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Text('No data available');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
