class ExpedientesController < ApplicationController
  before_action :set_expediente, only: [:show, :edit, :update, :destroy]

  # GET /expedientes
  # GET /expedientes.json
  # GET /expedientes.csv
  def index
    @expediente_filter = params[:expediente] ? Expediente.new(expediente_params) : Expediente.new({incompleto: false})

    @expedientes = policy_scope(Expediente).search(@expediente_filter)
    @expedientes = @expedientes.order(updated_at: :desc)
    @responsables = Responsable.grouped

    respond_to do |format|
      format.html do
        @count = @expedientes.count
        @expedientes = @expedientes.page params[:page]
        redirect_to @expedientes.first if @expedientes.count == 1
      end
      format.csv do
        @filename = "expedientes.csv"
      end
      format.json
    end
  end

  # GET /expedientes/1
  # GET /expedientes/1.json
  def show
    @movimientos = @expediente.movimientos.order(fecha_entrada: :desc)
  end

  # GET /expedientes/new
  def new
    @expediente = Expediente.new
  end

  # GET /expedientes/1/edit
  def edit
  end

  # POST /expedientes
  # POST /expedientes.json
  def create
    @expediente = Expediente.new(expediente_params)

    respond_to do |format|
      if @expediente.save
        format.html { redirect_to @expediente, notice: 'Expediente creado satisfactoriamente.' }
        format.json { render :show, status: :created, location: @expediente }
      else
        format.html { render :new }
        format.json { render json: @expediente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expedientes/1
  # PATCH/PUT /expedientes/1.json
  def update
    respond_to do |format|
      if @expediente.update(expediente_params)
        format.html { redirect_to @expediente, notice: 'Expediente actualizado satisfactoriamente.' }
        format.json { render :show, status: :ok, location: @expediente }
      else
        format.html { render :edit }
        format.json { render json: @expediente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expedientes/1
  # DELETE /expedientes/1.json
  def destroy
    @expediente.destroy
    respond_to do |format|
      format.html { redirect_to expedientes_url, notice: 'Expediente eliminado satisfactoriamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expediente
      @expediente = Expediente.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expediente_params
      params.require(:expediente).permit(:numero_interno, :numero_expediente, :tecnico_id, :zona_id,
        :plurianual, :agrupado, :activo, :incompleto, :fecha_entrada_desde, :fecha_entrada_hasta,
        :fecha_salida_desde, :fecha_salida_hasta, :pendiente, :estabilidad_fiscal,
        :etapa, :responsable_id, :validado, :validador_id, titular_ids: [])
    end
end
