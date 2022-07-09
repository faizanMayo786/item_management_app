// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controller/record_controller.dart';
import '../../model/record.dart';
import '../page/add_record_page.dart';

// ignore: must_be_immutable
class CardItem extends StatefulWidget {
  CardItem({
    Key? key,
    this.title = 'Dashboard',
    required this.record,
    required this.index,
    required this.listKey,
  }) : super(key: key);
  Record record;
  String title;
  GlobalKey<AnimatedListState> listKey;
  final RecordController records = Get.put(RecordController());
  int index;
  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.width * 0.015);
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        padding: EdgeInsets.all(size.width <= 700
            ? MediaQuery.of(context).size.width * 0.015
            : size.width * 0.007),
        height: size.width <= 700 && widget.title == 'Dashboard' ? 300.0 : 150,
        child: Center(
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      spreadRadius: 1,
                      color: Colors.grey.shade200,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  cardRow(context,
                                      title: 'Name', value: widget.record.name),
                                  cardRow(context,
                                      title: 'Contact No.',
                                      value: widget.record.contactNo),
                                  cardRow(context,
                                      title: 'Address',
                                      value: widget.record.address),
                                  cardRow(context,
                                      title: 'Amount',
                                      value: '\$${widget.record.amount}'),
                                  Visibility(
                                    visible: size.width <= 700 &&
                                        widget.title == 'Dashboard',
                                    child: cardRow(context,
                                        title: 'Remaining',
                                        value: '\$${widget.record.remaining}'),
                                  ),
                                  size.width <= 700 &&
                                          widget.title == 'Dashboard'
                                      ? cardRow(context,
                                          title: 'Item',
                                          value: widget.record.item)
                                      : const SizedBox(),
                                  size.width <= 700 &&
                                          widget.title == 'Dashboard'
                                      ? cardRow(context,
                                          title: 'Quantity',
                                          value: widget.record.quantity)
                                      : const SizedBox(),
                                  size.width <= 700 &&
                                          widget.title == 'Dashboard'
                                      ? cardRow(
                                          context,
                                          title: 'Date',
                                          value: DateFormat("yyyy-MM-dd")
                                              .format(widget.record.date),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                              size.width > 700
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        widget.title == 'Dashboard'
                                            ? cardRow(context,
                                                title: 'Remaining',
                                                value:
                                                    '\$${widget.record.remaining}')
                                            : const SizedBox(),
                                        widget.title == 'Dashboard'
                                            ? cardRow(context,
                                                title: 'Item',
                                                value: widget.record.item)
                                            : const SizedBox(),
                                        widget.title == 'Dashboard'
                                            ? cardRow(context,
                                                title: 'Quantity',
                                                value: widget.record.quantity)
                                            : const SizedBox(),
                                        widget.title == 'Dashboard'
                                            ? cardRow(
                                                context,
                                                title: 'Date',
                                                value: DateFormat("yyyy-MM-dd")
                                                    .format(widget.record.date),
                                              )
                                            : const SizedBox(),
                                      ],
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    widget.title == 'Dashboard'
                        ? Positioned(
                            top: 15,
                            right: 15,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 25,
                                  width: 30,
                                  child: IconButton(
                                    splashRadius: 1,
                                    iconSize: 20,
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddRecordPage(
                                            title: 'Update',
                                            updateRecord: widget.record,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                  width: 30,
                                  child: IconButton(
                                    splashRadius: 1,
                                    padding: EdgeInsets.zero,
                                    iconSize: 20,
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      await onDelete(context);
                                    },
                                  ),
                                ),
                              ],
                            ))
                        : const SizedBox()
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Future<void> onDelete(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm"),
        content: const Text('You want to Delete?'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              HapticFeedback.lightImpact();
              Fluttertoast.showToast(
                msg: 'Deleting Item',
              );
              bool isDeleted =
                  await widget.records.deleteRecord(widget.record.id);
              if (isDeleted == true) {
                // print(widget.index);
                widget.listKey.currentState!.removeItem(
                  widget.index,
                  duration: const Duration(milliseconds: 500),
                  (context, animation) => SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(-2, 0),
                      end: const Offset(0, 0),
                    ).animate(animation),
                    child: CardItem(
                        record: widget.record,
                        index: widget.index,
                        listKey: widget.listKey),
                  ),
                );
                widget.records.record.removeAt(widget.index);
              } else {
                Navigator.of(context).pop();
                HapticFeedback.lightImpact();
                Fluttertoast.showToast(
                  msg: 'Something Went Wrong',
                );
              }
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

  Row cardRow(BuildContext context,
      {required String title, required dynamic value}) {
    // print(MediaQuery.of(context).size.width * 0.6);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width <= 700 ? 220 : 220,
          child: Text(
            value.toString(),
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ],
    );
  }
}
