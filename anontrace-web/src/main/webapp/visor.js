// Datos para los combos en cascada
    const datosRegion = {
        "Lima": ["Miraflores", "San Isidro", "Cercado de Lima", "SJL", "Los Olivos"],
        "Callao": ["Bellavista", "La Perla", "Carmen de la Legua", "Ventanilla"]
    };

    /*function cargarDistritos() {
        const provincia = document.getElementById("filtroProvincia").value;
        const comboDistrito = document.getElementById("filtroDistrito");
        
        // Limpiar distritos anteriores
        comboDistrito.innerHTML = '<option value="">-- Todos los distritos --</option>';
        
        if (provincia && datosRegion[provincia]) {
            datosRegion[provincia].forEach(distrito => {
                let option = document.createElement("option");
                option.value = distrito;
                option.text = distrito;
                comboDistrito.add(option);
            });
        }
    }*/
	
	document.addEventListener("DOMContentLoaded", function() {
	    // Usamos los nombres exactos que definimos en el <script> del JSP
	    if (typeof provParaRestaurar !== 'undefined' && provParaRestaurar !== "") {
	        console.log("Restaurando Provincia:", provParaRestaurar, distParaRestaurar);
	        
	        // Sincronizamos el valor del select de provincia
	        document.getElementById("filtroProvincia").value = provParaRestaurar;
	        
	        // Cargamos los distritos pasándole el ID para que lo seleccione
	        cargarDistritos(distParaRestaurar);
	    }
	});
	   
	function cargarDistritos(idSeleccionado = null) {
	    const idProvincia = document.getElementById("filtroProvincia").value;
	    const selectDistrito = document.getElementById("filtroDistrito");

	    // Limpiar distritos actuales
	    selectDistrito.innerHTML = '<option value="">Cargando...</option>';

	    if (idProvincia === "") {
	        selectDistrito.innerHTML = '<option value="">-- Seleccione Provincia --</option>';
	        return;
	    }

	    // Llamada al controlador (asumiendo que tienes un endpoint que devuelve JSON)
	    fetch('/anontrace-web/buscarDistritos?idProvincia=' + idProvincia)
	        .then(response => response.json())
	        .then(data => {
	            selectDistrito.innerHTML = '<option value="">-- Todas --</option>';
	            data.forEach(distrito => {
	                const option = document.createElement("option");
	                option.value = distrito.id_distrito;
	                option.text = distrito.nombre;
					if (idSeleccionado && distrito.id_distrito == idSeleccionado) {
					                   option.selected = true;
					               }
	                selectDistrito.appendChild(option);
	            });
	        })
	        .catch(error => {
	            console.error('Error:', error);
	            selectDistrito.innerHTML = '<option value="">Error al cargar</option>';
	        });
	}


    function aplicarFiltros() {

		    const form = document.createElement('form');
		    form.method = 'POST';
		    form.action = 'visor'; //Servlet
			
			const selDist = document.getElementById('filtroDistrito');
			const selTipo = document.getElementById('filtroTipo');

		    const filtros = {
		        'idProvincia': document.getElementById('filtroProvincia').value,	    
				'idDistrito': selDist.value,
				'nameDistrito': selDist.options[selDist.selectedIndex].text,
				'idTipo': selTipo.value,
				'nameTipo': selTipo.options[selTipo.selectedIndex].text,
		        'fechaInicio': document.getElementById('fechaInicio').value,
		        'fechaFin': document.getElementById('fechaFin').value,
		        'horaInicio': document.getElementById('horaInicio').value,
		        'horaFin': document.getElementById('horaFin').value
			};
				
        console.log("Aplicando filtros:", filtros);
        
        //  Mostrar cargando mientras se filtran los datos
        const loading = document.getElementById('loading');
        loading.style.display = 'block';

        // Aquí es donde harás el fetch() a tu Servlet pasándole estos parámetros
		for (const key in filtros) {
			        const input = document.createElement('input');
			        input.type = 'hidden';
			        input.name = key;
			        input.value = filtros[key];
			        form.appendChild(input);
			    }

			    document.body.appendChild(form);
			    form.submit();
				
				console.log("Aplicando filtros:", filtros);		      
							  
        setTimeout(() => {
            loading.style.display = 'none';
            alert("Filtrando datos para: " + (filtros.nameTipo || "Todos") + " en " + (filtros.nameDistrito || "Toda la región"));
        }, 1000);
    }
	
	/*function aplicarFiltros() {
	    // Crear un formulario temporal
	    const form = document.createElement('form');
	    form.method = 'POST';
	    form.action = 'VisorController'; // Tu URL mapping del Servlet

	    const filtros = {
	        'idProvincia': document.getElementById('filtroProvincia').value,
	        'idDistrito': document.getElementById('filtroDistrito').value,
	        'idTipo': document.getElementById('filtroTipo').value,
	        'fechaInicio': document.getElementById('fechaInicio').value,
	        'fechaFin': document.getElementById('fechaFin').value,
	        'horaInicio': document.getElementById('horaInicio').value,
	        'horaFin': document.getElementById('horaFin').value
	    };

	    // Añadir cada filtro como un input oculto
	    for (const key in filtros) {
	        const input = document.createElement('input');
	        input.type = 'hidden';
	        input.name = key;
	        input.value = filtros[key];
	        form.appendChild(input);
	    }

	    document.body.appendChild(form);
	    form.submit();
		
		
		console.log("Aplicando filtros:", filtros);
		      
		      //  Mostrar cargando mientras se filtran los datos
		      const loading = document.getElementById('loading');
		      loading.style.display = 'block';

		      // Aquí es donde harás el fetch() a tu Servlet pasándole estos parámetros
		      setTimeout(() => {
		          loading.style.display = 'none';
		          alert("Filtrando datos para: " + (filtros.tipo || "Todos") + " en " + (filtros.distrito || "Toda la región"));
		      }, 1000);
			  
			  
	}*/

	
	function limpiarFiltros() {
	    console.log("Iniciando limpieza...");

	    // 1. Limpiar campos de texto y fechas (con validación de existencia)
	    const campos = ["txtBuscar", "fechaInicio", "fechaFin", "filtroTipo", "filtroProvincia", "horaInicio", "horaFin"];
	    
	    campos.forEach(id => {
	        let el = document.getElementById(id);
	        if (el) el.value = ""; 
	    });

	    // 2. Resetear cascada de distritos
	    const comboDistrito = document.getElementById("filtroDistrito");
	    if (comboDistrito) {
	        comboDistrito.innerHTML = '<option value="">-- Seleccione Provincia --</option>';
	        comboDistrito.value = "";
	    }

	    // 3. Ejecutar las funciones de refresco del mapa
	    if (typeof centrarCiudad === "function") centrarCiudad();
	    
	    // IMPORTANTE: Llamamos a aplicarFiltros para que el mapa se actualice 
	    // y muestre TODO (ya que los filtros ahora están vacíos)
	    aplicarFiltros(); 

	    console.log("Filtros limpiados y mapa actualizado.");
	}

	
	///script2
	// Inicializar mapa centrado en una ubicación (ej. Lima)
	        var map = L.map('map', {
	            zoomControl: true // RF 3: Control de zoom (+/-) incluido por defecto
	        }).setView([-12.0463, -77.0427], 13);

	        // Capa de OpenStreetMap (RF 1)
	        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
	            attribution: '&copy; OpenStreetMap contributors'
	        }).addTo(map);

			setTimeout(function(){ map.invalidateSize(); }, 400);
			
	        // RF 6: Función para centrar mapa
	        function centrarCiudad() {
	            map.flyTo([-12.0463, -77.0427], 13);
	        }

	        // RF 4: Iconografía diferente para cada tipo
	        function obtenerEmoji(tipo) {
	            switch(tipo) {
	                case 'Robo al paso': return '🏃‍♂️';
	                case 'Asalto a tienda': return '🏪';
	                case 'Venta de droga': return '💊';
	                case 'Extorsión': return '📞';
	                default: return '⚠️';
	            }
	        }

	        // Simulación de carga de datos
	        /*function actualizarDatos() {
	            const loading = document.getElementById('loading');
	            loading.style.display = 'block'; // Mostrar Cargando...

	            // Simulamos una petición al servidor (esto lo conectarás a tu Servlet/DAO luego)
	            setTimeout(() => {
	                // Ejemplo de punto cargado desde la base de datos
	                const ejemploIncidente = {
	                    lat: -12.05,
	                    lng: -77.05,
	                    tipo: 'Robo al paso',
	                    desc: 'Sujeto en moto lineal'
	                };

	          
	                // RF 4: Crear marcador con ícono personalizado
	                const iconoTexto = L.divIcon({
	                	// Agrega la \ antes del $
	                	html: `<div style="font-size: 24px;">\${obtenerEmoji(ejemploIncidente.tipo)}</div>`,
	                    className: 'dummy',
	                    iconSize: [30, 30]
	                });

	                L.marker([ejemploIncidente.lat, ejemploIncidente.lng], {icon: iconoTexto})
	                    .addTo(map)
	                    .bindPopup(`<b>${ejemploIncidente.tipo}</b><br>${ejemploIncidente.desc}`);

	                loading.style.display = 'none'; // Ocultar Cargando...
	                alert("Datos actualizados desde el sistema.");
	            }, 1500);
	        }

	        // Carga inicial
	        actualizarDatos();*/
			
			// Simulación de carga de datos corregida
			/*function actualizarDatos() {
			    const loading = document.getElementById('loading');
			    loading.style.display = 'block';

			    setTimeout(() => {
			        // Ejemplo de punto cargado (Sustituye esto por tu fetch al Servlet después)
			        const lat = -12.05;
			        const lng = -77.05;
			        const tipo = 'Robo al paso';
			        
			        // Crear marcador con el emoji correspondiente
			        const iconoEmoji = L.divIcon({
			            html: `<div style="font-size: 24px;">${obtenerEmoji(tipo)}</div>`,
			            className: 'custom-div-icon',
			            iconSize: [30, 30],
			            iconAnchor: [15, 15]
			        });

			        L.marker([lat, lng], {icon: iconoEmoji})
			            .addTo(map)
			            .bindPopup(`<b>${tipo}</b><br>Sujeto en moto detectado.`)
			            .openPopup();

			        loading.style.display = 'none';
			    }, 1000);
			}*/
			
			/*function obtenerEmoji (tipo) {
			    // Convertimos a minúsculas para evitar problemas con mayúsculas/minúsculas
			    const t = tipo.toLowerCase();
			    
			    if (t==1) return '🏃‍♂️';
			    if (t==2) return '🏪';
			    if (t==3) return '💊';
			    if (t==4) return '📞';
			    if (t==5) return '🔫';
			    
			    return '⚠️'; // Emoji por defecto
			}*/
			
			function obtenerEmoji(tipo) {
			    // Convertimos a minúsculas para evitar problemas con mayúsculas/minúsculas
			    const t = tipo.toLowerCase();
			    
			    if (t.includes('robo')) return '🏃‍♂️';
			    if (t.includes('asalto')) return '🏪';
			    if (t.includes('droga')) return '💊';
			    if (t.includes('extorsión') || t.includes('extorsion')) return '📞';
			    if (t.includes('arma')) return '🔫';
				if (t.includes('otros')) return '⚠️';
			    
			    return '⚠️'; // Emoji por defecto
			}
			
			function actualizarDatos() {
			    const loading = document.getElementById('loading');
			    loading.style.display = 'block';

				if (window.layerGroup) {
				        layerGroup.clearLayers();
				    } else {
				        // Si no tienes layerGroup, inicialízalo una sola vez
				        window.layerGroup = L.layerGroup().addTo(map);
				    }

			    // 2. Recorremos los datos reales que llegaron del doPost
			    incidenciasFiltradas.forEach(inc => {
			        const iconoEmoji = L.divIcon({
			            html: `<div style="font-size: 24px;">${obtenerEmoji(inc.tipo)}</div>`,
			            className: 'custom-div-icon',
			            iconSize: [30, 30],
			            iconAnchor: [15, 15]
			        });

					L.marker([inc.lat, inc.lng], {icon: iconoEmoji})
					           .addTo(layerGroup) 
					           .bindPopup(`<b>${inc.tipo}</b><br>${inc.desc || 'Sin descripción'}`);
					
			    });

			    loading.style.display = 'none';
			}

			function mostrarIncidenciasEnMapa(datos) {
			    if (!datos || datos.length === 0) return;

			    datos.forEach(inc => {
			        // Crear el marcador
			        const marker = L.marker([inc.lat, inc.lng], {
			            icon: L.divIcon({
			                html: `<div style="font-size: 24px;">${obtenerEmoji(inc.tipo)}</div>`,
			                className: 'custom-div-icon',
			                iconSize: [30, 30]
			            })
			        }).addTo(map);

			        // Añadir popup
			        marker.bindPopup(`<b>${inc.tipo}</b><br>${inc.desc}`);
			    });
			}
			

			// Llamar a la función al cargar para ver algo de inmediato
			actualizarDatos();
			
			
		
			    // Esto se ejecuta apenas carga la página tras el filtro
			   /* if (incidenciasFiltradas.length > 0) {
			        mostrarIncidenciasEnMapa(incidenciasFiltradas);
			    }*/
	
		
