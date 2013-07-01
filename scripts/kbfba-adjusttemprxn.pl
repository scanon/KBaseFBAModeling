#!/usr/bin/env perl
########################################################################
# Authors: Christopher Henry, Scott Devoid, Paul Frybarger
# Contact email: chenry@mcs.anl.gov
# Development location: Mathematics and Computer Science Division, Argonne National Lab
########################################################################
use strict;
use warnings;
use Bio::KBase::workspaceService::Helpers qw(auth get_ws_client workspace workspaceURL parseObjectMeta parseWorkspaceMeta printObjectMeta);
use Bio::KBase::fbaModelServices::Helpers qw(get_fba_client runFBACommand universalFBAScriptCode );
#Defining globals describing behavior
my $primaryArgs = ["Template ID","Reaction ID"];
my $servercommand = "adjust_template_reaction";
my $script = "kbfba-adjusttemprxn";
my $translation = {
	"Template ID" => "templateModel",
	"Reaction ID" => "reaction",
	workspace => "workspace",
	compartment => "compartment",
	direction => "direction",
	type => "type",
	"new" => "new",
	"delete" => "delete",
	auth => "auth",
	clearComplexes => "clearComplexes"
};
#Defining usage and options
my $specs = [
    [ 'compartment|c=s', 'Compartment of template reaction', { "default" => "c" } ],
    [ 'direction=s', 'Direction of template reaction' ],
    [ 'type=s', 'Type of template reaction' ],
    [ 'new', 'Create new biomass reaction' ],
    [ 'delete', 'Delete specified biomass reaction' ],
    [ 'clearComplexes', 'Clear all complexes mapped to reaction' ],
    [ 'complexesToAdd=s@', 'Complexes to add to reaction (; delimited)' ],
    [ 'complexesToRemove=s@', 'Complexes to remove from reaction (; delimited)' ],
    [ 'workspace|w=s', 'Workspace to save FBA results', { "default" => workspace() } ],
];
my ($opt,$params) = universalFBAScriptCode($specs,$script,$primaryArgs,$translation);
if (defined($opt->{complexesToAdd})) {
	foreach my $cpx (@{$opt->{complexesToAdd}}) {
		push(@{$params->{complexesToAdd}},split(/;/,$cpx));
	}
}
if (defined($opt->{complexesToRemove})) {
	foreach my $cpx (@{$opt->{complexesToRemove}}) {
		push(@{$params->{complexesToRemove}},split(/;/,$cpx));
	}
}
#Calling the server
my $output = runFBACommand($params,$servercommand,$opt);
#Checking output and report results
if (!defined($output)) {
	print "Adjustment of template reaction failed!\n";
} else {
	print "Adjustment of template reaction successful:\n";
}