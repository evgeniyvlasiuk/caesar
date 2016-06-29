class StaticPagesController < ApplicationController
  def home

  end

  def encode                                      #метод, вызываемый нажатием кнопок
    str = params["text"]["{:value=>nil}"]         #присвоить переменной параметр с формы
    key = params["key"]["{:value=>nil}"].to_i
    if params[:commit] === "Decode"
      key=key*-1
    end
    offset= key
    tmp = []
    res = ''
    str.each_byte {|b| tmp.push(b)}
    tmp.each do |b|
      case b
        when 65..90
          b+=offset
          while b>90 do b-=26 end
          while b<65 do b+=26 end
        when 97..122
          b+=offset
          while b>122 do b-=26 end
          while b<97 do b+=26 end
        else
      end
      res << b.chr
    end
    @textout = res
    gon.str=str                 #присваиваем gon переменную для работы в js файле(использую gem "gon")
    respond_to do |format|      #возврат формата json
      format.json {render :json => @textout}
      format.html {render 'home'}
    end

  end

end
