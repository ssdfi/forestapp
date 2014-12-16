class TecnicosController < ApplicationController
  before_action :set_tecnico, only: [:show, :edit, :update, :destroy]

  # GET /tecnicos
  # GET /tecnicos.json
  def index
    @tecnico = params[:tecnico] ? Tecnico.new(tecnico_params) : Tecnico.new

    @tecnicos = Tecnico.search(@tecnico)
    @tecnicos = @tecnicos.order(updated_at: :desc)
    @tecnicos = @tecnicos.page(params[:page])

  end

  # GET /tecnicos/1
  # GET /tecnicos/1.json
  def show
    @expedientes = @tecnico.expedientes.page params[:page]
  end

  # GET /tecnicos/new
  def new
    @tecnico = Tecnico.new
  end

  # GET /tecnicos/1/edit
  def edit
  end

  # POST /tecnicos
  # POST /tecnicos.json
  def create
    @tecnico = Tecnico.new(tecnico_params)

    respond_to do |format|
      if @tecnico.save
        format.html { redirect_to @tecnico, notice: 'Tecnico creado satisfactoriamente.' }
        format.json { render :show, status: :created, location: @tecnico }
      else
        format.html { render :new }
        format.json { render json: @tecnico.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tecnicos/1
  # PATCH/PUT /tecnicos/1.json
  def update
    respond_to do |format|
      if @tecnico.update(tecnico_params)
        format.html { redirect_to @tecnico, notice: 'Tecnico actualizado satisfactoriamente.' }
        format.json { render :show, status: :ok, location: @tecnico }
      else
        format.html { render :edit }
        format.json { render json: @tecnico.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tecnicos/1
  # DELETE /tecnicos/1.json
  def destroy
    @tecnico.destroy
    respond_to do |format|
      format.html { redirect_to tecnicos_url, notice: 'Tecnico eliminado satisfactoriamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tecnico
      @tecnico = Tecnico.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tecnico_params
      params.require(:tecnico).permit(:nombre, :activo)
    end
end
