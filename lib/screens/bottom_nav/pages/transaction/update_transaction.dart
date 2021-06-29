import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/models/transaction_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/utils/string_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/category_choser.dart';
import 'package:budgetplanner/widgets/custom_input.dart';
import 'package:budgetplanner/widgets/dashed_rect.dart';
import 'package:budgetplanner/widgets/loading_ui.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UpdateTransaction extends StatelessWidget {
  final TransactionModel transactionModel;
  const UpdateTransaction({Key? key, required this.transactionModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TransactionEntryController.to;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kSpaceS, vertical: kSpaceM),
          child: CustomScrollView(
            //controller: ScrollController(),
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      height: Get.height * .15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Update your daily",
                            style: kLabelStyle.apply(
                                color: Theme.of(context).hintColor),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            transactionModel.transactionType!,
                            style: kTitleStyle,
                          )
                        ],
                      ),
                    ),
                    //BudgetCard()
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
              SliverToBoxAdapter(
                child: Form(
                  //key: controller.,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      CategoryChooser(
                        leftRowData: Text(
                            transactionModel.catName ?? select_budget_category),
                        rightRowData: transactionModel.catName != null
                            ? Container(
                                height: 35,
                                width: 35,
                                margin: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: DataRepositoryImpl()
                                      .iconUrl(transactionModel.catName!)!
                                      .colorName,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Icon(
                                  DataRepositoryImpl()
                                      .iconUrl(transactionModel.catName!)!
                                      .iconName,
                                  color: whiteColor,
                                ),
                              )
                            : Container(
                                height: 35,
                                width: 35,
                                child: DashedRect(
                                  color: Theme.of(context).hintColor,
                                  strokeWidth: 1.0,
                                  gap: 2.0,
                                ),
                              ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CategoryChooser(
                        leftRowData: Text(monthName),
                        rightRowData:
                            Text(DateFormat('LLLL').format(DateTime.now())),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              controller
                                  .deletetransaction(transactionModel.id!);
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
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
