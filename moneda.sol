// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Cripto {
    
    string nombre;
    string simbolo;
    mapping (address => uint) balance;
    uint fondosdisponibles;
    uint fondosCirculantes;
    address owner;
    
    constructor(uint suministros, string memory nombreNuevo, string memory simboloNuevo) {
        fondosdisponibles = suministros;
        fondosCirculantes = suministros;
        nombre = nombreNuevo;
        simbolo = simboloNuevo;
        owner = msg.sender;
    }
    
    function ObtenerBalance() public view returns (uint){
        return balance[msg.sender];
    }
    
    function CambiarOwner(address nuevoOwner) public SoloOwner {
        require(owner == msg.sender, "Solo el owner puede asignar un nuevo owner.");
        owner = nuevoOwner;
        
    }
    
    function FondearSaldo (address direccion, uint monto) public SoloOwner {
        //establesco que el owner no se pueda cargar valor
        require(direccion != owner, "El owner no se puede cargar saldo a si mismo.");
        
        
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
    
    modifier SoloOwner (){
         require(owner != msg.sender, "Solo el owner puede ejecutar la function.");
         _;
    }
    
    function Cobrar() public payable{
        //va vacia.
    }
    
    function RetirarTokens() public SoloOwner {
        //a partir de la version 4 , solo puede retirar address con asignacion payable.
        address payable ownerPagable = payable(owner);
        ownerPagable.transfer(10 wei); 
    }
    
    function QuemarTokens(uint monto) public SoloOwner {
        require( monto <= fondosdisponibles, "No hay suficientes fondos disponibles para quemar.");
        balance[address(0)] += fondosdisponibles;
        fondosdisponibles = 0;
        fondosCirculantes -= monto;
    }
    
    function VerCirculante() public view returns (uint){
        return fondosCirculantes;
    }
    
    
}    