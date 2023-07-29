import 'package:flutter/material.dart';
import 'package:rsk_talon/common/common.dart';

class CustomInputWidget extends StatefulWidget {
  final TextEditingController? controller;
  final bool? isPasswordField;
  final String? hinText;
  final FormFieldValidator<String>? validator;
  final TextInputType? inputType;
  final String labelText;
  final Function(String)? onChanged;
  final String infoText;
  final bool? isError;

  const CustomInputWidget({
    super.key,
    this.controller,
    this.isPasswordField,
    this.hinText,
    this.validator,
    this.inputType,
    required this.labelText,
    this.onChanged,
    required this.infoText,
    this.isError,
  });

  @override
  State<CustomInputWidget> createState() => _CustomInputWidgetState();
}

class _CustomInputWidgetState extends State<CustomInputWidget> {
  bool _obsecureText = true;
  final GlobalKey _key = GlobalKey();

  void _showOverlay(context) async {
    final box = _key.currentContext?.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);
    final entry = OverlayEntry(
      builder: (context) => Positioned(
        top: offset.dy - 20,
        left: offset.dx + 25,
        child: Material(
          color: Colors.transparent,
          animationDuration: const Duration(milliseconds: 400),
          child: Container(
            width: 160,
            padding: const EdgeInsets.all(10),
            decoration: const ShapeDecoration(
              color: Color(0xFF373B4A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
            ),
            child: Text(
              widget.infoText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(entry);
    await Future.delayed(const Duration(seconds: 3));
    entry.remove();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isError == true) {
      Future.delayed(const Duration(seconds: 1), () {
        _showOverlay(context);
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              widget.labelText,
              style: TextStyle(
                color: (widget.isError ?? false) ? Colors.red : Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              key: _key,
              onTap: () => _showOverlay(context),
              child: Icon(
                Icons.info_outline,
                color: (widget.isError ?? false) ? Colors.red : Colors.white,
                size: 22,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.inputType,
          obscureText: widget.isPasswordField == true ? _obsecureText : false,
          cursorColor: AppColors.primary,
          validator: widget.validator,
          onChanged: widget.onChanged,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            contentPadding: const EdgeInsets.all(15),
            filled: true,
            fillColor: Colors.white,
            hintText: widget.hinText,
            errorStyle: const TextStyle(fontSize: 0),
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.black.withOpacity(.4),
              fontWeight: FontWeight.w600,
            ),
            suffixIcon: widget.isPasswordField == true
                ? GestureDetector(
                    onTap: () {
                      _obsecureText = !_obsecureText;
                      setState(() {});
                    },
                    child: Icon(
                      _obsecureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.black.withOpacity(.4),
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
