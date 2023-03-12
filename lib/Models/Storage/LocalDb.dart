import 'package:localstorage/localstorage.dart';

class LocalDatabase {
  final LocalStorage storage = LocalStorage('database');
  LocalDatabase._privateCostractor();

  static final LocalDatabase instense = LocalDatabase._privateCostractor();

// get data from local
  Future getOnLocal({key}) async {
    try {
      if (storage.getItem(key) == null) {
        await storage.setItem(key, []);
        return [];
      } else {
        return storage.getItem(key);
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

// set data on local
  Future setDataLocal({key = 'public', data}) async {
    await storage.setItem(key, data);
    return data;
  }

  // delete data
  Future removeDataLocal({key, data}) async {
    await storage.deleteItem(key);
    return true;
  }
}
