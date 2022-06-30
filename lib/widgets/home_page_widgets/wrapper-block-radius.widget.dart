import 'package:acresapp/common/helpers/size_block.dart';
import 'package:flutter/material.dart';

class WrapperBlockRadiusWidget extends StatelessWidget {
  const WrapperBlockRadiusWidget(this.child);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      offset: const  Offset(0, 20),
                      blurRadius: SizeBlock.v! * 40,
                      )
                ],
                color: Colors.white,
                border: Border.all(width: 5, color: Colors.white),
                borderRadius: BorderRadius.circular(SizeBlock.v! * 40)),
            child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(SizeBlock.v! * 30)),
                child: child)));
  }
}
