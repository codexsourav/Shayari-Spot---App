import 'package:localstorage/localstorage.dart';

class FavImagesLocalDb {
  final LocalStorage storage = LocalStorage('fevourite');

  FavImagesLocalDb._privateCostractor();

  static final FavImagesLocalDb instense =
      FavImagesLocalDb._privateCostractor();

// for get storage data
  Future getSaved() async {
    if (storage.getItem('savedimg') == null) {
      await storage.setItem('savedimg', []);
      return [];
    } else {
      return storage.getItem('savedimg');
    }
  }

// for add new data
  Future addSaved(data) async {
    var storedata = await getSaved();
    storedata.add(data);
    storage.setItem('savedimg', storedata);
  }

// for delete data
  Future deleteData(id) async {
    var storedata = await getSaved();
    storedata.removeWhere((item) => item['id'] == id);
    storage.setItem('savedimg', storedata);
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
