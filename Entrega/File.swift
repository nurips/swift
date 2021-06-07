//
//  File.swift
//  Entrega
//
//  Created by nuria on 23/03/2020.
//  Copyright © 2020 nuria. All rights reserved.
//

import Foundation

class Palabra {
    /* VARIABLES:
     oculta->esta variable almacena la palabra que hay que almacenar
     array palabraOculta-> Array donde esta almacenada las posibles palabras Ocultas del juego
     s-> variable String donde almacenaremos tantos guioenes como caracteres tenga la palabra Oculta*/
    
    var oculta = ""
    var palabraOculta = ["ESPAÑA", "BRASIL", "TURQUIA" , "ETIOPIA" , "COLOMBIA" , "ARGENTINA" ,"FRANCIA","ARGELIA" ,"MEXICO" , "ECUADOR" , "RUSIA", "FILANDIA"]
    var s = ""
    
    /*
        Funcion CrearRandom -> Esta funcion la usaremos para crear de forma aleatoria la palabra Oculta. Esto se hace mediante el randomElement, que elige de manera aletaoria una palabra de la array PalabraOculta, esta palabra se guarda en la variable oculta. Si esta array Palabra oculta esta vacia , oculta se almacena como vacia, esta es la variable es la que devolvemos.
           En la funcion nos pasan un String palabra . Esta variable la usamos en la funcion EliminarPalabra , que comentaremos mas abajo para que lo uso.
        
     
    */
    func CrearRandom(palabra : String)->(String){
        var randomName = ""
        //var item = 0
        //let longi = palabraOculta.count
        palabraOculta = EliminarPalabra(elimina: palabra, lista: palabraOculta)
      
            if !palabraOculta.isEmpty {
            randomName = palabraOculta.randomElement()!
            oculta = randomName
            }else{
                oculta = ""
        }
          
         return (oculta)
        
    }
    
    /*
        funcion crearLineasPalabras() -> Esta funcion creamos para crear los guiones con la longitud de la palabra a adivinar.
           s  es vacia, entra en el while y rellena s con los guiones de la palabra Oculta.
       Si s no es vacia, la volvemos vacia (Esto es porque vienes de una palabra anterior acertada)
     */
    
    func crearLineasPalabras ()->String{
    var i = 0
        if !s.isEmpty{
            s = ""
        }
        while (i < oculta.count){
        s += "-"
        i += 1
     }
        return s
    }
    
    
    
    /*
        Funcion comprobar Letras-> Esta funcion la usaremos para ir comprobando las letras de la palabra , con las letras que ha pausado el usuario. Si esta esta en la palabra llamamos a la fucion remplaza , si no delvolvemos el estado anterior de la palabra.
     */
    
    func comprobarLetra ( letra : String, anterior : String)->(String){
         var gs = anterior
     
        for item in 0..<oculta.count{
           
            let pal = oculta.index(oculta.startIndex, offsetBy: item)
            var r = oculta[pal]
            if  r == Character.init(letra) {
       // if let index = oculta.index (of: Character.init(letra)){
        //if  let firstIndex : Range <String.Index> = oculta.range(of: letra)  {
        //    let index = oculta.distance(from: oculta.startIndex, to: firstIndex.lowerBound)
                gs = remplaza(offset: item , le: letra)
                // print (index)
        
         //   }
            }
        
        }
            return gs
    }
/*
     Funcion remplaza -> Esta fucion la usamos cuando una letra esta en la palabra, para remplazar los guiones por la letra que nos han pasado , en la posicion que le corresponde. Devolveremos la variable s con los cambios
     */

    func remplaza (offset : Int, le : String ) -> String{
       // var temp = anterior
        let index = s.index (s.startIndex , offsetBy: offset)
        let range = index...index
        s.replaceSubrange(range, with: le)
        
        return s
    }
/*
     Funcion EliminarPalabra -> Esta fucion la usamos para eliminar la palabra que ya hemos usado en el juego. Para ello usamos filter , creando una array con las palabras que son distintas a la palabra ya utilizada. Devolvemos la nuevo array. Esta fucion la usamos mas arriba en la funcion crearPalabra.
     */
    
    
    func EliminarPalabra (elimina : String ,lista:[String])->[String]{

        let pal = lista.filter{ $0 != elimina}
              return pal
                   
        }
    
    

}
