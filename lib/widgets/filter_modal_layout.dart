import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/screens/onboard/pages/one.dart';
import 'package:budgetplanner/screens/onboard/pages/two.dart';
import 'package:budgetplanner/utils/category_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterLayout extends StatefulWidget {
  const FilterLayout({Key? key}) : super(key: key);

  @override
  _FilterLayoutState createState() => _FilterLayoutState();
}

class _FilterLayoutState extends State<FilterLayout> {
  final controller = TransactionEntryController.to;
  final int _numPages = 2;
  final PageController _pageController = PageController(initialPage: 0);
  int tappedIndex = 0;
  bool isSelected = false;
  bool isESelected = false;
  List<String> filterTabs = [income, expense];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .5,
      decoration: BoxDecoration(
          color: Theme.of(context).hintColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      padding: EdgeInsets.all(10),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    child: ListView.builder(
                      itemCount: filterTabs.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          filterTab(filterTabs[index], index),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    //controller.setCurrentPage(page);
                  },
                  children: <Widget>[
                    incomeChips(income),
                    expenseChips(expense),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      minimumSize: Size(50, 50),
                      primary: whiteColor,
                      side: BorderSide(
                        color: heenColor,
                        width: 1,
                      ),
                    ),
                    onPressed: () {},
                    child: Icon(
                      Icons.delete,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      minimumSize: Size(50, 50),
                      primary: whiteColor,
                      side: BorderSide(
                        color: heenColor,
                        width: 1,
                      ),
                    ),
                    onPressed: () {},
                    child: Icon(
                      Icons.delete,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget incomeChips(String name) {
    return Container(
      decoration: BoxDecoration(
          //border: Border.all(color: red),
          ),
      child: FilterChip(
        selected: isSelected,
        label: Text(name),
        onSelected: (selected) {
          setState(() {
            isSelected = selected;
          });
        },
      ),
    );
  }

  Widget expenseChips(String name) {
    return Container(
      decoration: BoxDecoration(
          //border: Border.all(color: red),
          ),
      child: FilterChip(
        selected: isESelected,
        label: Text(name),
        onSelected: (selected) {
          setState(() {
            isESelected = selected;
          });
        },
      ),
    );
  }

  Widget filterTab(String name, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            tappedIndex = index;
          });
          print("index $index tappedIndex $tappedIndex");
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
        child: Container(
          height: 40.0,
          width: 120.0,
          decoration: BoxDecoration(
            color: (tappedIndex == index) ? shade : Theme.of(context).hintColor,
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          child: Center(
              child: Text(
            name,
            style: kHeaderStyle.copyWith(color: Theme.of(context).primaryColor),
          )),
        ),
      ),
    );
  }
}
