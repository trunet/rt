package RT::Action::CreateQueue;
use strict;
use warnings;

use base qw/Jifty::Action::Record::Create RT::Action::WithCustomFields/;

sub record_class { 'RT::Model::Queue' }

use constant report_detailed_messages => 1;

use Jifty::Param::Schema;
use Jifty::Action schema {
    param sign =>
        render as 'Checkbox';
    param encrypt =>
        render as 'Checkbox';
};

sub arguments {
    my $self = shift;
    if ( !$self->{_cached_arguments} ) {
        $self->{_cached_arguments} = $self->SUPER::arguments;
        my $queue = RT::Model::Queue->new;
        my @args = $self->_setup_custom_fields( cfs => $queue->custom_fields );
        for my $args (@args) {
            my $name = delete $args->{name};
            $self->{_cached_arguments}{$name} = $args;

        }
    }

    return $self->{_cached_arguments};
}

sub take_action {
    my $self = shift;
    $self->SUPER::take_action;
    $self->_add_custom_field_values;
    return 1;
}

1;
