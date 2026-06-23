import 'package:flutter/material.dart';

class AnswerCard extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const AnswerCard({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      
      borderRadius:
          BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        
        decoration: BoxDecoration(
        
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(18),
          border: Border.all(
            color: Colors.deepPurple,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}