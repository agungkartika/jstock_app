import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuantityInput extends StatelessWidget {
  final RxInt quantity;

  const QuantityInput({super.key, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 5,
                spreadRadius: 2,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  if (quantity.value > 1) {
                    quantity.value--;
                  }
                },
              ),
              Text(
                quantity.value.toString(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  quantity.value++;
                },
              ),
            ],
          ),
        ));
  }
}
