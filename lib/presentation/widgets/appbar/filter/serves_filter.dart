import 'package:flutter/material.dart';
import 'package:holodos/common/app_const.dart';

class ServesDropdownButton extends StatefulWidget {
  final ValueChanged<int> onChanged;

  const ServesDropdownButton({Key? key, required this.onChanged})
      : super(key: key);

  @override
  State<ServesDropdownButton> createState() => _ServesDropdownButtonState();
}

class _ServesDropdownButtonState extends State<ServesDropdownButton> {
  String dropdownValue = "";
  int servesValue = 0;

  List<String> items = ["All", "1", "2", "3 +"];
  @override
  void initState() {
    servesValue = 0;
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
        servesValue = int.tryParse(value!.split(" ").first) ?? 0;
        setState(() {
          dropdownValue = value;
        });
        widget.onChanged(servesValue);
      },
      items: items
          .map<DropdownMenuItem<String>>((item) =>
              DropdownMenuItem<String>(value: item, child: Text(item)))
          .toList(),
    );
  }
}
