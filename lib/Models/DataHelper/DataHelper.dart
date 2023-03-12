// ignore: file_names
import '../ApiHelper/Airtable.dart';
import '../Storage/LocalDb.dart';

class DataHelper {
  var localDataBase = LocalDatabase.instense;
  var airtableApi = AirtableDb.instense;

  Future getDataBase({fldname = 'Public'}) async {
    try {
      var data = await localDataBase.getOnLocal(key: fldname);

      if (data.isEmpty) {
        var dbData = await airtableApi.getApiData(tblname: fldname);
        await localDataBase.setDataLocal(key: fldname, data: dbData);
        return dbData;
      } else {
        return data;
      }
    } catch (e) {
      if (e.toString() == "Failed host lookup: 'api.airtable.com'") {
        return ['error', 'Chack Your Internet'];
      } else {
        return ['error', 'Sumthing Want Wrong!'];
      }
    }
  }

  Future refreshData({fldname = 'Public'}) async {
    try {
      List dbData = await airtableApi.getApiData(tblname: fldname);
      await localDataBase.setDataLocal(key: fldname, data: dbData);
      return dbData;
    } catch (e) {
      if (e.toString() == "Failed host lookup: 'api.airtable.com'") {
        return ['error', 'Chack Your Internet'];
      } else {
        return ['error', 'Sumthing Want Wrong!'];
      }
    }
  }
}
