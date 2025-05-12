
package com.elveloz.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class Usuario {
    private Integer id_usuario;
    private String username;
    private String nombre;
    private String apellido;
    private String password_e;
    private int id_rol;
    private boolean activo;
    
}
