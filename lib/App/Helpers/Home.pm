package App::Helpers::Home;
use App::Config::Constants;

my $constants = \%App::Config::Constants::Data;

our %HomeHelper = (
  index_css => sub {
    my @rpta = ();
    if($constants->{'ambiente'} eq 'desarrollo'){
      push @rpta, 'bower_components/bootstrap/dist/css/bootstrap.min';
      push @rpta, 'bower_components/font-awesome/css/font-awesome.min';
      push @rpta, 'css/style';
    }
    if($constants->{'ambiente'} eq 'produccion'){
      push @rpta , 'dist/home.min';
    }
    return @rpta;
  },
  index_js => sub {
    my @rpta = ();
    if($constants->{'ambiente'} eq 'desarrollo'){
      push @rpta, 'bower_components/jquery/dist/jquery.min';
      push @rpta, 'bower_components/bootstrap/dist/js/bootstrap.min';
    }
    if($constants->{'ambiente'} eq 'produccion'){
      push @rpta , 'dist/home.min';
    }
    return @rpta;
  },
);

1;
