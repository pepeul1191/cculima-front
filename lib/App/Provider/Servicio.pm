package App::Provider::Servicio;
use strict;
use warnings;
use REST::Client;
use utf8;
use JSON;
use Encode qw(decode encode);
use App::Config::Constants;
#use Mojo::Log; use Data::Dumper;my $log = Mojo::Log->new;
my $servicio_url = $App::Config::Constants::Data{'servicio_cculima'};

sub listar {
  my $rpta = '';
  my $url = $servicio_url . 'servicio/listar';
  my $client = REST::Client->new();
  $client->GET($url);
  if( $client->responseCode() eq '200' ){
    $rpta = decode('utf8', $client->responseContent());
  } elsif( $client->responseCode() eq '500' ){
    my %temp = ();
    $temp{'tipo_mensaje'} = "error";
    my @temp = ('Se ha producido un error en el cliente REST', '' . $client->responseContent());
    $temp{'mensaje'} = [@temp];
    $rpta = Encode::decode('utf8', JSON::to_json \%temp);
  } elsif( $client->responseCode() eq '404' ){
    my %temp = ();
    $temp{'tipo_mensaje'} = "error";
    my @temp = ('Recurso no encontrado en servicio', '' . $client->responseContent());
    $temp{'mensaje'} = [@temp];
    $rpta = Encode::decode('utf8', JSON::to_json \%temp);
  }else{
    my %temp = ();
    $temp{'tipo_mensaje'} = "error";
    my @temp = ('Error: Excepción de servicio no capturada', '' . $client->responseContent());
    $temp{'mensaje'} = [@temp];
    $rpta = Encode::decode('utf8', JSON::to_json \%temp);
  }
  return $rpta;
}

1;
