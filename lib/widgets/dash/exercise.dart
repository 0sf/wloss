import 'package:flutter/material.dart';

class ShowExcercise extends StatelessWidget {
  final double dif;
  final List<String> excr;
  ShowExcercise(this.dif, this.excr);

  @override
  Widget build(BuildContext context) {
    if (dif < 0) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: <Widget>[
            // Text(excr.join(' , '),
            //     style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 16,
            //         color: Colors.purple.shade300)),

            Container(
              height: 55,
              child: ListView.builder(
                itemCount: excr.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext ctx, int index) {
                  return Container(
                    width: 100,
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(excr[index]),
                                content: Text(
                                  " You can do ${excr[index]} for 40 min to loose the extra ${((-1) * dif).toStringAsFixed(1)} calorie amount",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              );
                            });
                      },
                      child: Text(
                        excr[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.purple.shade400,
                        ),
                      ),
                    ),

                    // InkWell(

                    //     child: Text(
                    //       excr[index],
                    //       style: TextStyle(
                    //           fontWeight: FontWeight.bold, fontSize: 16),
                    //     ),
                    //     onTap: () {
                    //       print('tapped!');
                    //     }),
                  );
                },
              ),
            ),
            // SizedBox(
            //   height: 20,
            // ),
            // Text(
            //   " You can do ${excr[0]} for 40 min to loose the extra ${((-1) * dif).toStringAsFixed(1)} calorie amount",
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            // ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
