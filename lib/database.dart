// ignore_for_file: unnecessary_new

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:guard/screens/details/details_screen1.dart';

late final RTreference = FirebaseDatabase.instance.reference();

// writing into a realtime firebase
WTDBWrite() {
  RTreference.child("SensorInfo").set({
    'Status': "true",
    'Name': "test",
    'Location': "test",
    'ID': '3',
    'Description': null
  });
}

Stream<Map<String, dynamic>> getReadings(SensorName) {
  final transformer =
      StreamTransformer<Event, Map<String, dynamic>>.fromHandlers(
          handleData: (Event event, EventSink<Map<String, dynamic>> sink) {
    final document = Map.from(event.snapshot.value);
    sink.add(Map.from(document.values.first));
  });

  return RTreference.child(SensorName)
      .orderByKey()
      .limitToLast(1)
      .onValue
      .transform(transformer);
}

x() {
  Future<int> GetInitial(String SensorName) async {
    final dbRef = FirebaseDatabase.instance.reference().child(SensorName);
    final snapshot = await dbRef.child(SensorName).once();
    print('Data : ${snapshot.value}');
    return int.parse(snapshot.value);
  }
}

CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('SensorInfo');

// getting all data from Cloud data base
getData(sensor, field) async {
  // Get docs from collection reference
  DocumentSnapshot documentSnapshot = await _collectionRef.doc(sensor).get();
  final allData = documentSnapshot.get(field);
  return (allData);
}

// Reading data from the Cloud firebase
readData(DocId, field) {
  DocumentReference documentReference =
      FirebaseFirestore.instance.collection("SensorInfo").doc(DocId);

  return documentReference.get().then((dataSnapshot) {
    return (dataSnapshot.get(field));
  });
}

// Updating Cloud firebase Values.
updateData(DocId, field, value) {
  DocumentReference documentReference =
      FirebaseFirestore.instance.collection("SensorInfo").doc(DocId);
  documentReference.update({field: value});
}
