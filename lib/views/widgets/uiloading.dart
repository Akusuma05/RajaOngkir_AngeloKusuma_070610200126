part of 'widgets.dart';

class Uiloading {
  static Container loading() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      color: Colors.transparent,
      child: SpinKitFadingCircle(
        size: 50,
        color: Color(0xFFFF5555),
      ),
    );
  }

  static Container loadingblock() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      color: Colors.black26,
      child: SpinKitFadingCircle(
        size: 50,
        color: Color(0xFFFF5555),
      ),
    );
  }
}
