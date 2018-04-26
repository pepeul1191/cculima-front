package App::Controller::Teatro;
use strict;
use warnings;
use Mojo::Base 'Mojolicious::Controller';
use utf8;
use JSON;
use Encode qw(decode encode);
use App::Provider::Teatro;
#use Mojo::Log; use Data::Dumper;my $log = Mojo::Log->new;
sub listar {
  my $self = shift;
  my %mensaje = App::Provider::Teatro::listar();
  if($mensaje{'codigo'} eq '200'){
    my $rpta = %mensaje{'mensaje'};
    $self->render(text =>  Encode::decode('utf8', $rpta), status => 200);
  }else{
    my $codigo = int(%mensaje{'codigo'});
    $self->render(text => Encode::decode('utf8', JSON::to_json \%mensaje), status => $codigo);
  }
}

sub listar_elenco {
  my $self = shift;
  my $teatro_id = $self->param('teatro_id');
  if ($teatro_id eq 'E'){
    $self->render(text =>  '[]', status => 200);
  }else{
    my %mensaje = ();
    %mensaje = App::Provider::Teatro::listar_elenco($teatro_id);
    if($mensaje{'codigo'} eq '200'){
      my $rpta = %mensaje{'mensaje'};
      $self->render(text =>  Encode::decode('utf8', $rpta), status => 200);
    }else{
      my $codigo = int(%mensaje{'codigo'});
      $self->render(text => Encode::decode('utf8', JSON::to_json \%mensaje), status => $codigo);
    }
  }
}

sub listar_equipo {
  my $self = shift;
  my $teatro_id = $self->param('teatro_id');
  if ($teatro_id eq 'E'){
    $self->render(text =>  '[]', status => 200);
  }else{
    my %mensaje = ();
    %mensaje = App::Provider::Teatro::listar_equipo($teatro_id);
    if($mensaje{'codigo'} eq '200'){
      my $rpta = %mensaje{'mensaje'};
      $self->render(text =>  Encode::decode('utf8', $rpta), status => 200);
    }else{
      my $codigo = int(%mensaje{'codigo'});
      $self->render(text => Encode::decode('utf8', JSON::to_json \%mensaje), status => $codigo);
    }
  }
}

1;
