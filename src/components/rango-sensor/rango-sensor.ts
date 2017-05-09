import { Component, Input, OnInit, Output } from '@angular/core';

/**
 * Generated class for the RangoSensor component.
 *
 * See https://angular.io/docs/ts/latest/api/core/index/ComponentMetadata-class.html
 * for more info on Angular Components.
 */
@Component({
  selector: 'rango-sensor',
  templateUrl: 'rango-sensor.html'
})
export class RangoSensor implements OnInit {
  //@Output() max: string;
  //@Output() min: string;  

  constructor() {
    console.log('Hello RangoSensor Component');    
  }

  ngOnInit(){
    console.log("Rango sensor");    
  }
}
