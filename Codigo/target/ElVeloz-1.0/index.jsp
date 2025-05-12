
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
        <title>Login</title>
    </head>
    <body class="bg-gray-200">

        <div class="min-h-screen flex items-center justify-center">

            <div class="bg-white p-8 rounded-xl shadow-xl w-full max-w-sm">

                <h2 class="text-3xl font-bold text-center text-gray-700 mb-8">Acceso</h2>

                <form action="usuarioControlador?accion=validarUsuario" method="POST">
                    <div class="mb-5">
                        <label for="username" class="block text-sm font-semibold text-gray-600 mb-2">Usuario</label>
                        <input type="text" name="username" id="#"
                               class="w-full px-4 py-2.5 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition duration-150"
                               placeholder="Nombre de usuario" required>
                    </div>

                    <div class="mb-8">
                        <label for="password" class="block text-sm font-semibold text-gray-600 mb-2">Contraseña</label>
                        <input type="password" name="password" id="#"
                               class="w-full px-4 py-2.5 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition duration-150"
                               placeholder="••••••••" required>
                    </div>

                    <div>
                        <button type="submit"
                                class="w-full flex justify-center py-3 px-4 border border-transparent rounded-lg shadow-md text-base font-semibold text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition duration-150">
                            Ingresar
                        </button>
                    </div>
                </form>

            </div>
        </div>

    </body>
</html>
