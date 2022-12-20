import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holodos/common/app_const.dart';
import 'package:holodos/presentation/cubit/cuisine/cuisine_cubit.dart';

class CuisinesDropdownButton extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const CuisinesDropdownButton({Key? key, required this.onChanged})
      : super(key: key);

  @override
  State<CuisinesDropdownButton> createState() => _CuisinesDropdownButtonState();
}

class _CuisinesDropdownButtonState extends State<CuisinesDropdownButton> {
  String dropdownValue = "";
  String cuisinesValue = "All";

  List<String> items = ["All"];

  @override
  void initState() {
    BlocProvider.of<CuisineCubit>(context).getCuisines();

    cuisinesValue = "All";
    dropdownValue = items.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CuisineCubit, CuisineState>(
      builder: (context, cuisineState) {
        if (cuisineState is CuisineLoaded) {
          return dropdownMenu(
              cuisineState.cuisines.map((e) => e.name).toList());
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  DropdownButton<String> dropdownMenu(List<String> cuisines) {
    items = ["All"] + cuisines;
    return DropdownButton<String>(
      style: TextStyles.text16black,
      isExpanded: true,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      onChanged: (String? value) {
        if (value! != "All") {
          cuisinesValue = value;
        } else {
          cuisinesValue = "All";
        }
        setState(() {
          dropdownValue = value;
        });

        widget.onChanged(cuisinesValue);
      },
      items: items
          .map<DropdownMenuItem<String>>((item) =>
              DropdownMenuItem<String>(value: item, child: Text(item)))
          .toList(),
    );
  }
}
