import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class SimpleMapScreen extends StatefulWidget {
  @override
  _SimpleMapScreenState createState() => _SimpleMapScreenState();
}

class _SimpleMapScreenState extends State<SimpleMapScreen> {
  double? latitude;
  double? longitude;
  bool isLoading = true;

  final double destinationLatitude = 10.3788;
  final double destinationLongitude = 78.3877;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enable location services.")),
        );
        setState(() => isLoading = false);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Location permissions are denied.")),
          );
          setState(() => isLoading = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Location permissions are permanently denied.")),
        );
        setState(() => isLoading = false);
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
        isLoading = false;
      });

      // Automatically navigate to the destination
      _navigateToDestination();
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching location: $e")),
      );
    }
  }

  Future<void> _navigateToDestination() async {
    if (latitude == null || longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Current location is not available.")),
      );
      return;
    }

    final String googleMapsUrl =
        "https://www.google.com/maps/dir/?api=1&origin=$latitude,$longitude&destination=$destinationLatitude,$destinationLongitude&travelmode=driving";

    final String appleMapsUrl =
        "https://maps.apple.com/?saddr=$latitude,$longitude&daddr=$destinationLatitude,$destinationLongitude";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else if (await canLaunch(appleMapsUrl)) {
      await launch(appleMapsUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not launch map for navigation.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigate to Destination'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Text(
                "Fetching your location and navigating to the destination...",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}










// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';

// class SimpleMapScreen extends StatefulWidget {
//   @override
//   _SimpleMapScreenState createState() => _SimpleMapScreenState();
// }

// class _SimpleMapScreenState extends State<SimpleMapScreen> {
//   double? latitude;
//   double? longitude;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   Future<void> _getCurrentLocation() async {
//     try {
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Please enable location services.")),
//         );
//         setState(() => isLoading = false);
//         return;
//       }

//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text("Location permissions are denied.")),
//           );
//           setState(() => isLoading = false);
//           return;
//         }
//       }

//       if (permission == LocationPermission.deniedForever) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content: Text("Location permissions are permanently denied.")),
//         );
//         setState(() => isLoading = false);
//         return;
//       }

//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       setState(() {
//         latitude = position.latitude;
//         longitude = position.longitude;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() => isLoading = false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error fetching location: $e")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Geolocator Map Example'),
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : latitude == null || longitude == null
//               ? Center(child: Text("Unable to fetch location."))
//               : Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Your Location:",
//                         style: TextStyle(fontSize: 20),
//                       ),
//                       Text(
//                         "Latitude: $latitude",
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       Text(
//                         "Longitude: $longitude",
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       SizedBox(height: 20),
//                       Container(
//                         width: MediaQuery.of(context).size.width * 0.8,
//                         height: 300,
//                         color: Colors.grey[300],
//                         child: CustomPaint(
//                           painter: MapPainter(
//                               latitude: latitude!, longitude: longitude!),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//     );
//   }
// }

// class MapPainter extends CustomPainter {
//   final double latitude;
//   final double longitude;

//   MapPainter({required this.latitude, required this.longitude});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.blue
//       ..style = PaintingStyle.fill;

//     // Simulate a simple map with a marker
//     canvas.drawRect(
//       Rect.fromLTWH(0, 0, size.width, size.height),
//       paint..color = Colors.lightBlueAccent,
//     );

//     final markerPaint = Paint()..color = Colors.red;

//     // Draw a marker
//     canvas.drawCircle(
//       Offset(size.width / 2, size.height / 2),
//       10,
//       markerPaint,
//     );

//     // Draw coordinates text
//     final textSpan = TextSpan(
//       text: 'Lat: $latitude, Lng: $longitude',
//       style: TextStyle(color: Colors.black, fontSize: 12),
//     );
//     final textPainter = TextPainter(
//       text: textSpan,
//       textDirection: TextDirection.ltr,
//     );
//     textPainter.layout();
//     textPainter.paint(canvas,
//         Offset(size.width / 2 - textPainter.width / 2, size.height - 20));
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
