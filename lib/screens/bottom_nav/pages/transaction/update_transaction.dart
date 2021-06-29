import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/models/transaction_model.dart';
import 'package:budgetplanner/widgets/loading_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateTransaction extends StatelessWidget {
  final TransactionModel transactionModel;
  const UpdateTransaction({Key? key, required this.transactionModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TransactionEntryController.to;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
          child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              controller.deletetransaction(transactionModel.id!);
              print(transactionModel.catName);
            },
            child: Text("Delete"),
          ),
          ElevatedButton(
            onPressed: () {
              transactionModel.amount = 299;
              transactionModel.updatedOn = DateTime.now();
              controller.updatetransaction(transactionModel);
            },
            child: Text("Update"),
          ),
        ],
      )),
    );
  }
}
