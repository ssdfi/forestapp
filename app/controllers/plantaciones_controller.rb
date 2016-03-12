class PlantacionesController < ApplicationController
  before_action :set_plantacion, only: [:show, :edit, :update, :destroy, :map]
  layout 'map', :only => [:map]

  # GET /plantaciones
  # GET /plantaciones.json
  def index
    @plantacion_filter = params[:plantacion] ? Plantacion.new(plantacion_params) : Plantacion.new

    @plantaciones = Plantacion.search(@plantacion_filter)
    @plantaciones = @plantaciones.order(updated_at: :desc)
    @plantaciones = @plantaciones.page(params[:page])
  end

  # GET /plantaciones/1
  # GET /plantaciones/1.json
  def show
    @expedientes = @plantacion.expedientes.page params[:page]
    @movimientos = @plantacion.movimientos
    @actividades = @plantacion.actividades
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

  # GET /plantaciones/mass_edit
  def mass_edit
    if params[:plantacion] and params[:plantacion][:ids]
      @plantacion = Plantacion.new(plantacion_params)
    elsif params[:actividad_id]
      @plantacion = Plantacion.new({ids: Actividad.find(params[:actividad_id]).plantaciones.pluck(:id).join("\r\n")})
      @actividad_id = params[:actividad_id]
    else
      redirect_to :back
    end
  end

  # PATCH/PUT /plantaciones/mass_update
  def mass_update
    if Plantacion.mass_update(plantacion_params)
      if params[:actividad_id].empty?
        redirect_to plantaciones_path(plantacion: plantacion_params.slice(:ids)), notice: 'Plantaciones actualizadas satisfactoriamente.'
      else
        actividad = Actividad.find(params[:actividad_id])
        redirect_to expediente_movimiento_actividad_path(actividad.movimiento.expediente, actividad.movimiento, actividad), notice: 'Plantaciones actualizadas satisfactoriamente.'
      end
    else
      render :mass_edit
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

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_plantacion
      @plantacion = Plantacion.find(params[:id] || params[:plantacion_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plantacion_params
      params.require(:plantacion).permit(:titular_id, :anio_plantacion, :tipo_plantacion_id, :nomenclatura_catastral, :estado_plantacion_id,
        :distancia_plantas, :cantidad_filas, :distancia_filas, :densidad, :fuente_informacion_id, :anio_informacion, :fuente_imagen_id,
        :fecha_imagen, :base_geometrica_id, :provincia_id, :departamento_id, :estrato_desarrollo_id, :uso_forestal_id, :uso_anterior_id,
        :activo, :comentarios, :objetivo_plantacion_id, :ids, :copiar_datos, :activar_nuevas, especie_ids: [], plantacion_nuevas_ids: [])
    end
end
