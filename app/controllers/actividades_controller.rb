class ActividadesController < ApplicationController
  before_action :set_expediente
  before_action :set_movimiento
  before_action :set_actividad, only: [:show, :map, :edit, :update, :destroy]

  # GET /actividades
  # GET /actividades.json
  def index
    @actividades = @movimiento.actividades
  end

  # GET /actividades/1
  # GET /actividades/1.json
  def show
  end

  # GET /actividades/1/map
  def map
    srs_database = RGeo::CoordSys::SRSDatabase::ActiveRecordTable.new
    factory_to = RGeo::Geos.factory(:srs_database => srs_database, :srid => "4326")
    factory = RGeo::GeoJSON::EntityFactory.instance
    features = []
    
    plantaciones = @actividad.plantaciones

    flash.now[:alert] = "La actividad no tiene plantaciones asociadas." unless plantaciones.length > 0

    plantaciones.each do |plantacion|
      factory_from = RGeo::Geos.factory(:srs_database => srs_database, :srid => plantacion.zona.srid)
      plantacion_original = RGeo::Feature.cast(plantacion.geom, :factory => factory_from, :project => false)
      feature = RGeo::Feature.cast(plantacion_original, :factory => factory_to, :project => true)
      features << factory.feature(feature, plantacion.id, {
          "especie" => plantacion.especies.first.nombre_comun
        })
    end
    
    @geojson = RGeo::GeoJSON.encode(factory.feature_collection(features)).to_json
  end

  # GET /actividades/new
  def new
    @actividad = Actividad.new
  end

  # GET /actividades/1/edit
  def edit
  end

  # POST /actividades
  # POST /actividades.json
  def create
    @actividad = Actividad.new(actividad_params)

    respond_to do |format|
      if @actividad.save
        format.html { redirect_to @actividad, notice: 'Actividad was successfully created.' }
        format.json { render :show, status: :created, location: @actividad }
      else
        format.html { render :new }
        format.json { render json: @actividad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /actividades/1
  # PATCH/PUT /actividades/1.json
  def update
    respond_to do |format|
      if @actividad.update(actividad_params)
        format.html { redirect_to @actividad, notice: 'Actividad was successfully updated.' }
        format.json { render :show, status: :ok, location: @actividad }
      else
        format.html { render :edit }
        format.json { render json: @actividad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /actividades/1
  # DELETE /actividades/1.json
  def destroy
    @actividad.destroy
    respond_to do |format|
      format.html { redirect_to actividades_url, notice: 'Actividad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_actividad
      @actividad = Actividad.find(params[:id] || params[:actividad_id])
    end

    def set_movimiento
      @movimiento = Movimiento.find(params[:movimiento_id])
    end

    def set_expediente
      @expediente = Expediente.find(params[:expediente_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def actividad_params
      params.require(:actividad).permit(:movimiento_id, :tipo_actividad_id, :superficie_presentada, :superficie_certificada, :superficie_inspeccionada, :superficie_registrada)
    end
end
