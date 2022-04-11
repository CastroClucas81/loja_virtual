import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(),
                  ),
                );
              },
              child: Text(
                "Criar conta",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(
                child: CircularProgressIndicator(),
              );

            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "E-mail",
                    ),
                    validator: (text) {
                      if (text!.isEmpty || !text.contains("@"))
                        return "E-mail inválido.";
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Senha",
                    ),
                    validator: (text) {
                      if (text!.isEmpty || text.length < 6)
                        return "Senha inválida";
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        "Esqueci minha senha",
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      //if (_formKey.currentState!.validate()) {}

                      model.signIn();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      "Entrar",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
