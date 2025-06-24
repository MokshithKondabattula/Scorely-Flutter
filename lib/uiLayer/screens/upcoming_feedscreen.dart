import 'package:flutter/material.dart';
import 'package:scorely/dataLayer/models/response.dart';
import 'package:scorely/dataLayer/services/remote_api.dart';
import 'package:scorely/core/loading_indicator.dart';
import 'package:scorely/utils/date_time_utils.dart' as custom_utils;
import 'package:scorely/uiLayer/widgets/error_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<List<Data>> _fetchData() async {
    return await RemoteService().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text(
          "BROWSE SERIES",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),

        backgroundColor: Color(0xFFF9FAFB),
        foregroundColor: Colors.black,
        toolbarHeight: 44,
      ),
      body: FutureBuilder<List<Data>>(
        future: _fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingIndicator());
          }

          if (snapshot.hasError) {
            return CustomErrorWidget(error: snapshot.error.toString());
          }

          final seriesList = snapshot.data ?? [];
          if (seriesList.isEmpty) {
            return const Center(
              child: Text("No data available!", style: TextStyle(fontSize: 14)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: seriesList.length,
            itemBuilder: (context, index) {
              return ItemWidget(d: seriesList[index]);
            },
          );
        },
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final Data d;

  const ItemWidget({super.key, required this.d});

  @override
  Widget build(BuildContext context) {
    final String startDate = custom_utils.DateU.getDate(d.startDate ?? '');
    final String endDate = d.endDate ?? '';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(255 * 0.2.toInt()),
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            d.name ?? '',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Divider(color: Colors.grey[300]),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if ((d.odi ?? 0) > 0)
                    Text("ODIs: ${d.odi}", style: _matchTypeStyle()),
                  if ((d.t20 ?? 0) > 0)
                    Text("T20Is: ${d.t20}", style: _matchTypeStyle()),
                  if ((d.test ?? 0) > 0)
                    Text("Tests: ${d.test}", style: _matchTypeStyle()),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Start: $startDate", style: _dateStyle(true)),
                  Text("End: $endDate", style: _dateStyle(false)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextStyle _matchTypeStyle() => const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  TextStyle _dateStyle(bool isStart) => TextStyle(
    fontSize: 14,
    fontWeight: isStart ? FontWeight.w600 : FontWeight.w400,
    color: isStart ? Colors.blueGrey : Colors.black54,
  );
}
