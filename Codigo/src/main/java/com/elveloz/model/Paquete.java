
package com.elveloz.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class Paquete {
    private Integer id_paquete;
    private Integer id_peticion_envio;
    private String nombre;
    private String categoria;
    private int cantidad;
    private double peso;
}
