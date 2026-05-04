import 'package:flutter/material.dart';
import 'package:workers_campe/screens/LoginPage.dart';
import 'package:workers_campe/screens/deliveryDetailPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Color kGreen = Color(0xFF639922);
const Color kGreenLight = Color(0xFFEAF3DE);

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreenLight,
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: kGreen,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () async {
            final sp = await SharedPreferences.getInstance();
            await sp.setBool('isUserLogged', false);

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          icon: Icon(Icons.logout),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Available deliveries',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kGreen,
                ),
              ),

              SizedBox(height: 25),

              InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DeliveryDetailPage(
                        deliveryNumber: 1,
                        deadline: '18:30',
                        destinationAddress: '221B Baker Street',
                        distanceKm: 3.4,
                        estimatedMinutes: 16,
                        points: 45,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: kGreenLight,
                        child: Icon(
                          Icons.directions_bike,
                          color: kGreen,
                          size: 34,
                        ),
                      ),

                      SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Delivery #1',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 6),

                            Text(
                              '221B Baker Street',
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),

                            SizedBox(height: 6),

                            Text(
                              '3.4 km • 16 min • +45 pts',
                              style: TextStyle(
                                color: kGreen,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}