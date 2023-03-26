import 'package:dicoding_restaurant_app/data/models/customer_review_model.dart';
import 'package:flutter/material.dart';

class RestaurantCustomerReviewCardWidget extends StatelessWidget {
  const RestaurantCustomerReviewCardWidget({
    Key? key,
    required this.customerReview,
    required this.margin,
  }) : super(key: key);

  final CustomerReviewModel customerReview;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: margin,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8),
      ),
      width: 210,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            customerReview.name,
            style: Theme.of(context).textTheme.titleSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            customerReview.date,
            style: Theme.of(context).textTheme.labelMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Center(
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  customerReview.review,
                  style: Theme.of(context).textTheme.labelMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
