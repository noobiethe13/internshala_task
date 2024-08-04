//Height: 841, Width: 384.0 (A14)
class Responsive {
  final double height;
  final double width;

  Responsive({required this.height, required this.width});

  //HEIGHTS
  double get height20 => 0.0237 * height;
  double get height14 => 0.0166 * height;
  double get height75 => 0.0891 * height;
  double get height10 => 0.0118 * height;
  double get height18 => 0.0214 * height;
  double get height16 => 0.019 * height;
  double get height12 => 0.0142 * height;
  double get height40 => 0.0475 * height;
  double get height50 => 0.0594 * height;
  double get height300 => 0.3567 * height;
  double get height30 => 0.0356 * height;

  //WIDTHS
  double get width30 => 0.078 * width;
  double get width150 => 0.39 * width;
  double get width160 => 0.4166 * width;
  double get width5 => 0.013 * width;
  double get width80 => 0.2083 * width;
  double get width20 => 0.052 * width;
  double get width100 => 0.2604 * width;
  double get width10 => 0.026 * width;
}