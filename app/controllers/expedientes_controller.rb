class ExpedientesController < ApplicationController
  before_action :set_expediente, only: [:show, :edit, :update, :destroy]

  # GET /expedientes
  # GET /expedientes.json
  def index
    @expediente = params[:expediente] ? Expediente.new(expediente_params) : Expediente.new

    @expedientes = Expediente.page params[:page]

    @expedientes = @expedientes.where("numero_interno ILIKE ?", "%#{@expediente.numero_interno}%") unless @expediente.numero_interno.blank?
    @expedientes = @expedientes.where("numero_expediente ILIKE ?", "%#{@expediente.numero_expediente}%") unless @expediente.numero_expediente.blank?
    @expedientes = @expedientes.where("titular ILIKE ?", "%#{@expediente.titular}%") unless @expediente.titular.blank?
    @expedientes = @expedientes.where("numero_expediente IS #{'NOT' unless @expediente.incompleto} NULL") unless @expediente.incompleto.nil?
    @expedientes = @expedientes.where(plurianual: @expediente.plurianual) unless @expediente.plurianual.nil?
    @expedientes = @expedientes.where(agregado: @expediente.agregado) unless @expediente.agregado.nil?
    @expedientes = @expedientes.where(activo: @expediente.activo) unless @expediente.activo.nil?
    
    @expedientes = @expedientes.order(updated_at: :desc)
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
        format.html { redirect_to @expediente, notice: 'Expediente was successfully created.' }
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
        format.html { redirect_to @expediente, notice: 'Expediente was successfully updated.' }
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
      format.html { redirect_to expedientes_url, notice: 'Expediente was successfully destroyed.' }
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
      params.require(:expediente).permit(:numero_interno, :numero_expediente, :titular, :tecnico, :plurianual, :agregado, :activo, :incompleto)
    end
end
