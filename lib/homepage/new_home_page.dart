import 'package:doccure_patient/constanst/strings.dart';
import 'package:flutter/material.dart';

class AllHomePage extends StatelessWidget {
  const AllHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Container(
        width: width,
        height: height,
        color: Color(0xFFf6f6f6),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/imgs/2.png'),
                  radius: 20.0,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Welcome, Mr. John Doe',
                  style: getCustomFont(
                      size: 26.0, color: Colors.black, weight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'What would you like to do today?',
                  style: getCustomFont(
                      size: 15.0, color: Colors.black, weight: FontWeight.w400),
                ),
              ),
               const SizedBox(
                height: 20.0,
              ),
              mailAlert(context),
              const SizedBox(
                height: 29.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20.0),
                  child: Row(
                    children: [
                      ...List.generate(10, (index) => horizontalItem())
                    ],
                  ),
                ),
              ),
               const SizedBox(
                height: 15.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20.0),
                  child: Row(
                    children: [
                      ...List.generate(10, (index) => horizontalItem())
                    ],
                  ),
                ),
              ),
               const SizedBox(
                height: 25.0,
              ),
               SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20.0),
                  child: Row(
                    children: [
                      ...List.generate(4, (index) => horizontalSecondItem(context))
                    ],
                  ),
                ),
                ),
                const SizedBox(height: 80.0,)
            ],
          ),
        ),
      ),
    );
  }

  Widget horizontalItem() => Container(
        width: 185.0,
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.only(right: 10.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: [
            Image.asset(
              'assets/imgs/1.png',
              width: 80.0,
              height: 80.0,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              'Find a medical center',
              textAlign: TextAlign.center,
              style: getCustomFont(
                  size: 15.0, color: Colors.black, weight: FontWeight.w600),
            ),
             const SizedBox(
              height: 9.0,
            ),
             Text(
              'Find hosiptals, pharmacies, laboratories and clinics',
              textAlign: TextAlign.center,
              style: getCustomFont(
                  size: 12.0, color: Colors.black45, weight: FontWeight.w400),
            ),
            const SizedBox(
              height: 5.0,
            ),
          ],
        ),
      );

      
     Widget horizontalSecondItem(context) => Container(
        width: MediaQuery.of(context).size.width/1.4,
        height: 100.0,
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
            color: BLUECOLOR.withOpacity(.5), borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: [
           
          ],
        ),
      );

       Widget mailAlert(context) => Container(
        width: MediaQuery.of(context).size.width,
       
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
        margin: const EdgeInsets.only(right: 20.0, left: 20.0),
        decoration: BoxDecoration(
            boxShadow: SHADOW,
            color: Colors.red.withOpacity(.5), borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Text('E-mail Verification Pending', style: getCustomFont(size: 18.0, color: Colors.black, weight: FontWeight.bold),),
                 const SizedBox(height: 5.0),
                 Text('verify your email to link your account', style: getCustomFont(size: 14.0, color: Colors.black54, weight: FontWeight.w400),),
                ],
              ),
            ),
            Icon(Icons.warning, color: Colors.red, size: 19.0,)
          ],
        ),
      );
}
