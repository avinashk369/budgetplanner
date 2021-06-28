import 'package:budgetplanner/models/transaction_model.dart';
import 'package:budgetplanner/resources/firestore/dataRepositoryImpl.dart';
import 'package:budgetplanner/utils/category_constants.dart';
import 'package:budgetplanner/utils/date_formatter.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class GroupedList extends StatefulWidget {
  final List<TransactionModel> transactionModelList;
  const GroupedList({Key? key, required this.transactionModelList})
      : super(key: key);

  @override
  _GroupedListState createState() => _GroupedListState();
}

class _GroupedListState extends State<GroupedList> {
  @override
  Widget build(BuildContext context) {
    return GroupedListView<TransactionModel, String>(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 10),
      elements: widget.transactionModelList,
      groupBy: (element) => element.createdOn!.substring(0, 10),
      groupComparator: (value1, value2) => value2.compareTo(value1),
      itemComparator: (item1, item2) =>
          item1.catName!.compareTo(item2.catName!),
      //order: GroupedListOrder.DESC,
      //useStickyGroupSeparators: true,
      separator: Padding(
        padding: EdgeInsets.only(left: 60, bottom: kSpaceS, right: kSpaceS),
        child: Divider(
          height: 1,
          color: kGrey,
        ),
      ),
      groupSeparatorBuilder: (String value) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 10,
              ),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    color: tealColor,
                  ),
                  child: Text(
                    DateFormatter().getVerboseDateTimeRepresentation(value),
                    style: kLabelStyle.apply(color: darkColor),
                  )),
            ),
          ],
        ),
      ),
      itemBuilder: (c, element) {
        TransactionModel transactionModel = element;
        return InkWell(
          onTap: () {
            //open trainer detail screen
            print(transactionModel.catName);
          },
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: kSpaceS, vertical: kSpaceS),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent, width: 0)),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 50.0,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: DataRepositoryImpl()
                            .iconUrl(transactionModel.catName!)!
                            .colorName,
                      ),
                      child: Icon(
                        DataRepositoryImpl()
                            .iconUrl(transactionModel.catName!)!
                            .iconName,
                        color: whiteColor,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              transactionModel.catName.toString(),
                              style: kLabelStyle.apply(
                                  fontSizeFactor: 1.2,
                                  color: Theme.of(context).hintColor),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              transactionModel.notes ?? "",
                              style: kLabelStyle.apply(
                                color: kGrey,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              (transactionModel.transactionType == expense)
                                  ? transactionModel.expenseType ?? ""
                                  : income,
                            )
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "\u20B9 " + transactionModel.amount.toString(),
                      style: kLabelStyle.apply(
                        fontSizeFactor: 1.2,
                        color: (transactionModel.transactionType == expense)
                            ? redColor
                            : greenbuttoncolor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
