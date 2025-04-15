import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotassignedWidget extends StatefulWidget {
  final String task_name;
  final String desc;
  final String task_start_date;
  final String task_end_date;
  final String creationDate;
  final String status;
//  final double? amount;
  final void Function(bool?)? onChanged;
  const NotassignedWidget({
    super.key,
    required this.task_name,
    required this.desc,
    required this.task_start_date,
    required this.task_end_date,
    required this.creationDate,
    required this.status, this.onChanged,
   // this.amount,
  });

  @override
  State<NotassignedWidget> createState() => _NotassignedWidgetState();
}

class _NotassignedWidgetState extends State<NotassignedWidget> {
  bool isChecked = false;
  final NumberFormat _currencyFormat = NumberFormat.currency(
    symbol: '',
    decimalDigits: 0,
    customPattern: '#,##0;(#,##0)',
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(80),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Transform.scale(
                            scale: 1.3,
                            child: Checkbox(
                              value: isChecked,
                              onChanged: isChecked ? null : widget.onChanged,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              side: WidgetStateBorderSide.resolveWith(
                                    (states) => BorderSide(
                                  width: 2.0,
                                  color: Colors.grey[400]!,
                                ),
                              ),
                              activeColor: const Color(0xFF4CAF50),
                            ),
                          ),

                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.3),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Text(
                                "not ASSIGNED",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.task_name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.desc,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 17),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 1,
                      height: 1,
                    ),
                    const SizedBox(height: 16),
                    _buildDateInfo(Icons.calendar_today, "Start Date",
                        widget.task_start_date),
                    const SizedBox(height: 10),
                    _buildDateInfo(Icons.event_available, "End Date",
                        widget.task_end_date),
                    const SizedBox(height: 10),
                    _buildDateInfo(
                        Icons.create, "Created", widget.creationDate),
                    // if (widget.amount != null) ...[
                    //   const SizedBox(height: 10),
                    //   Row(
                    //     children: [
                    //       Icon(Icons.attach_money,
                    //           size: 20, color: Colors.grey[600]),
                    //       const SizedBox(width: 8),
                    //       // Text(
                    //       //   "Amount: ",
                    //       //   style: TextStyle(
                    //       //     fontSize: 15,
                    //       //     color: Colors.grey[600],
                    //       //   ),
                    //       // ),
                    //       // Text(
                    //       //   _currencyFormat.format(widget.amount),
                    //       //   style: TextStyle(
                    //       //     fontSize: 15,
                    //       //     fontWeight: FontWeight.w500,
                    //       //     color: widget.amount! < 0
                    //       //         ? Colors.red
                    //       //         : Colors.black87,
                    //       //   ),
                    //       // ),
                    //     ],
                    //   ),
                    // ],
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.person_off,
                            size: 20, color: Colors.grey[600]),
                        const SizedBox(width: 8),
                        Text(
                          "Status: ",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          widget.status,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateInfo(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          "$label: ",
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
