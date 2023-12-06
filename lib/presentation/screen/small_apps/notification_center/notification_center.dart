import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_note/exports.dart';

class NotificationCenterScreen extends StatefulWidget {
  const NotificationCenterScreen({super.key});

  @override
  State<NotificationCenterScreen> createState() =>
      _NotificationCenterScreenState();
}

class _NotificationCenterScreenState extends State<NotificationCenterScreen>
    with SingleTickerProviderStateMixin {
  CardStackInfo? _cardInfo;
  Key? _selectedKey;

  late AnimationController _blurController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _blurController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _animation = Tween<double>(begin: 0, end: 10).animate(_blurController);
    _animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _blurController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroundContainer(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    'Thursday, September 30',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    '8:23',
                    style: TextStyle(
                        fontSize: 100,
                        height: 1.1,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 70),
                  _notifications(
                    onClickCard: (cardInfo) {
                      setState(() {
                        if (_selectedKey == cardInfo.widget.key) {
                          _cardInfo = null;
                          _selectedKey = null;
                          _blurController.reverse();
                        } else {
                          _selectedKey = cardInfo.widget.key;
                          _cardInfo = cardInfo;
                          _blurController.forward();
                        }
                      });
                    },
                  )
                ],
              ),
            ),
          ),
          if (_cardInfo != null)
            Positioned(
              left: _cardInfo!.offset.dx,
              top: _cardInfo!.offset.dy,
              width: _cardInfo!.size.width,
              height: _cardInfo!.size.height,
              child: _cardInfo!.widget.copy(
                selected: true,
                key: _cardInfo!.widget.key,
              ),
            ),
        ],
      ),
    );
  }

  Widget _backgroundContainer({required Widget child}) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        const Image(
          image: AssetImage(Assets.samBackgroundImage),
          fit: BoxFit.cover,
        ),
        child,
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaY: _animation.value,
            sigmaX: _animation.value,
          ),
          child: Container(),
        ),
      ],
    );
  }

  Widget _notifications({
    required OnClickCard onClickCard,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notification Center',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        NotificationCard(
          title: '리디',
          subTitle: '<공자의 가르침> 다운로드 성공',
          time: 'now',
          iconRes: IconRes(
            iconData: Icons.menu_book_rounded,
            color: Palette.paletteBlue100,
          ),
          onClick: onClickCard,
          key: UniqueKey(),
        ),
        NotificationCard(
          title: '긴급재난문자',
          subTitle:
              '[기상청] 11월30일04:55 경북 경주시 동남동쪽 19km 지역 규모4.3 지진발생/낙하물 주의, 국민재난안전포털 행동요령에 따라 대응, 여진주의',
          time: '3h ago',
          iconRes: IconRes(
            iconData: Icons.warning,
            color: Palette.paletteYellow100,
          ),
          onClick: onClickCard,
          key: UniqueKey(),
        ),
        NotificationCard(
          title: '대한민국',
          subTitle: '애프터 라이프(1부) /브루스 그레이슨 / 현대지성',
          time: '12:35 AM',
          iconRes: IconRes(
            iconData: Icons.play_circle_filled,
            color: Palette.red03Basic,
          ),
          onClick: onClickCard,
          key: UniqueKey(),
        ),
        NotificationCard(
          title: '병원 예약 정보',
          subTitle: '강남 삼성 병원 예약 완료',
          time: 'now',
          iconRes: IconRes(
            iconData: Icons.medical_information,
            color: Palette.white,
          ),
          onClick: onClickCard,
          key: UniqueKey(),
        ),
      ],
    );
  }
}

@immutable
class CardStackInfo {
  final NotificationCard widget;
  final Offset offset;
  final Size size;

  const CardStackInfo({
    required this.widget,
    required this.offset,
    required this.size,
  });
}

typedef OnClickCard = Function(
  CardStackInfo card,
);

@immutable
class NotificationCard extends StatelessWidget {
  final bool selected;
  final String title;
  final String subTitle;
  final String time;
  final IconRes iconRes;
  final OnClickCard onClick;

  const NotificationCard({
    this.selected = false,
    required this.title,
    required this.subTitle,
    required this.time,
    required this.iconRes,
    required this.onClick,
    super.key,
  });

  NotificationCard copy({
    Key? key,
    bool? selected,
    String? title,
    String? subTitle,
    String? time,
    IconRes? iconRes,
    OnClickCard? onClick,
  }) {
    return NotificationCard(
      key: key ?? this.key,
      selected: selected ?? this.selected,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      time: time ?? this.time,
      iconRes: iconRes ?? this.iconRes,
      onClick: onClick ?? this.onClick,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        RenderBox box = context.findRenderObject() as RenderBox;
        Offset offset = box.localToGlobal(Offset.zero);
        Size size = box.size;
        final card = CardStackInfo(widget: this, offset: offset, size: size);
        onClick(card);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: selected ? Palette.white : Palette.white.withAlpha(150),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: selected ? 0 : 20,
              sigmaY: selected ? 0 : 20,
            ),
            child: Container(
              padding: const EdgeInsets.all(13),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: iconRes.color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(iconRes.iconData),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              time,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Palette.paletteGray10050p,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          subTitle,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class IconRes {
  final IconData iconData;
  final Color color;

  IconRes({
    required this.iconData,
    required this.color,
  });
}
