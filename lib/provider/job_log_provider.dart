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
  List<Propertylist> _listProperties = [];
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
  RangeValues _priceRange = RangeValues(50000, 200000);
  RangeValues get priceRange => _priceRange;
  final List<String> locations = [
    'Hillview',
    'Metrocity',
    'Beachside',
    'Townsburg'
  ];
  String _selectedLocationValue = "Hillview";
  String get selectedLocationValue => _selectedLocationValue;
  final List<String> tags = ['New', 'Available', 'Furnished', 'Luxury'];
  String _selectedTagsValue = "Furnished";
  String get selectedTagsValue => _selectedTagsValue;
  final List<String> status = ['Sold', 'Available'];
  String _selectedstatusValue = "Available";
  String get selectedstatusValue => _selectedstatusValue;
  //fetch Data from the server and store in provider method
  Future<List<JobLogmodel>> fetchJobLogs() async {
    if (_isLoading || !_hasMore) return _listJobLogs;

    _isLoading = true;

    try {
      final data = await _apiService.fetchJobLogs(currentPage, 20);

      if (data['response'] != null && data['response']['logs'] != null) {
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
  setPriceRange(RangeValues rangeValue) {
    _priceRange = rangeValue;
    notifyListeners();
  }

  //set location Value
  setLocation(String selectedValue) {
    _selectedLocationValue = selectedValue;
    notifyListeners();
  }

  //set tags  Value
  setTags(String selectedValue) {
    _selectedTagsValue = selectedValue;
    notifyListeners();
  }

  //set status  Value
  setStatus(String selectedValue) {
    _selectedstatusValue = selectedValue;
    notifyListeners();
  }

  //added property
  addeProperty(Property property) {
    _listProperty.add(property);
    notifyListeners();
  }

  Future<List<Propertylist>> getPropertyList() async {
    if (_isPropertyLoading || !_hasPropertyMore) return _listProperties;

    _isPropertyLoading = true;

    try {
      final data =
          await _apiService.fetchPropertylist(currentPropertyPage, pageSize);

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

  filterData() async {
    try {
      currentPropertyPage = 1;
      final data = await _apiService.fetchfilterPropertylist(
          priceRange.start,
          priceRange.end,
          selectedLocationValue,
          selectedTagsValue,
          selectedstatusValue,
          currentPropertyPage,
          pageSize);
      if (data['properties'] != null) {
        final List<dynamic> newProperties = data['properties'];
        if(newProperties.isEmpty){
          _listProperties = [];
        }
        for (var property in newProperties) {
          _listProperties.add(Propertylist.fromJson(property));
        }
      }
      return _listProperties;
    } catch (e) {
      return _listProperties;
    } finally {
      notifyListeners();
    }
  }
}
