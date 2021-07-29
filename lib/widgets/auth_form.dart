import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn);

  final void Function(String email, String username, String password,
      bool isLogin, BuildContext ctx) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = false;
  var _email = '';
  var _user = '';
  var _password = '';

  void _trySubmit() {
    bool _isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (_isValid) {
      _formKey.currentState.save();
      widget.submitFn(
          _email.trim(), _user.trim(), _password.trim(), _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(8),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@'))
                        return 'Please Enter a valid Email Address';
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                    ),
                    onSaved: (newValue) => _email = newValue,
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('user'),
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Please Enter a valid Usename';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                      onSaved: (newValue) => _user = newValue,
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 6)
                        return 'Please Enter a valid Password';
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    onSaved: (newValue) => _password = newValue,
                    obscureText: true,
                  ),
                  SizedBox(height: 12),
                  RaisedButton(
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                      onPressed: () {
                        print(_isLogin);
                        _trySubmit();
                      }),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(_isLogin
                        ? 'Create a account'
                        : 'Already have an account'),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
