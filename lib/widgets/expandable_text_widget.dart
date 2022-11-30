import 'package:flutter/material.dart';
import 'package:food_delivary_app/utils/colors.dart';
import 'package:food_delivary_app/utils/dimansion.dart';
import 'package:food_delivary_app/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({super.key, required this.text});

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddentext = true;

  double textHeight = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
              text: firstHalf,
              size: Dimensions.font20 / 1.2,
              color: AppColors.paraColor,
              height: 1.8,
            )
          : Column(
              children: [
                SmallText(
                  text: hiddentext
                      ? (" $firstHalf...")
                      : (firstHalf + secondHalf),
                  size: Dimensions.font20 / 1.2,
                  color: AppColors.paraColor,
                  height: 1.8,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddentext = !hiddentext;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                        text: "Show more ",
                        color: AppColors.mainColor,
                        size: Dimensions.font20 / 1.1,
                      ),
                      Icon(
                        hiddentext
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: AppColors.mainColor,
                        size: Dimensions.iconSize24 + 6,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
