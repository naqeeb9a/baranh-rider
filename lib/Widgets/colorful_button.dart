import 'package:flutter/material.dart';

import '../utils/dynamic_sizes.dart';

colorfulButton(context, text, buttonColor, borderColor, fontWeight,
    {function = ""}) {
  return InkWell(
    onTap: function == "" ? () {} : function,
    child: Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1.5, color: borderColor),
                color: buttonColor,
                borderRadius: BorderRadius.circular(
                    CustomSizes().dynamicWidth(context, 0.1))),
            padding: EdgeInsets.all(CustomSizes().dynamicWidth(context, 0.035)),
            child: Center(
                child: Text(
              text,
              style: TextStyle(fontWeight: fontWeight),
            )),
          ),
        ),
      ],
    ),
  );
}
