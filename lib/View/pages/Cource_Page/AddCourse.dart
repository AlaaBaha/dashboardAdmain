import 'dart:typed_data';

import 'package:admaindashboard/Controller/cource_controller/AddCourse_controller.dart';
import 'package:admaindashboard/View/constants/page_titles.dart';
import 'package:admaindashboard/View/widgets/Button.dart';
import 'package:admaindashboard/View/widgets/app_scaffold.dart';
import 'package:admaindashboard/config_Customer/Color.dart';
import 'package:admaindashboard/config_Customer/size_phone.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';
import 'package:dropdown_search/dropdown_search.dart';
class Course extends StatefulWidget {
  const Course({Key? key}) : super(key: key);

  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> {
  bool value=false;
  List<String>? catalog;
  bool downnload=false;
  String cataloging="";
  GlobalKey<FormState> _key=GlobalKey();
  TextEditingController name=TextEditingController();
  TextEditingController addCatalog=TextEditingController();
  TextEditingController link=TextEditingController();
  TextEditingController image=TextEditingController();
  FilePickerResult? file;
  PlatformFile? ImagInf;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    catalog=  AddCourse_controller().catalogers;
  }
  @override
  Widget build(BuildContext context) {
    size_phone().init(context);
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: AppScaffold(
          pageTitle: PageTitles.Course,
          body: SingleChildScrollView(
            child: Container(
              color: backgroundColor,
              child:Stack(
                children: [
                   Center(
                     child: Container(
                  height: size_phone.defualtsize!*45,
                            margin: EdgeInsets.only(top: size_phone.defualtsize!*5),
                            width:size_phone.defualtsize!*30,
                            child: Form_AddCourse()),

                      ),
                  if(downnload)  Container(
                      color: ColorForm.withOpacity(.1),
                      height: size_phone.height,
                      width: size_phone.width,
                      child:LoadingOverlayPro(
                          progressIndicator: LoadingBouncingLine.circle(
                            backgroundColor: Colors.white,
                            borderColor: Colors.white,
                          ),
                          isLoading: downnload, child: Text('')
                      )
                  ),
                ],
              )
            ),
          )),
    );
  }
  Form_AddCourse(){
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Card(

            child: Padding(
              padding:  EdgeInsets.all(size_phone.defualtsize!*1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: size_phone.defualtsize!*1,),
                  textfield('أدخل اسم الكورس', Icon(Icons.person),name),

                  SizedBox(height: size_phone.defualtsize!*1,),
                  Row(
                    children: [
                      Expanded(
                        child: textfield(image.text!=''?image.text!:'ادخل صوره للكورس',Icon(Icons.camera),image),
                      ),
                      SizedBox(height: size_phone.defualtsize!*1,),
                      Container(
                          margin: EdgeInsets.only(right: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: TextButton(onPressed: selectFile,style: ButtonStyle(
                            backgroundColor:MaterialStatePropertyAll(ColorForm) ,
                              padding: MaterialStatePropertyAll(EdgeInsets.only(left: 11,right: 11,top: 13,bottom: 13)),
                          ),
                              child: Text('اختار',style: TextStyle(fontSize: 25,color: Colors.white, fontFamily: "body"),)
                          )),
                    ],
                  ),

                  SizedBox(height: size_phone.defualtsize!*1,),
                  textfield("أدخل رابط محتوى الكورس", Icon(Icons.details),link),
                  SizedBox(height: size_phone.defualtsize!*1,),
                  lis(catalog!),
                  SizedBox(height: size_phone.defualtsize!*1,),
                  value==false? Row(children: [
                    Text("اضافه تصنيف اخر",style:  TextStyle(fontFamily:'body',fontSize: 22,color:Colors.grey,),),
                     Checkbox(value: value,
                        focusColor: ColorForm,
                        onChanged: (val){
                          setState(() {
                            value=val!;
                          });

                        }),

                  ],):  Row(
                    children: [
                      Expanded(
                        child: textfield('ادخل التصنيف',Icon(Icons.add),addCatalog),
                      ),
                      SizedBox(height: size_phone.defualtsize!*1,),
                      Container(
                          margin: EdgeInsets.only(right: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: TextButton(onPressed: (){
                            setState(() {
                              value=false;
                              catalog!.add(addCatalog.text);
                            });
                          },style: ButtonStyle(
                            backgroundColor:MaterialStatePropertyAll(ColorForm) ,
                            padding: MaterialStatePropertyAll(EdgeInsets.only(left: 11,right: 11,top: 13,bottom: 13)),
                          ),
                              child: Text('اضافة',style: TextStyle(fontSize: 25,color: Colors.white, fontFamily: "body"),)
                          )),
                    ],
                  ),
                  SizedBox(height: size_phone.defualtsize!*1,),
                  Customer_config.CustomerButton('إرسال',ColorForm, Colors.white, size_phone.defualtsize!*2, size_phone.defualtsize!*5,
                          () {
                        if(_key.currentState!.validate()){
                          setState(() {
                            downnload=true;
                          });
                          AddCourse_controller().
                          AddCouse(context!,name.text,cataloging,ImagInf!.name,ImagInf!.bytes,link.text).whenComplete(() {
                            setState(() {
                              downnload=false;
                              image.text="";
                              name.text="";
                              link.text="";
                              cataloging="";
                            });
                          });
                      //
                        };
                       }
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Container textfield(String title,Icon icon,TextEditingController control){

    return  Container(
      child: TextFormField(
autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: control,
          validator: (val){
            if(val!.isEmpty)
              return 'الحقل مطلوب';
            else if(control==name&&val.isNum)
            return 'لا تدخل رقم';
          }
          ,
          onSaved: (val){

            control.text=val!;
          },
          readOnly: title!='ادخل صوره للكورس'?false:true,
          keyboardType:title=="أدخل رابط محتوى الكورس"?TextInputType.multiline:TextInputType.text,
          maxLines: title=="أدخل رابط محتوى الكورس"?4:1,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: icon,
            hintStyle: TextStyle(fontFamily:'body',fontSize: 22,color:Colors.grey,),
            hintText: title,
            enabledBorder:bord(),
            disabledBorder:bord(),
            border: bord(),
            focusedBorder: bord(),
            focusColor: Color.fromRGBO(232, 152, 115, 1.0),

          )
      ),
    );
  }
  Future<void> selectFile()async{
    FilePickerResult? _filePickerResult;

    try {
      _filePickerResult = await FilePicker.platform.pickFiles(
        allowedExtensions: ['jpg','png','jpeg',],
        type: FileType.custom,);
      if (_filePickerResult != null) {
        ImagInf=_filePickerResult.files.single;
        setState(() {
          image.text = _filePickerResult!.files.single.name;
          file= _filePickerResult;
          Uint8List? uploader =ImagInf!.bytes;

        });

      }

    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }

  }
  OutlineInputBorder bord(){
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(
          color: Color.fromRGBO(142, 152, 152, 1.0),
        )
    );
  }
DropdownSearch<String> lis(List<String> item){
  return DropdownSearch<String>(
    onSaved: (val){
      setState(() {
        if(val!=null)
          cataloging=val;
      });
    },
    validator: (val){
      if(val!.isEmpty){ return 'الحقل مطلوب';}
    },
    dropdownDecoratorProps: DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
          prefixIcon: Icon(Icons.category_outlined),
          border:bord(),
          helperText: "اختر تصنيف منتجك ",
          helperStyle: TextStyle(color: Colors.grey,fontFamily: 'body',fontSize: 23)
      ),
    ),
    popupProps: PopupProps.menu(
        searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
                border:bord()
            )
        ),
        menuProps: MenuProps(
            borderRadius: BorderRadius.circular(25),
            elevation:.5,
            barrierColor:Colors.blueGrey.withOpacity(.3)
        ),
        fit: FlexFit.tight
    ),
    onChanged: (val){
      setState(() {
        cataloging=val!;
      });
    },
    items: item,
    selectedItem: cataloging,

  );
}}

