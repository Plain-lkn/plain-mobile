import 'package:flutter/material.dart';
import 'package:flutter_plain_application/components/layouts/dimensions.dart';
import 'package:flutter_plain_application/components/layouts/spacing.dart';
import 'package:flutter_plain_application/components/scheme.dart';

class ColumnList extends StatelessWidget {
  const ColumnList({
    super.key,
    this.spacing = 0.0,
    required this.items
  });

  final double spacing;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Spacing.outerPadding),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Scheme.current.rearground,
        borderRadius: BorderRadius.circular(Dimensions.radius)
      ),
      child: RawColumnList(spacing: spacing, items: items),
    );
  }
}

class ColumnDivider extends StatelessWidget {
  const ColumnDivider({
    super.key,
    this.thickness = 1
  });

  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.innerPadding),
      child: Divider(height: 1, color: Scheme.current.outline),
    );
  }
}

class RawColumnList extends StatelessWidget {
  const RawColumnList({
    super.key,
    this.spacing = 0.0,
    required this.items
  });

  final double spacing;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: spacing,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.expand((e) => [e, ColumnDivider(thickness: 1)]).toList()..removeLast(),
    );
  }
}