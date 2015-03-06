class PlantacionesController < ApplicationController
  before_action :set_plantacion, only: [:show, :edit, :update, :destroy, :map, :replace]
  layout 'map', :only => [:map]

  # GET /plantaciones
  # GET /plantaciones.json
  def index
    @plantaciones = Plantacion.all.page params[:page]
  end

  # GET /plantaciones/1
  # GET /plantaciones/1.json
  def show
    @expedientes = @plantacion.expedientes.page params[:page]
  end

  # GET /plantaciones/1/map
  def map
    @geojson = @plantacion.to_geojson
  end

  # GET /plantaciones/new
  def new
    @plantacion = Plantacion.new
  end

  # GET /plantaciones/1/edit
  def edit
  end

  # POST /plantaciones
  # POST /plantaciones.json
  def create
    @plantacion = Plantacion.new(plantacion_params)

    respond_to do |format|
      if @plantacion.save
        format.html { redirect_to @plantacion, notice: 'Plantación creada satisfactoriamente.' }
        format.json { render :show, status: :created, location: @plantacion }
      else
        format.html { render :new }
        format.json { render json: @plantacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plantaciones/1
  # PATCH/PUT /plantaciones/1.json
  def update
    respond_to do |format|
      if @plantacion.update(plantacion_params)
        format.html { redirect_to @plantacion, notice: 'Plantación actualizada satisfactoriamente.' }
        format.json { render :show, status: :ok, location: @plantacion }
      else
        format.html { render :edit }
        format.json { render json: @plantacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plantaciones/1
  # DELETE /plantaciones/1.json
  def destroy
    @plantacion.destroy
    respond_to do |format|
      format.html { redirect_to plantaciones_url, notice: 'Plantación eliminada satisfactoriamente.' }
      format.json { head :no_content }
    end
  end

  # PUT /plantaciones/1/replace
  # PUT /plantaciones/1/replace.json
  def replace
    @plantacion.activo = false
    params[:plantaciones_nuevas_ids].split("\n").each do |plantacion_id|
      @plantacion.plantaciones_nuevas << Plantacion.find(plantacion_id) unless plantacion_id.to_i == 0
    end
    respond_to do |format|
      if @plantacion.save
        format.html { redirect_to @plantacion, notice: 'Plantación reemplazada satisfactoriamente.' }
        format.json { render :show, status: :ok, location: @plantacion }
      else
        format.html { render :show }
        format.json { render json: @plantacion.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_plantacion
      @plantacion = Plantacion.find(params[:id] || params[:plantacion_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plantacion_params
      params.require(:plantacion).permit(:titular_id, :anio_plantacion, :tipo_plantacion_id, :nomenclatura_catastral, :estado_plantacion_id,
        :distancia_plantas, :cantidad_filas, :distancia_filas, :densidad, :fuente_informacion_id, :fecha_informacion, :fuente_imagen_id,
        :fecha_imagen, :zona_id, :departamento_id, :estrato_desarrollo_id, :uso_forestal_id, :uso_anterior_id, :activo, :comentarios, especie_ids: [])
    end
end
