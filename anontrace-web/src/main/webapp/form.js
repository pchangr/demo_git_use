var map;
	var marcador;
	
window.onload = function(){
					// Inicializamos el mapa si no existe
									           if (!map) {
									               map = L.map('map-registro').setView([-12.0463, -77.0427], 13);
									               
									               L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
									                   attribution: '© OpenStreetMap'
									               }).addTo(map);

									               // LA MAGIA: Al hacer clic, "jala" los datos a los inputs
									               map.on('click', function(e) {
									                   var lat = e.latlng.lat.toFixed(6);
									                   var lng = e.latlng.lng.toFixed(6);

									                   // 1. Rellena tus campos de texto
									                   document.getElementById('latitud').value = lat;
									                   document.getElementById('longitud').value = lng;

									                   // 2. Mueve el indicador visual al lugar del clic
									                   if (marcador) {
									                       marcador.setLatLng(e.latlng);
									                   } else {
									                       marcador = L.marker(e.latlng).addTo(map);
									                   }

									                   document.getElementById('statusMapa').innerText = "📍 Ubicación capturada: " + lat + ", " + lng;
									               });
												   
												   setTimeout(function(){ map.invalidateSize(); }, 500);
									           }
				   }

/*				   function capturarCoordenadas() {
				   		           // Simulamos coordenadas de Lima como si fuera un GPS real
				   		           document.getElementById('latitud').value = "-12.0" + (Math.floor(Math.random() * 9000) + 1000);
				   		           document.getElementById('longitud').value = "-77.0" + (Math.floor(Math.random() * 9000) + 1000);
				   		           document.getElementById('statusMapa').innerText = "📍 Ubicación capturada correctamente";
								   
								   
				   		       }*/
							   
							   function capturarCoordenadas() {
							       // Verificamos si el usuario ya hizo clic en el mapa y existe un marcador
							       if (marcador) {
							           var posicion = marcador.getLatLng(); // Obtenemos la posición real del marcador
							           
							           var lat = posicion.lat.toFixed(6);
							           var lng = posicion.lng.toFixed(6);

							           // Pasamos las coordenadas del marcador a los inputs
							           document.getElementById('latitud').value = lat;
							           document.getElementById('longitud').value = lng;
							           
							           document.getElementById('statusMapa').innerText = "📍 Coordenadas del marcador capturadas";
							       } else {
							           // Si no hay marcador, avisamos al usuario
							           document.getElementById('statusMapa').innerText = "❌ Primero haz clic en el mapa para situar el marcador";
							       }
							   }

							   

				   		       function seleccionarRapido(delito, elemento) {
				   		           document.getElementById('tipoIncidente').value = delito;
				   		           document.querySelectorAll('.icon-btn').forEach(i => i.classList.remove('selected'));
				   		           elemento.classList.add('selected');
				   		       }

				   		       function cancelarRegistro() {
				   		           if(confirm("¿Desea cancelar el reporte? Se borrarán todos los datos.")) {
				   		               document.getElementById('incidenciaForm').reset();
				   		               document.getElementById('formRegistro').classList.add('hidden');
				   		               document.getElementById('btnAbrirForm').classList.remove('hidden');
				   		               document.getElementById('statusMapa').innerText = "";
				   		           }
				   		       }

				   		       function validarFormulario(e) {
								e.preventDefault();
								
				   		           const tipo = document.getElementById('tipoIncidente').value;
				   		           const lat = document.getElementById('latitud').value;

				   		           if (!lat) {
				   		               alert("DEBE MARCAR LA UBICACIÓN EN EL MAPA ANTES DE ENVIAR");
				   		               return false;
				   		           }
				   		           if (!tipo) {
				   		               alert("DEBE SELECCIONAR EL TIPO DE INCIDENTE");
				   		               return false;
				   		           }
				   		           //return true; // Si todo está bien, se envía al Servlet
								   
								   
								   // --- ENVÍO POR AJAX (FETCH) ---
								       const form = document.getElementById('incidenciaForm');
								       const formData = new FormData(form);

								       fetch('registrarIncidencia', {
								           method: 'POST',
								           body: new URLSearchParams(formData) // Envía los datos como un formulario normal
								       })
								       .then(response => response.text()) // Esperamos el código REP-XXXXX del Servlet
								       .then(data => {
								           if (data.includes("REP-")) {
								               // MOSTRAR MODAL DE ÉXITO
								               Swal.fire({
								                   title: '¡Reporte Confirmado!',
								                   html: `El incidente ha sido registrado bajo el código:<br><br><b style="font-size: 24px; color: #4a89dc;">${data}</b>`,
								                   icon: 'success',
								                   confirmButtonText: 'Entendido'
								               });
								               form.reset(); // Limpia el formulario para un nuevo reporte
								           } else {
								               Swal.fire("Error", "No se pudo registrar en la base de datos", "error");
								           }
								       })
								       .catch(error => {
								           console.error('Error:', error);
								           Swal.fire("Error de conexión", "No se pudo contactar con el servidor", "error");
								       });
				   		       }