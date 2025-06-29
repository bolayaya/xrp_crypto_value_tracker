import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'services/api_service.dart';
import 'about_page.dart';

void main() {
  runApp(XRPTrackerApp());
}

class XRPTrackerApp extends StatelessWidget {
  const XRPTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XRP Tracker',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFFDFDFB),
        primaryColor: Color(0xFFC7C7BB),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFC7C7BB),
          foregroundColor: Colors.black,
          elevation: 0,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),

      home: const XRPHomePage(),
    );
  }
}

class XRPHomePage extends StatefulWidget {
  const XRPHomePage({super.key});

  @override
  _XRPHomePageState createState() => _XRPHomePageState();
}

class _XRPHomePageState extends State<XRPHomePage> {
  double? xrpValue;
  String bid = '-';
  String ask = '-';
  String volume = '-';

  @override
  void initState() {
    super.initState();
    fetchXRP();
  }

  Future<void> fetchXRP() async {
    try {
      final response = await http.get(Uri.parse(ApiService.apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          xrpValue = double.tryParse(data['last_trade']);
          bid = data['bid'];
          ask = data['ask'];
          volume = data['rolling_24_hour_volume'];
        });
      }
    } catch (e) {
      print("Error fetching XRP data: $e");
    }
  }

  // 👇 Move build() inside _XRPHomePageState
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live XRP Price Tracker (MYR)"),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AboutPage()),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: fetchXRP,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Center(
            child: xrpValue == null
                ? const CircularProgressIndicator()
                : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "XRP to MYR",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "MYR ${xrpValue!.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.white,
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        infoRow("Bid Price", bid),
                        infoRow("Ask Price", ask),
                        infoRow("Last Trade", xrpValue!.toStringAsFixed(2)),
                        infoRow("24h Volume", volume),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: fetchXRP,
                  icon: const Icon(Icons.refresh),
                  label: const Text("Refresh Price"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFC7C7BB),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget
  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[800])),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
