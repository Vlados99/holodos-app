import 'package:flutter/material.dart';

class CookTimeDropdownButton extends StatefulWidget {
  final ValueChanged<int> onValueChanged;
  final ValueChanged<String> onSymbolChanged;

  const CookTimeDropdownButton(
      {Key? key, required this.onValueChanged, required this.onSymbolChanged})
      : super(key: key);

  @override
  State<CookTimeDropdownButton> createState() => _CookTimeDropdownButtonState();
}

class _CookTimeDropdownButtonState extends State<CookTimeDropdownButton> {
  String dropdownValue = "";

  int cookTimeValue = 0;
  String cookTimeSymbol = "All";

  List<String> items = ["All", "< 30 min", "> 30 min", "> 60 min"];
  @override
  void initState() {
    cookTimeValue = 0;
    cookTimeSymbol = "All";
    dropdownValue = items.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      onChanged: (String? value) {
        if (value! != "All") {
          cookTimeSymbol = value.split(" ").first;
          cookTimeValue = int.tryParse(value.split(" ").elementAt(1)) ?? 0;
        } else {
          cookTimeSymbol = "All";
          cookTimeValue = 0;
        }
        setState(() {
          dropdownValue = value;
        });

        widget.onValueChanged(cookTimeValue);
        widget.onSymbolChanged(cookTimeSymbol);
      },
      items: items
          .map<DropdownMenuItem<String>>((item) =>
              DropdownMenuItem<String>(value: item, child: Text(item)))
          .toList(),
    );
  }
}
