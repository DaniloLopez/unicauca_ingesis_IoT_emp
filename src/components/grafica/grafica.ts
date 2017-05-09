import { Component, Input, OnInit} from '@angular/core';

/**
 * Generated class for the Grafica component.
 *
 * See https   ://angular.io/docs/ts/latest/api/core/index/ComponentMetadata-class.html
 * for more info on Angular Components.
 */
@Component({
  selector   : 'grafica',
  templateUrl   : 'grafica.html' 
})
export class Grafica implements OnInit{
  @Input() name_sensor  : string;
  @Input() name_var     : string;
  @Input() sensor_id    : string;
  
  constructor() {    
    
  }
  ngOnInit(){    
    console.log("sensor   : " + this.name_sensor)
  }

}
