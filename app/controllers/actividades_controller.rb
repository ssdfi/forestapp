class ActividadesController < ApplicationController
  before_action :set_expediente
  before_action :set_movimiento
  before_action :set_actividad, only: [:show, :map, :edit, :update, :destroy]
  layout 'map', :only => [:map]

  # GET /actividades
  # GET /actividades.json
  def index
    redirect_to [@expediente, @movimiento]
  end

  # GET /actividades/1
  # GET /actividades/1.json
  def show
    @actividades_plantaciones = @actividad.actividades_plantaciones.page params[:plantaciones_page]
    @actividades_titulares = @actividad.actividades_titulares.page params[:titulares_page]
    @pagos = @actividad.pagos.page params[:pagos_page]
  end

  # GET /actividades/1/map
  def map
    @geojson = Plantacion.plantaciones_to_geojson(@actividad.plantaciones)
  end

  # GET /actividades/new
  def new
    @actividad = @movimiento.actividades.new
  end

  # GET /actividades/1/edit
  def edit
  end

  # POST /actividades
  # POST /actividades.json
  def create
    @actividad = @movimiento.actividades.new(actividad_params)

    respond_to do |format|
      if @actividad.save
        format.html { redirect_to [@expediente, @movimiento, @actividad], notice: 'Actividad creada satisfactoriamente.' }
        format.json { render :show, status: :created, location: [@expediente, @movimiento, @actividad] }
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
        format.html { redirect_to [@expediente, @movimiento, @actividad], notice: 'Actividad actualizada satisfactoriamente.' }
        format.json { render :show, status: :ok, location: [@expediente, @movimiento, @actividad] }
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
      format.html { redirect_to expediente_movimiento_actividades_url(@expediente, @movimiento), notice: 'Actividad eliminada satisfactoriamente.' }
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
      params.require(:actividad).permit(:movimiento_id, :tipo_actividad_id, :superficie_presentada, :superficie_certificada, :superficie_inspeccionada, :superficie_registrada,
        actividades_plantaciones_attributes: [:id, :plantacion_id, :fecha, :numero_plantas, :superficie_presentada, :superficie_certificada, :superficie_inspeccionada, :superficie_registrada,
          :estado_aprobacion_id, :observaciones, :_destroy])
    end
end
