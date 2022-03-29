import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:magnijobs_rnr/models/expandable_tile_model.dart';

import '../styles.dart';
import '../utils/utils.dart';

typedef FieldValidator = String? Function(String? data);

class SvgViewer extends StatelessWidget {
  final String svgPath;
  final double? height;
  final double? width;
  final Color? color;

  const SvgViewer(
      {Key? key, required this.svgPath, this.height, this.width, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svgPath,
      color: color,
      height: height ?? 18,
      width: width ?? 18,
    );
  }
}

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  final Color? fillColor;
  final String? labelText;
  final String? hintText;
  final Color? hintColor;
  final Color? labelColor;
  final String? prefixIcon;
  final String? suffixIcon;
  final Color? focusBorderColor;
  final Color? unfocusBorderColor;
  final double? contentPadding;
  final bool? enable;
  final String? text;
  final String? sufixLabel;

  // ignore: prefer_typing_uninitialized_variables
  final onChanged;
  final double? leftPadding;
  final double? rightPadding;
  final TextEditingController? controller;
  final Function? focusListner;
  late FocusNode focusNode;
  final FieldValidator? validator;
  final TextInputType? keyboardType;
  final bool isDigitsOnly;
  final Color textColor;
  final bool? obsecureText;
  final Widget? suffixIconWidet;
  TextDirection? textDirection;

  MyTextField(
      {Key? key,
      this.textDirection,
      this.textColor = AppColor.blackColor,
      this.obsecureText,
      this.fillColor,
      this.labelText,
      this.hintText,
      this.hintColor,
      this.labelColor,
      this.prefixIcon,
      this.suffixIcon,
      this.focusBorderColor,
      this.unfocusBorderColor,
      this.onChanged,
      this.contentPadding,
      this.enable = true,
      this.isDigitsOnly = false,
      this.text,
      this.sufixLabel,
      this.leftPadding,
      this.rightPadding,
      this.controller,
      this.focusListner,
      this.validator,
      this.suffixIconWidet,
      this.keyboardType})
      : super(key: key) {
    focusNode = FocusNode();
    if (focusListner != null) {
      focusNode.addListener(() {
        if (!focusNode.hasFocus) {
          focusListner!();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: leftPadding ?? 100.w,
        right: rightPadding ?? 100.w,
      ),
      child: TextFormField(
        obscureText: obsecureText ?? false,
        style:
            AppTextStyles.textStyleNormalBodySmall.copyWith(color: textColor),
        controller: controller ?? TextEditingController(),
        initialValue: text,
        inputFormatters:
            isDigitsOnly ? [FilteringTextInputFormatter.digitsOnly] : [],
        keyboardType: keyboardType ?? TextInputType.text,
        enabled: enable,
        //onFieldSubmitted: onChanged,
        focusNode: focusNode,
        validator: validator,
        onChanged: onChanged,
        autofocus: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(contentPadding ?? 25.h),
          fillColor: fillColor,
          labelText: hintText ?? "",
          hintText: hintText,
          filled: fillColor != null,
          hintStyle:
              AppTextStyles.textStyleBoldBodySmall.copyWith(color: hintColor),
          labelStyle: AppTextStyles.textStyleNormalBodySmall
              .copyWith(color: labelColor),
          prefixIcon: (prefixIcon != null)
              ? Padding(
                  padding: EdgeInsets.all(contentPadding ?? 100.w),
                  child: SvgViewer(
                    svgPath: prefixIcon!,
                    width: 14,
                    height: 14,
                  ),
                )
              : null,
          suffixIcon: sufixLabel != null
              ? Padding(
                  padding: EdgeInsets.all(25.h),
                  child: Text(
                    sufixLabel ?? '',
                    style: AppTextStyles.textStyleBoldBodySmall,
                  ),
                )
              : (suffixIcon != null)
                  ? Padding(
                      padding: EdgeInsets.all(25.h),
                      child: SvgViewer(
                        svgPath: suffixIcon!,
                        width: 20.w,
                        height: 20.h,
                      ),
                    )
                  : (suffixIconWidet != null)
                      ? suffixIconWidet
                      : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.r),
            borderSide:
                BorderSide(color: focusBorderColor ?? AppColor.alphaGrey),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.r),
            borderSide:
                BorderSide(color: focusBorderColor ?? AppColor.alphaGrey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.r),
            borderSide:
                BorderSide(color: unfocusBorderColor ?? AppColor.alphaGrey),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.r),
            borderSide: const BorderSide(color: AppColor.redColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.r),
            borderSide: BorderSide(
                color: focusBorderColor ?? AppColor.primaryBlueColor),
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String buttonText;
  final onTap;
  final double? padding;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? width;
  final Widget? prefixIcon;
  final Widget? postFixIcon;
  final double? height;
  final double? cornerRadius;
  final TextStyle? textStyle;
  final double? leftPadding;
  final double? rightPading;

  Button(
      {Key? key,
      required this.buttonText,
      this.onTap,
      this.prefixIcon,
      this.postFixIcon,
      this.padding,
      this.color,
      this.textColor,
      this.cornerRadius,
      this.borderColor,
      this.textStyle,
      this.width,
      this.height,
      this.leftPadding,
      this.rightPading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: () {},
      child: Padding(
        padding: EdgeInsets.only(
            left: leftPadding == null ? 10.w : leftPadding!,
            right: rightPading == null ? 10.w : rightPading!),
        child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.all(padding ?? 80.w),
          decoration: BoxDecoration(
              border: borderColor == null
                  ? null
                  : Border.all(
                      color: borderColor!,
                    ),
              borderRadius:
                  BorderRadius.all(Radius.circular(cornerRadius ?? 50.r)),
              color: color ?? AppColor.primaryBlueColor),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              prefixIcon ?? const IgnorePointer(),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    buttonText,
                    textAlign: TextAlign.center,
                    style: textStyle ??
                        AppTextStyles.textStyleBoldBodySmall
                            .copyWith(color: textColor),
                  ),
                ),
              ),
              postFixIcon ?? const IgnorePointer(),
            ],
          )),
        ),
      ),
    );
  }
}

class MyDropDown extends StatefulWidget {
  Color? fillColor;
  Function(dynamic? value)? onChange;
  dynamic? value;
  Color? borderColor;
  final Color? labelColor;
  final Color? textColor;
  final String? prefixIcon;
  final String? suffixIcon;
  List<dynamic>? items = [];
  final String? labelText;
  final String? hintText;
  final Color? hintColor;
  final double? leftPadding;
  final double? rightPadding;
  final FormFieldValidator<dynamic>? validator;
  final List<DropdownMenuItem<Object>>? itemFuntion;
  bool isDense;
  bool isItalicHint;

  MyDropDown(
      {this.fillColor,
      required this.onChange,
      this.textColor,
      this.value,
      this.items,
      this.borderColor,
      this.labelColor,
      this.prefixIcon,
      this.suffixIcon,
      this.labelText,
      this.hintText,
      this.hintColor,
      this.leftPadding,
      this.rightPadding,
      this.validator,
      this.itemFuntion,
      this.isDense = true,
      this.isItalicHint = false});

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: widget.leftPadding ?? 100.w,
        right: widget.rightPadding ?? 100.w,
      ),
      child: DropdownButtonFormField(
        icon: SvgViewer(
            height: 12,
            width: 12,
            svgPath: widget.suffixIcon ?? 'assets/icons/ic_arrow_down.svg'),
        isExpanded: true,
        validator: widget.validator,
        onTap: () {
          print("on tap");
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            hintStyle: AppTextStyles.textStyleBoldBodySmall.copyWith(
                fontStyle:
                    widget.isItalicHint ? FontStyle.italic : FontStyle.normal),
            prefixIcon: (widget.prefixIcon != null)
                ? Padding(
                    padding: EdgeInsets.all(100.w),
                    child: SvgViewer(svgPath: widget.prefixIcon!),
                  )
                : null,
            contentPadding: EdgeInsets.all(20.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.r),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.r),
              borderSide:
                  BorderSide(color: widget.borderColor ?? AppColor.greenColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.r),
              borderSide:
                  BorderSide(color: widget.borderColor ?? AppColor.greenColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.r),
              borderSide: const BorderSide(color: AppColor.orangeColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.r),
              borderSide:
                  BorderSide(color: widget.borderColor ?? AppColor.greenColor),
            ),
            filled: true,
            fillColor: widget.fillColor ?? Colors.transparent),
        onChanged: widget.onChange,
        value: widget.value,
        isDense: widget.isDense,
        hint: Text(
          widget.hintText ?? "",
          style: AppTextStyles.textStyleBoldBodySmall.copyWith(
              color: widget.hintColor,
              fontStyle:
                  widget.isItalicHint ? FontStyle.italic : FontStyle.normal),
        ),
        items: widget.items != null
            ? widget.items?.map((dynamic value) {
                return DropdownMenuItem<dynamic>(
                    value: value,
                    child: Text(
                      value.toString(),
                      style: TextStyle(
                        color: widget.textColor,
                      ),
                    ));
              }).toList()
            : widget.itemFuntion,
      ),
    );
  }
}

// ignore: must_be_immutable
class ExpandableCardContainer extends StatefulWidget {
  bool isExpanded;
  Widget collapsedChild;
  Widget expandedChild;

  ExpandableCardContainer(
      {required this.isExpanded,
      required this.collapsedChild,
      required this.expandedChild});

  @override
  _ExpandableCardContainerState createState() =>
      _ExpandableCardContainerState();
}

class _ExpandableCardContainerState extends State<ExpandableCardContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 4000),
        curve: Curves.easeInOut,
        child: widget.isExpanded ? widget.expandedChild : widget.collapsedChild,
      ),
    );
  }
}

class ExpandAbleTile extends StatefulWidget {
  ExpandableTileModel model;
  Widget? expandedWidgetChild;
  bool isCheckBox = false;
  bool isActiveCheckBox = false;
  Function? onTapCheckBox;

  ExpandAbleTile(
      {Key? key,
      required this.model,
      this.expandedWidgetChild,
      this.isCheckBox = false,
      this.onTapCheckBox,
      this.isActiveCheckBox = false})
      : super(key: key);

  @override
  State<ExpandAbleTile> createState() => _ExpandAbleTileState();
}

class _ExpandAbleTileState extends State<ExpandAbleTile> {
  _ExpandAbleTileState();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(35.r)),
      child: Container(
        color: AppColor.primaryBlueDarkColor,
        child: Column(
          children: [
            ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 10, right: 5),
              initiallyExpanded: widget.model.isExpanded,
              trailing: widget.model.isExpanded
                  ? const Icon(
                      Icons.arrow_drop_down_outlined,
                      color: AppColor.whiteColor,
                      size: 40,
                    )
                  : const Icon(
                      Icons.arrow_drop_up_outlined,
                      color: AppColor.whiteColor,
                      size: 40,
                    ),
              onExpansionChanged: (value) {
                setState(() {
                  widget.model.isExpanded = value;
                });
              },
              title: widget.isCheckBox
                  ? mySimpleCheckBox(
                      message: widget.model.title ?? "",
                      isActive: widget.isActiveCheckBox,
                      onTap: widget.onTapCheckBox)
                  : Text(
                      widget.model.title ?? "",
                      style: AppTextStyles.textStyleNormalBodyMedium
                          .copyWith(color: AppColor.whiteColor),
                    ),
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 50.w, right: 50.w, bottom: 10.h),
                        child: widget.expandedWidgetChild ??
                            Text(
                              widget.model.message ?? "",
                              textAlign: TextAlign.start,
                              style: AppTextStyles.textStyleNormalBodySmall
                                  .copyWith(color: AppColor.whiteColor),
                            ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
