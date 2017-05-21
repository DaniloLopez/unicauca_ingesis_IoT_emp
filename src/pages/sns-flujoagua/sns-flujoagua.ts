import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
//import del servicio conector
import { EmpService } from "../../providers/emp-service";


@IonicPage()
@Component({
  selector: 'page-sns-flujoagua',
  templateUrl: 'sns-flujoagua.html',
  providers: [EmpService],
})
export class SnsFlujoagua {

  private xmlItems: any;    

  constructor(
    public navCtrl: NavController,
    public navParams: NavParams,
    public es: EmpService)
  {
    this.xmlItems = "aunno";
  }

  ionViewDidLoad() {
    console.log('ionViewDidLoad SnsFlujoagua, obteniendo xml' + this.xmlItems);    
  }
}
