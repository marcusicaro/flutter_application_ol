class MockAuthService {
  String _username = 'admin';
  String _password = 'admin';

  Future<bool> login(String username, String password) async {
    return username == _username && password == _password;
  }
}
