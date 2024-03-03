import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/appColors.dart';
import 'package:se7ety/core/utils/text_style.dart';
import 'package:se7ety/core/widget/custom_button.dart';
import 'package:se7ety/core/widget/title_widget.dart';
import 'package:se7ety/features/patient/search/data/doctorModel.dart';
import 'package:se7ety/features/patient/search/presentation/widget/booking.dart';
import 'package:se7ety/features/patient/search/presentation/widget/contact_icon.dart';

class DoctorProfile extends StatefulWidget {
  final String? email;

  const DoctorProfile({super.key, this.email});
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  late doctorModel doctor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.bottonColor,
        title: Text(
          'بيانات الدكتور',
          style: getTitleStyle(color: appColors.scaffColor),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            splashRadius: 25,
            icon: Icon(
              Icons.arrow_back_ios,
              color: appColors.bottonColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('doctor')
            .where('email', isEqualTo: widget.email)
            .snapshots(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var userData = snapshot.data!.docs.first;
          doctor = doctorModel(
              id: '',
              bio: userData['bio'],
              phone1: userData['phone1'],
              phone2: userData['phone2'],
              name: userData['name'],
              image: userData['image'],
              specialization: userData['specialization'],
              rating: userData['rating'],
              email: userData['email'],
              openHour: userData['openHour'],
              closeHour: userData['closeHour'],
              address: userData['address']);
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                // ------------ Header ---------------
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: appColors.scaffColor,
                          child: CircleAvatar(
                            backgroundColor: appColors.scaffColor,
                            radius: 60,
                            backgroundImage: (userData['image'] != null)
                                ? NetworkImage(userData['image'])
                                    as ImageProvider
                                : const AssetImage('assets/doc.png'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "د. ${userData['name']}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: getTitleStyle(),
                          ),
                          Text(
                            userData['specialization'],
                            style: getbodyStyle(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                userData['rating'].toString(),
                                style: getbodyStyle(),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              const Icon(
                                Icons.star_rounded,
                                size: 20,
                                color: Colors.orange,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              IconTile(
                                onTap: () {},
                                backColor: appColors.bottonColor,
                                imgAssetPath: Icons.phone,
                                num: '1',
                              ),
                              if (userData['phone2'] != null)
                                IconTile(
                                  onTap: () {},
                                  backColor: appColors.bottonColor,
                                  imgAssetPath: Icons.phone,
                                  num: '2',
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  "نبذه تعريفية",
                  style: getbodyStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  userData['bio'],
                  style: getSmallStyle(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 169, 216, 255),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TileWidget(
                          text:
                              '${userData['openHour']} - ${userData['closeHour']}',
                          icon: Icons.watch_later_outlined),
                      const SizedBox(
                        height: 15,
                      ),
                      TileWidget(
                          text: userData['address'],
                          icon: Icons.location_on_rounded),
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "معلومات الاتصال",
                  style: getbodyStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 169, 216, 255),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TileWidget(text: userData['email'], icon: Icons.email),
                      const SizedBox(
                        height: 15,
                      ),
                      TileWidget(text: userData['phone1'], icon: Icons.call),
                      const SizedBox(
                        height: 15,
                      ),
                      if (userData['phone2'] != null)
                        TileWidget(text: userData['phone2'], icon: Icons.call),
                    ],
                  ),
                ),
              ],
            )),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: customButton(
          text: 'احجز موعد الان',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingView(doctor: doctor),
              ),
            );
          },
        ),
      ),
    );
  }
}
