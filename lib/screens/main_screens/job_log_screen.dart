import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gnb_project/dynamic_widget/utils/colors.dart';
import 'package:gnb_project/dynamic_widget/utils/date_format.dart';
import 'package:gnb_project/dynamic_widget/utils/helper_service.dart';
import 'package:gnb_project/provider/job_log_provider.dart';
import 'package:gnb_project/dynamic_widget/dynamic_code/app_bar.dart';
import 'package:provider/provider.dart';

class JobListData extends StatefulWidget {
  @override
  _JobListDataState createState() => _JobListDataState();
}

class _JobListDataState extends State<JobListData> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  bool shows = false;
  DateTime? _startDate;
  DateTime? _endDate;
  bool hasValidationError = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _startDate = DateTime.now();
    _endDate = DateTime.now();
    super.initState();
    final provider = Provider.of<JobLogProvider>(context, listen: false);
    provider.fetchJobLogs();

    _scrollController.addListener(() {
      final provider = Provider.of<JobLogProvider>(context, listen: false);
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !provider.isLoading &&
          provider.hasMore) {
        provider.fetchJobLogs();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backButton: true,
        appBar: AppBar(),
        title: "Job List",
        onTap: () {
          setState(() {
            shows = true;
          });

          HelperService().showAdvanceFilter(
            context,
            _formKey,
            _startDateController,
            _endDateController,
            () async {
              await selectDate(context, _startDateController, _startDate);
              // fetchData(equipmentType);
            },
            (value) {
              if (value == null || value.isEmpty) {
                if (_endDateController.text.isEmpty) {
                  hasValidationError = true;
                  return 'Please select an end date';
                }
              }
              if (_endDateController.text.isNotEmpty && value!.isNotEmpty) {
                DateTime startDate = allDynamicDateFormat.parse(value);
                DateTime endDate = allDynamicDateFormat.parse(
                  _endDateController.text,
                );
                if (endDate.isBefore(startDate)) {
                  hasValidationError = true;
                  return 'Start date should be before end date';
                }
              }
              hasValidationError = false;
              return null;
            },
            () async {
              await selectDate(context, _endDateController, _endDate);
            },
            (value) {
              if (value == null || value.isEmpty) {
                hasValidationError = true;
                return 'Please select an end date';
              }
              if (_startDateController.text.isNotEmpty && value.isNotEmpty) {
                DateTime startDate = allDynamicDateFormat.parse(
                  _startDateController.text,
                );
                DateTime endDate = allDynamicDateFormat.parse(value);

                if (startDate.isAfter(endDate)) {
                  hasValidationError = true;
                  return 'End date should be after the start date';
                }
              }
              hasValidationError = false;
              return null;
            },
            () {
              if (_formKey.currentState!.validate()) {
                // Perform any necessary action before closing the dialog
                // fetchData();
                shows = true;
                Navigator.of(context).pop(); // Close the dialog
              }
            },
          );
        },
        onTap1: shows
            ? () {
                setState(() {
                  shows = false;
                });
              }
            : null,
      ),
      body: Consumer<JobLogProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            controller: _scrollController,
            itemCount:
                provider.listJobLogs.length + (provider.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < provider.listJobLogs.length) {
                final log = provider.listJobLogs[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Postcode: ${log.postcode ?? "-"}'),
                        Text('Machine ID: ${log.machineId ?? "-"}'),
                        Text('Start Date: ${formatDate(log.startAt)}'),
                        Text('End Date: ${formatDate(log.endAt)}'),
                        Text('Status: ${log.status ?? "-"}'),
                      ],
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: provider.hasMore
                        ? Center(
                            child: CupertinoActivityIndicator(
                              radius: 20.0,
                              animating: true,
                              color: globalColor,
                            ),
                          )
                        : const Text('No more data'),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  Future<void> selectDate(
    BuildContext context,
    TextEditingController controller,
    DateTime? initialDate,
  ) async {
    DateTime? pickedDate = await HelperService().selectDatePicker(context);

    if (pickedDate != null) {
      setState(() {
        if (controller == _startDateController) {
          _startDate = pickedDate;
          _endDate = _endDate ?? pickedDate;
        } else if (controller == _endDateController) {
          _endDate = pickedDate;
        }
        // Format the picked date to show only the date
        controller.text = allDynamicDateFormat.format(pickedDate);
        _formKey.currentState!.validate();
      });
    }
  }
}
