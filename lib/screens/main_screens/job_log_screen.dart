import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gnb_project/dynamic_widget/utils/colors.dart';
import 'package:gnb_project/dynamic_widget/utils/date_format.dart';
import 'package:gnb_project/provider/job_log_provider.dart';
import 'package:gnb_project/dynamic_widget/dynamic_code/app_bar.dart';
import 'package:provider/provider.dart';

class JobListData extends StatefulWidget {
  @override
  _JobListDataState createState() => _JobListDataState();
}

class _JobListDataState extends State<JobListData> {
  final ScrollController _scrollController = ScrollController();

  bool hasValidationError = false;
  
  @override
  void initState() {
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

  
}
