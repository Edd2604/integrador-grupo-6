document.addEventListener('DOMContentLoaded', function () {
    const botonesActualizar = document.querySelectorAll('.btn-actualizar');
    const modalModificar = document.getElementById('modal-modificar');
    const formularioModificar = document.getElementById('formulario-modificar');
    const botonGuardarModal = document.getElementById('guardar-usuario');
    const inputIdUsuario = document.getElementById('id_usuario');
    const inputUsername = document.getElementById('username');
    const inputNombre = document.getElementById('nombre');
    const inputApellido = document.getElementById('apellido');
    const selectRol = document.getElementById('rol');
    const botonCerrarModal = modalModificar ? modalModificar.querySelector('.cerrar-modal') : null;

    function cerrarModal() {
        if (modalModificar) {
            modalModificar.classList.add('hidden');
        }
    }

     if (botonCerrarModal) {
         botonCerrarModal.addEventListener('click', cerrarModal);
     }


    botonesActualizar.forEach(boton => {
        boton.addEventListener('click', async () => {
            const idUsuario = boton.dataset.id;
            console.log('ID del usuario al hacer clic:', idUsuario);

            inputIdUsuario.value = idUsuario;

            try {
                const response = await fetch(`usuarioControlador?accion=obtenerUsuario&id=${idUsuario}`);
                if (!response.ok) {
                    const errorBody = await response.text();
                    throw new Error(`Error HTTP! status: ${response.status}. Body: ${errorBody}`);
                }
                const usuario = await response.json();

                inputUsername.value = usuario.username;
                inputNombre.value = usuario.nombre;
                inputApellido.value = usuario.apellido;

                if (selectRol && usuario.id_rol !== undefined) {
                    selectRol.value = usuario.id_rol.toString();
                } else if (selectRol) {
                     console.warn("id_rol no encontrado en la respuesta o selectRol no existe.");
                }

                modalModificar.classList.remove('hidden');

            } catch (error) {
                console.error('Error al obtener los datos del usuario:', error);
                alert('No se pudieron cargar los datos del usuario. Inténtalo de nuevo.');
            }
        });
    });

    botonGuardarModal.addEventListener('click', async (event) => {
        event.preventDefault();

        botonGuardarModal.disabled = true;

        const datos = new URLSearchParams(new FormData(formularioModificar));
        for (const [key, value] of datos.entries()) {
            console.log(`Datos a enviar - ${key}: ${value}`);
        }

        try {
            const response = await fetch('usuarioControlador?accion=actualizarUsuario', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: datos
            });

            const resultado = await response.text();
            console.log('Respuesta completa del servidor:', resultado);

            if (!response.ok) {
                console.error(`Error HTTP! Estado: ${response.status}`);
                alert(`Error al guardar los cambios: ${resultado}`);

            } else {
                console.log('Estado HTTP 200 OK.');
                if (resultado.trim() === "SUCCESS") {
                    console.log('Actualización exitosa según la respuesta.');
                    cerrarModal();

                    // Redireccionar a la lista de usuarios activos
                    //window.location.href = "ElVeloz/usuarioControlador?accion=listarActivos";

                    // Si solo quieres recargar la página actual:
                     window.location.reload();

                } else {
                    console.warn('Actualización no exitosa según la respuesta del servlet:', resultado);
                    alert(`La actualización no fue exitosa: ${resultado}`);
                }
            }

        } catch (error) {
            console.error('Error en la llamada fetch al guardar:', error);
            alert('Ocurrió un error de conexión o servidor. Inténtalo de nuevo.');
        } finally {
            botonGuardarModal.disabled = false;
        }
    });
});