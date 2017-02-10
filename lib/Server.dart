import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:route/server.dart';
import 'package:uuid/uuid.dart';
import 'package:validator/validator.dart';

class Server{
  Server(){}

  /**
   * This is the serve Method if the router which routes the URLS to the right methods
   *
   * @param ip: ip on which the server is provided
   * @param port: port on which the server is provided
   *
   * @return the router with the URLs
   */
  Future<Router> serve({ip : '0.0.0.0', port: 4040}) async {
    final server = await HttpServer.bind(ip, port);
    final router = new Router(server)
      ..serve(userGetUrl,           method: 'OPTIONS').listen(options)
      ..serve(userPostUrl,          method: 'POST'   ).listen(createUser)
      ..serve(userGetUrl,           method: 'GET'    ).listen(readUser)
      ..serve(userGetUrl,           method: 'PUT'    ).listen(updateUser)
      ..serve(userGetUrl,           method: 'DELETE' ).listen(deleteUser)

    return new Future.value(router);
  }

  /**
   * Sets CORS headers for responses.
   */
  void enableCors(HttpResponse response) {
    response.headers.add( "Access-Control-Allow-Origin","*" );
    response.headers.add("Access-Control-Allow-Methods","HEAD,GET,PUT,POST,DELETE,OPTIONS" );
    response.headers.add(
        "Access-Control-Allow-Headers",
        "Origin, X-Requested-With, Content-Type, Accept, Charset, charset, pwd, secret, name, mail, newpwd"
    );
  }

  /**
   * the Options which the Request can fulfill
   */
  void options(HttpRequest req) {
    HttpResponse res = req.response;
    enableCors(res);
    res.write("POST, GET, DELETE, PUT, OPTIONS");
    res.close();
  }


}


