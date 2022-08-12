import 'package:doccure_patient/constanst/strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

getRegisterForm({ctl, obscure = false, hint, icon = Icons.email_outlined}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$hint', style: GoogleFonts.poppins()),
        const SizedBox(height: 5.0,),
        Container(
          height: 55.0,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: const Color(0xFFE8E8E8), width: 1.0),
            color: Color(0xFFF1F1F1),
          ),
          child: Row(
            children: [
              Flexible(
                  child: TextFormField(
                controller: ctl,
                obscureText: obscure,
                keyboardType: TextInputType.text,
                style: GoogleFonts.poppins(fontSize: 15.0, color: Colors.black45),
                decoration: InputDecoration(
                    hintText: obscure ? 'password': 'username@example.com',
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                    hintStyle:
                        GoogleFonts.poppins(fontSize: 15.0, color: Colors.black45),
                    border: const OutlineInputBorder(borderSide: BorderSide.none)),
              )),
              obscure ? Icon(Icons.lock, color: Color(0xFF838383),): const SizedBox()
            ],
          ),
        ),
      ],
    );

getButton(context, callBack) => GestureDetector(
      onTap: () => callBack(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: BLUECOLOR,
            borderRadius: BorderRadius.circular(8.0)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Text(
              'Sign In',
              style: GoogleFonts.poppins(
                  fontSize: 19.0,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ),
    );
