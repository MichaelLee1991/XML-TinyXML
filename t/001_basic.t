# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl TinyXML.t'

#########################

# change 'tests => 2' to 'tests => last_test_to_print';

use Test::More tests => 10;
BEGIN { use_ok('XML::TinyXML') };


my $fail = 0;
foreach my $constname (qw(
	XML_BADARGS XML_GENERIC_ERR XML_LINKLIST_ERR XML_MEMORY_ERR XML_NOERR
	XML_OPEN_FILE_ERR XML_PARSER_GENERIC_ERR XML_UPDATE_ERR XML_BAD_CHARS
        XML_NODETYPE_COMMENT XML_NODETYPE_SIMPLE XML_NODETYPE_CDATA)) {
  next if (eval "my \$a = $constname; 1");
  if ($@ =~ /^Your vendor has not defined XML::TinyXML macro $constname/) {
    print "# pass: $@";
  } else {
    print "# fail: $@";
    $fail = 1;
  }

}

ok( $fail == 0 , 'Constants' );
#########################

$txml = XML::TinyXML->new();
$txml->loadFile("./t/t.xml");
is($txml->countChildren('/xml/parent'), 3);
my $node;
ok ($node = $txml->getNode('/xml/parent'));
is($txml->countChildren($node), 3);
is($txml->countChildren($node->{_node}), 3);
$txml->addRootNode('xml2');
is($txml->countRootNodes, 2);
# test array context
my @array = $txml->rootNodes;
is(scalar(@array), 2);

# test scalar context
my $ref = $txml->rootNodes;
is(ref($ref), "ARRAY");
is(scalar(@$ref), 2);

$txml->removeRootNode(1);