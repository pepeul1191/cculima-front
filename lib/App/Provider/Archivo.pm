package App::Provider::Archivo;
use strict;
use warnings;
use REST::Client;
use utf8;
use Encode qw(decode encode);
use App::Config::Constants;

my $servicio_url = $App::Config::Constants::Data{'servicio_archivos'};
#use Mojo::Log; use Data::Dumper;my $log = Mojo::Log->new;
sub obtener_id {
  my %rpta = ();
  my $url = $servicio_url . 'imagen/obtener_id';
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

sub crear {
  my (%data) = @_;
  my %rpta = ();
  my $url = $servicio_url . 'imagen/crear?data=' . Encode::decode('utf8', JSON::to_json \%data);;
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

1;
