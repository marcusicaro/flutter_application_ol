class MockAuthService {
  final String _username = 'admin';
  final String _password = 'admin';

  bool login(String username, String password) {
    return username == _username && password == _password;
  }
}
