import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Completion extends StatelessWidget {
  const Completion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shadowColor: Colors.grey,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularPercentIndicator(
              animation: true,
              animationDuration: 2000,
              radius: 60,
              lineWidth: 10,
              percent: 0.5,
              progressColor: Colors.black,
              backgroundColor: Colors.black12,
              circularStrokeCap: CircularStrokeCap.round,
              center: Text(
                '50%',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Text(
                '50% Completed',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                'Try Your Best !',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
