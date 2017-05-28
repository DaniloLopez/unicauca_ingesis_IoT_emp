import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
import { EmpService } from "../../providers/emp-service";
import { Temperatura } from "../../models/temperatura";
/**
 * Generated class for the SnsTemperatura page.
 *
 * See http://ionicframework.com/docs/components/#navigation for more info
 * on Ionic pages and navigation.
 */
@IonicPage()
@Component({
  selector: 'page-sns-temperatura',
  templateUrl: 'sns-temperatura.html',
})
export class SnsTemperatura {

  private temp        : string;
  private variable    : string;
  private listaValores: string[];  

  constructor(
    public navCtrl: NavController, 
    public navParams: NavParams,
    empService : EmpService) {    
      //suscribe tiene dos argumentos, uno en caso de exito y otro en caso de error
      this.variable = "Exito";
      this.getTemperatura(empService);
      this.listaValores = [];
  }

  ionViewDidLoad() {
    console.log('ionViewDidLoad SnsTemperatura');
  }

  private loadTemperatura(temperatura: Temperatura, err: string){
    //console.log("respuesta: " + temperatura.valor);    
    this.listaValores.push("exito");
    console.log(this.listaValores);
    if(err){
      //console.log(err);
      console.log("coneccion rechazada");
      this.temp = "None";
      return;
    }    
    this.temp = temperatura.valor;  
  }

  private getTemperatura( empService : EmpService){    
      this.variable = "Exito";
      var i : number = 0;
      for (i = 0; i< 10; i++){
        console.log("iteracion " + i);
        empService.getTemperatura().subscribe(
          tempertura => 
            this.loadTemperatura(tempertura, null), 
            err => this.loadTemperatura(null, err)
        );
      }      
  }

}
