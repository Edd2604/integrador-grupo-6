document.addEventListener('DOMContentLoaded', function () {
    const botonesActualizarNacional = document.querySelectorAll('.btn-actualizar-cliente-nacional'); // Selector para botones de clientes nacionales
    const modalModificarClienteNacional = document.getElementById('modal-modificar-cliente-nacional');
    const formularioModificarClienteNacional = document.getElementById('formulario-modificar-cliente-nacional');
    const botonGuardarClienteNacionalModal = document.getElementById('guardar-cliente-nacional');

    // Referencias a los campos del formulario del modal nacional
    const inputIdClienteNacional = document.getElementById('id_cliente_nacional_modal');
    const inputNombreNacional = document.getElementById('nombre_nacional_modal');
    const inputApellidoNacional = document.getElementById('apellido_nacional_modal');
    const inputEmailNacional = document.getElementById('email_nacional_modal');
    const inputTelefonoNacional = document.getElementById('telefono_nacional_modal');
    const selectNacionalidadNacional = document.getElementById('nacionalidad_nacional_modal');
    const selectTipoDocumentoNacional = document.getElementById('tipo_documento_nacional_modal');
    const inputNumeroDocumentoNacional = document.getElementById('numero_documento_nacional_modal');

    function cerrarModalNacional() {
        if (modalModificarClienteNacional) {
            modalModificarClienteNacional.classList.add('hidden');
        }
    }

    // Event listener para el botón de cerrar del modal nacional
    const botonCerrarModalNacional = modalModificarClienteNacional ? modalModificarClienteNacional.querySelector('button[onclick*="modal-modificar-cliente-nacional"]') : null;
    if (botonCerrarModalNacional) {
        botonCerrarModalNacional.addEventListener('click', cerrarModalNacional);
    }

    botonesActualizarNacional.forEach(boton => {
        boton.addEventListener('click', async () => {
            const idCliente = boton.dataset.id;
            console.log('ID del cliente nacional al hacer clic:', idCliente);

            inputIdClienteNacional.value = idCliente;

            try {
                const response = await fetch(`nacionalControlador?accion=obtenerCliente&id=${idCliente}`);
                if (!response.ok) {
                    const errorBody = await response.text();
                    throw new Error(`Error HTTP! status: ${response.status}. Body: ${errorBody}`);
                }
                const cliente = await response.json();

                inputNombreNacional.value = cliente.nombre;
                inputApellidoNacional.value = cliente.apellido;
                inputEmailNacional.value = cliente.email;
                inputTelefonoNacional.value = cliente.telefono;
                selectNacionalidadNacional.value = cliente.nacionalidad;
                selectTipoDocumentoNacional.value = cliente.tipo_documento;
                inputNumeroDocumentoNacional.value = cliente.numero_documento;

                modalModificarClienteNacional.classList.remove('hidden');

            } catch (error) {
                console.error('Error al obtener los datos del cliente nacional:', error);
                alert('No se pudieron cargar los datos del cliente nacional. Inténtalo de nuevo.');
            }
        });
    });

    botonGuardarClienteNacionalModal.addEventListener('click', async (event) => {
        event.preventDefault();
        botonGuardarClienteNacionalModal.disabled = true;

        const datos = new URLSearchParams(new FormData(formularioModificarClienteNacional));
        // No hay que enviar el id_rol_cliente porque no se cambia

        try {
            const response = await fetch('nacionalControlador?accion=actualizarCliente', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: datos
            });

            const resultado = await response.text();
            console.log('Respuesta completa del servidor al actualizar cliente nacional:', resultado);

            if (!response.ok) {
                console.error(`Error HTTP al actualizar cliente nacional! Estado: ${response.status}`);
                alert(`Error al guardar los cambios: ${resultado}`);
            } else {
                console.log('Estado HTTP 200 OK para actualización de cliente nacional.');
                if (resultado.trim() === "SUCCESS") {
                    console.log('Actualización de cliente nacional exitosa según la respuesta.');
                    cerrarModalNacional();
                    window.location.reload(); // Recarga la página para mostrar los cambios
                } else {
                    console.warn('Actualización de cliente nacional no exitosa según la respuesta del servlet:', resultado);
                    alert(`La actualización del cliente nacional no fue exitosa: ${resultado}`);
                }
            }
        } catch (error) {
            console.error('Error en la llamada fetch al guardar cliente nacional:', error);
            alert('Ocurrió un error de conexión o servidor al actualizar el cliente nacional. Inténtalo de nuevo.');
        } finally {
            botonGuardarClienteNacionalModal.disabled = false;
        }
    });
});


