import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataDisplayScreen extends StatefulWidget {
  final User user;

  DataDisplayScreen({required this.user});

  @override
  _DataDisplayScreenState createState() => _DataDisplayScreenState();
}

class _DataDisplayScreenState extends State<DataDisplayScreen> {
  int currentPage = 0;
  int itemsPerPage = 1;

  List<List<QueryDocumentSnapshot>> pages = [];
  late QuerySnapshot documents;

  @override
  void initState() {
    super.initState();
    fetchDocumentsAndPages();
  }

  Future<void> fetchDocumentsAndPages() async {
    documents = await FirebaseFirestore.instance
        .collection('user_request')
        .where('userId', isEqualTo: widget.user.uid)
        .get();

    pages = List<List<QueryDocumentSnapshot>>.generate(
      (documents.size / itemsPerPage).ceil(),
      (int index) {
        int start = index * itemsPerPage;
        int end = (index + 1) * itemsPerPage;
        if (end > documents.size) {
          end = documents.size;
        }
        return documents.docs.sublist(start, end);
      },
    );

    setState(() {});
  }

  Future<void> _deleteAppointment(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('user_request')
          .doc(documentId)
          .delete();

      final newDocuments = await FirebaseFirestore.instance
          .collection('user_request')
          .where('userId', isEqualTo: widget.user.uid)
          .get();

      documents = newDocuments;

      pages = List<List<QueryDocumentSnapshot>>.generate(
        (documents.size / itemsPerPage).ceil(),
        (int index) {
          int start = index * itemsPerPage;
          int end = (index + 1) * itemsPerPage;
          if (end > documents.size) {
            end = documents.size;
          }
          return documents.docs.sublist(start, end);
        },
      );

      setState(() {
        if (currentPage >= pages.length) {
          currentPage = pages.length - 1;
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lịch bảo trì được xóa thành công')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi xóa lịch hẹn')),
      );
    }
  }

  Future<void> _showDeleteConfirmationDialog(String documentId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận xóa lịch hẹn'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Bạn có chắc chắn muốn xóa lịch hẹn này?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Có'),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteAppointment(documentId);
              },
            ),
            TextButton(
              child: Text('Không'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theo dõi lịch bảo trì'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25, left: 15),
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

            final currentPageData = pages.isNotEmpty ? pages[currentPage] : [];
            return ListView.builder(
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
                final selectedArrivalTime = data['selectedArrivalTime'] ?? '';
                final status = data['status'] ?? '';

                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tên công ty: $businessName',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8), // Khoảng cách giữa các dòng văn bản
                      Text(
                        'Mã số doanh nghiệp: $businessCode',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8), // Khoảng cách giữa các dòng văn bản
                      Text(
                        'Người liên hệ: $representative',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8), // Khoảng cách giữa các dòng văn bản
                      Text(
                        'Số điện thoại: $phoneNumber',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8), // Khoảng cách giữa các dòng văn bản
                      Text(
                        'Các thiết bị cần bảo trì: $devices',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8), // Khoảng cách giữa các dòng văn bản
                      Text(
                        'Địa chỉ: $address',
                        style: TextStyle(fontSize: 18),
                      ),

                      SizedBox(height: 8), // Khoảng cách giữa các dòng văn bản
                      Text(
                        'Chọn ngày: $formattedDate',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8), // Khoảng cách giữa các dòng văn bản
                      Text(
                        'Chọn giờ: $selectedTime',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8), // Khoảng cách giữa các dòng văn bản
                      Text(
                        'Dự kiến đến: $selectedArrivalTime',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 28), // Khoảng cách giữa các dòng văn bản
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12), // Điều chỉnh khoảng cách và lề
                        decoration: BoxDecoration(
                          color: Colors.blue, // Màu nền
                          borderRadius: BorderRadius.circular(8), // Góc bo tròn
                        ),
                        child: Text(
                          'Trạng thái: $status',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white, // Màu chữ
                            fontWeight: FontWeight.bold, // Chữ đậm
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextButton(
                          onPressed: () => _showDeleteConfirmationDialog(document.id), 
                          style: ButtonStyle(
                            alignment: Alignment
                                .centerLeft, // Căn giữa theo chiều dọc và căn trái
                          ),
                          child: Text(
                            'Xóa lịch hẹn',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),

                      SizedBox(height: 140),
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
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
