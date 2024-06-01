import 'package:dio/dio.dart';
import 'dart:async';

import 'package:fruit_app/server/server_setting.dart';

import '../models/cart_model.dart';
import '../models/fruit_model.dart';

String user_email="";

class TabRepository {
  final _api = "${ServerSetting.getBaseUrl()}/api";
  Dio dio = Dio();

  Future<List<Fruit>> fetchBooks() async {
    try {
      Response response = await dio.get('$_api/fruit');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Fruit.fromJson(json)).toList();
      } else {
        // Nếu mã trạng thái không phải là 200, xử lý lỗi
        print('Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error: $e');
      return [];
    }
  }

  Future<List<Cart>> fetchCart() async {
    try {
      Response response = await dio.get('$_api/cart');
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data;
        List<Cart> carts = responseData.map((json) => Cart.fromJson(json)).toList();
        return carts;
      } else {
        throw 'Failed to load carts';
      }
    } catch (e) {
      throw 'Error: $e';
    }
  }


  Future<Map<String, dynamic>> login( email,  password) async {
    try {
      final response = await dio.post(
        '$_api/signin',
        data: {
          "email": "$email",
          "password": "$password",
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        user_email= '$email';
        // Ensure response.data is a Map<String, dynamic>
        if (response.data is Map<String, dynamic>) {
          return response.data;
        } else {
          throw Exception('Response data format is invalid');
        }
      } else {
        throw Exception('Failed to login');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Error response data: ${e.response?.data}');
        if (e.response?.data is Map<String, dynamic>) {
          throw Exception('Failed to login: ${e.response?.data['error']}');
        } else {
          throw Exception('Failed to login: Unexpected response format');
        }
      } else {
        throw Exception('Failed to login: ${e.message}');
      }
    }
  }

  Future<void> addCart(String userEmail, Fruit fruit, int itemCount) async {
    try {
      final response = await dio.post(
        '$_api/cart',
        data: {
          // Assuming cart data is sent in a format that matches the server's expectations
          // Adjust this based on your server's requirements
          "user": userEmail,
          "name": fruit.name,
          "quantity": itemCount,
          "imgurl": fruit.imgurl,
          "price": fruit.price,
          "status": '0', // Add other cart properties as needed
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        // Handle successful response
        // You may want to return some data from the server or perform other actions
      } else {
        // Handle other status codes
        throw Exception('Failed to add cart: ${response.statusCode}');
      }
    } catch (e) {
      // Handle errors
      print('Failed to add cart: $e');
      throw Exception('Failed to add cart: $e');
    }
  }


}

