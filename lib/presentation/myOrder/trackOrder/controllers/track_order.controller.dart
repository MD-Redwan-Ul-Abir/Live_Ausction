import 'package:get/get.dart';

import '../../../commonWidgets/customStapprStatus.dart';

class TrackOrderController extends GetxController {
  final List<OrderStep> incompleteSteps = [
    OrderStep(
      time: "14 Hours later",
      text: "Delivered the product",
      state: OrderStepState.upcoming,
    ),
    OrderStep(
      time: "12 Hour later",
      text: "Heading to your Address",
      state: OrderStepState.upcoming,
    ),
    OrderStep(
      time: "Now",
      text: "The parcel Near By you",
      state: OrderStepState.current,
    ),
    OrderStep(
      time: "12 Hour ago",
      text: "The Courier picked up your order",
      state: OrderStepState.completed,
    ),
    OrderStep(
      time: "1 Day ago",
      text: "We Found a Courier",
      state: OrderStepState.completed,
    ),
    OrderStep(
      time: "1 Day ago",
      text: "The Products is packaging",
      state: OrderStepState.completed,
    ),
  ];

  // Example data for completed order
  final List<OrderStep> completedSteps = [
    OrderStep(
      time: "Now",
      text: "Delivered the product",
      state: OrderStepState.current,
    ),
    OrderStep(
      time: "12 Hour ago",
      text: "Heading to your Address",
      state: OrderStepState.completed,
    ),
    OrderStep(
      time: "12 Hour ago",
      text: "The parcel Near By you",
      state: OrderStepState.completed,
    ),
    OrderStep(
      time: "12 Hour ago",
      text: "The Courier picked up your order",
      state: OrderStepState.completed,
    ),
    OrderStep(
      time: "1 Day ago",
      text: "We Found a Courier",
      state: OrderStepState.completed,
    ),
    OrderStep(
      time: "1 Day ago",
      text: "The Products is packaging",
      state: OrderStepState.completed,
    ),
  ];
}