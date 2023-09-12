import 'package:aokiji_s_application4/presentation/filter_screen/filter_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import thư viện Firestore
import 'package:aokiji_s_application4/core/utils/color_constant.dart';
import 'package:aokiji_s_application4/core/utils/image_constant.dart';
import 'package:aokiji_s_application4/core/utils/size_utils.dart';
import 'package:aokiji_s_application4/presentation/notification_screen/notification_screen.dart';
import 'package:aokiji_s_application4/widgets/app_bar/appbar_iconbutton_1.dart';
import 'package:aokiji_s_application4/widgets/app_bar/appbar_subtitle.dart';
import 'package:aokiji_s_application4/widgets/app_bar/custom_app_bar.dart';

class DateTimePickerScreen extends StatefulWidget {
  @override
  _DateTimePickerScreenState createState() => _DateTimePickerScreenState();
}

class _DateTimePickerScreenState extends State<DateTimePickerScreen> {
  DateTime? selectedDate = DateTime.now();
  TimeOfDay? selectedTime = TimeOfDay.now();
  TimeOfDay? selectedArrivalTime;

  Future<bool> onBackPressed() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                FilterScreen())); // Navigate back to the previous screen
    return Future.value(false); // Prevent default back navigation
  }

  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _businessCodeController = TextEditingController();
  final TextEditingController _representativeController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController =
      TextEditingController(); // New controller
  final TextEditingController _devicesController =
      TextEditingController(); // New controller
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
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
            title: Text("Khoảng thời gian bạn chọn đã trôi qua"),
            content: Text("Vui lòng chọn khoảng thời gian phù hợphợp"),
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

  Future<void> _saveDataToFirestore() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('user_request');

    if (_businessNameController.text.isEmpty ||
        _businessCodeController.text.isEmpty ||
        _representativeController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _phoneNumberController.text.isEmpty || // New check
        _devicesController.text.isEmpty || // New check
        selectedDate == null ||
        selectedTime == null ||
        selectedArrivalTime == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Lỗi"),
            content: Text("Vui lòng nhập đầy đủ thông tin"),
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
    } else {
      await collection.add({
        'userId': user?.uid,
        'businessName': _businessNameController.text,
        'businessCode': _businessCodeController.text,
        'representative': _representativeController.text,
        'address': _addressController.text,
        'phoneNumber': _phoneNumberController.text, // New field
        'devices': _devicesController.text, // New field
        'selectedDate': selectedDate,
        'selectedTime': selectedTime!.format(context),
        'selectedArrivalTime': selectedArrivalTime!.format(context),
        'status': 'Đặt trước',
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Thành công"),
            content: Text("Dữ liệu đã được lưu"),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationScreen(),
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorConstant.gray50,
          appBar: CustomAppBar(
            title: AppbarSubtitle(text: 'Thông tin đăng ký'),
            height: getVerticalSize(48),
            leadingWidth: 64,
            leading: AppbarIconbutton1(
              svgPath: ImageConstant.imgArrowleft,
              margin: getMargin(left: 24),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilterScreen(),
                  ),
                );
              },
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _businessNameController,
                    decoration: InputDecoration(
                      labelText: 'Tên công ty',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _businessCodeController,
                    decoration: InputDecoration(
                      labelText: 'Mã doanh nghiệp',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _representativeController,
                    decoration: InputDecoration(
                      labelText: 'Người liên hệ',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      labelText: 'Số điện thoại',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _devicesController,
                    decoration: InputDecoration(
                      labelText: 'Các thiết bị cần bảo trì',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: 'Địa chỉ',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Chọn ngày',
                      suffixIcon: InkWell(
                        onTap: _selectDate,
                        child: Icon(Icons.calendar_today),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _timeController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Chọn giờ',
                      suffixIcon: InkWell(
                        onTap: _selectTime,
                        child: Icon(Icons.access_time),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    readOnly: true,
                    controller: TextEditingController(
                      text:
                          "${selectedTime?.format(context)} - ${selectedArrivalTime?.format(context)}",
                    ),
                    decoration: InputDecoration(
                      labelText: 'Dự kiến đến',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await _saveDataToFirestore();
                        // Handle success after saving data
                      },
                      child: Text('Xác nhận'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
