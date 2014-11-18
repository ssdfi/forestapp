buildPopup = (properties) ->
  list = "<div>"
  for property,value of properties
    list += "<div><strong>" + property + ": </strong>" + value + "</div>"
  list += "</div>"

$(document).ready ->

  map = L.map 'map'

  ignSatelital = L.tileLayer.wms "http://wms.ign.gob.ar/geoserver/wms", {
    layers: 'argentina500k:argentina500k_satelital',
    format: 'image/png',
    attribution: 'IGN - CONAE'
    transparent: true
  }

  ignBase = L.tileLayer.wms "http://wms.ign.gob.ar/geoserver/wms", {
    layers: 'capabasesigign',
    format: 'image/png',
    attribution: 'IGN'
    transparent: true
  }

  osm = L.tileLayer "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
  }

  googleSatelital = new L.Google('SATELLITE')

  geoJson = L.geoJson plantaciones, {
    style: (feature) ->
      {color: "orange"}
    onEachFeature: (feature, layer) ->
      layer.bindPopup buildPopup(feature.properties)
  }

  map.addLayer googleSatelital
  map.addLayer geoJson

  if plantaciones.features.length > 0
    map.fitBounds geoJson.getBounds()
  else
    map.setView [-36, -62], 4

  L.control.layers({
    "OpenStreetMap": osm,
    "Google Satelital": googleSatelital,
    "IGN Satelital": ignSatelital,
    "IGN Base": ignBase
  }, {
    "Plantaciones": geoJson
  }).addTo map
