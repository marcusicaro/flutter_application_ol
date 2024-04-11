import 'package:flutter/material.dart';

class CustomFutureBuilder extends StatelessWidget {
  final Future future;
  final String errorMessage;
  final Function(BuildContext, AsyncSnapshot) buildSuccessState;

  const CustomFutureBuilder({
    super.key,
    required this.future,
    required this.errorMessage,
    required this.buildSuccessState,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              errorMessage,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        } else {
          return buildSuccessState(context, snapshot);
        }
      },
    );
  }
}
