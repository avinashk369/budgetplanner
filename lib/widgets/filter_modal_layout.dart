import 'package:budgetplanner/controllers/expense_controller.dart';
import 'package:budgetplanner/controllers/income_controller.dart';
import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterLayout extends StatefulWidget {
  final Function(List<String>) applyFilter;
  final Function(List<String>) removeFilter;
  const FilterLayout(
      {Key? key, required this.applyFilter, required this.removeFilter})
      : super(key: key);

  @override
  _FilterLayoutState createState() => _FilterLayoutState();
}

class _FilterLayoutState extends State<FilterLayout> {
  final controller = TransactionEntryController.to;
  final expController = ExpenseController.tagged(expenseController);
  final incController = IncomeController.tagged(incomeController);

  final PageController _pageController = PageController(initialPage: 0);
  int tappedIndex = 0;
  bool isSelected = false;
  bool isESelected = false;
  List<String> filterTabs = [
    "Income",
    "Expense",
  ];
  List<String> filterName = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      padding: EdgeInsets.all(10),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Container(
                height: 40,
                child: ListView.builder(
                  itemCount: filterTabs.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      filterTab(filterTabs[index], index),
                ),
              ),
              SizedBox(height: 35),
              Expanded(
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    //controller.setCurrentPage(page);
                    setState(() {
                      tappedIndex = page;
                    });
                  },
                  children: <Widget>[
                    Column(
                      children: [
                        Container(
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 5,
                            children: buildIncomeChoiceList(),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                                onPressed: () {
                                  List<String> blank = [];
                                  incController.catList.forEach((element) {
                                    setState(() {
                                      element.isSelected = false;
                                    });
                                  });
                                  widget.removeFilter(blank);
                                },
                                child: Text(
                                  "Clear Filter",
                                  style: kLabelStyle.copyWith(color: darkColor),
                                )),
                            OutlinedButton(
                                onPressed: () {
                                  widget.applyFilter(filterName);
                                },
                                child: Text(
                                  "Apply Filter",
                                  style: kLabelStyle.copyWith(color: darkColor),
                                ))
                          ],
                        )
                      ],
                    ),
                    Container(
                      child: Column(
                        children: [
                          Wrap(
                            spacing: 8,
                            runSpacing: 5,
                            children: buildExpChoiceList(),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OutlinedButton(
                                  onPressed: () {
                                    List<String> blank = [];
                                    expController.catList.forEach((item) {
                                      setState(() {
                                        item.isSelected = false;
                                      });
                                    });
                                    widget.removeFilter(blank);
                                  },
                                  child: Text(
                                    "Clear Filter",
                                    style:
                                        kLabelStyle.copyWith(color: darkColor),
                                  )),
                              OutlinedButton(
                                  onPressed: () {
                                    widget.applyFilter(filterName);
                                  },
                                  child: Text(
                                    "Apply Filter",
                                    style:
                                        kLabelStyle.copyWith(color: darkColor),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildExpChoiceList() {
    List<Widget> choices = [];
    expController.catList.forEach((item) {
      choices.add(Container(
        child: FilterChip(
          label: Text(item.name!),
          labelStyle: kLabelStyle.copyWith(color: whiteColor),
          checkmarkColor: whiteColor,
          backgroundColor: darkColor,
          selectedColor: tealColor,
          shape: StadiumBorder(
              side: BorderSide(color: Colors.transparent, width: 1)),
          selected: item.isSelected,
          onSelected: (selected) {
            (selected)
                ? filterName.add(item.name!)
                : filterName.remove(item.name);
            setState(() {
              item.isSelected = selected;
            });
          },
        ),
      ));
    });
    return choices;
  }

  buildExpSourceChoiceList() {
    List<Widget> choices = [];
    expController.expenseSourceList.forEach((item) {
      choices.add(Container(
        child: FilterChip(
          label: Text(item.name!),
          labelStyle: kLabelStyle.copyWith(color: Theme.of(context).hintColor),
          backgroundColor: Colors.transparent,
          selectedColor: tealColor,
          shape: StadiumBorder(
              side: BorderSide(color: Colors.transparent, width: 1)),
          selected: true,
          onSelected: (selected) {
            setState(() {
              item.isSelected = !item.isSelected;
            });
          },
        ),
      ));
    });
    return choices;
  }

  buildRecurranceChoiceList() {
    List<Widget> choices = [];
    expController.recurranceList.forEach((item) {
      choices.add(Container(
        child: FilterChip(
          label: Text(item.name!),
          labelStyle: kLabelStyle.copyWith(color: whiteColor),
          backgroundColor: Colors.transparent,
          selectedColor: tealColor,
          shape: StadiumBorder(
              side: BorderSide(color: Colors.transparent, width: 1)),
          selected: item.isSelected,
          onSelected: (selected) {
            setState(() {
              item.isSelected = !item.isSelected;
            });
          },
        ),
      ));
    });
    return choices;
  }

  buildIncomeChoiceList() {
    List<Widget> choices = [];
    incController.catList.forEach((item) {
      choices.add(Container(
        child: FilterChip(
          label: Text(item.name!),
          labelStyle: kLabelStyle.copyWith(color: whiteColor),
          checkmarkColor: whiteColor,
          backgroundColor: darkColor,
          selectedColor: tealColor,
          shape: StadiumBorder(
              side: BorderSide(color: Colors.transparent, width: 1)),
          selected: item.isSelected,
          onSelected: (selected) {
            (selected)
                ? filterName.add(item.name!)
                : filterName.remove(item.name);
            setState(() {
              item.isSelected = selected;
            });
          },
        ),
      ));
    });

    return choices;
  }

  Widget filterTab(String name, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          tappedIndex = index;
        });
        print("index $index tappedIndex $tappedIndex");
        _pageController.animateToPage(index,
            duration: Duration(milliseconds: 500), curve: Curves.ease);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: (tappedIndex == index) ? tealColor : whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        child: Center(
            child: Text(
          name,
          style: kHeaderStyle.copyWith(color: darkColor),
        )),
      ),
    );
  }
}
