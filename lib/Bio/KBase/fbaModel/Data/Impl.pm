package Bio::KBase::fbaModel::Data::Impl;
use strict;
use Bio::KBase::Exceptions;
# Use Semantic Versioning (2.0.0-rc.1)
# http://semver.org 
our $VERSION = "0.1.0";

=head1 NAME

fbaModelData

=head1 DESCRIPTION

=head1 fbaModelData

Data access library for fbaModel services. This API is meant for
interanl use only. Do not distribute or expose publically.

=cut

#BEGIN_HEADER
use JSON::XS;
use Config::Simple;
use ModelSEED::Store;
use ModelSEED::Auth::Basic;
use ModelSEED::Database::MongoDBSimple;
use Moose;
with 'ModelSEED::Database';
sub store {
    my ($self) = @_;
    return $self->{_store};
}
#END_HEADER

sub new
{
    my($class, @args) = @_;
    my $self = {
    };
    bless $self, $class;
    #BEGIN_CONSTRUCTOR
    my ($host, $db);
    if (my $e = $ENV{KB_DEPLOYMENT_CONFIG}) {
        my $service = $ENV{KB_SERVICE_NAME};
        my $c = new Config::Simple($e);
        $host = $c->param("$service.mongodb-hostname");
        $db   = $c->param("$service.mongodb-database");
    } else {
        warn "No deployment configuration found;\n";
    }
    if (!$host) {
        $host = "mongodb.kbase.us";
        warn "\tfalling back to $host for database!\n";
    }
    if (!$db) {
        $db = "modelObjectStore";
        warn "\tfalling back to $db for collection\n";
    }
    $self->{_db} = ModelSEED::Database::MongoDBSimple->new(
        db_name => $db,
        host    => $host,
    );
    # TODO : Replace this with per rpc-call authorization
    $self->{_auth} = ModelSEED::Auth::Basic->new(
        username => "kbase",
        password => "kbase",
    );
    $self->{_store} = ModelSEED::Store->new(
        auth => $self->{_auth},
        database => $self->{_db},
    );
    #END_CONSTRUCTOR

    if ($self->can('_init_instance'))
    {
	$self->_init_instance();
    }
    return $self;
}

=head1 METHODS



=head2 has_data

  $existence = $obj->has_data($ref)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a Ref
$existence is a Bool
Ref is a string
Bool is an int

</pre>

=end html

=begin text

$ref is a Ref
$existence is a Bool
Ref is a string
Bool is an int


=end text



=item Description



=back

=cut

sub has_data
{
    my $self = shift;
    my($ref) = @_;

    my @_bad_arguments;
    (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument \"ref\" (value was \"$ref\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to has_data:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'has_data');
    }

    my $ctx = $Bio::KBase::fbaModel::Data::Service::CallContext;
    my($existence);
    #BEGIN has_data
    $existence = $self->store()->has_data($ref);
    #END has_data
    my @_bad_returns;
    (!ref($existence)) or push(@_bad_returns, "Invalid type for return variable \"existence\" (value was \"$existence\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to has_data:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'has_data');
    }
    return($existence);
}




=head2 get_data

  $data = $obj->get_data($ref)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a Ref
$data is a Data
Ref is a string
Data is a string

</pre>

=end html

=begin text

$ref is a Ref
$data is a Data
Ref is a string
Data is a string


=end text



=item Description



=back

=cut

sub get_data
{
    my $self = shift;
    my($ref) = @_;

    my @_bad_arguments;
    (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument \"ref\" (value was \"$ref\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to get_data:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'get_data');
    }

    my $ctx = $Bio::KBase::fbaModel::Data::Service::CallContext;
    my($data);
    #BEGIN get_data
    my $hash = $self->store()->get_data($ref);
    $data    = encode_json($hash);
    #END get_data
    my @_bad_returns;
    (!ref($data)) or push(@_bad_returns, "Invalid type for return variable \"data\" (value was \"$data\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to get_data:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'get_data');
    }
    return($data);
}




=head2 save_data

  $success = $obj->save_data($ref, $data, $config)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a Ref
$data is a Data
$config is a SaveConf
$success is a Bool
Ref is a string
Data is a string
SaveConf is a reference to a hash where the following keys are defined:
	is_merge has a value which is a Bool
	schema_update has a value which is a Bool
Bool is an int

</pre>

=end html

=begin text

$ref is a Ref
$data is a Data
$config is a SaveConf
$success is a Bool
Ref is a string
Data is a string
SaveConf is a reference to a hash where the following keys are defined:
	is_merge has a value which is a Bool
	schema_update has a value which is a Bool
Bool is an int


=end text



=item Description



=back

=cut

sub save_data
{
    my $self = shift;
    my($ref, $data, $config) = @_;

    my @_bad_arguments;
    (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument \"ref\" (value was \"$ref\")");
    (!ref($data)) or push(@_bad_arguments, "Invalid type for argument \"data\" (value was \"$data\")");
    (ref($config) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument \"config\" (value was \"$config\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to save_data:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'save_data');
    }

    my $ctx = $Bio::KBase::fbaModel::Data::Service::CallContext;
    my($success);
    #BEGIN save_data
    my $hash = decode_json $data;
    $success = $self->store()->save_data($ref, $hash, $config);
    #END save_data
    my @_bad_returns;
    (!ref($success)) or push(@_bad_returns, "Invalid type for return variable \"success\" (value was \"$success\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to save_data:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'save_data');
    }
    return($success);
}




=head2 get_aliases

  $aliases = $obj->get_aliases($query)

=over 4

=item Parameter and return types

=begin html

<pre>
$query is an Alias
$aliases is an Aliases
Alias is a reference to a hash where the following keys are defined:
	uuid has a value which is an UUID
	owner has a value which is a Username
	type has a value which is a string
	alias has a value which is a string
UUID is a string
Username is a string
Aliases is a reference to a list where each element is an Alias

</pre>

=end html

=begin text

$query is an Alias
$aliases is an Aliases
Alias is a reference to a hash where the following keys are defined:
	uuid has a value which is an UUID
	owner has a value which is a Username
	type has a value which is a string
	alias has a value which is a string
UUID is a string
Username is a string
Aliases is a reference to a list where each element is an Alias


=end text



=item Description



=back

=cut

sub get_aliases
{
    my $self = shift;
    my($query) = @_;

    my @_bad_arguments;
    (ref($query) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument \"query\" (value was \"$query\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to get_aliases:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'get_aliases');
    }

    my $ctx = $Bio::KBase::fbaModel::Data::Service::CallContext;
    my($aliases);
    #BEGIN get_aliases
    $aliases = $self->store()->get_aliases($query);
    #END get_aliases
    my @_bad_returns;
    (ref($aliases) eq 'ARRAY') or push(@_bad_returns, "Invalid type for return variable \"aliases\" (value was \"$aliases\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to get_aliases:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'get_aliases');
    }
    return($aliases);
}




=head2 update_alias

  $success = $obj->update_alias($ref, $uuid)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a Ref
$uuid is an UUID
$success is a Bool
Ref is a string
UUID is a string
Bool is an int

</pre>

=end html

=begin text

$ref is a Ref
$uuid is an UUID
$success is a Bool
Ref is a string
UUID is a string
Bool is an int


=end text



=item Description



=back

=cut

sub update_alias
{
    my $self = shift;
    my($ref, $uuid) = @_;

    my @_bad_arguments;
    (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument \"ref\" (value was \"$ref\")");
    (!ref($uuid)) or push(@_bad_arguments, "Invalid type for argument \"uuid\" (value was \"$uuid\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to update_alias:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'update_alias');
    }

    my $ctx = $Bio::KBase::fbaModel::Data::Service::CallContext;
    my($success);
    #BEGIN update_alias
    $success = $self->store()->update_alias($ref, $uuid);
    #END update_alias
    my @_bad_returns;
    (!ref($success)) or push(@_bad_returns, "Invalid type for return variable \"success\" (value was \"$success\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to update_alias:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'update_alias');
    }
    return($success);
}




=head2 add_viewer

  $success = $obj->add_viewer($ref, $viewer)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a Ref
$viewer is a Username
$success is a Bool
Ref is a string
Username is a string
Bool is an int

</pre>

=end html

=begin text

$ref is a Ref
$viewer is a Username
$success is a Bool
Ref is a string
Username is a string
Bool is an int


=end text



=item Description



=back

=cut

sub add_viewer
{
    my $self = shift;
    my($ref, $viewer) = @_;

    my @_bad_arguments;
    (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument \"ref\" (value was \"$ref\")");
    (!ref($viewer)) or push(@_bad_arguments, "Invalid type for argument \"viewer\" (value was \"$viewer\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to add_viewer:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'add_viewer');
    }

    my $ctx = $Bio::KBase::fbaModel::Data::Service::CallContext;
    my($success);
    #BEGIN add_viewer
    $success = $self->store()->add_viewer($ref, $viewer);
    #END add_viewer
    my @_bad_returns;
    (!ref($success)) or push(@_bad_returns, "Invalid type for return variable \"success\" (value was \"$success\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to add_viewer:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'add_viewer');
    }
    return($success);
}




=head2 remove_viewer

  $success = $obj->remove_viewer($ref, $viewer)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a Ref
$viewer is a Username
$success is a Bool
Ref is a string
Username is a string
Bool is an int

</pre>

=end html

=begin text

$ref is a Ref
$viewer is a Username
$success is a Bool
Ref is a string
Username is a string
Bool is an int


=end text



=item Description



=back

=cut

sub remove_viewer
{
    my $self = shift;
    my($ref, $viewer) = @_;

    my @_bad_arguments;
    (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument \"ref\" (value was \"$ref\")");
    (!ref($viewer)) or push(@_bad_arguments, "Invalid type for argument \"viewer\" (value was \"$viewer\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to remove_viewer:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'remove_viewer');
    }

    my $ctx = $Bio::KBase::fbaModel::Data::Service::CallContext;
    my($success);
    #BEGIN remove_viewer
    $success = $self->store()->remove_viewer($ref, $viewer);
    #END remove_viewer
    my @_bad_returns;
    (!ref($success)) or push(@_bad_returns, "Invalid type for return variable \"success\" (value was \"$success\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to remove_viewer:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'remove_viewer');
    }
    return($success);
}




=head2 set_public

  $success = $obj->set_public($ref, $public)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a Ref
$public is a Bool
$success is a Bool
Ref is a string
Bool is an int

</pre>

=end html

=begin text

$ref is a Ref
$public is a Bool
$success is a Bool
Ref is a string
Bool is an int


=end text



=item Description



=back

=cut

sub set_public
{
    my $self = shift;
    my($ref, $public) = @_;

    my @_bad_arguments;
    (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument \"ref\" (value was \"$ref\")");
    (!ref($public)) or push(@_bad_arguments, "Invalid type for argument \"public\" (value was \"$public\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to set_public:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'set_public');
    }

    my $ctx = $Bio::KBase::fbaModel::Data::Service::CallContext;
    my($success);
    #BEGIN set_public
    $success = $self->store()->set_public($ref, $public);
    #END set_public
    my @_bad_returns;
    (!ref($success)) or push(@_bad_returns, "Invalid type for return variable \"success\" (value was \"$success\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to set_public:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'set_public');
    }
    return($success);
}




=head2 alias_owner

  $owner = $obj->alias_owner($ref)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a Ref
$owner is a Username
Ref is a string
Username is a string

</pre>

=end html

=begin text

$ref is a Ref
$owner is a Username
Ref is a string
Username is a string


=end text



=item Description



=back

=cut

sub alias_owner
{
    my $self = shift;
    my($ref) = @_;

    my @_bad_arguments;
    (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument \"ref\" (value was \"$ref\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to alias_owner:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'alias_owner');
    }

    my $ctx = $Bio::KBase::fbaModel::Data::Service::CallContext;
    my($owner);
    #BEGIN alias_owner
    $owner = $self->store()->alias_owner($ref);
    #END alias_owner
    my @_bad_returns;
    (!ref($owner)) or push(@_bad_returns, "Invalid type for return variable \"owner\" (value was \"$owner\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to alias_owner:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'alias_owner');
    }
    return($owner);
}




=head2 alias_public

  $public = $obj->alias_public($ref)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a Ref
$public is a Bool
Ref is a string
Bool is an int

</pre>

=end html

=begin text

$ref is a Ref
$public is a Bool
Ref is a string
Bool is an int


=end text



=item Description



=back

=cut

sub alias_public
{
    my $self = shift;
    my($ref) = @_;

    my @_bad_arguments;
    (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument \"ref\" (value was \"$ref\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to alias_public:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'alias_public');
    }

    my $ctx = $Bio::KBase::fbaModel::Data::Service::CallContext;
    my($public);
    #BEGIN alias_public
    $public = $self->store()->alias_public($ref);
    #END alias_public
    my @_bad_returns;
    (!ref($public)) or push(@_bad_returns, "Invalid type for return variable \"public\" (value was \"$public\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to alias_public:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'alias_public');
    }
    return($public);
}




=head2 alias_viewers

  $viewers = $obj->alias_viewers($ref)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a Ref
$viewers is a Usernames
Ref is a string
Usernames is a reference to a list where each element is a Username
Username is a string

</pre>

=end html

=begin text

$ref is a Ref
$viewers is a Usernames
Ref is a string
Usernames is a reference to a list where each element is a Username
Username is a string


=end text



=item Description



=back

=cut

sub alias_viewers
{
    my $self = shift;
    my($ref) = @_;

    my @_bad_arguments;
    (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument \"ref\" (value was \"$ref\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to alias_viewers:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'alias_viewers');
    }

    my $ctx = $Bio::KBase::fbaModel::Data::Service::CallContext;
    my($viewers);
    #BEGIN alias_viewers
    $viewers = $self->store()->alias_viewers($ref);
    #END alias_viewers
    my @_bad_returns;
    (ref($viewers) eq 'ARRAY') or push(@_bad_returns, "Invalid type for return variable \"viewers\" (value was \"$viewers\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to alias_viewers:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'alias_viewers');
    }
    return($viewers);
}




=head2 ancestors

  $ancestors = $obj->ancestors($ref)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a Ref
$ancestors is an UUIDs
Ref is a string
UUIDs is a reference to a list where each element is an UUID
UUID is a string

</pre>

=end html

=begin text

$ref is a Ref
$ancestors is an UUIDs
Ref is a string
UUIDs is a reference to a list where each element is an UUID
UUID is a string


=end text



=item Description



=back

=cut

sub ancestors
{
    my $self = shift;
    my($ref) = @_;

    my @_bad_arguments;
    (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument \"ref\" (value was \"$ref\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to ancestors:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'ancestors');
    }

    my $ctx = $Bio::KBase::fbaModel::Data::Service::CallContext;
    my($ancestors);
    #BEGIN ancestors
    $ancestors = $self->store()->ancestors($ref);
    #END ancestors
    my @_bad_returns;
    (ref($ancestors) eq 'ARRAY') or push(@_bad_returns, "Invalid type for return variable \"ancestors\" (value was \"$ancestors\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to ancestors:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'ancestors');
    }
    return($ancestors);
}




=head2 ancestor_graph

  $graph = $obj->ancestor_graph($ref)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a Ref
$graph is an AncestorGraph
Ref is a string
AncestorGraph is a reference to a hash where the following keys are defined:
	object has a value which is an UUIDs
	objectParents has a value which is a reference to a list where each element is an UUIDs
UUIDs is a reference to a list where each element is an UUID
UUID is a string

</pre>

=end html

=begin text

$ref is a Ref
$graph is an AncestorGraph
Ref is a string
AncestorGraph is a reference to a hash where the following keys are defined:
	object has a value which is an UUIDs
	objectParents has a value which is a reference to a list where each element is an UUIDs
UUIDs is a reference to a list where each element is an UUID
UUID is a string


=end text



=item Description



=back

=cut

sub ancestor_graph
{
    my $self = shift;
    my($ref) = @_;

    my @_bad_arguments;
    (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument \"ref\" (value was \"$ref\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to ancestor_graph:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'ancestor_graph');
    }

    my $ctx = $Bio::KBase::fbaModel::Data::Service::CallContext;
    my($graph);
    #BEGIN ancestor_graph
    $graph = $self->store()->ancestor_graph($ref);
    #END ancestor_graph
    my @_bad_returns;
    (ref($graph) eq 'HASH') or push(@_bad_returns, "Invalid type for return variable \"graph\" (value was \"$graph\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to ancestor_graph:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'ancestor_graph');
    }
    return($graph);
}




=head2 descendants

  $descendants = $obj->descendants($ref)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a Ref
$descendants is an UUIDs
Ref is a string
UUIDs is a reference to a list where each element is an UUID
UUID is a string

</pre>

=end html

=begin text

$ref is a Ref
$descendants is an UUIDs
Ref is a string
UUIDs is a reference to a list where each element is an UUID
UUID is a string


=end text



=item Description



=back

=cut

sub descendants
{
    my $self = shift;
    my($ref) = @_;

    my @_bad_arguments;
    (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument \"ref\" (value was \"$ref\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to descendants:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'descendants');
    }

    my $ctx = $Bio::KBase::fbaModel::Data::Service::CallContext;
    my($descendants);
    #BEGIN descendants
    $descendants = $self->store()->descendants($ref);
    #END descendants
    my @_bad_returns;
    (ref($descendants) eq 'ARRAY') or push(@_bad_returns, "Invalid type for return variable \"descendants\" (value was \"$descendants\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to descendants:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'descendants');
    }
    return($descendants);
}




=head2 descendant_graph

  $graph = $obj->descendant_graph($ref)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a Ref
$graph is a DescendantGraph
Ref is a string
DescendantGraph is a reference to a hash where the following keys are defined:
	object has a value which is an UUIDs
	objectChildren has a value which is a reference to a list where each element is an UUIDs
UUIDs is a reference to a list where each element is an UUID
UUID is a string

</pre>

=end html

=begin text

$ref is a Ref
$graph is a DescendantGraph
Ref is a string
DescendantGraph is a reference to a hash where the following keys are defined:
	object has a value which is an UUIDs
	objectChildren has a value which is a reference to a list where each element is an UUIDs
UUIDs is a reference to a list where each element is an UUID
UUID is a string


=end text



=item Description



=back

=cut

sub descendant_graph
{
    my $self = shift;
    my($ref) = @_;

    my @_bad_arguments;
    (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument \"ref\" (value was \"$ref\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to descendant_graph:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'descendant_graph');
    }

    my $ctx = $Bio::KBase::fbaModel::Data::Service::CallContext;
    my($graph);
    #BEGIN descendant_graph
    $graph = $self->store()->descendant_graph($ref);
    #END descendant_graph
    my @_bad_returns;
    (ref($graph) eq 'HASH') or push(@_bad_returns, "Invalid type for return variable \"graph\" (value was \"$graph\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to descendant_graph:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'descendant_graph');
    }
    return($graph);
}




=head2 init_database

  $success = $obj->init_database()

=over 4

=item Parameter and return types

=begin html

<pre>
$success is a Bool
Bool is an int

</pre>

=end html

=begin text

$success is a Bool
Bool is an int


=end text



=item Description



=back

=cut

sub init_database
{
    my $self = shift;

    my $ctx = $Bio::KBase::fbaModel::Data::Service::CallContext;
    my($success);
    #BEGIN init_database
    # Do nothing for this as it is unathenticated
    # But return success because it really doesn't matter
    $success = 1;
    #END init_database
    my @_bad_returns;
    (!ref($success)) or push(@_bad_returns, "Invalid type for return variable \"success\" (value was \"$success\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to init_database:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'init_database');
    }
    return($success);
}




=head2 delete_database

  $success = $obj->delete_database($config)

=over 4

=item Parameter and return types

=begin html

<pre>
$config is a DeleteConf
$success is a Bool
DeleteConf is a reference to a hash where the following keys are defined:
	keep_data has a value which is a Bool
Bool is an int

</pre>

=end html

=begin text

$config is a DeleteConf
$success is a Bool
DeleteConf is a reference to a hash where the following keys are defined:
	keep_data has a value which is a Bool
Bool is an int


=end text



=item Description



=back

=cut

sub delete_database
{
    my $self = shift;
    my($config) = @_;

    my @_bad_arguments;
    (ref($config) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument \"config\" (value was \"$config\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to delete_database:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'delete_database');
    }

    my $ctx = $Bio::KBase::fbaModel::Data::Service::CallContext;
    my($success);
    #BEGIN delete_database
    # Do nothing for this call, as it is not authenticated
    $success = 0;
    #END delete_database
    my @_bad_returns;
    (!ref($success)) or push(@_bad_returns, "Invalid type for return variable \"success\" (value was \"$success\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to delete_database:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'delete_database');
    }
    return($success);
}




=head2 version 

  $return = $obj->version()

=over 4

=item Parameter and return types

=begin html

<pre>
$return is a string
</pre>

=end html

=begin text

$return is a string

=end text

=item Description

Return the module version. This is a Semantic Versioning number.

=back

=cut

sub version {
    return $VERSION;
}

=head1 TYPES



=head2 Bool

=over 4



=item Definition

=begin html

<pre>
an int
</pre>

=end html

=begin text

an int

=end text

=back



=head2 Ref

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 Username

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 UUID

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 Data

=over 4



=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 UUIDs

=over 4



=item Definition

=begin html

<pre>
a reference to a list where each element is an UUID
</pre>

=end html

=begin text

a reference to a list where each element is an UUID

=end text

=back



=head2 Usernames

=over 4



=item Definition

=begin html

<pre>
a reference to a list where each element is a Username
</pre>

=end html

=begin text

a reference to a list where each element is a Username

=end text

=back



=head2 Alias

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
uuid has a value which is an UUID
owner has a value which is a Username
type has a value which is a string
alias has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
uuid has a value which is an UUID
owner has a value which is a Username
type has a value which is a string
alias has a value which is a string


=end text

=back



=head2 Aliases

=over 4



=item Definition

=begin html

<pre>
a reference to a list where each element is an Alias
</pre>

=end html

=begin text

a reference to a list where each element is an Alias

=end text

=back



=head2 AncestorGraph

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
object has a value which is an UUIDs
objectParents has a value which is a reference to a list where each element is an UUIDs

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
object has a value which is an UUIDs
objectParents has a value which is a reference to a list where each element is an UUIDs


=end text

=back



=head2 DescendantGraph

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
object has a value which is an UUIDs
objectChildren has a value which is a reference to a list where each element is an UUIDs

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
object has a value which is an UUIDs
objectChildren has a value which is a reference to a list where each element is an UUIDs


=end text

=back



=head2 SaveConf

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
is_merge has a value which is a Bool
schema_update has a value which is a Bool

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
is_merge has a value which is a Bool
schema_update has a value which is a Bool


=end text

=back



=head2 DeleteConf

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
keep_data has a value which is a Bool

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
keep_data has a value which is a Bool


=end text

=back



=cut

1;
