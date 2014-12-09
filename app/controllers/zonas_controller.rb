class ZonasController < ApplicationController
  before_action :set_zona, only: [:show, :edit, :update, :destroy]

  # GET /zonas
  # GET /zonas.json
  def index
    @zonas = Zona.all.order(:codigo)
  end

  # GET /zonas/1
  # GET /zonas/1.json
  def show
  end

  # GET /zonas/new
  def new
    @zona = Zona.new
  end

  # GET /zonas/1/edit
  def edit
  end

  # POST /zonas
  # POST /zonas.json
  def create
    @zona = Zona.new(zona_params)

    respond_to do |format|
      if @zona.save
        format.html { redirect_to @zona, notice: 'Zona was successfully created.' }
        format.json { render :show, status: :created, location: @zona }
      else
        format.html { render :new }
        format.json { render json: @zona.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /zonas/1
  # PATCH/PUT /zonas/1.json
  def update
    respond_to do |format|
      if @zona.update(zona_params)
        format.html { redirect_to @zona, notice: 'Zona was successfully updated.' }
        format.json { render :show, status: :ok, location: @zona }
      else
        format.html { render :edit }
        format.json { render json: @zona.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /zonas/1
  # DELETE /zonas/1.json
  def destroy
    @zona.destroy
    respond_to do |format|
      format.html { redirect_to zonas_url, notice: 'Zona was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zona
      @zona = Zona.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def zona_params
      params.require(:zona).permit(:codigo, :descripcion, :srid, :provincia, :codigo_indec)
    end
end
