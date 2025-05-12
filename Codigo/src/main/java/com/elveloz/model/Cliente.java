
package com.elveloz.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Cliente {
    private Integer id_cliente;
    private Integer id_persona;
    private String tipo_documento;
    private String numero_documento;
}
