import 'package:localstorage/localstorage.dart';

class FavLocalDb {
  final LocalStorage storage = LocalStorage('fevourite');

  FavLocalDb._privateCostractor();

  static final FavLocalDb instense = FavLocalDb._privateCostractor();

// for get storage data
  Future getSaved() async {
    if (storage.getItem('saved') == null) {
      await storage.setItem('saved', []);
      return [];
    } else {
      return storage.getItem('saved');
    }
  }

// for add new data
  Future addSaved(data) async {
    var storedata = await getSaved();
    storedata.add(data);
    storage.setItem('saved', storedata);
  }

// for delete data
  Future deleteData(id) async {
    var storedata = await getSaved();
    storedata.removeWhere((item) => item['id'] == id);
    storage.setItem('saved', storedata);
  }

// for chack data exist on favraites
  Future chackexistondb(sid) async {
    List alldata = await getSaved();
    if (alldata.isNotEmpty && alldata != null) {
      for (var data in alldata) {
        if (data['id'] == sid) {
          return data['id'];
        }
      }
    }
    return false;
  }
}
