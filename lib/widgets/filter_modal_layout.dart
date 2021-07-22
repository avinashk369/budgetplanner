import 'package:budgetplanner/controllers/expense_controller.dart';
import 'package:budgetplanner/controllers/income_controller.dart';
import 'package:budgetplanner/controllers/transaction_controller.dart';
import 'package:budgetplanner/utils/controller_constants.dart';
import 'package:budgetplanner/utils/styles.dart';
import 'package:budgetplanner/widgets/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loading_ui.dart';

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
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: Colors.grey[100], //grey[100]
                    ),
                    child: ListView.builder(
                      itemCount: filterTabs.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: filterTab(filterTabs[index], index),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: greylightcolor, //grey[100]
                    ),
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          backgroundColor: Colors.grey[100],
                          elevation: 0,
                          child: Icon(Icons.cancel, color: redColor),
                          onPressed: () {
                            List<String> blank = [];
                            incController.catList.forEach((element) {
                              setState(() {
                                element.isSelected = false;
                              });
                            });
                            expController.catList.forEach((item) {
                              setState(() {
                                item.isSelected = false;
                              });
                            });
                            widget.removeFilter(blank);
                          },
                        ),
                        FloatingActionButton(
                          backgroundColor: Colors.grey[100],
                          elevation: 0,
                          child: Icon(
                            Icons.check,
                            color: tealColor,
                          ),
                          onPressed: () {
                            widget.applyFilter(filterName);
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
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
                          child: Obx(
                            () => (expController.isLoading()
                                ? loader()
                                : Wrap(
                                    spacing: 5,
                                    children: buildIncomeChoiceList(),
                                  )),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Column(
                        children: [
                          Obx(
                            () => (expController.isLoading()
                                ? LoadingUI()
                                : Wrap(
                                    spacing: 5,
                                    children: buildExpChoiceList(),
                                  )),
                          ),
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

  Widget loader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: darkColor,
            strokeWidth: 2,
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
          elevation: 0,
          labelStyle: kLabelStyle.copyWith(
              fontSize: 14, color: (item.isSelected) ? whiteColor : darkColor),
          checkmarkColor: whiteColor,
          selectedColor: tealColor,
          selected: item.isSelected,
          backgroundColor: Colors.grey[100],
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
          labelStyle: kLabelStyle.copyWith(color: whiteColor, fontSize: 12),
          backgroundColor: Colors.transparent,
          selectedColor: tealColor,
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
    //Color tc = darkColor;
    List<Widget> choices = [];
    incController.catList.forEach((item) {
      choices.add(FilterChip(
        label: Text(item.name!),
        elevation: 0,
        labelStyle: kLabelStyle.copyWith(
            fontSize: 14, color: (item.isSelected) ? whiteColor : darkColor),
        checkmarkColor: whiteColor,
        selectedColor: tealColor,
        selected: item.isSelected,
        backgroundColor: Colors.grey[100],
        onSelected: (selected) {
          (selected)
              ? filterName.add(item.name!)
              : filterName.remove(item.name);
          setState(() {
            item.isSelected = selected;
          });
        },
      ));
    });

    return choices;
  }

  Widget filterTab(String name, int index) {
    return ChoiceChip(
      label: Text(
        name,
      ),
      elevation: 0,
      selected: (tappedIndex == index),
      labelStyle: kLabelStyle.copyWith(
          fontSize: 16, color: (tappedIndex == index) ? whiteColor : darkColor),
      selectedColor: tealColor,
      backgroundColor:
          (tappedIndex == index) ? Colors.transparent : Colors.grey[100],
      onSelected: (value) {
        setState(() {
          tappedIndex = index;
        });
        print("index $index tappedIndex $tappedIndex");
        _pageController.animateToPage(index,
            duration: Duration(milliseconds: 500), curve: Curves.ease);
      },
    );
    // return InkWell(
    //   onTap: () {
    //     setState(() {
    //       tappedIndex = index;
    //     });
    //     print("index $index tappedIndex $tappedIndex");
    //     _pageController.animateToPage(index,
    //         duration: Duration(milliseconds: 500), curve: Curves.ease);
    //   },
    //   child: Container(
    //     padding: EdgeInsets.symmetric(horizontal: 10),
    //     decoration: BoxDecoration(
    //       color: (tappedIndex == index) ? tealColor : whiteColor,
    //       borderRadius: BorderRadius.all(Radius.circular(3)),
    //     ),
    //     child: Center(
    //         child: Text(
    //       name,
    //       style: kHeaderStyle.copyWith(color: darkColor),
    //     )),
    //   ),
    // );
  }
}
