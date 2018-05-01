package App::Helper::Contenido;
use App::Config::Constants;

my $constants = \%App::Config::Constants::Data;

our %ContenidoHelper = (
  index_css => sub {
    my @rpta = ();
    if($constants->{'ambiente'} eq 'desarrollo'){
      push @rpta, 'bower_components/bootstrap/dist/css/bootstrap.min';
      push @rpta, 'bower_components/font-awesome/css/font-awesome.min';
      push @rpta, 'bower_components/swp-plugins/assets/css/mootools.autocomplete';
      push @rpta, 'bower_components/swp-plugins/assets/css/mootools.grid';
      push @rpta, 'bower_components/swp-plugins/assets/css/mootools.validations';
      push @rpta, 'bower_components/jquery-ui/themes/base/datepicker';
      push @rpta, 'bower_components/jquery-timepicker-wvega/jquery.timepicker',
      push @rpta, 'assets/css/vanillaCalendar';
      push @rpta, 'assets/css/styles';
    }
    if($constants->{'ambiente'} eq 'produccion'){
      push @rpta , 'dist/contenido.min';
    }
    return @rpta;
  },
  index_js => sub {
    my @rpta = ();
    if($constants->{'ambiente'} eq 'desarrollo'){
      push @rpta, 'bower_components/jquery/dist/jquery.min';
      push @rpta, 'bower_components/bootstrap/dist/js/bootstrap.min';
      push @rpta, 'bower_components/handlebars/handlebars.min';
      push @rpta, 'bower_components/underscore/underscore-min';
      push @rpta, 'bower_components/backbone/backbone-min';
      push @rpta, 'bower_components/backbone.marionette/lib/backbone.marionette.min';
      push @rpta, 'bower_components/swp-plugins/assets/js/mootools-core.min';
      push @rpta, 'bower_components/swp-plugins/assets/js/mootools.min';
      push @rpta, 'bower_components/swp-plugins/assets/js/mootools-interfaces.min';
      push @rpta, 'bower_components/swp-plugins/assets/js/jquery.upload';
      push @rpta, 'bower_components/swp-plugins/assets/js/mootools.chain';
      push @rpta, 'bower_components/swp-plugins/assets/js/mootools.dao';
      push @rpta, 'bower_components/swp-plugins/assets/js/mootools.autocomplete';
      push @rpta, 'bower_components/swp-plugins/assets/js/mootools.form';
      push @rpta, 'bower_components/swp-plugins/assets/js/mootools.observer';
      push @rpta, 'bower_components/swp-plugins/assets/js/mootools.grid';
      push @rpta, 'bower_components/swp-plugins/assets/js/jquery.upload';
      push @rpta, 'bower_components/jquery-ui/ui/widgets/datepicker';
      push @rpta, 'bower_components/jquery-timepicker-wvega/jquery.timepicker';
      push @rpta, 'bower_components/ckeditor/ckeditor';
      push @rpta, 'assets/js/vanillaCalendarModel';
      push @rpta, 'assets/js/vanillaCalendar';
      push @rpta, 'models/ambiente';
      push @rpta, 'models/servicio';
      push @rpta, 'models/teatro';
      push @rpta, 'models/exposicion';
      push @rpta, 'models/concierto';
      push @rpta, 'layout/app';
      push @rpta, 'views/_table_ambiente_galeria';
      push @rpta, 'views/_table_ambiente';
      push @rpta, 'views/ambiente_detalle';
      push @rpta, 'views/ambiente';
      push @rpta, 'views/_table_concierto';
      push @rpta, 'views/concierto_detalle';
      push @rpta, 'views/concierto';
      push @rpta, 'views/_table_exposicion';
      push @rpta, 'views/exposicion_detalle';
      push @rpta, 'views/exposicion';
      push @rpta, 'views/_table_servicio';
      push @rpta, 'views/servicio_detalle';
      push @rpta, 'views/servicio';
      push @rpta, 'views/_table_stand_up';
      push @rpta, 'views/stand_up';
      push @rpta, 'views/_table_teatro_elenco';
      push @rpta, 'views/_table_teatro_equipo';
      push @rpta, 'views/_table_teatro';
      push @rpta, 'views/teatro_detalle';
      push @rpta, 'views/teatro';
      push @rpta, 'routes/contenido';
    }
    if($constants->{'ambiente'} eq 'produccion'){
      push @rpta , 'dist/contenido.min';
    }
    return @rpta;
  },
);

1;
