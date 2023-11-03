import 'package:shared_preferences/shared_preferences.dart';

class DataService {
  final String _dataListKey = 'dataList';

  Future<void> addData(String newData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> dataList = prefs.getStringList(_dataListKey) ?? [];
    dataList.add(newData);
    await prefs.setStringList(_dataListKey, dataList);
  }

  Future<List<String>> getDataList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_dataListKey) ?? [];
  }

  Future<void> editData(int index, String updatedData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> dataList = prefs.getStringList(_dataListKey) ?? [];
    if (index >= 0 && index < dataList.length) {
      dataList[index] = updatedData;
      await prefs.setStringList(_dataListKey, dataList);
    }
  }

  Future<void> deleteData(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> dataList = prefs.getStringList(_dataListKey) ?? [];
    if (index >= 0 && index < dataList.length) {
      dataList.removeAt(index);
      await prefs.setStringList(_dataListKey, dataList);
    }
  }
}
