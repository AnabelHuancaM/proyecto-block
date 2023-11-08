// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RegistroPropiedades {
    struct Propiedad {
        string nombre;
        string descripcion;
        address propietario;
    }

    mapping(uint256 => Propiedad) public propiedades;
    uint256 public cantidadPropiedades;

    event PropiedadAgregada(uint256 indexed id, string nombre, string descripcion, address propietario);
    event PropiedadActualizada(uint256 indexed id, string nombre, string descripcion, address propietario);
    event PropiedadEliminada(uint256 indexed id);

    constructor() {
        cantidadPropiedades = 0;
    }

    function agregarPropiedad(string memory _nombre, string memory _descripcion) public {
        cantidadPropiedades++;
        propiedades[cantidadPropiedades] = Propiedad(_nombre, _descripcion, msg.sender);
        emit PropiedadAgregada(cantidadPropiedades, _nombre, _descripcion, msg.sender);
    }

    function actualizarPropiedad(uint256 _id, string memory _nombre, string memory _descripcion) public {
        require(_id > 0 && _id <= cantidadPropiedades, "ID de propiedad invalido");
        require(msg.sender == propiedades[_id].propietario, "Solo puedes actualizar tus propias propiedades");
        propiedades[_id].nombre = _nombre;
        propiedades[_id].descripcion = _descripcion;
        emit PropiedadActualizada(_id, _nombre, _descripcion, msg.sender);
    }

    function eliminarPropiedad(uint256 _id) public {
        require(_id > 0 && _id <= cantidadPropiedades, "ID de propiedad invalido");
        require(msg.sender == propiedades[_id].propietario, "Solo puedes eliminar tus propias propiedades");
        delete propiedades[_id];
        emit PropiedadEliminada(_id);
    }
}