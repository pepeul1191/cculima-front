package App;
use Mojo::Base 'Mojolicious';
use Mojo::Log;
my $log = Mojo::Log->new;
# This method will run once at server start
sub startup {
  my $self = shift;
  $self->hook(before_dispatch => sub {
    my $c = shift;
    #$c->res->headers->header('Access-Control-Allow-Origin' => '*');
    $c->res->headers->header('x-powered-by' => 'Mojolicious (Perl)');
    $c->res->headers->header('Server' => 'Ubuntu');
  });
  # Load configuration from hash returned by "my_app.conf"
  my $config = $self->plugin('Config');
  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer') if $config->{perldoc};
  # Router
  my $r = $self->routes;
  # Plugin
  $self->plugin('App::Plugin::SessionTrue');
  # Normal route to controller
  $r->get('/')->to('home#index');
  $r->get('/departamento/listar')->to('departamento#listar');
  $r->get('/rest/:sistema_id')->to('home#rest');
  # carga de servicio_archivos
  $r->post('/archivo/subir')->to('archivo#subir');
  # vista-contenidos
  $r->get('/contenido')->to('contenido#index');
  # rest-servicio
  $r->get('/servicio/listar')->to('servicio#listar');
  $r->post('/servicio/guardar_detalle')->to('servicio#guardar_detalle');
  $r->post('/servicio/asociar_foto')->to('servicio#asociar_foto');
  $r->get('/servicio/obtener/:servicio_id')->to('servicio#obtener');
  $r->post('/servicio/guardar')->to('servicio#guardar');
  # rest-ambiente
  $r->get('/ambiente/listar')->to('ambiente#listar');
  $r->get('/ambiente/listar_select')->to('ambiente#listar_select');
  $r->get('/ambiente/galeria/listar/:ambiente_id')->to('ambiente#listar_galeria');
  $r->get('/ambiente/obtener/:ambiente_id')->to('ambiente#obtener');
  $r->post('/ambiente/guardar_detalle')->to('ambiente#guardar_detalle');
  $r->post('/ambiente/asociar_imagen_princial')->to('ambiente#asociar_imagen_princial');
  $r->post('/ambiente/asociar_imagen_menu')->to('ambiente#asociar_imagen_menu');
  $r->post('/ambiente/galeria/guardar')->to('ambiente#galeria_guardar');
  $r->get('/ambiente/galeria/obtener_ruta_foto/:imagen_id')->to('ambiente#galeria_obtener_ruta_foto');
  $r->post('/ambiente/guardar')->to('ambiente#guardar');
  # rest-teatro
  $r->get('/teatro/listar')->to('teatro#listar');
  $r->get('/teatro/elenco/listar/:teatro_id')->to('teatro#listar_elenco');
  $r->get('/teatro/equipo/listar/:teatro_id')->to('teatro#listar_equipo');
  $r->get('/teatro/obtener_calendario/:teatro_id')->to('teatro#obtener_calendario');
  $r->get('/teatro/obtener/:teatro_id')->to('teatro#obtener');
  $r->post('/teatro/guardar_detalle')->to('teatro#guardar_detalle');
  $r->post('/teatro/elenco/guardar')->to('teatro#guardar_elenco');
  $r->post('/teatro/equipo/guardar')->to('teatro#guardar_equipo');
  $r->post('/teatro/asociar_imagen_menu')->to('teatro#asociar_imagen_menu');
  $r->post('/teatro/asociar_imagen_detalle')->to('teatro#asociar_imagen_detalle');
  $r->post('/teatro/asociar_calendario')->to('teatro#asociar_calendario');
  $r->post('/teatro/guardar')->to('teatro#guardar');
  # rest-exposicion
  $r->get('/exposicion/listar')->to('exposicion#listar');
  $r->post('/exposicion/guardar_detalle')->to('exposicion#guardar_detalle');
  $r->post('/exposicion/asociar_calendario')->to('exposicion#asociar_calendario');
  # rest-concierto
  $r->get('/concierto/listar')->to('concierto#listar');
  # rest-stand_up
  $r->get('/stand_up/listar')->to('stand_up#listar');
}

1;
