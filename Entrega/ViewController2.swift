//
//  ViewController2.swift
//  Entrega
//
//  Created by nuria on 17/03/2020.
//  Copyright © 2020 nuria. All rights reserved.
//

import UIKit
import Foundation

class ViewContoller2: UIViewController {
  /*
     var second -> Los 3 minutos dejamos para acertar las palabras
     var Tim -> La variable que señala al temporizador
     var Oculta -> Variable que almacena la palabra a Adivinar
     var Acierto -> Variable que almacena el numero de aciertos del usuario
     var temp-> variable que almacena el estado anterior de la palabra
     var pausar -> La variable que se usa si esta en true para pausar el temporizador
     */
    
    var second = 180
    var Tim = Timer()
    var palabra = Palabra()
    var Oculta = ""
    var s = ""
    var acierto = 0
    var temp = ""
    var color = " "
    var pausar = false
    /*
        tiempo-> LAbel que recoge el temporizador en la pantalla
         nick -> Label que recoge el nick del usuario
         palabraOculta -> Label donde ira apareciendo la palabra Oculta
         NumAcierto -> Label donde ira sumandose los aciertos de las palabras adivinadas
     */
    @IBOutlet weak var tiempo: UILabel!
    
    
    @IBOutlet weak var nick: UILabel!
    @IBOutlet weak var Imagen: UIImageView!
    
    @IBOutlet weak var palabraOculta: UILabel!
    
    @IBOutlet weak var NumAcierto: UILabel!
    var ni = ""
    
    /*
            funcion ViewDidLoad-> llamamos a la funcion time, para que inicie el temporizador.
                                  pasamos a la label nick el valor del nombre del usuario.
                                Ponemos el numero de Acierto a 0 de momento .
                                Cambiamos el color view y el navigation controller , dependiendo del color que nos hayan pasado por segue
                                LLamamos al metodo CrearRandom de la clase File , para que crear la primera palabra a adivinar y al crearLinea para crear los guiones
                   Asociamos a oculta la palabraOculta a adivinar
     */
    override func viewDidLoad() {
       
        super.viewDidLoad()
        if color == "black"{
            self.view.backgroundColor = UIColor.black
            navigationController?.navigationBar.barTintColor = UIColor.black
        }else{
            self.view.backgroundColor = UIColor.white
            navigationController?.navigationBar.barTintColor = UIColor.white
        }
         time()
        nick.text = ni
        NumAcierto.text = "Aciertos : " + "\(acierto)"
        //print (ni)
        
        let (oculta) = palabra.CrearRandom(palabra:"")
        palabraOculta.text = palabra.crearLineasPalabras()
        Oculta = oculta
        
    }
    
    /*
        funcion time -> Esta funcion crea un temporizador. Para eso usamos un metodo de clase , su valor de retorno se asigna a la contate Tim.
     Este tiene un valor de retono que se le asigna a la constante Tim. Esta constante ahora contiene una referencia al temporizador. , selector llama a la funcion Updatetime, y el time interval el intervalo de tiempo que se llama frecuencia al metodo
     
     */
    func time (){
        Tim = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewContoller2.updateTime)), userInfo: nil, repeats: true)
    }
    
    
    /*
        funcion PulsaLetra -> Esta funcion esta asociada a todos los botones con las letras del abecedario. En primer lugar asociamos la palabra anterior a la variable temp.  En esta funcion llamamos a la funcion de fichero File comprobarLetra, para que compruebe si esta letra esta o no contenida en la palabra. Si la variable va nos da una nueva string ,eso significa que es  distinta a la temp, entonces esta letra esta en la palabra . Ahora comprobamos si contine todavia guiones de la variable va , si todavia tiene guiones , eso quiere decir que todavia nos falta por acertar mas letras de la palabra. Con lo cual asociamos la variable va a la label palabraOculta.
            En cambio , si no contiene ningun guion mas , eso quiere decir que esta la palabra completa y hemos acertado la palabra , con lo cual sumamos el acierto al marcador, paramos el tiempo del temporizador, y salta la alerta como que hemos acertado la palabra , con dos botones Ok
                    Ok -> vuelve a crear otra palabra nueva para acertar , se llama a ultima palabra para comprobar si es la ultima del array ,  si no  se crea de nuevo la pantalla de ViewController2, empieza a contar el contador del tiempo desde el donde se dejo pausado.
     
                Cancel-> Antes de volver al ViewController , Nos salta una alerta diciendo Adios y el numero de palabras que el usuario hay acertado
            Si esta la variable va es igual a la variable temp , eso significa que esa letra no esta contenida a en la palabra, entonces llamaos a la funcion cargarImagen.
     
     */
    
@IBAction func PulsaLetra(_ sender: UIButton) {
        let le = sender.currentTitle!
         temp = palabraOculta.text!
        var va = palabra.comprobarLetra(letra: le  ,anterior: temp)
       //  ultimaPalabra(ultima: va)
        if va != temp{
        if va.contains("-"){
            palabraOculta.text = va
            palabraOculta.adjustsFontSizeToFitWidth = true
             print ("La letra que ha sido pausada" , va)
             
        }else{
            palabraOculta.text=va
            acierto += 1
            NumAcierto.text = "Aciertos : " +  "\(acierto)"
            Tim.invalidate()
            self.pausar = true
            
            let alert = UIAlertController(title: "Acertates" , message : nil , preferredStyle: .alert)
            let imagen = UIImage(named: "HOMERpng")
            
            let imagView = UIImageView (frame : CGRect (x : 10 , y : 50 , width: 250 , height: 230 ))
             imagView.image = imagen
            alert.view.addSubview(imagView)
           
           let height = NSLayoutConstraint (item : alert.view , attribute: .height , relatedBy: .equal , toItem: nil,attribute: .notAnAttribute , multiplier: 1 , constant: 320)
            let width = NSLayoutConstraint (item : alert.view , attribute: .width , relatedBy: .equal , toItem: nil,attribute: .notAnAttribute , multiplier: 1 , constant:250.0)
            
            alert.view.addConstraint(height)
            alert.view.addConstraint(width)
            
            //alert.addAction(action)
            let action1 = UIAlertAction (title: "Ok", style: .default, handler: {
                action in
                self.time()
                self.temp = va
                self.palabraOculta.text = ""
                let (pala) = self.palabra.CrearRandom(palabra: self.temp)
                self.ultimaPalabra(ultima: pala)
                self.palabraOculta.text=self.palabra.crearLineasPalabras()
                self.Oculta = pala
                self.Imagen.image = nil
                self.view.layoutIfNeeded()
            })
            let action2 = UIAlertAction (title: "Cancel", style: .default, handler: {
                action in
                let al = UIAlertController (title: "ADIOS", message : self.ni + " Has acertado " + "\(self.acierto) " + "palabras", preferredStyle: .alert)

                        al.addAction(UIAlertAction (title : "OK" , style : .default , handler: {
                           action in
                            self.Tim.invalidate()
                             self.pausar = true
                            
                            self.navigationController?.popViewController(animated: true)
                         
                            
                        }))
                        self.present(al, animated : true)
           
               
            })
            alert.addAction(action1)
            alert.addAction(action2)
          //  pruneNegativewidthConstraints()
            self.present (alert , animated : false)
        }
        }else{
            print("Esa letra no esta en la palabra", le)
         
                cargarImagen()
            
        }
        
  }
    

/*
     funcion updateTime -> Esta funcion la usamos para que vaya restando uno al timer . si el timer llega a ser menor de 0 , este se para para que no siga contando en negativo, y salta una alerta de tiempo terminado , con las palabras que ha acertado el usuario y con un boton Ok que nos devuelve a la pantalla Viewcontrolller
     */

    @objc func updateTime () {
        if second < 1{
                   Tim.invalidate()
                   let al = UIAlertController (title: "Se acabo el tiempo", message : ni + " Has acertado " + "\(acierto) " + "palabras" , preferredStyle: .alert)

                   al.addAction(UIAlertAction (title : "OK" , style : .default , handler: {
                       action in
                    self.Tim.invalidate()
                     self.pausar = true
                  
                      self.navigationController?.popViewController(animated: true)
                 
                  
                   }))
                   self.present(al, animated : true)
               }else {
               second -= 1
            tiempo.text = formato (time : TimeInterval (second))
                    }
           }
    /*
       funcion Formato -> Esta funcion formatea el timer , para que salga de la manera 00:00
     */
    
    func formato(time : TimeInterval) -> String {
        let minutes = Int (time) / 60 % 60
        let seconds = Int (time) % 60
        return String(format : "%02i : %02i" , minutes , seconds)
    }

/*     funcion ultimaPalabra-> Esta funcion se usa si hemos acertado todas las palabras que contiene la Array en el tiempo estimado, entonces hemos quedado la array sin palabras para adivinar . Esta funcion comprueba si la variable ultima que nos pasa es igual "" , si es asi salta una alerta de todas la palabra acertadas, con un boton Ok , que nos devuelve a la primera pantalla de ViewController
     */
    func ultimaPalabra (ultima:String){
        if ultima == ""{
                
            let alert = UIAlertController(title: "Acertates TODAS" , message :ni + "Has acertado " + "\(acierto) " + "palabras", preferredStyle: .alert)
                          
                           let action1 = UIAlertAction (title: "Ok", style: .default, handler: {
                            action in
                                           self.navigationController?.popViewController(animated: true)
                            
                          
                                       })
                                       alert.addAction(action1)
                                  
                                       self.present (alert , animated : false)
        
    }
    }
    
    /*
       funcion cagarImagen -> Va cargando la imagen del muñeco del ahorcado en la UIImageView . Depende de que estado de la imagen estemos , va cargando la siguiente de este estado. Si creamos todo el muñeco del ahorcado, esta salta una alerta de Game Over, con las palabras que ha acertado el jugador y  un boton ok  que nos devolvera a la pantalla ViewController
     */

func cargarImagen (){
    if Imagen.image == nil{
        Imagen.image = UIImage (named : "base1")
    }else{
        if Imagen.image == UIImage (named :"base1"){
            Imagen.image = UIImage(named: "base2")
        }else if Imagen.image == UIImage (named : "base2"){
            Imagen.image = UIImage (named: "base3")
        }else if Imagen.image == UIImage (named : "base3"){
            Imagen.image = UIImage (named: "base4")
        }else if Imagen.image == UIImage (named : "base4"){
            Imagen.image = UIImage (named: "base5")
        }else if Imagen.image == UIImage (named : "base5"){
            Imagen.image = UIImage (named: "base6")
        }else if Imagen.image == UIImage (named : "base6"){
            Imagen.image = UIImage (named: "base7")
        }else if Imagen.image == UIImage (named : "base7"){
            Imagen.image = UIImage (named: "base8")
        }else if Imagen.image == UIImage (named : "base8"){
            Imagen.image = UIImage (named: "base9")
        }else if Imagen.image == UIImage (named : "base9"){
            Imagen.image = UIImage (named: "base10")
            let al = UIAlertController (title: "GAME OVER", message : ni + " Has acertado " + "\(acierto) " + "palabras", preferredStyle: .alert)

            al.addAction(UIAlertAction (title : "OK" , style : .default , handler: {
               action in
                self.Tim.invalidate()
                 self.pausar = true
                
                self.navigationController?.popViewController(animated: true)
             
                
            }))
            self.present(al, animated : true)
        }
    }
}
    /*
       Funcion Activar Tiempo -> Sirve para activar o desactivar el tiempo arriba. Jugar sin temporizador o con el
         si el Switch esta activado -> el tiempo esta corriendo y la label la tenemos activada
         Si el switch esta desactivado -> el tiempo se para y la label esta desactivada
     */

    
    @IBAction func ActivarTiempo(_ sender: UISwitch) {
        if sender.isOn{
            tiempo.isEnabled = true
            time()
        }else {
            tiempo.isEnabled = false
            Tim.invalidate()
            pausar = true
        }
    
    }
    
    
}
