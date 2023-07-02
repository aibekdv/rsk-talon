import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:rsk_talon/common/common.dart';

class SelectOptionWidget extends StatelessWidget {
  final Function(bool isOpen) onMenuStateChange;
  final bool isOpenDropdown;
  final List<String> items;
  final Function(String value) onTapItem;
  final String title;

  const SelectOptionWidget({
    super.key,
    required this.onMenuStateChange,
    required this.isOpenDropdown,
    required this.items,
    required this.onTapItem,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    double maxHeight = items.length > 6 ? 250.0 : (items.length * 40) + 16;
    return DropdownButtonFormField2<String>(
      onMenuStateChange: onMenuStateChange,
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 0,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          borderSide: BorderSide(color: Colors.grey),
        ),
        border: UnderlineInputBorder(
          borderRadius: isOpenDropdown
              ? const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))
              : BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        fillColor: AppColors.whiteColor ,
        filled: true,
      ),
      hint: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xff5C5C5C),
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                onTap: () {
                  onTapItem(item);
                },
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      onChanged: (value) {},
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.expand_more,
          color: Colors.black45,
        ),
        iconSize: 24,
      ),
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 15),
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        maxHeight: maxHeight,
        elevation: 0,
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        height: 40,
      ),
    );
  }
}
