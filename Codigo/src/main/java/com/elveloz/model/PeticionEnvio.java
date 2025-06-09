
package com.elveloz.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


import java.sql.Timestamp;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PeticionEnvio {
    private Integer id_peticion_envio;
    private String codigo_peticion;
    private Integer id_cliente_nacional; 
    private Integer id_cliente_extranjero; 
    private Integer id_envio_consolidado; 
    private Timestamp fecha_creacion; 
    private double peso_total;
    private double precio_total;
    private String tipo_envio;
    private String pais_envio;
    private int cantidad_paquetes;
    private Integer id_usuario;
    
    private String nombreClienteNacionalCompleto;
    private String nombreClienteExtranjeroCompleto;
    
}
