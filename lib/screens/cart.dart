import 'package:flutter/material.dart';
import 'package:fruit_app/models/cart_model.dart';
import 'package:http/http.dart' as http;
import '../controller/fruit_controller.dart';
import '../widgets/cart_item.dart';// Import CartController
import 'package:url_launcher/url_launcher.dart';


class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  final Controller _controller = Controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cart",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Image.asset(
            "assets/images/back_icon.png",
            scale: 2.2,
          ),
        ),
      ),
      body: FutureBuilder<List<Cart>>(
        future: _controller.fetchCarts(), // Gọi hàm fetchCarts từ CartController để lấy danh sách giỏ hàng từ API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text('Your cart is empty'),
              );
            } else {
              return Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Cart cartItem = snapshot.data![index];
                        return CartItemWidget(
                          item: cartItem,
                        );
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Make a request to your API endpoint
                      // Assuming you are using the http package for making HTTP requests
                      // Replace 'http://localhost:8080/pay' with your actual API endpoint
                      http.get(Uri.parse('http://10.0.2.2:8080/pay'))
                          .then((response) {
                        // Handle successful response
                        if (response.statusCode == 200) {
                          // Assuming the response contains the URL to redirect to
                          String url = response.body;
                          // Open the URL in a web browser
                          launch(url);
                        } else {
                          // Handle other status codes
                          print('Failed to get URL: ${response.body}');
                        }
                      })
                          .catchError((error) {
                        // Handle errors
                        print('Error fetching URL: $error');
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FractionallySizedBox(
                            widthFactor: 1,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                textStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                                shape: StadiumBorder(),
                                backgroundColor: Color(0xff23AA49),
                              ),
                              child: Text("Checkout"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          } else {
            return Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}
