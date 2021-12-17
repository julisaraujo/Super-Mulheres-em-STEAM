import 'package:flutter/material.dart';

class DrawerCard extends StatelessWidget {

  final String text;
  final PageController controller;
  final int page;

  DrawerCard(this.text, this.controller,this.page);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        child: Material(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: InkWell(
            onTap: (){
              Navigator.of(context).pop();
              controller.jumpToPage(page);
            },
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                color: controller.page.round() == page ?
                Colors.white12 : Colors.transparent,
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 20.0,),
                  Material(
                    color: Colors.transparent,
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
