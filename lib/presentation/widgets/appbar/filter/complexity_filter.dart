import 'package:flutter/material.dart';
import 'package:holodos/common/app_const.dart';

class ComplexityDropdownButton extends StatefulWidget {
  final ValueChanged<int> onChanged;

  const ComplexityDropdownButton({super.key, required this.onChanged});

  @override
  State<ComplexityDropdownButton> createState() =>
      _ComplexityDropdownButtonState();
}

class _ComplexityDropdownButtonState extends State<ComplexityDropdownButton> {
  String dropdownValue = "";
  int complexityValue = 0;

  List<String> items = ["All", "1", "2", "3", "4", "5"];
  @override
  void initState() {
    complexityValue = 0;
    dropdownValue = items.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      style: TextStyles.text16black,
      isExpanded: true,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      onChanged: (String? value) {
        complexityValue = int.tryParse(value!) ?? 0;
        setState(() {
          dropdownValue = value;
        });

        widget.onChanged(complexityValue);
      },
      items: items
          .map<DropdownMenuItem<String>>((item) =>
              DropdownMenuItem<String>(value: item, child: Text(item)))
          .toList(),
    );
  }
}
