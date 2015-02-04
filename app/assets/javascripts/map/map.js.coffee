#= require jquery
#= require jquery_ujs
#= require bootstrap-sprockets
#= require leaflet
#= require Google
#= require L.Control.ZoomBox
#= require Control.MiniMap
#= require leaflet.label

### Construye el popup a mostrarse al hacer click en una plantación ###
buildPopup = (properties) ->
  list = "<div>"
  for property,value of properties
    list += "<div><strong>" + property + ": </strong>" + value + "</div>"
  list += "</div>"

$(document).ready ->

  ### Define el objeto map y el div que lo contiene ###
  map = L.map 'map'

  ### Capa WMS de imagen satelital del IGN y CONAE ###
  ignSatelital = L.tileLayer.wms "http://wms.ign.gob.ar/geoserver/wms", {
    layers: 'argentina500k:argentina500k_satelital',
    format: 'image/png',
    attribution: 'IGN - CONAE'
    transparent: true
  }

  ### Capa WMS base de información del IGN ###
  ignBase = L.tileLayer.wms "http://wms.ign.gob.ar/geoserver/wms", {
    layers: 'capabasesigign',
    format: 'image/png',
    attribution: 'IGN'
    transparent: true
  }

  ### Capa base de OpenStreetMap ###
  osm = L.tileLayer "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
  }
  osmMini = L.tileLayer "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"

  ### Capa de imagen satelital de Google ###
  googleSatelital = new L.Google('SATELLITE')

  ### Capa vectorial GeoJSON de las plantaciones ###
  geoJson = L.geoJson plantaciones, {
    style: (feature) ->
      {color: "orange"}
    onEachFeature: (feature, layer) ->
      layer.bindPopup buildPopup(feature.properties)
  }

  ###*
   * Agrega las capas de Google y GeoJson al mapa por defecto
   * El resto de las capas se manejan a través del selector de capas
   ###
  map.addLayer googleSatelital
  map.addLayer geoJson

  ###*
   * Define el extent del mapa para que abarque todas las plantaciones
   * Si no hay plantaciones centra el mapa en un punto determinado
   ###
  if plantaciones
    map.fitBounds geoJson.getBounds()
  else
    map.setView [-36, -62], 4

  ### Agrega todas las capas al selector de capas del mapa ###
  L.control.layers({
    "OpenStreetMap": osm,
    "Google Satelital": googleSatelital,
    "IGN Satelital": ignSatelital,
    "IGN Base": ignBase
  }, {
    "Plantaciones": geoJson
  }).addTo map

  ### Agrega otros controles al mapa ###
  L.control.zoomBox({
    className: "glyphicon glyphicon-zoom-in"
  }).addTo map
  new L.Control.MiniMap(osmMini, {
    position: 'bottomleft',
    zoomLevelOffset: -7
  }).addTo map
  L.control.scale({
    imperial: false
  }).addTo map