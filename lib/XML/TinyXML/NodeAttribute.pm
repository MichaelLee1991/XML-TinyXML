# -*- tab-width: 4 -*-
# ex: set tabstop=4:

=head1 NAME

XML::TinyXML::Node - Tinyxml Node object

=head1 SYNOPSIS

=over 4

  use XML::TinyXML::Node;

  $node = XML::TinyXML::Node->new("child", "somevalue", { attribute => "value" });

  $attr = $node->getAttribute("attribute");
  or
  $attr = $node->getAttribute(1); # attribute at index 1
  or
  @attrs = $node->getAttributes(); # returns all attributes in the node
  
=back

=head1 DESCRIPTION

Node representation for the TinyXML API

=head1 INSTANCE VARIABLES

=over 4

=item * _node

Reference to the underlying XmlNodeAttributePtr object (which is a binding to the XmlNode C structure)

=back

=head1 METHODS

=over 4

=cut

package XML::TinyXML::NodeAttribute;
 
use strict;

sub new {
    my ($class, $attr) = @_;
    return undef unless(UNIVERSAL::isa($attr, "XmlNodeAttributePtr"));
    my $self = bless({ _attr => $attr }, $class);
    # XXX - get  rid of this dirty hack done for retro-compatibility
    $self->{$attr->name} = $attr->value;
    return $self;
}

sub name {
    my ($self, $newName) = @_;
    my $name = $self->{_attr}->name;
    if ($newName) {
        $self->{_attr}->name($newName);
    }
    return $name;
}

sub value {
    my ($self, $newValue) = @_;
    my $value = $self->{_attr}->value;
    if ($newValue) {
        $self->{_attr}->value($newValue);
    }
    return $value;
}

1;