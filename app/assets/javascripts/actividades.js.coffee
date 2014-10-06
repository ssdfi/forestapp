$ ->
  map = L.map('map').setView([-35.18, -59.20], 10)

  L.tileLayer.wms("http://wms.ign.gob.ar/geoserver/wms", {
    layers: 'argentina500k:argentina500k_satelital',
    format: 'image/png',
    transparent: true,
    crs: L.CRS.EPSG4326
  }).addTo(map)