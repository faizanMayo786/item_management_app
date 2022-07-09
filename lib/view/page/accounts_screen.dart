import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/record_controller.dart';
import '../widget/card_item.dart';

// ignore: must_be_immutable
class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var records = Get.put(RecordController());

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  Future fetchData() async {
    await records.fetchRecord();
    return Future.delayed(Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (records.record.isEmpty) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No Record Added Yet!!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {
                        fetchData();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Try Refreshing',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.purple,
                            ),
                          ),
                          Icon(
                            Icons.refresh,
                            size: 20,
                            color: Colors.purple,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ));
            }
            return RefreshIndicator(
                onRefresh:  () {
              fetchData();
              setState(() {});
              return Future.delayed(Duration.zero);
            },
                child: GetX<RecordController>(builder: (context) {
                  return AnimatedList(
                    key: listKey,
                    initialItemCount: records.record.length,
                    itemBuilder: (context, index, animation) => SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(-1, 0),
                        end: const Offset(0, 0),
                      ).animate(animation),
                      child: CardItem(
                        title: 'Account',
                        listKey: listKey,
                        record: records.record[index],
                        index: index,
                      ),
                    ),
                  );
                }));
          }),
    );
  }
}
