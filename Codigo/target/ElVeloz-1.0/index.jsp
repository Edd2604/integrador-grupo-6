
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <script src="https://cdn.tailwindcss.com"></script>
        <title>Login</title>
        <style>
            /* Estilos personalizados para la notificación flotante */
            .notification-container {
                position: fixed;
                top: 1rem; /* 16px desde la parte superior */
                right: 1rem; /* 16px desde la derecha */
                z-index: 1000; /* Asegura que esté por encima de otros elementos */
                opacity: 0; /* Inicialmente oculto */
                transform: translateX(100%); /* Fuera de la vista a la derecha */
                transition: opacity 0.5s ease-in-out, transform 0.5s ease-in-out; /* Transición suave */
            }
            .notification-container.show {
                opacity: 1; /* Visible */
                transform: translateX(0); /* Vuelve a su posición */
            }
        </style>
        
    </head>
    <body class="bg-neutral-950 flex items-center justify-center min-h-screen relative overflow-hidden">

        <div class="p-10 lg:px-60 lg:py-20 md:px-20 md:py-10 rounded-xl shadow-neutral-800 shadow-md z-10 
          w-full max-w-full sm:max-w-lg md:max-w-xl lg:max-w-3xl xl:w-[1000px] bg-neutral-900">

          <h1 class="text-white text-3xl font-bold text-center mb-8 drop-shadow">El Veloz</h1>

          <div class="md:bg-neutral-800 p-2 md:p-8 rounded-xl md:shadow-lg bg-opacity-90">
            <form action="usuarioControlador?accion=validarUsuario" method="POST">
                
              <div class="relative z-0 w-full mb-8 group">
                <input type="text" name="username" id="floating_username" required
                  class="block py-2.5 px-0 w-full text-sm text-white bg-transparent border-0 border-b-2 border-gray-500 appearance-none focus:outline-none focus:ring-0 focus:border-gray-300 peer"
                  placeholder=" " />
                <label for="floating_username"
                  class="absolute text-sm text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6 peer-focus:text-gray-300">
                  Usuario
                </label>
              </div>

              <div class="relative z-0 w-full mb-10 group">
                <input type="password" name="password" id="floating_password" required
                  class="block py-2.5 px-0 w-full text-sm text-white bg-transparent border-0 border-b-2 border-gray-500 appearance-none focus:outline-none focus:ring-0 focus:border-gray-300 peer"
                  placeholder=" " />
                <label for="floating_password"
                  class="absolute text-sm text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6 peer-focus:text-gray-300">
                  Contraseña
                </label>
              </div>

              <button type="submit"
                class="w-full bg-gray-100 font-semibold py-2 rounded-full hover:bg-neutral-900 hover:text-white transition duration-200 shadow-md">
                Ingresar
              </button>
            </form>
          </div>
        </div>
        
        
      <%
        // Recuperar el mensaje de error del request
        String errorLogin = (String) request.getAttribute("errorLogin");
        if (errorLogin != null && !errorLogin.isEmpty()) {
    %>
        <div id="notification" class="notification-container flex items-center justify-center bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-lg shadow-md max-w-xs">
            <svg class="fill-current h-6 w-6 text-red-500 mr-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M2.93 17.07A10 10 0 1 1 17.07 2.93 10 10 0 0 1 2.93 17.07zM9 5v6h2V5H9zm0 8v2h2v-2H9z"/></svg>
            <span class="block sm:inline"> <%= errorLogin %></span>
            <button class="absolute top-0 right-0 p-2 text-red-700 hover:text-red-900" onclick="document.getElementById('notification').classList.remove('show')">
                <svg class="h-4 w-4 fill-current" role="button" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><title>Cerrar</title><path d="M14.348 14.849a1.2 1.2 0 0 1-1.697 0L10 11.697l-2.651 2.652a1.2 1.2 0 1 1-1.697-1.697L8.303 10 5.651 7.348a1.2 1.2 0 1 1 1.697-1.697L10 8.303l2.651-2.652a1.2 1.2 0 1 1 1.697 1.697L11.697 10l2.651 2.651a1.2 1.2 0 0 1 0 1.698z"/></svg>
            </button>
        </div>

        <script>
            // Mostrar la notificación y ocultarla después de 5 segundos
            document.addEventListener('DOMContentLoaded', function() {
                const notification = document.getElementById('notification');
                if (notification) {
                    // Agrega la clase 'show' después de un pequeño retraso para permitir la transición
                    setTimeout(() => {
                        notification.classList.add('show');
                    }, 100);

                    // Oculta la notificación automáticamente después de 5 segundos
                    setTimeout(() => {
                        notification.classList.remove('show');
                    }, 5000); // 5000 milisegundos = 5 segundos
                }
            });
        </script>
    <%
        }
    %>
  
        
        

      </body>
</html>
