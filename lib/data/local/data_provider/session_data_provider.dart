import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

abstract class _Keys {
  static const sessionId = "session_id";
  static const accountId = "account_id";
}

class SessionDataProvider {
  final _secureStorage = GetIt.instance<FlutterSecureStorage>();

  Future<String?> getSessionId() => _secureStorage.read(key: _Keys.sessionId);

  Future<void> setSessionId(String value) {
    return _secureStorage.write(key: _Keys.sessionId, value: value);
  }

  Future<void> deleteSessionId() {
    return _secureStorage.delete(key: _Keys.sessionId);
  }

  Future<int?> getAccountId() async {
    final id = await _secureStorage.read(key: _Keys.accountId);
    return id != null ? int.tryParse(id) : null;
  }

  Future<void> setAccountId(int value) {
    return _secureStorage.write(key: _Keys.accountId, value: value.toString());
  }

  Future<void> deleteAccountId(int? value) {
    return _secureStorage.delete(key: _Keys.accountId);
  }
}
