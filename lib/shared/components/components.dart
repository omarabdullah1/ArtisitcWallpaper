import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../styles/colors.dart';

Widget defaultButton({
  double? width = double.infinity,
  double? height = double.infinity,
  IconData? icon,
  background = Colors.black,
  bool isUpperCase = true,
  bool isIcon = false,
  double radius = 3.0,
  required Function function,
  required String text,
}) {
  return Container(
    width: width,
    height: height,
    child: MaterialButton(
      onPressed: () => function,
      child: isIcon
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text(
                  isUpperCase ? text.toUpperCase() : text,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            )
          : Text(
              isUpperCase ? text.toUpperCase() : text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        radius,
      ),
      color: background,
    ),
  );
}

Widget defaultButton2({
  double? width,
  double? height,
  background = defaultColor2,
  bool isUpperCase = true,
  double radius = 3.0,
  IconData? ico,
  required Function function,
  required String text,
}) {
  return Container(
    width: width,
    height: height,
    child: MaterialButton(
      onPressed: ()=>function,
      child: ico != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  ico,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Text(
                  isUpperCase ? text.toUpperCase() : text,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            )
          : Text(
              isUpperCase ? text.toUpperCase() : text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        radius,
      ),
      color: background,
    ),
  );
}

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: ()=>function,
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  ValueChanged<String>? onChange,
  Function? onTap,
  bool isPassword = false,
  bool isValidate = false,
  bool isPrefixText = false,
  Function? validate,
  required String label,
  @required prefix,
  required IconData suffix,
  required Function suffixPressed,
  bool isClickable = true,
  double borderRadius = 20.0,
  double fontSize = 16.0,
}) =>
    TextFormField(
      style: TextStyle(fontSize: fontSize),
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (_)=>onSubmit,
      onChanged: onChange,
      onTap: ()=>onTap,
      validator:  (_)=>validate!(),
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black12,
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black26,
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        labelText: label,
        labelStyle: TextStyle(fontSize: fontSize),
        prefixIcon: isPrefixText
            ? prefix
            : Icon(
                prefix,
              ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: ()=>suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black26,
              width: 2.5,
            ),
            borderRadius: BorderRadius.circular(borderRadius)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );

Widget searchFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  bool isValidate = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (_)=>onSubmit,
      onChanged: (_)=>onChange,
      onTap: ()=>onTap,
      validator: (_)=> validate(),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: ()=>suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0)),
      ),
    );


Widget myDivider({height = 1.0}) => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: height,
        color: Colors.grey[300],
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates { success, error, warning }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }

  return color;
}


Widget buildCategoryButton(String imagePath) {
  return Stack(
    alignment: Alignment.center,
    children: [
      const SizedBox(
        height: 150.0,
        child: CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
        ),
      ),
      Positioned(
          top: 20.0,
          child: Image.asset(
            imagePath,
            width: 70,
          )),
    ],
  );
}
