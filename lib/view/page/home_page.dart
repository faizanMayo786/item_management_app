
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../controller/record_controller.dart';
import 'accounts_screen.dart';
import 'add_record_page.dart';
import 'login_page.dart';
import '../widget/card_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var records = Get.put(RecordController());

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  Future fetchData() async {
    await records.fetchRecord();

    return Future.delayed(Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "Accounts Screen Button",
            onPressed: (() {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AccountScreen(),
                ),
              );
            }),
            child: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          FloatingActionButton(
            heroTag: "Add Screen Button",
            onPressed: (() {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddRecordPage(),
                ),
              );
            }),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
              return;
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      backgroundColor: Colors.white,
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
              onRefresh: () {
                fetchData();
                setState(() {});
                return Future.delayed(Duration.zero);
              },
              child: Builder(builder: (context) {
                return GetX<RecordController>(
                  builder: (context) {
                    return AnimatedList(
                      key: listKey,
                      initialItemCount: records.record.length,
                      itemBuilder: (context, index, animation) =>
                          SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(-1, 0),
                          end: const Offset(0, 0),
                        ).animate(animation),
                        child: CardItem(
                          listKey: listKey,
                          record: records.record[index],
                          index: index,
                        ),
                      ),
                    );
                  },
                );
              }),
            );
          }),
    );
  }

  Future<dynamic> logout(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm"),
        content: const Text('You want to Sign-Out?'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              HapticFeedback.lightImpact();
              Fluttertoast.showToast(
                msg: 'Signing Out',
              );
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('isLogin', false);
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
        ],
      ),
    );
  }
}
