
import 'package:gnb_project/service/service_file/config.dart';
import 'package:gnb_project/service/service_file/dynamic_api_service.dart';

class ApiService {
     DynamicApiService dynamicApiService = DynamicApiService(); 
  //fet data from server side method
  Future<Map<String, dynamic>> fetchJobLogs(int page, int limit) async {
    try {
     var data = {
       'page': page,
       'limit': limit,
     };
     var response = await dynamicApiService.postMethod(jobLogUrl, data);
     return response;
    }catch(error){
       return {
        "response": null
      };
    }
    
  }

   //fet data from server side method
  Future<Map<String, dynamic>> fetchPropertylist(int page, int limit) async {
    try {
     var url = "$property?page=$page&page_size=$limit";
     var response = await dynamicApiService.get(url);
     return response;
    }catch(error){
       return {
        "response": null
      };
    }
    
  }
}
