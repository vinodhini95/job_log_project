import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gnb_project/dynamic_widget/utils/helper_service.dart';

class AnalyticsManager {
  static final AnalyticsManager _instance = AnalyticsManager._internal();
  factory AnalyticsManager() => _instance;
  AnalyticsManager._internal();

  final Map<String, int> _viewCounts = {};
  final Map<String, Duration> _timeSpent = {};
  final Map<String, int> _clickCounts = {};


 //log view method
  void logView(String propertyId) {
    _viewCounts[propertyId] = (_viewCounts[propertyId] ?? 0) + 1;
    if (kDebugMode) {
      print('Property $propertyId viewed ${_viewCounts[propertyId]} times');
    }
  }
//log Time Spent Method
  void logTimeSpent(String propertyId, Duration duration) {
    _timeSpent[propertyId] = (_timeSpent[propertyId] ?? Duration.zero) + duration;
    if (kDebugMode) {
      print('Time spent on $propertyId: ${_timeSpent[propertyId]}');
    }
  }
// how many time logclicked method
  void logClick(String elementId) {
    _clickCounts[elementId] = (_clickCounts[elementId] ?? 0) + 1;
    if (kDebugMode) {
      print('Element $elementId clicked ${_clickCounts[elementId]} times');
    }
  }
//print summary in tost Message
  void printSummary(BuildContext context) {
     HelperService()
            .showTostMessage("${'Views: $_viewCounts'}${'Time Spent: $_timeSpent'}${'Clicks: $_clickCounts'}", context);
    if (kDebugMode) {
      print('--- Analytics Summary ---');
      print('Views: $_viewCounts');
      print('Time Spent: $_timeSpent');
      print('Clicks: $_clickCounts');
    }
   
  }
}
