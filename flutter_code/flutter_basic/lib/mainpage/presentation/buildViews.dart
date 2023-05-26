import 'package:flutter/material.dart';

import '../../weatherBox.dart';

class ViewUtil {
  static Widget buildListView() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        switch (index) {
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  static Widget buildItem(BuildContext context, int index) {
    if (index == 3) {
      // Display weather information in the first box
      return const WeatherBox(location: 'Costa Da Caparica');
    } else if (index == 2) {
      // Display weather information in the first box
      return HojeNaFctBox();
    } else {
      // Display a regular box for the other three boxes
      return const MyBox();
    }
  }
}
