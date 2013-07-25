#encoding: utf-8
class CategoriesController < ApplicationController
  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all

    i = 1
    @categories_count = Category.count(:conditions => {:parent_id => nil})

    @a = Array.new # array for parent categories
    @b = Array.new # array for subcategories
    while i < @categories_count+1  do
      @b[i] = Array.new
      @a[i] = Category.where("cat_order = ?", i)
      @id = Category.where("cat_order = ?", i).pluck(:id)
      @b[i].push(Category.find(:all, :conditions => { :parent_id => @id}))
      i +=1
    end


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  def set_session
    unless params[:id].nil?
      (session[:product] ||= [])<<{ :id => params[:id].to_i, :q => params[:quantity].to_i}
    end

    @basket = Array.new()
    unless session[:product].nil?
      session[:product].each do |prod|
        @basket << { :pr => Refinery::Products::Product.where("id = (?)", prod[:id]), :q => prod[:q] }
      end
    end
    #@ses = session[:product]
    #reset_session
    @categories = Category.all
    respond_to do |format|
      format.html # alphabet.html.erb
      format.json { render json: @categories }
    end
  end

  def set_hidden_session
    (session[:product] ||= [])<<{ :id => params[:id].to_i, :q => params[:quantity].to_i}
    render :nothing => true
  end
  
  def delete_from_session
    i = params[:id].to_i
    q = params[:q].to_i
    session[:product].reject! {|p| p[:id] == i && p[:q] ==  q}
 
    if session[:product].empty?
      redirect_to "/set"
    else
      render :nothing => true
    end
  end

  #отправка формы и корзины по почте  
  def send_order
    if session[:product].blank?
      @text = "Ваша корзина пуста"
    else 
        client = {
          :fio => params[:fio], 
          :phone => params[:phone], 
          :email => params[:email], 
          :job => params[:job], 
          :organization => params[:organization]
        }

        basket = Array.new()
        unless session[:product].nil?
          session[:product].each do |prod|
            basket << { :pr => Refinery::Products::Product.where("id = (?)", prod[:id]), :q => prod[:q] }
          end
        end

        ord = ""
        basket.each do |product|
          product[:pr].each do |p|
            ord = ord + p.title + product[:q].to_s + "," 
          end 
        end 
        @or = Sessionorder.create(:order => ord)

        UserMailer.order_confirmation(client, basket, Sessionorder.count).deliver
        reset_session
        @text = "Спасибо за ваш заказ №" + Sessionorder.count.to_s
    end
    respond_to do |format|
      format.html # finish.html.erb
      format.json { render json: @categories }
    end
  end


def delete_order
    reset_session
    
    redirect_to "/set"
  end

  def alphabet
   @catf = Category.all(:conditions => "title like '#{params[:char]}%'", :order => 'title')

    respond_to do |format|
      format.html # alphabet.html.erb
      format.json { render json: @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
    #session[:cat] = @category.title
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end
end
