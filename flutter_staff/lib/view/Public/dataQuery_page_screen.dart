import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staff/data_sources/api_services.dart';
import 'package:flutter_staff/models/timeKeeps.dart';

import 'package:flutter_staff/view/Screen/home_page_screen.dart';
import 'package:flutter_staff/view/Widget/datatable_widget.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staff/view/Widget/appBar_widget.dart';
import '../../models/logListMonths.dart';

class LoglistPage extends StatefulWidget {
  final String emp_code;
  const LoglistPage({super.key, required this.emp_code});

  @override
  State<LoglistPage> createState() => _LoglistPageState();
}

class _LoglistPageState extends State<LoglistPage> {
  final ApiServices apiHandler = ApiServices();
  List<LogListMonthModel> _lists = [];
  bool isLoading = false;
  // lấy dữ liệu từ model
  Future<void> getDataLogList(String code) async {
    setState(() {
      isLoading = true;
    });
    try {
      List<LogListMonthModel> loglists =
          await apiHandler.fetchLogListMonth(widget.emp_code.toString());
      setState(() {
        _lists = loglists;
        setState(() {
          isLoading = false;
        });
      });
    } catch (e) {
      // Xử lý lỗi nếu cần
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getDataLogList(widget.emp_code
        .toString()); // Replace 'EMPLOYEE_CODE' with the actual employee code
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          const AppBarForm(title_: 'Chấm Công Thực Tế'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _lists.isEmpty
                        ? const Center(child: Text('Không có dữ liệu.'))
                        : DataTable(
                            headingRowHeight: 65,
                            columns: const [
                              DataColumn(
                                  label: buildTitleDataColumn(
                                      name_title1: 'STT',
                                      name_title2: "(No.)")),
                              DataColumn(
                                  label: buildTitleDataColumn(
                                      name_title1: 'MÃ THẺ',
                                      name_title2: "(ID CARD)")),
                              DataColumn(
                                  label: buildTitleDataColumn(
                                      name_title1: 'NGÀY QUÉT',
                                      name_title2: "(SCAN DATE)")),
                              DataColumn(
                                  label: buildTitleDataColumn(
                                      name_title1: 'GIỜ QUÉT',
                                      name_title2: "(SCAN TIME)")),
                              DataColumn(
                                  label: buildTitleDataColumn(
                                      name_title1: 'SỐ MÁY',
                                      name_title2: "(MACHINE NAME)")),
                            ],
                            rows: _lists.asMap().entries.map((entry) {
                              int index = entry.key;
                              var loglists = entry.value;
                              return DataRow(
                                cells: [
                                  DataCell(buildContentDataCell(
                                      content: (index + 1).toString())),
                                  DataCell(buildContentDataCell(
                                      content: loglists.eMPCODE ?? '-')),
                                  DataCell(
                                    buildContentDataCell(
                                      content: loglists.dATECHECK != null
                                          ? DateFormat('dd/MM/yyyy').format(
                                              DateTime.parse(
                                                  loglists.dATECHECK!))
                                          : '-',
                                    ),
                                  ),
                                  DataCell(
                                    buildContentDataCell(
                                      content: loglists.tIMETEMP != null
                                          ? DateFormat('HH:mm:ss').format(
                                              DateTime.parse(
                                                  loglists.tIMETEMP!))
                                          : '-',
                                    ),
                                  ),
                                  DataCell(buildContentDataCell(
                                      content: loglists.nM ?? '-')),
                                ],
                              );
                            }).toList(),
                          ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimekeepPage extends StatefulWidget {
  final String emp_code;
  const TimekeepPage({super.key, required this.emp_code});

  @override
  State<TimekeepPage> createState() => _TimekeepPageState();
}

class _TimekeepPageState extends State<TimekeepPage> {
  final ApiServices apiServices = ApiServices();
  List<TimeKeepModel> _Lists = [];
  bool isLoading = false;
  // lấy dữ liệu từ model
  Future<void> getDataTimeKeep(String code) async {
    setState(() {
      isLoading = true;
    });
    try {
      List<TimeKeepModel> timekeeps =
          await apiServices.fetchTimeKeep(widget.emp_code.toString());
      setState(() {
        _Lists = timekeeps;
        setState(() {
          isLoading = false;
        });
      });
    } catch (e) {
      //  print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getDataTimeKeep(widget.emp_code.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          const AppBarForm(title_: 'Bảng Công Tháng'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _Lists.isEmpty
                        ? const Center(
                            child: Text('Không có dữ liệu chấm công.'))
                        : DataTable(
                            headingRowHeight: 65,
                            columns: const [
                              DataColumn(
                                  label: buildTitleDataColumn(
                                      name_title1: "NGÀY",
                                      name_title2: '(DATE)')),
                              DataColumn(
                                label: buildTitleDataColumn(
                                    name_title1: "THỨ", name_title2: '(DAY)'),
                              ),
                              DataColumn(
                                label: buildTitleDataColumn(
                                    name_title1: "GIỜ VÀO",
                                    name_title2: '(CHECK-IN)'),
                              ),
                              DataColumn(
                                label: buildTitleDataColumn(
                                    name_title1: "GIỜ RA",
                                    name_title2: '(CHECK-OUT)'),
                              ),
                              DataColumn(
                                label: buildTitleDataColumn(
                                    name_title1: "SỐ GIỜ",
                                    name_title2: '(HOUR)'),
                              ),
                              DataColumn(
                                label: buildTitleDataColumn(
                                    name_title1: "TC 150",
                                    name_title2: 'OT 150'),
                              ),
                              DataColumn(
                                label: buildTitleDataColumn(
                                    name_title1: "GHI CHÚ",
                                    name_title2: 'REMARK'),
                              ),
                              // DataColumn(
                              //   label: buildTitleRowDatatable1("DATE"),
                              // ),
                              // DataColumn(
                              //   label: buildTitleRowDatatable1('DAY'),
                              // ),
                              // DataColumn(
                              //   label: buildTitleRowDatatable1('CHECK-IN'),
                              // ),
                              // DataColumn(
                              //   label: buildTitleRowDatatable1('CHECK-OUT'),
                              // ),
                              // DataColumn(
                              //   label: buildTitleRowDatatable1('HOUR'),
                              // ),
                              // DataColumn(
                              //   label: buildTitleRowDatatable1('OT150'),
                              // ),
                              // DataColumn(
                              //   label: buildTitleRowDatatable1('REMARK'),
                              // ),
                            ],
                            rows: _Lists.map(
                              (timekeeps) {
                                return DataRow(
                                  color:
                                      MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                      if (timekeeps.dATENAME == "SUN") {
                                        return Colors.grey.withOpacity(
                                            0.3); // Màu nền cho hàng có giá trị dATEOFMONTH là 'SUN'
                                      }
                                      return null; // Màu nền mặc định
                                    },
                                  ),
                                  cells: [
                                    DataCell(buildContentDataCell(
                                        content: timekeeps.dATEOFMONTH != null
                                            ? DateFormat('dd/MM/yyyy').format(
                                                DateTime.parse(
                                                    timekeeps.dATEOFMONTH!))
                                            : '-')),
                                    DataCell(buildContentDataCell(
                                        content: timekeeps.dATENAME ?? '-')),
                                    DataCell(buildContentDataCell(
                                      content: timekeeps.tIMECHECKIN != null
                                          ? (DateFormat('HH:mm:ss').format(
                                                      DateTime.parse(timekeeps
                                                          .tIMECHECKIN!)) ==
                                                  '00:00:00'
                                              ? "-"
                                              : DateFormat('HH:mm:ss').format(
                                                  DateTime.parse(
                                                      timekeeps.tIMECHECKIN!)))
                                          : '-',
                                    )),
                                    DataCell(buildContentDataCell(
                                        content: timekeeps.tIMECHECKOUT != null
                                            ? (DateFormat('HH:mm:ss').format(
                                                        DateTime.parse(timekeeps
                                                            .tIMECHECKOUT!)) ==
                                                    "00:00:00"
                                                ? "-"
                                                : DateFormat('HH:mm:ss').format(
                                                    DateTime.parse(timekeeps
                                                        .tIMECHECKOUT!)))
                                            : '-')),
                                    DataCell(buildContentDataCell(
                                        content: timekeeps.hOURWORK
                                                    .toString() ==
                                                "0.0"
                                            ? '-'
                                            : (timekeeps.hOURWORK.toString() ==
                                                    "0"
                                                ? "-"
                                                : timekeeps.hOURWORK
                                                    .toString()))),
                                    DataCell(buildContentDataCell(
                                        content:
                                            timekeeps.oTWORK.toString() == "0.0"
                                                ? '-'
                                                :( timekeeps.oTWORK.toString() =="0"?"-":timekeeps.oTWORK.toString()))),
                                    DataCell(buildContentDataCell(
                                        content:
                                            (timekeeps.rEMARK.toString() == ""
                                                    ? '-'
                                                    : timekeeps.rEMARK) ??
                                                '-')),
                                    // DataCell(
                                    //   Text(timekeeps.dATEOFMONTH != null
                                    //       ? DateFormat('dd/MM/yyyy').format(
                                    //           DateTime.parse(
                                    //               timekeeps.dATEOFMONTH!))
                                    //       : '-'),
                                    // ),
                                    // DataCell(Text(timekeeps.dATENAME ?? '-')),
                                    // DataCell(
                                    //   Text(
                                    //     timekeeps.tIMECHECKIN != null
                                    //         ? DateFormat('HH:mm:ss').format(
                                    //             DateTime.parse(
                                    //                 timekeeps.tIMECHECKIN!))
                                    //         : '-',
                                    //   ),
                                    // ),
                                    // DataCell(
                                    //   Text(
                                    //     timekeeps.tIMECHECKOUT != null
                                    //         ? DateFormat('HH:mm:ss').format(
                                    //             DateTime.parse(
                                    //                 timekeeps.tIMECHECKOUT!))
                                    //         : '-',
                                    //   ),
                                    // ),
                                    // DataCell(Text(
                                    //     timekeeps.hOURWORK.toString() == "0"
                                    //         ? '-'
                                    //         : timekeeps.hOURWORK.toString())),
                                    // DataCell(Text(
                                    //     timekeeps.oTWORK.toString() == "0"
                                    //         ? '-'
                                    //         : timekeeps.oTWORK.toString())),
                                    // DataCell(Text(timekeeps.rEMARK ?? '-')),
                                  ],
                                );
                              },
                            ).toList(),
                          ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Hàm xây dựng tiêu đề
  Widget buildTitleRowDatatable1(String name_title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        name_title,
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          color: Colors.orange.shade800,
          fontSize: 17,
        ),
      ),
    );
  }
}
