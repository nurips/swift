//
//  ViewController.swift
//  Entrega
//
//  Created by nuria on 17/03/2020.
//  Copyright © 2020 nuria. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController , UITextFieldDelegate {
  /*
     ImagenPrincipal -> outlet que carga la imagen del muñeco pensando
     nickPersona -> textField que almacena el nick de la persona que ha elegido
     PalabrasPrincipales -> outlet donde se Almacenan el titulo de la aplicacion
     nick -> variable que almacen el nickPersona
     */
    @IBOutlet weak var IMAGENPRINCIPAL: UIImageView!
    
    @IBOutlet weak var Segmento: UISegmentedControl!
    @IBOutlet weak var nickPersona: UITextField!
    @IBOutlet weak var PalabrasPrincipales: UILabel!
    var nick = " "
    var color = " "
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        PalabrasPrincipales.text = " ¿CUANTAS PALABRAS ERES CAPAZ  DE ADIVINAR "
        IMAGENPRINCIPAL.image = UIImage(named: "Hombre-Pregunta")
        
        
    }
    /*
       funcion Empezar-> Cuando damos al boton de empezar , comprobamos que el textfield  no es vacio, si es vacio avisamos atraves de una alert que es un nombre no valido. Si este no esta vacio , asignamos el nickPersona a la variable nick y llamamos al segue Prueba para que salte la fucion prepare , para que pase este nick a ViewController2
     */
    
    @IBAction func Empezar(_ sender: UIButton) {
       if !(nickPersona.text?.isEmpty ?? true){
                nick = nickPersona.text!
                 performSegue(withIdentifier: "Prueba", sender: self)
                    
        }else{
            
            let al = UIAlertController (title: "Error", message :"Nombe no valido" , preferredStyle: .alert)

            al.addAction(UIAlertAction (title : "OK" , style : .default , handler: nil))
          
            self.present(al,animated: true)
        }
     
     }
    /*
       funcion prepare -> La usamos para pasar informacion de ViewController a ViewController2 , en este caso sera el nick del usuario
      */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DVC = segue.destination as! ViewContoller2
        DVC.ni = nick
        DVC.color = color
    }
    /*
       Funcion textFieldShouldReturn -> fucion para que de el teclado intro , la informacion se quede almacenada.
          Se llama resignFirstResponde , para que renuncie a su estado como primer respondedor en su ventana
     */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           return textField.resignFirstResponder()
        
       }
    /*
       funcion touchesBegan -> Reconocer el gesto cuando uno o mas dedos tocan la vista asociada
             y que se esconda el teclado con los valores del nick
            
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
   /*
      funcion Color -> Esta funcion sirve para que el usuaario cambie el color de la interfaz
        si el segmento elegido es 0 -> Entonces elige la opcion Clara (white) y cambiamos el color de navigation y view a este y el color
        Si el segmento elegido es 1 -> Entoces elegimos la opcion oscura (black) y cambiamos el color navigation , view y pasamos el color a la variable color (Esta variable pasara el nombre del color al Viewcontroller2)
     */
    
     
    @IBAction func Color(_ sender: UISegmentedControl) {
        if Segmento.selectedSegmentIndex == 0{
              navigationController?.navigationBar.barTintColor = UIColor.white
            self.view.backgroundColor = UIColor.white
            self.color = "white"
            
        }else{
            self.view.backgroundColor = UIColor.black
            navigationController?.navigationBar.barTintColor = UIColor.black
            self.color = "black"
        }
    }
    
    
}

