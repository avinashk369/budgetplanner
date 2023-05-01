import 'package:budgetplanner/models/transaction_model.dart';
import 'package:budgetplanner/screens/bottom_nav/pages/transaction/transaction_card.dart';
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
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: 10),
      elements: widget.transactionModelList,
      groupBy: (element) => element.createdOn!.toString().substring(0, 10),
      groupComparator: (value1, value2) => value2.compareTo(value1),
      // itemComparator: (item1, item2) =>
      //     item1.catName!.compareTo(item2.catName!),
      //order: GroupedListOrder.DESC,
      //useStickyGroupSeparators: true,
      separator: Padding(
        padding: EdgeInsets.only(left: 65, bottom: kSpaceS, right: kSpaceS),
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
                child: RawChip(
                  backgroundColor: Colors.purple[600],
                  label: Text(
                    DateFormatter().getVerboseDateTimeRepresentation(value),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: whiteColor,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                )),
          ],
        ),
      ),
      itemBuilder: (c, element) {
        TransactionModel transactionModel = element;
        return TransactionCard(transactionModel: transactionModel);
      },
    );
  }
}
