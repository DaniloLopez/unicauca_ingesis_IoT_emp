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

  temp : string;

  constructor(
    public navCtrl: NavController, 
    public navParams: NavParams,
    empService : EmpService) {    
      //suscribe tiene dos argumentos, uno en caso de exito y otro en caso de error
      empService.get().subscribe(tempertura => this.loadTemperatura(tempertura, null), err => this.loadTemperatura(null, err));  
  }

  ionViewDidLoad() {
    console.log('ionViewDidLoad SnsTemperatura');
  }

  private loadTemperatura(temperatura: Temperatura, err: string){
    
    if(err){
      console.log(err);
      return;
    }

    this.temp = temperatura.temp;  
  }

  

}
