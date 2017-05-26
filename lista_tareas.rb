require "sinatra"
require "make_todo"

get "/" do
	
	erb :index
end

get "/tareas/crear" do
	erb :crear_tarea
end
# Se recive como parámetro el títuño de la tarea, el cual se usará para crear la tarea en la base de datos
post "/tareas/crear" do
	Tarea.create(params[:tarea])
	@status = true
	erb :crear_tarea
end
# Se usa la variable de instancia @lista para indicar que lo que se va a mostrar son tareas sin completar en la vista
get "/tareas/sin_completar" do
	
	@lista = 1
	@lista_tareas = Tarea.all.select { |tarea| tarea["done"] == false } # Find solo devuelve el primero, select devuelve todos los que cumplen la condición

	erb :tareas_lista
end
# Se usa la variable de instancia @lista para indicar que lo que se va a mostrar son tareas completadas en la vista
get "/tareas/completadas" do
	
	@lista = 2
	@lista_tareas = Tarea.all.select { |tarea| tarea["done"] == true }

	erb :tareas_lista
end

get "/tareas/completar" do
	@lista_tareas = Tarea.all.select { |tarea| tarea["done"] == false }
	erb :completar_tarea
end
# Se recibe el Id de la tarea, el cual se usará para decirle a la base de datos que complete la tarea
post "/tareas/completar" do
	
	Tarea.update(params[:id])

	redirect "/tareas/completar"
end

get "/tareas/borrar" do
	@lista_tareas = Tarea.all
	erb :borrar_tarea
end
# Se recibe el Id de la tarea, el cual se usará para decirle a la base de datos la tarea a borrar
post "/tareas/borrar" do
	Tarea.destroy(params[:id])
	redirect "/tareas/borrar"
end