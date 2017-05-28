import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
//import del servicio conector
import { EmpService } from "../../providers/emp-service";
import { FlujoAgua } from "../../models/flujoAgua";


@IonicPage()
@Component({
  selector: 'page-sns-flujoagua',
  templateUrl: 'sns-flujoagua.html',
  providers: [EmpService],
})
export class SnsFlujoagua {

  private valor : string;
  private mensaje : string;

  constructor(
    public navCtrl: NavController,
    public navParams: NavParams,
    public empService: EmpService)
  {
    empService.getFlujoAgua().subscribe(flujoAgua=> this.loadFlujo(flujoAgua, null), err => this.loadFlujo(null, err));
  }

  ionViewDidLoad() {
    console.log('ionViewDidLoad SnsFlujoagua');    
  }

  private loadFlujo(flujo: FlujoAgua, err: string){    
    if(err){
      console.log(err);
      this.valor = "None";
      return;
    }
    this.valor = flujo.distancia;  
    var aux = parseFloat(this.valor);
    if (aux < 1.00){
      this.mensaje = "flujo de agua activo"    
    }
    else{
      this.mensaje = "flujo de agua inactivo"  
    }    
  }

}
