import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.account_balance_wallet_rounded,
              size: 60,
              color: Color(0xFF388E3C),
            ),
            SizedBox(height: 20),
            Text(
              "XRP Crypto Value Tracker",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            SizedBox(height: 12),
            Text(
              "This app provides real-time tracking of XRP (Ripple) cryptocurrency value in Malaysian Ringgit (MYR). It fetches data from a live API and displays key metrics including last trade value, bid, ask, and 24-hour volume.",
              style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
            ),
            SizedBox(height: 24),
            Divider(),
            SizedBox(height: 12),
            Text(
              "Developer",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 6),
            Text(
              "Nur Aliya Yasmin Binti Mohamad Hafiz\nCS251 • Matric No: 2023103013",
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
