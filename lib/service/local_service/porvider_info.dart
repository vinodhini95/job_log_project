import 'package:gnb_project/provider/job_log_provider.dart';
import 'package:provider/provider.dart';

class InitiateFlutterPackage {
  getProviderChangeNotifier() {
    var listChangeNotifier = [
      ChangeNotifierProvider(create: (_) => JobLogProvider())
      
    ];
    return listChangeNotifier;
  }
}
