// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controller/record_controller.dart';
import '../../model/record.dart';
import '../widget/custom_field.dart';
import 'package:uuid/uuid.dart';

import '../widget/custom_button.dart';
import 'home_page.dart';

class AddRecordPage extends StatefulWidget {
  AddRecordPage({
    Key? key,
    this.updateRecord,
    this.title = 'Add',
  }) : super(key: key);
  String title;
  Record? updateRecord;
  @override
  State<AddRecordPage> createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  TextEditingController phNumController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController amountController = TextEditingController();

  TextEditingController remainingController = TextEditingController();

  TextEditingController itemController = TextEditingController();

  TextEditingController quantityController = TextEditingController();

  TextEditingController memoController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  final controller = Get.put(RecordController());

  DateTime? _date;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.title != 'Add') {
      nameController.text = widget.updateRecord!.name;
      addressController.text = widget.updateRecord!.address;
      phNumController.text = widget.updateRecord!.contactNo;
      amountController.text = widget.updateRecord!.amount.toString();
      remainingController.text = widget.updateRecord!.remaining.toString();
      itemController.text = widget.updateRecord!.item;
      quantityController.text = widget.updateRecord!.quantity.toString();
      // memoController.text = widget.updateRecord!.name;
      dateController.text = dateController.text =
          DateFormat("yyyy-MM-dd").format(widget.updateRecord!.date);
      _date = widget.updateRecord!.date;
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    addressController.dispose();
    amountController.dispose();
    phNumController.dispose();
    remainingController.dispose();
    itemController.dispose();
    quantityController.dispose();
    dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        shadowColor: Colors.black,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: !_isLoading
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomFormTextField(
                            controller: nameController,
                            hintText: 'Name',
                            icon: Icons.person_rounded,
                            isNumber: false,
                            isPassword: false,
                            onTap: () {},
                            size: size,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Name';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomFormTextField(
                            hintText: 'Phone Number',
                            icon: Icons.phone_rounded,
                            controller: phNumController,
                            onTap: () {},
                            isNumber: true,
                            isPassword: false,
                            size: size,
                            validator: (value) {
                              return null;
                            
                              // if (value!.isEmpty) {
                              //   return 'Enter Phone Number';
                              // }
                              // return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomFormTextField(
                            hintText: 'Address',
                            icon: Icons.home_rounded,
                            onTap: () {},
                            controller: addressController,
                            isNumber: false,
                            isPassword: false,
                            size: size,
                            validator: (value) {
                              return null;
                            
                              // if (value!.isEmpty) {
                              //   return 'Enter Address';
                              // }
                              // return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomFormTextField(
                            onTap: () {},
                            controller: amountController,
                            hintText: 'Amount',
                            icon: Icons.attach_money_outlined,
                            isNumber: false,
                            isPassword: false,
                            size: size,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Amount';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomFormTextField(
                            hintText: 'Remaining',
                            onTap: () {},
                            controller: remainingController,
                            icon: Icons.paid_rounded,
                            isNumber: false,
                            isPassword: false,
                            size: size,
                            validator: (value) {
                              return null;
                            
                              // if (value!.isEmpty) {
                              //   return 'Enter Remaining';
                              // }
                              // return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomFormTextField(
                            hintText: 'Item',
                            icon: Icons.category_rounded,
                            controller: itemController,
                            onTap: () {},
                            isNumber: false,
                            isPassword: false,
                            size: size,
                            validator: (value) {
                              return null;
                            
                              // if (value!.isEmpty) {
                              //   return 'Enter Item';
                              // }
                              // return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomFormTextField(
                            hintText: 'Quantity',
                            controller: quantityController,
                            icon: Icons.production_quantity_limits_rounded,
                            isNumber: false,
                            onTap: () {},
                            isPassword: false,
                            size: size,
                            validator: (value) {
                              return null;
                            
                              // if (value!.isEmpty) {
                              //   return 'Enter Quantity';
                              // }
                              // return null;
                            },
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: CustomFormTextField(
                        //     hintText: 'Memo',
                        //     controller: memoController,
                        //     icon: Icons.note_alt_rounded,
                        //     onTap: () {},
                        //     isNumber: false,
                        //     isPassword: false,
                        //     size: size,
                        //     validator: (value) {
                        //       // if (value!.isEmpty) {
                        //       //   return 'Enter Memo';
                        //       // }
                        //       // return null;
                        //     },
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomFormTextField(
                            hintText: 'Date',
                            icon: Icons.calendar_month,
                            isNumber: false,
                            controller: dateController,
                            isPassword: false,
                            onTap: () {
                              _pickDateOnPressed(
                                context,
                              );
                            },
                            size: size,
                            readOnly: true,
                            validator: (value) {
                              return null;
                            
                              // if (value!.isEmpty) {
                              //   return 'Enter Date';
                              // }
                              // return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomButton(
                            title: '${widget.title} Record',
                            size: size,
                            onPressed: () async {
                              await onSubmit(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Future<void> onSubmit(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      Record rec = Record(
        id: widget.title == 'Add' ? const Uuid().v1() : widget.updateRecord!.id,
        name: nameController.text,
        address: addressController.text,
        amount: double.parse(amountController.text),
        remaining: double.parse(remainingController.text),
        contactNo: phNumController.text,
        date: _date!,
        item: itemController.text,
        quantity: int.parse(quantityController.text),
      );
      // print(rec.id.toString());
      bool isSuccess = false;
      if (widget.title == 'Add') {
        isSuccess = await controller.addRecord(rec);
      } else {
        isSuccess = await controller.updateRecord(rec);
      }
      if (isSuccess) {
        HapticFeedback.lightImpact();
        Fluttertoast.showToast(
          msg: 'Record ${widget.title == 'Add' ? 'Submitted' : 'Updated'}',
        );
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (route) => false,
        );
      } else {
        HapticFeedback.lightImpact();
        Fluttertoast.showToast(
          msg: 'Something Went Wrong!',
        );
        setState(() {
          _isLoading = false;
        });
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  _pickDateOnPressed(
    BuildContext context,
  ) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      pickedDate = DateFormat("yyyy-MM-dd").parse(pickedDate.toString());
      dateController.text = DateFormat("yyyy-MM-dd").format(pickedDate);
      // print(pickedDate.toString());

      _date = pickedDate;
      // print(_date);
    } else {
      // print("Date is not selected");
    }
  }
}
// DateFormat("yyyy-MM-dd hh:mm:ss").parse(pickedDate.toString())