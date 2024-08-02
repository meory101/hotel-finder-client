
import 'dart:convert';

import 'package:http/http.dart'as http;
 class HttpMethods{


  postMethod(String url,var body)async{

  http.Response response = await  http.post(
      Uri.parse(url),
      body: body,


    );
  return response;
  }

  getMethod(String url,)async{

    http.Response response = await  http.get(
      Uri.parse(url),


    );
    return response;
  }
}