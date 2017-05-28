import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
import { EmpService } from "../../providers/emp-service";
import { Humedad } from "../../models/humedad";

@IonicPage()
@Component({
  selector: 'page-sns-humedad',
  templateUrl: 'sns-humedad.html',  
})
export class SnsHumedad {

  hum : string;

  constructor(public navCtrl: NavController, public navParams: NavParams, empService : EmpService)
  {
    empService.getHumedad().subscribe(humedad => this.loadHumedad(humedad, null), err => this.loadHumedad(null, err));

  }

  ionViewDidLoad() {
    //this.xmlItems = this.es.getSensorHumedad();   
    console.log("controlador de humedad");
  } 

  private loadHumedad(humedad: Humedad, err: string){
    
    if(err){
      console.log(err);
      this.hum= "None";
      return;
    }

    this.hum = humedad.valor;  
  }
}
