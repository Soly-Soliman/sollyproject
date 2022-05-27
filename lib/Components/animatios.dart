import 'package:flutter/material.dart';

class Like_Animation extends StatefulWidget {
  final Widget child ;
   final bool isAnimating ;
   final Duration duration;
   final VoidCallback? onEnd;
   final bool smallLike;

  const Like_Animation
      ({Key?key ,
    required this.child ,
     this.duration = const Duration(microseconds: 150),
    required this.isAnimating,

    required this.smallLike,
    this.onEnd ,

  }  ) :super (key: key) ;

  @override
  _Like_AnimationState createState() => _Like_AnimationState();

}

class _Like_AnimationState extends State<Like_Animation>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller ;
  late Animation<double> scale ;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this ,duration: Duration(microseconds:widget.duration.inMilliseconds ~/2 ),);
    scale =Tween<double>(begin: 1,end: 1.2).animate(_controller);
  }
  @override
  void didUpdateWidget(covariant Like_Animation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.isAnimating!=oldWidget.isAnimating){
      startAnimation ;
    }
  }

  startAnimation()async{
    if(widget.isAnimating || widget.smallLike){
      await _controller.forward();
      await  _controller.reverse();
      await Future.delayed(const Duration(milliseconds: 200,),);
      if(widget.onEnd!=null){
        widget.onEnd!();
      }
    }
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
  //  return Container(color: const Color(0xFFFFE306));

    return ScaleTransition(
        scale: scale ,
      child:widget.child ,

    );
  }
}