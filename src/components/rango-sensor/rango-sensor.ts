import { Component, OnInit, Output, Input } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from "@angular/forms";
import { NavController } from "ionic-angular";

@Component({
  selector: 'rango-sensor',
  templateUrl: 'rango-sensor.html'
})
export class RangoSensor implements OnInit {
  @Output() max: string;
  @Output() min: string;  

  @Input() texto: string;
  @Input() texto2: string;

  myForm: FormGroup;  
  formRango: FormGroup;  

 
//es recomendable que en el contructor solo se declaren variables  
  constructor(
    public navCtrl: NavController,
    public fb: FormBuilder
  ) {
    console.log('Hello RangoSensor Component');            
    this.formRango = this.fb.group({
      'minimo': ['' , [Validators.required, Validators.minLength(1), Validators.maxLength(2), Validators.pattern(/^\d*$/)]],
      'maximo': ['' , [Validators.required, Validators.minLength(1), Validators.maxLength(2), Validators.pattern(/^\d*$/)]]
    });
  }

//esta funcion se ejecuta cuando el componente ya esta listo pra usarse  
  ngOnInit(){
    console.log("Rango sensor " + this.texto);    
    console.log("Rango sensor2 " + this.texto2);
  }

  
  saveData(){
    console.log(this.myForm.value);
  }

  actualizar(){
    console.log(this.formRango.value);
  }
}
