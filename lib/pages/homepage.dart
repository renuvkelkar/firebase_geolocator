import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:geocoder/model.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isCheckin = false;

  var locationMessage = '';
  var locationMessage1 = '';
  var CheckOuttimeMessage = '';
  var checkinAddress = '';
  var checkOutAddress = '';
  var checkinDateMeg = '';

  var CheckintimeMessage = '';
  String latitude;
  String longitude;
  Position _position;
  Address _address;
  Future<Address>convertCoordinatesToAddress(Coordinates coordinates)async {
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);
    return addresses.first;
  }

  void getCurrentLocation() async {

    String now = DateFormat("dd-MM-yyyy hh:mm:ss").format(DateTime.now());
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;
    var checkinDate = DateFormat("dd/MM/yyyy",).format(DateTime.now());
    var checkinTime = DateFormat("hh:mm").format(DateTime.now());


    // passing this to latitude and longitude strings
    latitude = "$lat";
    longitude = "$long";
    final coordinates=new Coordinates(position.latitude, position.longitude);
    convertCoordinatesToAddress(coordinates).then((value)=>_address=value);

    setState(() {
      checkinDateMeg = "$checkinDate";
      locationMessage = "Latitude: $lat and Longitude: $long";

      checkinAddress = "Address from Coordinates1 : ${_address?.addressLine ?? '-'}";
      CheckintimeMessage = "$checkinTime ";

      Text(DateFormat("dd/MM/yyyy",).format(DateTime.now()),
          style: TextStyle(fontSize: 15,));
    });
  }
  void getCurrentLocation1() async {
    String now = DateFormat("dd-MM-yyyy hh:mm:ss").format(DateTime.now());
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;
   // var checkinDate = DateFormat("dd/MM/yyyy",).format(DateTime.now());
    var checkOutTime = DateFormat("hh:mm").format(DateTime.now());


    // passing this to latitude and longitude strings
    latitude = "$lat";
    longitude = "$long";
    final coordinates=new Coordinates(position.latitude, position.longitude);
    convertCoordinatesToAddress(coordinates).then((value)=>_address=value);

    setState(() {
      locationMessage1 = "Latitude: $lat and Longitude: $long";
      checkOutAddress = "Address from Coordinates1 : ${_address?.addressLine ?? '-'}";
      CheckOuttimeMessage = "CheckOut time: $checkOutTime ";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("Firebase Geo locator"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              size: 45.0,
              color: Colors.white,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Get User Location",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              locationMessage,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 05.0,
            ),
            Text("Checkin Date", style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold,)),
            Text(checkinDateMeg),
            SizedBox(
              height: 05.0,
            ),
            Text("Checkin time", style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold,)),
            Text(CheckintimeMessage),
            // Text("""Address from Coordinates""",
            //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
            SizedBox(height: 20),
            Text(checkinAddress,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,)),

            // button for taking the location
            !isCheckin?MaterialButton(
              color: Colors.white,
              onPressed: () {
                getCurrentLocation();
                isCheckin = true;
              },
              child: Text("Check In"),
            ): MaterialButton(
              color: Colors.white,
              onPressed: () {
                getCurrentLocation1();
                isCheckin = false;
              },
              child: Text("Check Out "),
            ),

            SizedBox(
              height: 30.0,
            ),
            Text(
              locationMessage1,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 05.0,
            ),
            Text("Checkout time", style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold,)),
            Text(CheckOuttimeMessage),
            Text(checkOutAddress),


            // FlatButton(
            //   color: Colors.white,
            //   onPressed: () {
            //     googleMap();
            //   },
            //   child: Text("Open GoogleMap"),
            // ),
          ],
        ),
      ),
    );
  }
}

