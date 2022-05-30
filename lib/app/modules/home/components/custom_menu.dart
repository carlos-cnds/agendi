import 'package:flutter/material.dart';

class CustomMenu extends StatelessWidget {
  final Function onPress;
  const CustomMenu({Key? key, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          child: Container(
            width: 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 2.5,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2)),
                ),
                SizedBox(
                  height: 7,
                ),
                Container(
                  height: 2.5,
                  width: 21,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2)),
                ),
                SizedBox(
                  height: 7,
                ),
                Container(
                  height: 2.5,
                  width: 13,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2)),
                )
              ],
            ),
          ),
          onTap: () => onPress,
        )
      ],
    );
  }
}
