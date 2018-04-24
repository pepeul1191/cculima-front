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
  # rest-ambiente
  $r->get('/ambiente/listar')->to('ambiente#listar');
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
  # rest-exposicion
  $r->get('/exposicion/listar')->to('exposicion#listar');
  # rest-concierto
  $r->get('/concierto/listar')->to('concierto#listar');
  # rest-stand_up
  $r->get('/stand_up/listar')->to('stand_up#listar');
}

1;
