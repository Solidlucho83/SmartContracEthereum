// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Cripto {
    
    string nombre;
    string simbolo;
    
    
    mapping (address => uint) balance;
    uint fondosdisponibles;
    address owner;
    
    constructor(uint suministros, string memory nombreNuevo, string memory simboloNuevo) {
        fondosdisponibles = suministros;
        nombre = nombreNuevo;
        simbolo = simboloNuevo;
        owner = msg.sender;
    }
    
    function ObtenerBalance() public view returns (uint){
        return balance[msg.sender];
    }
    
    function CambiarOwner(address nuevoOwner) public {
        require(owner == msg.sender, "Solo el owner puede asignar un nuevo owner.");
        owner = nuevoOwner;
        
    }
    
    function FondearSaldo (address direccion, uint monto) public{
        //establesco que el owner no se pueda cargar valor
        require(direccion != owner, "El owner no se puede cargar saldo a si mismo.");
         
        //valido que sea unicamente el owner (dueño) el que pueda ejecutar esta funcion.
        require(owner == msg.sender, "Solo el owner puede realizar esta accion.");
        
        //require para no cargar mas saldo del que hay, devuelve  false sino
        require(fondosdisponibles >= monto, "No hay fondos suficientes." );
        
        //le añado saldo al monto con +=
        balance[direccion] += monto;
        fondosdisponibles -= monto; 
        
    }
    
    function Transferir (address destino , uint monto) public {
        require(balance[msg.sender] >= monto, "No tiene suficiente saldo para Transferir.");
        balance[msg.sender] -= monto; 
        balance[destino] += monto; 
        
    }