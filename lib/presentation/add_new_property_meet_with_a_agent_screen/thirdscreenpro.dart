import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DataEditScreen extends StatefulWidget {
  final User user;

  DataEditScreen({required this.user});

  @override
  _DataEditScreenState createState() => _DataEditScreenState();
}

class _DataEditScreenState extends State<DataEditScreen> {
  int currentPage = 0;
  int itemsPerPage = 1; // Số

  DateTime? selectedDate = DateTime.now();
  TimeOfDay? selectedTime = TimeOfDay.now();
  TimeOfDay? selectedArrivalTime;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  void didChangeDependencies() {
    super.didChangeDependencies();
    _dateController.text = selectedDate != null
        ? "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}"
        : '';
    _timeController.text = selectedTime?.format(context) ?? '';

    selectedArrivalTime = _calculateArrivalTime(selectedTime!);
  }

  TimeOfDay _calculateArrivalTime(TimeOfDay startTime) {
    final int minutesPerHour = 60;
    final int minutesToAdd = 30;

    int totalMinutes =
        startTime.hour * minutesPerHour + startTime.minute + minutesToAdd;
    int arrivalHour = totalMinutes ~/ minutesPerHour;
    int arrivalMinute = totalMinutes % minutesPerHour;

    return TimeOfDay(hour: arrivalHour, minute: arrivalMinute);
  }

  Future<void> _updateDataInFirestore(String documentId) async {
    final collection = FirebaseFirestore.instance.collection('user_request');

    await collection.doc(documentId).update({
      'selectedDate': Timestamp.fromDate(selectedDate!),
      'selectedTime': _timeController.text, // Update the time
      'selectedArrivalTime': selectedArrivalTime!.format(context),
    });
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        _dateController.text =
            "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}";
      });
    }
  }

  Future<TimeOfDay?> _showCustomTimePicker(BuildContext context) async {
    final now = TimeOfDay.now();
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: now,
    );

    if (selectedTime == null) {
      return null;
    }

    final selectedDateTime = DateTime.now()
        .add(Duration(hours: selectedTime.hour, minutes: selectedTime.minute));
    final currentTime = DateTime.now();

    if (selectedDateTime.isBefore(currentTime)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("The time period you selected has elapsed"),
            content: Text("Please choose a suitable time."),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      // Hiển thị thông báo lỗi nếu chọn thời gian đã qua
      return null;
    }

    return selectedTime;
  }

  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await _showCustomTimePicker(context);
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
        _timeController.text = selectedTime!.format(context);
        selectedArrivalTime = _calculateArrivalTime(selectedTime!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sửa thông tin đăng ký'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('user_request')
              .where('userId', isEqualTo: widget.user.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error fetching data'));
            }

            final documents = snapshot.data as QuerySnapshot;
            if (documents.docs.isEmpty) {
              return Center(child: Text('Dữ liệu đặt lịch trống'));
            }
            final List<List<QueryDocumentSnapshot>> pages =
                List<List<QueryDocumentSnapshot>>.generate(
                    (documents.size / itemsPerPage).ceil(), (int index) {
              int start = index * itemsPerPage;
              int end = (index + 1) * itemsPerPage;
              if (end > documents.size) {
                end = documents.size;
              }
              return documents.docs.sublist(start, end);
            });

            final currentPageData = pages[currentPage];

            return ListView.builder(
              padding: EdgeInsets.only(top: 8),
              itemCount: currentPageData.length,
              itemBuilder: (context, index) {
                final document = currentPageData[index];
                final data = document.data() as Map<String, dynamic>;
                final selectedDate = data['selectedDate'] as Timestamp;
                final formattedDate = DateTime.fromMillisecondsSinceEpoch(
                        selectedDate.seconds * 1000)
                    .toString();
                final phoneNumber = data['phoneNumber'] ?? '';
                final devices = data['devices'] ?? '';
                final businessName = data['businessName'] ?? '';
                final businessCode = data['businessCode'] ?? '';
                final representative = data['representative'] ?? '';
                final address = data['address'] ?? '';
                final selectedTime = data['selectedTime'] ?? '';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      enabled: false,
                      initialValue: businessName,
                      decoration: InputDecoration(
                        labelText: 'Tên công ty',
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      enabled: false,
                      initialValue: businessCode,
                      decoration: InputDecoration(
                        labelText: 'Mã số doanh nghiệp',
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      enabled: false,
                      initialValue: representative,
                      decoration: InputDecoration(
                        labelText: 'Người liên hệ',
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      enabled: false,
                      initialValue: phoneNumber,
                      decoration: InputDecoration(
                        labelText: 'Số điện thoại',
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      enabled: false,
                      initialValue: devices,
                      decoration: InputDecoration(
                        labelText: 'Các thiết bị cần bảo trì',
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      enabled: false,
                      initialValue: address,
                      decoration: InputDecoration(
                        labelText: 'Địa chỉ',
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _dateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Chọn ngày: $formattedDate',
                        suffixIcon: InkWell(
                          onTap: _selectDate,
                          child: Icon(Icons.calendar_today),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _timeController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Chọn giờ: $selectedTime',
                        suffixIcon: InkWell(
                          onTap: _selectTime,
                          child: Icon(Icons.access_time),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ... Existing form fields ...

                        // Save Button
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List<Widget>.generate(pages.length,
                              (int pageIndex) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentPage = pageIndex;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 6),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: pageIndex == currentPage
                                      ? Colors.blue
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  (pageIndex + 1).toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  await _updateDataInFirestore(
                                      document.id); // Pass the document ID
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Data saved successfully')),
                                  );
                                },
                                child: Text('Lưu'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
