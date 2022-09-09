
import 'package:flutter/material.dart';

enum SeatType {
  outdoor,
  counter,
  hightop,
  standard,
}

class RestaurantReservationTable {
  final List<TimeOfDay> availableTimes;
  final int size;
  final SeatType seatType;

  const RestaurantReservationTable({required this.availableTimes, required this.size, required this.seatType});
}

//Dummy function
List<RestaurantReservationTable> getTableData(DateTime date, int restaurantId) {

  return [
    const RestaurantReservationTable(
      size: 5, seatType: SeatType.counter, availableTimes: [
        TimeOfDay(hour: 15, minute: 15),
        TimeOfDay(hour: 15, minute: 30),
        TimeOfDay(hour: 15, minute: 45),
        TimeOfDay(hour: 17, minute: 00),
        TimeOfDay(hour: 19, minute: 15),
      ],
    ),
    const RestaurantReservationTable(
      size: 2, seatType: SeatType.standard, availableTimes: [
        TimeOfDay(hour: 17, minute: 15),
        TimeOfDay(hour: 17, minute: 30),
        TimeOfDay(hour: 17, minute: 45),
        TimeOfDay(hour: 17, minute: 00),
        TimeOfDay(hour: 18, minute: 00),
        TimeOfDay(hour: 18, minute: 15),
      ],
    )
  ];
}