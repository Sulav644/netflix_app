import 'package:flutter/material.dart';

class LoaderPage extends StatefulWidget {
  final Widget goToPage;
  const LoaderPage({super.key, required this.goToPage});

  @override
  State<LoaderPage> createState() => _LoaderPageState();
}

class _LoaderPageState extends State<LoaderPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) =>
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return widget.goToPage;
        })));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      ),
    );
  }
}
