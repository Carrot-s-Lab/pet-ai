import 'package:flutter/material.dart';

import '../app_font/app_font.dart';
import '../color/app_color.dart';

// class AppTextField extends StatefulWidget {
//   const AppTextField({
//     super.key,
//     this.labelText,
//     this.hintText,
//     this.controller,
//     this.validator,
//     this.autoValidateMode,
//     this.obscureText = false,
//     this.readOnly = false,
//     this.onTap,
//     this.maxLines = 1,
//     this.textInputType,
//     this.decoration = const InputDecoration(),
//     this.fillColor,
//     this.borderRadius,
//     this.borderColor,
//     this.inputFormatters,
//     this.hintStyle,
//     this.labelStyle,
//     this.textStyle,
//     this.focusNode,
//     this.suffixIcon,
//     this.onChanged,
//     this.prefixIcon,
//     this.contentPadding,
//     this.autoFocus,
//     this.enabledBorder = true,
//     this.isEnabled,
//   });
//
//   final TextEditingController? controller;
//   final FormFieldValidator<String>? validator;
//   final AutovalidateMode? autoValidateMode;
//   final String? labelText;
//   final String? hintText;
//   final bool obscureText;
//   final bool readOnly;
//   final GestureTapCallback? onTap;
//   final int? maxLines;
//   final TextInputType? textInputType;
//   final InputDecoration? decoration;
//   final BorderRadius? borderRadius;
//   final Color? borderColor;
//   final Color? fillColor;
//   final bool enabledBorder;
//   final List<TextInputFormatter>? inputFormatters;
//   final TextStyle? hintStyle;
//   final TextStyle? labelStyle;
//   final TextStyle? textStyle;
//   final FocusNode? focusNode;
//   final void Function(String)? onChanged;
//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//   final EdgeInsetsGeometry? contentPadding;
//   final bool? autoFocus;
//   final bool? isEnabled;
//
//   @override
//   State<AppTextField> createState() => _AppTextFieldState();
// }
//
// class _AppTextFieldState extends State<AppTextField> {
//   @override
//   Widget build(BuildContext context) {
//     final borderColorX = (widget.enabledBorder ? widget.borderColor : widget.fillColor) ?? AppColors.borderColor;
//
//     return TextFormField(
//       enabled: widget.isEnabled,
//       controller: widget.controller,
//       focusNode: widget.focusNode,
//       autofocus: widget.autoFocus ?? false,
//       style: widget.textStyle ?? AppFonts.f14m,
//       decoration: InputDecoration(
//         contentPadding: widget.contentPadding,
//         errorStyle: AppFonts.f13r.apply(color: AppColors.red),
//         labelText: widget.labelText,
//         labelStyle: widget.labelStyle ?? AppFonts.f14r,
//         hintText: widget.hintText,
//         hintStyle: widget.hintStyle ?? AppFonts.f14m.apply(color: AppColors.lightTextColor),
//         fillColor: widget.fillColor ?? AppColors.white,
//         filled: true,
//         suffixIcon: widget.suffixIcon,
//         prefixIcon: widget.prefixIcon,
//         border: OutlineInputBorder(
//           borderRadius: widget.borderRadius ?? const BorderRadius.all(Radius.circular(16)),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
//           borderSide: BorderSide(
//             color: borderColorX,
//           ),
//         ),
//         disabledBorder: OutlineInputBorder(
//           borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
//           borderSide: BorderSide(
//             color: borderColorX,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: widget.borderRadius ?? const BorderRadius.all(Radius.circular(16)),
//           borderSide: BorderSide(color: AppColors.primaryColor),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: widget.borderRadius ?? const BorderRadius.all(Radius.circular(16)),
//           borderSide: BorderSide(color: AppColors.red),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: widget.borderRadius ?? const BorderRadius.all(Radius.circular(16)),
//           borderSide: BorderSide(color: AppColors.primaryColor),
//         ),
//       ),
//       validator: widget.validator,
//       autovalidateMode: widget.autoValidateMode,
//       obscureText: widget.obscureText,
//       readOnly: widget.readOnly,
//       onTap: widget.onTap,
//       maxLines: widget.maxLines,
//       keyboardType: widget.textInputType,
//       inputFormatters: widget.inputFormatters,
//       onChanged: (value) {
//         widget.onChanged?.call(value);
//       },
//     );
//   }
// }

class AppTextField extends TextFormField {
  AppTextField({
    super.key,
    super.controller,
    super.focusNode,
    String? labelText,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Widget? suffixIconWithFrame,
    super.keyboardType,
    super.textInputAction,
    super.obscureText,
    super.maxLength,
    super.maxLines,
    super.minLines,
    super.expands,
    bool super.enabled = true,
    super.readOnly,
    super.autofocus,
    super.textAlign,
    super.textDirection,
    super.textCapitalization,
    super.autocorrect,
    super.enableSuggestions,
    super.scrollPadding,
    super.inputFormatters,
    super.validator,
    super.onChanged,
    super.onTap,
    super.onEditingComplete,
    super.onFieldSubmitted,
    super.onSaved,
    Color focusedColor = Colors.blue,
    Color errorColor = Colors.red,
    TextStyle? textStyle,
    TextStyle? hintStyle,
    Color super.cursorColor = Colors.black,
    BorderRadius? borderRadius,
    Color? fillColor,
    Color? borderColor,
    bool enabledBorder = true,
    FloatingLabelBehavior? floatingLabelBehavior,
    EdgeInsetsGeometry? contentPadding,
    bool isDense = false,
  }) : super(
          style: AppFonts.f14m,
          decoration: InputDecoration(
            contentPadding: contentPadding,
            floatingLabelBehavior: floatingLabelBehavior,
            errorStyle: AppFonts.f14r.apply(color: AppColors.red),
            labelText: labelText,
            labelStyle: AppFonts.f14r,
            prefixIcon: prefixIcon == null
                ? null
                : Container(
                    width: double.minPositive,
                    height: double.minPositive,
                    alignment: Alignment.center,
                    child: prefixIcon,
                  ),
            suffixIcon: suffixIconWithFrame ?? Container(
              width: double.minPositive,
              height: double.minPositive,
              alignment: Alignment.center,
              child: suffixIcon,
            ),
            hintText: hintText,
            hintStyle: hintStyle ?? AppFonts.f14m.apply(color: AppColors.textTertiary),
            fillColor: fillColor ?? AppColors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(16)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(16),
              borderSide: BorderSide(
                color: (enabledBorder ? borderColor : fillColor) ?? AppColors.borderColor,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(16),
              borderSide: BorderSide(
                color: (enabledBorder ? borderColor : fillColor) ?? AppColors.borderColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(
                // color: Colors.transparent,
                // color: enabledBorder ? AppColors.primaryColor : fillColor ?? AppColors.borderColor,
                color: (enabledBorder ? borderColor : fillColor) ?? AppColors.borderColor
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(color: AppColors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
          ),
        );
}
