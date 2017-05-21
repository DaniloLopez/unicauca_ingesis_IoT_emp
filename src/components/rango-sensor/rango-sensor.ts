import { Component, OnInit, Output, Input } from '@angular/core';

@Component({
  selector: 'rango-sensor',
  templateUrl: 'rango-sensor.html'
})
export class RangoSensor implements OnInit {
  @Output() max: string;
  @Output() min: string;  

  @Input() texto: string;
  @Input() texto2: string;
  
 
//es recomendable que en el contructor solo se declaren variables  
  constructor() {
    console.log('Hello RangoSensor Component');    
  }

//esta funcion se ejecuta cuando el componente ya esta listo pra usarse  
  ngOnInit(){
    console.log("Rango sensor " + this.texto);    
    console.log("Rango sensor2 " + this.texto2);    
  }
}