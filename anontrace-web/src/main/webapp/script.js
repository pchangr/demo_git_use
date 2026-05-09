//alert("¡El JS está conectado correctamente!");
// RF  Confirmación de acción crítica
        function reclasificar(id) {
            if (confirm("¿Está seguro que desea reclasificar el reporte " + id + "?")) {
                const nuevaCat = prompt("Ingrese nueva categoría (Baja, Media, Alta):");
                if (nuevaCat) {
                    alert("Reporte " + id + " actualizado a categoría: " + nuevaCat);
                    // Aquí llamarías a tu Servlet AdminController para el UPDATE en la BD
                }
            }
        }

       
		
		function confirmarSalida() {
		    if (confirm("¿Estás seguro de que quieres cerrar sesión?")) {
		        // Esto redirige al servlet
		        window.location.href = "logout"; 
		    }
		}

        //  Bloqueo de acceso directo (se complementa con Java Filters)
      //  console.log("Control de acceso activo...");

	
		function reclasificar(codigo) {
		    let nuevaCategoria = prompt("Ingrese la nueva categoría para el reporte " + codigo + ":");
		    
		    if (nuevaCategoria) {
		        // Redirigimos a un servlet encargado de la acción
		        window.location.href = "reclasificar?codigo=" + codigo + "&categoria=" + nuevaCategoria;
		    }
		}
	
						
		       

	
