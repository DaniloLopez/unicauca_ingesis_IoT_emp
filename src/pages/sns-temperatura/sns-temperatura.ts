import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';

//providers
import { EmpService } from "../../providers/emp-service";
import { EmpEcaProvider } from "../../providers/emp-eca/emp-eca";

//modelos
import { Temperatura } from "../../models/temperatura";
import { RangoSensorModel } from "../../models/rangoSensor";

import { Http, Response } from '@angular/http';

import { Eca } from "../../models/eca";

@IonicPage()
@Component({
  selector: 'page-sns-temperatura',
  templateUrl: 'sns-temperatura.html',
})
export class SnsTemperatura {

  //variable que almacena la temperatura de la ultima peticion a los sensores
  private temp        : string;  
  //variable auciliar para organizar los datos en el vector de datos
  private cant : number;
  //variable para almacenar el tiempo de retardo
  private delay : number;
  //numero de peticones que realiza al servidor
  private iteraciones : number;
  //vector que almacena los datos de la grafica
  private datos = [];  
  //vector de opciones para almacenar la configuracion de los graficos
  private chartOptions: any; 
  //objeto del rovider empEca para realizar las peticones al servidor
  private ecaService : EmpEcaProvider;

  constructor(public navCtrl: NavController, public navParams: NavParams, empService : EmpService, ecaService : EmpEcaProvider) {                
      //solicita que se realizen las peticiones
      this.ecaService = ecaService;
      this.getTemperatura(empService);
      this.datos = [];    
      this.delay = 2000;
      this.iteraciones = 2;
  }

  //cuando el componente este listo se realizan las operaciones correspondientes
  ionViewDidLoad() {
    console.log('ionViewDidLoad SnsTemperatura  ' + this.datos);        
  }

  private getTemperatura( empService : EmpService){          
      var i : number = 0;
      //ciclo para solicitar los diez valores de temperatura
      for (i = 0; i< 10; i++){
        console.log("iteracion " + i);
        //suscribe tiene dos argumentos, uno en caso de exito y otro en caso de error
        empService.getTemperatura().subscribe(
          tempertura => 
            //si la peticion es exitosa envia el dato de temperatura
            this.loadTemperatura(tempertura, null), 
            err => this.loadTemperatura(null, err)
        );        
      };
      //llamado al retardo de tiempo
      this.wait(this.delay);  
      //se inicializa la varible auxiliar a su estado inicial
      this.cant = 1;        
  }

  private loadTemperatura(temperatura: Temperatura, err: string){          
    //si ocurre un error, informa y dibuja la grafica
    if(err){      
      console.log("conexion rechazada");
      console.log(err);
      this.temp = "None";
      this.dibujarGrafica();
      return;
    }        
    //alamacena los datos retornados en la peticion en un vector
    this.datos.push([+temperatura.valor, this.cant]);
    console.log("  " + this.datos);
    console.log("respuesta: " + temperatura.valor);        
    this.temp = temperatura.valor;  
    //contador auxiliar para ayudar a ordenar el vector que contiene los resultados
    this.cant = this.cant + 1;
    //si ya se hicieron las 10 iteraciones y no hubo errores, se pinta la grafica
    if(this.cant == 10){
      this.dibujarGrafica();
    }
  }
     

  //metodo que se encarga de dar los valores adecuados para que se dibuje la grafica
  dibujarGrafica(){
    console.log("en componente de temperatura para graficar");
    this.chartOptions = {
      chart: {
        type: 'line',
        inverted: true
      },
      title: {
          text: "Temperatura Vs Tiempo"
      },
      subtitle: {
          text: 'La grafica puede variar con respecto a los valores reales'
      },
      xAxis: {
          reversed: false,
          title: {
              enabled: true,
              text: "Temperatura"
          },
          labels: {
              formatter: function () {
                  return this.value + '°';
              }
          },
          maxPadding: 0.05,
          showLastLabel: true
      },
      yAxis: {
          title: { text: "Tiempo" },
          labels: {
              formatter: function () {
                  return this.value;
              }
          },
          lineWidth: 2
      },
      legend: {
          enabled: false
      },
      tooltip: {
          headerFormat: '<b>{series.name}</b><br/>',
          pointFormat: '{point.x} : {point.y}'
      },
      plotOptions: {
          spline: {
              marker: {
                  enable: false
              }
          }
      },
      series: [{
          name: "Temperatura",
          data: this.datos
      }]
    }  

  }

  //realizar un retrazo para que se de tiempo a la peticion de retornar algo
  wait(ms){
    var start = new Date().getTime();
    var end = start;
    while(end < start + ms) {
      end = new Date().getTime();
    }
  }

  datosSensor : RangoSensorModel;

  recibirValoresRango(mensaje : RangoSensorModel){    
    this.datosSensor = mensaje;

    console.log("recibiendo datos del componente sensor hijo");
    console.log(mensaje.minimo);
    console.log(mensaje.maximo);      

    this.ecaService.deleteTemperaturaMax().subscribe(
      status => 
        this.eliminarEcaTempMax(status, null),
        err => this.eliminarEcaTempMax(null, err)
    )   
  }

  private eliminarEcaTempMax(res : Eca, err : string){
    let ecaService : EmpEcaProvider;
    var r = res;
    if(err){
      console.log("error en maxima  "  + err );
    }
    console.log("procesado eliminar temp");
    if(res.valor == 200) {
      this.ecaService.deleteTemperaturaMin().subscribe(
      status => 
        this.eliminarEcaTempMin(status, null),
        err => this.eliminarEcaTempMin(null, err)
      )
    }  
  }
  
  private eliminarEcaTempMin(res : Eca, err : string){
    if(err){
      console.log("error en minima  " + err);
      return;
    }

    console.log("Resultado peticion eliminar ecas min" + res);
  }




}
