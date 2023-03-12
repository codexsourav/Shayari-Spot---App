import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<File?> fileFromImageUrl(String url, {path, name}) async {
  try {
    final response = await http.get(Uri.parse(url));
    final documentDirectory = await getTemporaryDirectory();
    final file =
        File(join(path ?? documentDirectory.path, name ?? 'Shayari_Spot.png'));
    file.writeAsBytesSync(response.bodyBytes);

    return file;
  } catch (e) {
    print(e);
    return null;
  }
}

Future getDownloadPath() async {
  if (!Platform.isAndroid) {
    var dpath = await getDownloadsDirectory();
    return dpath!.path;
  } else {
    String directory = "/storage/emulated/0/Download/";
    bool dirDownloadExists = await Directory(directory).exists();

    if (dirDownloadExists) {
      return "/storage/emulated/0/Download/";
    } else {
      return "/storage/emulated/0/Downloads/";
    }
  }
}
