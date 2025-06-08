
package com.elveloz.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Cliente {
    private Integer id_cliente;
    private String nombre;
    private String apellido;
    private String email;
    private String telefono;
    private String nacionalidad;
    private String tipo_documento;
    private String numero_documento;
    private Integer id_rol_cliente;
    private boolean activo;
}
