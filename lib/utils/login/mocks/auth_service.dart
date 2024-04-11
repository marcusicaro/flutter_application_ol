class MockAuthService {
  String _username = 'admin';
  String _password = 'admin';

  bool login(String username, String password) {
    return username == _username && password == _password;
  }
}
