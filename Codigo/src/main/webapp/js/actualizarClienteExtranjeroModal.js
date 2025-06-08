document.addEventListener('DOMContentLoaded', function () {
    const botonesActualizarExtranjero = document.querySelectorAll('.btn-actualizar-cliente-extranjero'); // Selector para botones de clientes extranjeros
    const modalModificarClienteExtranjero = document.getElementById('modal-modificar-cliente-extranjero');
    const formularioModificarClienteExtranjero = document.getElementById('formulario-modificar-cliente-extranjero');
    const botonGuardarClienteExtranjeroModal = document.getElementById('guardar-cliente-extranjero');

    // Referencias a los campos del formulario del modal extranjero
    const inputIdClienteExtranjero = document.getElementById('id_cliente_extranjero_modal');
    const inputNombreExtranjero = document.getElementById('nombre_extranjero_modal');
    const inputApellidoExtranjero = document.getElementById('apellido_extranjero_modal');
    const inputEmailExtranjero = document.getElementById('email_extranjero_modal');
    const inputTelefonoExtranjero = document.getElementById('telefono_extranjero_modal');
    const selectNacionalidadExtranjero = document.getElementById('nacionalidad_extranjero_modal');
    const selectTipoDocumentoExtranjero = document.getElementById('tipo_documento_extranjero_modal');
    const inputNumeroDocumentoExtranjero = document.getElementById('numero_documento_extranjero_modal');

    function cerrarModalExtranjero() {
        if (modalModificarClienteExtranjero) {
            modalModificarClienteExtranjero.classList.add('hidden');
        }
    }

    // Event listener para el botón de cerrar del modal extranjero
    const botonCerrarModalExtranjero = modalModificarClienteExtranjero ? modalModificarClienteExtranjero.querySelector('button[onclick*="modal-modificar-cliente-extranjero"]') : null;
    if (botonCerrarModalExtranjero) {
        botonCerrarModalExtranjero.addEventListener('click', cerrarModalExtranjero);
    }

    botonesActualizarExtranjero.forEach(boton => {
        boton.addEventListener('click', async () => {
            const idCliente = boton.dataset.id;
            console.log('ID del cliente extranjero al hacer clic:', idCliente);

            inputIdClienteExtranjero.value = idCliente;

            try {
                const response = await fetch(`extranjeroControlador?accion=obtenerCliente&id=${idCliente}`);
                if (!response.ok) {
                    const errorBody = await response.text();
                    throw new Error(`Error HTTP! status: ${response.status}. Body: ${errorBody}`);
                }
                const cliente = await response.json();

                inputNombreExtranjero.value = cliente.nombre;
                inputApellidoExtranjero.value = cliente.apellido;
                inputEmailExtranjero.value = cliente.email;
                inputTelefonoExtranjero.value = cliente.telefono;
                selectNacionalidadExtranjero.value = cliente.nacionalidad;
                selectTipoDocumentoExtranjero.value = cliente.tipo_documento;
                inputNumeroDocumentoExtranjero.value = cliente.numero_documento;

                modalModificarClienteExtranjero.classList.remove('hidden');

            } catch (error) {
                console.error('Error al obtener los datos del cliente extranjero:', error);
                alert('No se pudieron cargar los datos del cliente extranjero. Inténtalo de nuevo.');
            }
        });
    });

    botonGuardarClienteExtranjeroModal.addEventListener('click', async (event) => {
        event.preventDefault();
        botonGuardarClienteExtranjeroModal.disabled = true;

        const datos = new URLSearchParams(new FormData(formularioModificarClienteExtranjero));
        // No hay que enviar el id_rol_cliente porque no se cambia

        try {
            const response = await fetch('extranjeroControlador?accion=actualizarCliente', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: datos
            });

            const resultado = await response.text();
            console.log('Respuesta completa del servidor al actualizar cliente extranjero:', resultado);

            if (!response.ok) {
                console.error(`Error HTTP al actualizar cliente extranjero! Estado: ${response.status}`);
                alert(`Error al guardar los cambios: ${resultado}`);
            } else {
                console.log('Estado HTTP 200 OK para actualización de cliente extranjero.');
                if (resultado.trim() === "SUCCESS") {
                    console.log('Actualización de cliente extranjero exitosa según la respuesta.');
                    cerrarModalExtranjero();
                    window.location.reload(); // Recarga la página para mostrar los cambios
                } else {
                    console.warn('Actualización de cliente extranjero no exitosa según la respuesta del servlet:', resultado);
                    alert(`La actualización del cliente extranjero no fue exitosa: ${resultado}`);
                }
            }
        } catch (error) {
            console.error('Error en la llamada fetch al guardar cliente extranjero:', error);
            alert('Ocurrió un error de conexión o servidor al actualizar el cliente extranjero. Inténtalo de nuevo.');
        } finally {
            botonGuardarClienteExtranjeroModal.disabled = false;
        }
    });
});