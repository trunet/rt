# BEGIN BPS TAGGED BLOCK {{{
#
# COPYRIGHT:
#
# This software is Copyright (c) 1996-2011 Best Practical Solutions, LLC
#                                          <sales@bestpractical.com>
#
# (Except where explicitly superseded by other copyright notices)
#
#
# LICENSE:
#
# This work is made available to you under the terms of Version 2 of
# the GNU General Public License. A copy of that license should have
# been provided with this software, but in any event can be snarfed
# from www.gnu.org.
#
# This work is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
# 02110-1301 or visit their web page on the internet at
# http://www.gnu.org/licenses/old-licenses/gpl-2.0.html.
#
#
# CONTRIBUTION SUBMISSION POLICY:
#
# (The following paragraph is not intended to limit the rights granted
# to you to modify and distribute this software under the terms of
# the GNU General Public License and is only of importance to you if
# you choose to contribute your changes and enhancements to the
# community by submitting them to Best Practical Solutions, LLC.)
#
# By intentionally submitting any modifications, corrections or
# derivatives to this work, or any other work intended for use with
# Request Tracker, to Best Practical Solutions, LLC, you confirm that
# you are the copyright holder for those contributions and you grant
# Best Practical Solutions,  LLC a nonexclusive, worldwide, irrevocable,
# royalty-free, perpetual, license to use, copy, create derivative
# works based on those contributions, and sublicense and distribute
# those contributions and any derivatives thereof.
#
# END BPS TAGGED BLOCK }}}

=head1 NAME

  RT::Links - A collection of Link objects

=head1 SYNOPSIS

  use RT::Links;
  my $links = RT::Links->new($CurrentUser);

=head1 DESCRIPTION


=head1 METHODS



=cut


package RT::Links;

use strict;
use warnings;


use RT::Link;

use base 'RT::SearchBuilder';

sub Table { 'Links'}


use RT::URI;

sub Limit  {
    my $self = shift;
    my %args = ( ENTRYAGGREGATOR => 'AND',
		 OPERATOR => '=',
		 @_);

    # If we're limiting by target, order by base
    # (Order by the thing that's changing)

    if ( ($args{'FIELD'} eq 'Target') or 
	 ($args{'FIELD'} eq 'LocalTarget') ) {
	$self->OrderBy (ALIAS => 'main',
			FIELD => 'Base',
			ORDER => 'ASC');
    }
    elsif ( ($args{'FIELD'} eq 'Base') or 
	    ($args{'FIELD'} eq 'LocalBase') ) {
	$self->OrderBy (ALIAS => 'main',
			FIELD => 'Target',
			ORDER => 'ASC');
    }
    

    $self->SUPER::Limit(%args);
}


=head2 LimitRefersTo URI

find all things that refer to URI

=cut

sub LimitRefersTo {
    my $self = shift;
    my $URI = shift;

    $self->Limit(FIELD => 'Type', VALUE => 'RefersTo');
    $self->Limit(FIELD => 'Target', VALUE => $URI);
}


=head2 LimitReferredToBy URI

find all things that URI refers to

=cut

sub LimitReferredToBy {
    my $self = shift;
    my $URI = shift;

    $self->Limit(FIELD => 'Type', VALUE => 'RefersTo');
    $self->Limit(FIELD => 'Base', VALUE => $URI);
}



sub Next {
    my $self = shift;

    my $Link = $self->SUPER::Next();
    return $Link unless $Link && ref $Link;

    return $Link if $self->IsValidLink( $Link );
    return $self->Next;
}

# }}}

=head2 NewItem

Returns an empty new RT::Link item

=cut

sub NewItem {
    my $self = shift;
    return(RT::Link->new($self->CurrentUser));
}

=head2 ItemsArrayRef

Returns a reference to the set of all valid links found in this search.

=cut

sub ItemsArrayRef {
    my $self = shift;
    return [ grep { $self->IsValidLink($_) } @{ $self->SUPER::ItemsArrayRef } ];
}

=head2 Count

Returns number of all valid links found in this search.

note: use RedoSearch to flush this instead of _DoCount

=cut

sub Count {
    my $self = shift;
    return scalar @{ $self->ItemsArrayRef };
}

=head2 IsValidLink

if linked to a local ticket and is deleted, then the link is invalid.

=cut

sub IsValidLink {
    my $self = shift;
    my $link = shift;

    return unless $link && ref $link && $link->Target && $link->Base;

    # Skip links to local objects thast are deleted
    return
      if $link->TargetURI->IsLocal
          && ( UNIVERSAL::isa( $link->TargetObj, "RT::Ticket" )
              && $link->TargetObj->__Value('status') eq "deleted"
              || UNIVERSAL::isa( $link->BaseObj, "RT::Ticket" )
              && $link->BaseObj->__Value('status') eq "deleted" );

    return 1;
}

RT::Base->_ImportOverlays();

1;
