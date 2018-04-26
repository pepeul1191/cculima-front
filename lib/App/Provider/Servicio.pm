package App::Provider::Servicio;
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
  my $url = $servicio_url . 'servicio/listar';
  my $client = REST::Client->new();
  $client->GET($url);
  if( $client->responseCode() eq '200' ){
    $rpta{'tipo_mensaje'} = 'success';
    $rpta{'codigo'} = 200;
    $rpta{'mensaje'} = decode('utf8', $client->responseContent());
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
  my $url = $servicio_url . 'servicio/crear_detalle?data=' . $data;
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
  my $url = $servicio_url . 'servicio/editar_detalle?data=' . $data;
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

sub asociar_foto {
  my($servicio_id, $foto_id) = @_;
  my %rpta = ();
  my $client = REST::Client->new();
  my $url = $servicio_url . 'servicio/asociar_foto?servicio_id=' . $servicio_id . '&foto_id=' . $foto_id;
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
  my($servicio_id) = @_;
  my %rpta = ();
  my $client = REST::Client->new();
  my $url = $servicio_url . 'servicio/obtener/' . $servicio_id;
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
  my $url = $servicio_url . 'servicio/guardar?data=' . $data;
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
