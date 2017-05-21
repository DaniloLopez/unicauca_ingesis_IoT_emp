import { Injectable } from '@angular/core';
import { Http, Response } from '@angular/http';
import { Observable } from "rxjs/Observable";
import { Temperatura } from "../models/temperatura";
import { xml2js } from "xml2js";

//procesar la respuesta
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/catch';

@Injectable()
export class EmpService {

  public xmlItems: any;
  public urlService: String;
  public osid: String;
  
  constructor(public http: Http) {
    console.log('Hello EmpService Provider');        
    this.osid = "?osid=1519735968"
  }  

  get(): Observable<Temperatura>{
    //en el map va una funcion que permita procesar respuesta
    //el cath es para procesar el error    
    //return this.http.get("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22popayan%2C%20co%22)&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=")
    return this.http.get("http://186.87.66.4/SendData?osid=1519735968&variableEstado=Temperatura&tipove=1")
    .map(this.procesarRespuesta).catch(this.procesarError);  

  }

  private procesarRespuesta(response : Response){
    let body = response.text();
    console.log(body);

    //5 por tamaño de palabra float, 1 por l colilla y 1 por el mayor que
    var posIni = body.indexOf("float") + 5 + 1 + 1;
    var num;
    for (var i = posIni; i < body.length; i++){
      var bo = body[i] ;
      var con = bo.localeCompare("<");
      if (con == 0){
        num = body.substring(posIni,i);
        break;
      }
    }
    console.log(num);

    

    let temp = num;
    let temperatura = new Temperatura(temp);
    return temperatura;
  }

  private procesarError (){
    return Observable.throw("error al consumir servicio de temeratura");
  }


  parseXML(data)
  {
      return new Promise(resolve =>
      {
        var k,
            arr    = [],
            parser = new xml2js.Parser(
            {
                trim: true,
                explicitArray: true
            });

        parser.parseString(data, function (err, result)
        {
            var obj = result.Objects.object;
            for(k in obj.InfoItem)
            {
              var item = obj.InfoItem[k];
              arr.push({
                  id           : item.value[0]                
              });
            }

            resolve(arr);
        });
      });
  }



}

