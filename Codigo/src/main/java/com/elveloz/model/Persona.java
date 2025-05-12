
package com.elveloz.model;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Persona {
    private Integer id_persona;
    private String nombre;
    private String email;
    private String telefono;
    private String nacionalidad;
}
