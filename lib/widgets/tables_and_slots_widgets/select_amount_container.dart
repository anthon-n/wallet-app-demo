import 'package:acresapp/common/helpers/size_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectAmountContainer extends StatefulWidget {
  String? amount;
  Color? color;
  bool isDollarSignNeeded;

  SelectAmountContainer({required this.amount, required this.color, this.isDollarSignNeeded = true});

  @override
  _SelectAmountContainerState createState() => _SelectAmountContainerState();
}

class _SelectAmountContainerState extends State<SelectAmountContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SizeBlock.v! * 10, vertical: SizeBlock.v! * 3),
      width: SizeBlock.h! * 100,
      height: SizeBlock.v! * 44,
      decoration: BoxDecoration(
        border: Border.all(color: widget.color!,),
        borderRadius: BorderRadius.circular(SizeBlock.v! * 10,),
      ),
      child: Row(
        children: <Widget>[
          Text('+',
             style: TextStyle(
                  fontFamily: 'KorolevCompressed',
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: SizeBlock.v! * 30)),
          const Spacer(),
          RichText(
            text: TextSpan(
              children: <InlineSpan>[
                if (widget.isDollarSignNeeded) WidgetSpan(
                  alignment: PlaceholderAlignment.top,
                  baseline: TextBaseline.alphabetic,
                  child: Transform.translate(
                    offset: const Offset(0.0, 2.0),
                    child:  Text(
                        '\$',
                        style: TextStyle(
                            fontFamily: 'KorolevCompressed',
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: SizeBlock.v! * 20)
                    ),
                  ),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.top,
                  baseline: TextBaseline.alphabetic,
                  child: Transform.translate(
                    offset: const Offset(0.0, 0.0),
                    child:
                    Text(widget.amount.toString(),
                        style: TextStyle(
                            fontFamily: 'KorolevCompressed',
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: SizeBlock.v! * 30)
                    ),

                  ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}