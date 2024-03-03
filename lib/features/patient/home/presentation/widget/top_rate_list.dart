import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/appColors.dart';
import 'package:se7ety/core/widget/doctorCard.dart';
import 'package:se7ety/features/patient/search/presentation/widget/doctor_profile.dart';

class topListView extends StatefulWidget {
  const topListView({super.key});

  @override
  State<topListView> createState() => _topListViewState();
}

class _topListViewState extends State<topListView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('doctor')
            .orderBy('rating', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                //physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doctor = snapshot.data!.docs[index];
                  if (doctor['name'] == null ||
                      doctor['specialization'] == null ||
                      doctor['image'] == null ||
                      doctor['rating'] == null) {
                    return Container(
                      height: 50,
                      width: double.infinity,
                      color: appColors.bottonColor,
                    );
                  }
                  return doctor_card(
                      name: doctor['name'],
                      image: doctor['image'],
                      specialization: doctor['specialization'],
                      rating: doctor['rating'],
                      onPreesed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              DoctorProfile(email: doctor['email']),
                        ));
                      });
                });
          }
        },
      ),
    );
  }
}
