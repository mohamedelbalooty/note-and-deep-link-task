import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:note_task/utils/theme/colors.dart';
import '../model/error_result.dart';

class IconButtonUtil extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final VoidCallback onClick;

  const IconButtonUtil(
      {Key? key,
      required this.icon,
      this.color = blackClr,
      this.size = 26.0,
      required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      color: color,
      iconSize: size,
      onPressed: onClick,
    );
  }
}

class ElevatedButtonUtil extends StatelessWidget {
  final String title;
  final VoidCallback onClick;

  const ElevatedButtonUtil(
      {Key? key, required this.title, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        title,
        style: const TextStyle(
          color: whiteClr,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(mainClr),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 5, horizontal: 20)),
        shape: MaterialStateProperty.all<BeveledRectangleBorder>(
          BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      onPressed: onClick,
    );
  }
}

class TextFormFiledUtil extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?) onValidate;

  const TextFormFiledUtil(
      {Key? key,
      required this.label,
      required this.controller,
      required this.onValidate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: blackClr,
      controller: controller,
      validator: onValidate,
      style: const TextStyle(
        color: blackClr,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: const TextStyle(
          color: blackClr,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        enabledBorder: _border,
        focusedBorder: _border,
        errorBorder: _border,
        focusedErrorBorder: _border,
      ),
    );
  }

  final OutlineInputBorder _border = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
    borderSide: BorderSide(color: mainClr, width: 2),
  );
}

class LoadingUtil extends StatelessWidget {
  const LoadingUtil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(mainClr)));
  }
}

class ErrorResultUtil extends StatelessWidget {
  const ErrorResultUtil({Key? key, required this.errorResult})
      : super(key: key);
  final ErrorResult errorResult;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              errorResult.image,
              height: 200,
              width: MediaQuery.of(context).size.width * 0.8,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 20),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Center(
                child: Text(
                  errorResult.message,
                  style: const TextStyle(
                    color: whiteClr,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void onShowToast({required String toastMessage}) {
  Fluttertoast.showToast(
      msg: toastMessage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: Colors.black87.withOpacity(0.5),
      fontSize: 16);
}

void onNavigate(BuildContext context, {required Widget page}) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}

void onPop(BuildContext context) {
  Navigator.pop(context);
}
