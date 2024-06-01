import 'package:flutter/material.dart';

import '../../../server/tab_response.dart';
import '../../../utils/routes.dart';


class Splash extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TabRepository _repository = TabRepository();

  @override
  Widget build(BuildContext context) {
    Widget _buildEmail() {
      return Container(
        height: 50,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              offset: Offset(3, 3), blurRadius: 6, color: Colors.grey.shade400)
        ]),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Hãy nhập email của bạn";
            }
            return null;
          },
          controller: emailController,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.email_outlined),
              hintText: "Nhập email của bạn"),
        ),
      );
    }

    Widget _buildPassword() {
      return Container(
        height: 50,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              offset: Offset(3, 3), blurRadius: 6, color: Colors.grey.shade400)
        ]),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Hãy nhập mật khẩu của bạn";
            }
            return null;
          },
          controller: passwordController,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.lock_outline_rounded),
              hintText: "Nhập mật khẩu của bạn"),
        ),
      );
    }

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 220,
                        left: 30,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Đăng nhập",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 26),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Đăng nhập để tiếp tục",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 17),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 25,),
                      _buildEmail(),
                      const SizedBox(height: 25,),
                      _buildPassword(),
                      const SizedBox(height: 25,),
                      ElevatedButton(
                        onPressed: () async {
                          await _repository.login(
                            emailController.text,
                            passwordController.text,
                          );
                          Navigator.pushNamed(context, MyRoutes.dashboardRoute);
                        },
                        child: Text("Đăng nhập"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}
