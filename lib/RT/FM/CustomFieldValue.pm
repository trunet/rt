# BEGIN LICENSE BLOCK
# 
#  Copyright (c) 2002 Jesse Vincent <jesse@bestpractical.com>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of version 2 of the GNU General Public License 
#  as published by the Free Software Foundation.
# 
#  A copy of that license should have arrived with this
#  software, but in any event can be snarfed from www.gnu.org.
# 
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
# 
# END LICENSE BLOCK

# Autogenerated by DBIx::SearchBuilder factory (by <jesse@bestpractical.com>)
# WARNING: THIS FILE IS AUTOGENERATED. ALL CHANGES TO THIS FILE WILL BE LOST.  
# 
# !! DO NOT EDIT THIS FILE !!
#


=head1 NAME

RT::FM::CustomFieldValue


=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=cut

package RT::FM::CustomFieldValue;
use RT::FM::Record; 
use RT::FM::CustomField;


use base qw( RT::FM::Record );

sub _Init {
  my $self = shift; 

  $self->Table('FM_CustomFieldValues');
  $self->SUPER::_Init(@_);
}





=item Create PARAMHASH

Create takes a hash of values and creates a row in the database:

  int(11) 'CustomField'.
  varchar(255) 'Name'.
  varchar(255) 'Description'.
  int(11) 'SortOrder'.
  int(11) 'CreatedBy'.

=cut




sub Create {
    my $self = shift;
    my %args = ( 
                CustomField => '0',
                Name => '',
                Description => '',
                SortOrder => '',
                CreatedBy => '',

		  @_);
    $self->SUPER::Create(
                         CustomField => $args{'CustomField'},
                         Name => $args{'Name'},
                         Description => $args{'Description'},
                         SortOrder => $args{'SortOrder'},
                         CreatedBy => $args{'CreatedBy'},
);

}



=item id

Returns the current value of id. 
(In the database, id is stored as int(11).)


=cut


=item CustomField

Returns the current value of CustomField. 
(In the database, CustomField is stored as int(11).)



=item SetCustomField VALUE


Set CustomField to VALUE. 
Returns (1, 'Status message') on success and (0, 'Error Message') on failure.
(In the database, CustomField will be stored as a int(11).)


=cut


=item CustomFieldObj

Returns the CustomField Object which has the id returned by CustomField


=cut

sub CustomFieldObj {
	my $self = shift;
	my $CustomField =  RT::FM::CustomField->new($self->CurrentUser);
	$CustomField->Load($self->CustomField());
	return($CustomField);
}

=item Name

Returns the current value of Name. 
(In the database, Name is stored as varchar(255).)



=item SetName VALUE


Set Name to VALUE. 
Returns (1, 'Status message') on success and (0, 'Error Message') on failure.
(In the database, Name will be stored as a varchar(255).)


=cut


=item Description

Returns the current value of Description. 
(In the database, Description is stored as varchar(255).)



=item SetDescription VALUE


Set Description to VALUE. 
Returns (1, 'Status message') on success and (0, 'Error Message') on failure.
(In the database, Description will be stored as a varchar(255).)


=cut


=item SortOrder

Returns the current value of SortOrder. 
(In the database, SortOrder is stored as int(11).)



=item SetSortOrder VALUE


Set SortOrder to VALUE. 
Returns (1, 'Status message') on success and (0, 'Error Message') on failure.
(In the database, SortOrder will be stored as a int(11).)


=cut


=item CreatedBy

Returns the current value of CreatedBy. 
(In the database, CreatedBy is stored as int(11).)



=item SetCreatedBy VALUE


Set CreatedBy to VALUE. 
Returns (1, 'Status message') on success and (0, 'Error Message') on failure.
(In the database, CreatedBy will be stored as a int(11).)


=cut


=item Created

Returns the current value of Created. 
(In the database, Created is stored as datetime.)


=cut


=item LastUpdatedBy

Returns the current value of LastUpdatedBy. 
(In the database, LastUpdatedBy is stored as int(11).)


=cut


=item LastUpdated

Returns the current value of LastUpdated. 
(In the database, LastUpdated is stored as datetime.)


=cut



sub _ClassAccessible {
    {
     
        id =>
		{read => 1, type => 'int(11)', default => ''},
        CustomField => 
		{read => 1, write => 1, type => 'int(11)', default => '0'},
        Name => 
		{read => 1, write => 1, type => 'varchar(255)', default => ''},
        Description => 
		{read => 1, write => 1, type => 'varchar(255)', default => ''},
        SortOrder => 
		{read => 1, write => 1, type => 'int(11)', default => ''},
        CreatedBy => 
		{read => 1, write => 1, type => 'int(11)', default => ''},
        Created => 
		{read => 1, auto => 1, type => 'datetime', default => ''},
        LastUpdatedBy => 
		{read => 1, auto => 1, type => 'int(11)', default => ''},
        LastUpdated => 
		{read => 1, auto => 1, type => 'datetime', default => ''},

 }
};


        eval "require RT::FM::CustomFieldValue_Overlay";
        if ($@ && $@ !~ /^Can't locate/) {
            die $@;
        };

        eval "require RT::FM::CustomFieldValue_Local";
        if ($@ && $@ !~ /^Can't locate/) {
            die $@;
        };




=head1 SEE ALSO

This class allows "overlay" methods to be placed
into the following files _Overlay is for a System overlay by the original author,
while _Local is for site-local customizations.  

These overlay files can contain new subs or subs to replace existing subs in this module.

If you'll be working with perl 5.6.0 or greater, each of these files should begin with the line 

   no warnings qw(redefine);

so that perl does not kick and scream when you redefine a subroutine or variable in your overlay.

RT::FM::CustomFieldValue_Overlay, RT::FM::CustomFieldValue_Local

=cut


1;
