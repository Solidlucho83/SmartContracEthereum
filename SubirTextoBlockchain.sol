// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract EscribirMensaje {
    
    string  mensaje;
    
    //se le añade memory para luego descartarlo.
    function recibirMensaje(string memory MensajeNuevo) public{
       mensaje = MensajeNuevo;
    }
    
    // le añade View para no consumir GAS
    // se puede usar la function abi.encodePacket para concatenar string
    function subirBlockchain() public view returns (string memory) {
        return string(mensaje);
    }
   
}