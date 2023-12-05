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
  Key? _selectedKey;
  NotificationCard? _selectedWidget;

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
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  void dispose() {
    _blurController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
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
                      onClickCard: (key, widget) {
                        setState(() {
                          if (_selectedKey == key) {
                            _selectedKey = null;
                            _selectedWidget = null;
                            _blurController.reverse();
                          } else {
                            _selectedKey = key;
                            _selectedWidget = widget;
                            _blurController.forward();
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
            if (_selectedWidget != null)
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.all(13),
                  child: IntrinsicHeight(
                    child: NotificationCard(
                      selected: true,
                      title: _selectedWidget!.title,
                      subTitle: _selectedWidget!.subTitle,
                      time: _selectedWidget!.time,
                      iconRes: _selectedWidget!.iconRes,
                      onClick: _selectedWidget!.onClick,
                      key: _selectedWidget!.key,
                    ),
                  ),
                ),
              ),
          ],
        ),
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
              )
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
          onClick: (key, widget) => onClickCard(key, widget),
          key: UniqueKey(),
        ),
        NotificationCard(
          title: '긴급재난문자',
          subTitle:
              '[기상청] 11월30일04:55 경북 경주시 동남동쪽 19km 지역 규모4.3 지진발생/낙하물 주의, 국민재난안전포털 행동ㅇ요령에 따라 대응, 여진주의',
          time: '3h ago',
          iconRes: IconRes(
            iconData: Icons.warning,
            color: Palette.paletteYellow100,
          ),
          onClick: (key, widget) => onClickCard(key, widget),
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
          onClick: (key, widget) => onClickCard(key, widget),
          key: UniqueKey(),
        ),
        NotificationCard(
          title: '리디',
          subTitle: '<맹자의 가르침> 다운로드 성공',
          time: 'now',
          iconRes: IconRes(
            iconData: Icons.menu_book_rounded,
            color: Palette.paletteBlue100,
          ),
          onClick: (key, widget) => onClickCard(key, widget),
          key: UniqueKey(),
        ),
      ],
    );
  }
}

typedef OnClickCard = Function(
  Key? key,
  NotificationCard widget,
);

@immutable
class NotificationCard extends StatelessWidget {
  final bool selected;
  final String title;
  final String subTitle;
  final String time;
  final IconRes iconRes;
  final OnClickCard onClick;

  NotificationCard({
    this.selected = false,
    required this.title,
    required this.subTitle,
    required this.time,
    required this.iconRes,
    required this.onClick,
    super.key,
  });

  final GlobalKey gKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick(key, this);

        // RenderBox box = gKey.currentContext?.findRenderObject() as RenderBox;
        // Offset position = box.localToGlobal(Offset.zero);
        // double y = position.dy;
        // print('woogear position = $position');
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
