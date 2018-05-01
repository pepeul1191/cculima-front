package App::Provider::Concierto;
use strict;
use warnings;
use REST::Client;
use utf8;
use Encode qw(decode encode);
use App::Config::Constants;

my $servicio_url = $App::Config::Constants::Data{'servicio_cculima'};
#use Mojo::Log; use Data::Dumper;my $log = Mojo::Log->new;
sub listar {
  my %rpta = ();
  my $url = $servicio_url . 'concierto/listar';
  my $client = REST::Client->new();
  $client->GET($url);
  if( $client->responseCode() eq '200' ){
    $rpta{'tipo_mensaje'} = 'success';
    $rpta{'codigo'} = 200;
    $rpta{'mensaje'} = $client->responseContent();
  } elsif( $client->responseCode() eq '500' ){
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 500;
    my @temp = ('Se ha producido un error en el cliente REST', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  } elsif( $client->responseCode() eq '404' ){
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 404;
    my @temp = ('Recurso no encontrado en servicio', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  }else{
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 500;
    my @temp = ('Error: Excepción de servicio no capturada', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  }
  return %rpta;
}

sub crear_detalle {
  my($data) = @_;
  my %rpta = ();
  my $url = $servicio_url . 'concierto/crear_detalle?data=' . $data;
  my $client = REST::Client->new();
  $client->POST($url);
  if( $client->responseCode() eq '200' ){
    $rpta{'tipo_mensaje'} = 'success';
    $rpta{'codigo'} = 200;
    $rpta{'mensaje'} = $client->responseContent();
  } elsif( $client->responseCode() eq '500' ){
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 500;
    my @temp = ('Se ha producido un error en el cliente REST', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  } elsif( $client->responseCode() eq '404' ){
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 404;
    my @temp = ('Recurso no encontrado en servicio', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  }else{
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 500;
    my @temp = ('Error: Excepción de servicio no capturada', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  }
  return %rpta;
}

sub editar_detalle {
  my($data) = @_;
  my %rpta = ();
  my $client = REST::Client->new();
  my $url = $servicio_url . 'concierto/editar_detalle?data=' . $data;
  $client->POST($url);
  if( $client->responseCode() eq '200' ){
    $rpta{'tipo_mensaje'} = 'success';
    $rpta{'codigo'} = 200;
    $rpta{'mensaje'} = $client->responseContent();
  } elsif( $client->responseCode() eq '500' ){
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 500;
    my @temp = ('Se ha producido un error en el cliente REST', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  } elsif( $client->responseCode() eq '404' ){
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 404;
    my @temp = ('Recurso no encontrado en servicio', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  }else{
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 500;
    my @temp = ('Error: Excepción de servicio no capturada', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  }
  return %rpta;
}

sub asociar_calendario {
  my($concierto_id, $fechas) = @_;
  my %rpta = ();
  my $client = REST::Client->new();
  my $url = $servicio_url . 'concierto/asociar_calendario?concierto_id=' . $concierto_id . '&fechas=' . $fechas;
  $client->POST($url);
  if( $client->responseCode() eq '200' ){
    $rpta{'tipo_mensaje'} = 'success';
    $rpta{'codigo'} = 200;
    $rpta{'mensaje'} = $client->responseContent();
  } elsif( $client->responseCode() eq '500' ){
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 500;
    my @temp = ('Se ha producido un error en el cliente REST', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  } elsif( $client->responseCode() eq '404' ){
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 404;
    my @temp = ('Recurso no encontrado en servicio', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  }else{
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 500;
    my @temp = ('Error: Excepción de servicio no capturada', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  }
  return %rpta;
}

sub asociar_imagen_menu {
  my($concierto_id, $imagen_menu_id) = @_;
  my %rpta = ();
  my $client = REST::Client->new();
  my $url = $servicio_url . 'concierto/asociar_imagen_menu?concierto_id=' . $concierto_id . '&imagen_menu_id=' . $imagen_menu_id;
  $client->POST($url);
  if( $client->responseCode() eq '200' ){
    $rpta{'tipo_mensaje'} = 'success';
    $rpta{'codigo'} = 200;
    $rpta{'mensaje'} = $client->responseContent();
  } elsif( $client->responseCode() eq '500' ){
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 500;
    my @temp = ('Se ha producido un error en el cliente REST', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  } elsif( $client->responseCode() eq '404' ){
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 404;
    my @temp = ('Recurso no encontrado en servicio', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  }else{
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 500;
    my @temp = ('Error: Excepción de servicio no capturada', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  }
  return %rpta;
}

sub asociar_imagen_detalle {
  my($concierto_id, $imagen_detalle_id) = @_;
  my %rpta = ();
  my $client = REST::Client->new();
  my $url = $servicio_url . 'concierto/asociar_imagen_detalle?concierto_id=' . $concierto_id . '&imagen_detalle_id=' . $imagen_detalle_id;
  $client->POST($url);
  if( $client->responseCode() eq '200' ){
    $rpta{'tipo_mensaje'} = 'success';
    $rpta{'codigo'} = 200;
    $rpta{'mensaje'} = $client->responseContent();
  } elsif( $client->responseCode() eq '500' ){
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 500;
    my @temp = ('Se ha producido un error en el cliente REST', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  } elsif( $client->responseCode() eq '404' ){
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 404;
    my @temp = ('Recurso no encontrado en servicio', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  }else{
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 500;
    my @temp = ('Error: Excepción de servicio no capturada', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  }
  return %rpta;
}

sub obtener {
  my($concierto_id) = @_;
  my %rpta = ();
  my $client = REST::Client->new();
  my $url = $servicio_url . 'concierto/obtener/' . $concierto_id;
  $client->GET($url);
  if( $client->responseCode() eq '200' ){
    $rpta{'tipo_mensaje'} = 'success';
    $rpta{'codigo'} = 200;
    $rpta{'mensaje'} = $client->responseContent();
  } elsif( $client->responseCode() eq '500' ){
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 500;
    my @temp = ('Se ha producido un error en el cliente REST', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  } elsif( $client->responseCode() eq '404' ){
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 404;
    my @temp = ('Recurso no encontrado en servicio', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  }else{
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 500;
    my @temp = ('Error: Excepción de servicio no capturada', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  }
  return %rpta;
}

sub obtener_calendario {
  my($concierto_id) = @_;
  my %rpta = ();
  my $client = REST::Client->new();
  my $url = $servicio_url . 'concierto/obtener_calendario/' . $concierto_id;
  $client->GET($url);
  if( $client->responseCode() eq '200' ){
    $rpta{'tipo_mensaje'} = 'success';
    $rpta{'codigo'} = 200;
    $rpta{'mensaje'} = $client->responseContent();
  } elsif( $client->responseCode() eq '500' ){
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 500;
    my @temp = ('Se ha producido un error en el cliente REST', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  } elsif( $client->responseCode() eq '404' ){
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 404;
    my @temp = ('Recurso no encontrado en servicio', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  }else{
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 500;
    my @temp = ('Error: Excepción de servicio no capturada', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  }
  return %rpta;
}

sub guardar {
  my($data) = @_;
  my %rpta = ();
  my $client = REST::Client->new();
  my $url = $servicio_url . 'concierto/guardar?data=' . $data;
  $client->POST($url);
  if( $client->responseCode() eq '200' ){
    $rpta{'tipo_mensaje'} = 'success';
    $rpta{'codigo'} = 200;
    $rpta{'mensaje'} = $client->responseContent();
  } elsif( $client->responseCode() eq '500' ){
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 500;
    my @temp = ('Se ha producido un error en el cliente REST', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  } elsif( $client->responseCode() eq '404' ){
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 404;
    my @temp = ('Recurso no encontrado en servicio', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  }else{
    $rpta{'tipo_mensaje'} = 'error';
    $rpta{'codigo'} = 500;
    my @temp = ('Error: Excepción de servicio no capturada', '' . $client->responseContent());
    $rpta{'mensaje'} = [@temp];
  }
  return %rpta;
}


1;
