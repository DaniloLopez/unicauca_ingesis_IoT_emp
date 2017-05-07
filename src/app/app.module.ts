import { BrowserModule } from '@angular/platform-browser';
import { ErrorHandler, NgModule } from '@angular/core';
import { IonicApp, IonicErrorHandler, IonicModule } from 'ionic-angular';
import { SplashScreen } from '@ionic-native/splash-screen';
import { StatusBar } from '@ionic-native/status-bar';

import { MyApp } from './app.component';
import { Inicio } from '../pages/inicio/inicio';
import { Apagar } from "../pages/apagar/apagar";
import { Graficas } from "../pages/graficas/graficas";
import { Sensores } from "../pages/sensores/sensores";
import { Temporizador } from "../pages/temporizador/temporizador";
import { Acerca } from "../pages/acerca/acerca";

@NgModule({
  declarations: [
    MyApp,
    Inicio,
    Apagar,
    Graficas,
    Sensores,
    Temporizador,
    Acerca    
  ],
  imports: [
    BrowserModule,
    IonicModule.forRoot(MyApp)
  ],
  bootstrap: [IonicApp],
  entryComponents: [
    MyApp,
    Inicio,
    Apagar,
    Graficas,
    Sensores,
    Temporizador,
    Acerca  
  ],
  providers: [
    StatusBar,
    SplashScreen,
    {provide: ErrorHandler, useClass: IonicErrorHandler}
  ]
})
export class AppModule {}
