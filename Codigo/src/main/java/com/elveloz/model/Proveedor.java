
package com.elveloz.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Proveedor {
    private Integer id_proveedor;
    private Integer id_persona;
    private Integer dni;
}
