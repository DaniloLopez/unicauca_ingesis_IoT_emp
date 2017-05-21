import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';

@IonicPage()
@Component({
  selector: 'page-sns-humedad',
  templateUrl: 'sns-humedad.html',  
})
export class SnsHumedad {

  constructor(public navCtrl: NavController,public navParams: NavParams)
  {

  }

  ionViewDidLoad() {
    //this.xmlItems = this.es.getSensorHumedad();   
    console.log("controlador de humedad");
  }

}
