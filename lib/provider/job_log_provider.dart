// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:gnb_project/model/property_list_model.dart';
import 'package:gnb_project/model/property_model.dart';
import 'package:gnb_project/service/service_file/api_service.dart';

import '../model/job_log_model.dart';

class JobLogProvider extends ChangeNotifier {

  ApiService _apiService = ApiService();

   // set variable for serach list
  List<JobLogmodel> searchJobModel = [];
  List<JobLogmodel> get _searchJobModel => searchJobModel;

  //set variable for list of joblogs
  final List<JobLogmodel> _listJobLogs = [];
  List<JobLogmodel> get listJobLogs => _listJobLogs;

  //set variable for list of joblogs
  final List<Propertylist> _listProperties = [];
  List<Propertylist> get listProperties => _listProperties;
  final List<Property> _listProperty = [];
  List<Property> get listProperty => _listProperty;

  int currentPage = 1;
  int currentPropertyPage = 1;
  int pageSize = 20;
  bool _isLoading = false;
  bool _hasMore = true;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  bool _isPropertyLoading = false;
  bool _hasPropertyMore = true;
  bool get isPropertyLoading => _isPropertyLoading;
  bool get hasPropertyMore => _hasPropertyMore;
  RangeValues _priceRange = RangeValues(1, 10);
  RangeValues get priceRange => _priceRange;
  final List<String> locations = ['Mumbai', 'Delhi', 'Bangalore', 'Chennai'];
  String _selectedLocationValue = "Chennai";
  String get selectedLocationValue => _selectedLocationValue;

  //fetch Data from the server and store in provider method
  Future<List<JobLogmodel>> fetchJobLogs() async {
    if (_isLoading || !_hasMore) return _listJobLogs;

    _isLoading = true;

    try {
      final data = await _apiService.fetchJobLogs(currentPage, 20);

      if (data['response'] != null &&
          data['response']['logs'] != null) {
        final List<dynamic> newLogs = data['response']['logs'];
        for (var jobLog in newLogs) {
           _listJobLogs.add(JobLogmodel.fromJson(jobLog));
        }
       
        currentPage++;

        if (newLogs.isEmpty || newLogs.length < 20) {
          _hasMore = false;
        }
      } else {
        _hasMore = false;
      }
      return _listJobLogs;
    } catch (e) {
      return _listJobLogs;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  //set price Range Value
  setPriceRange(RangeValues rangeValue){
   _priceRange = rangeValue;
   notifyListeners();
  }
 //set price Range Value
  setLocation(String selectedValue){
   _selectedLocationValue = selectedValue;
   notifyListeners();
  }

  //added property
  addeProperty(Property property){
    _listProperty.add(property);
    notifyListeners();
  }

 Future<List<Propertylist>> getPropertyList()async{
    if (_isPropertyLoading || !_hasPropertyMore) return _listProperties;

    _isPropertyLoading = true;

    try {
      final data = await _apiService.fetchPropertylist(currentPropertyPage, pageSize);

      if (data['properties'] != null) {
        final List<dynamic> newProperties = data['properties'];
        for (var property in newProperties) {
           _listProperties.add(Propertylist.fromJson(property));
        }
       
        currentPropertyPage++;

        if (newProperties.isEmpty || newProperties.length < pageSize) {
          _hasPropertyMore = false;
        }
      } else {
        _hasPropertyMore = false;
      }
      return _listProperties;
    } catch (e) {
      return _listProperties;
    } finally {
      _isPropertyLoading = false;
      notifyListeners();
    }
  }
  }

