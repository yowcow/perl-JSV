package JSV::Keyword::MultipleOf;

use strict;
use warnings;
use parent qw(JSV::Keyword);

sub keyword { "multipleOf" }

sub validate {
    my ($class, $validator, $schema, $instance, $opts) = @_;
    return 1 unless $class->has_keyword($schema);

    $opts         ||= {};
    $class->initialize_args($schema, $instance, $opts);

    unless ($opts->{type} eq "number" || $opts->{type} eq "integer") {
        return 1;
    }

    my $keyword_value = $class->keyword_value($schema);
    my $result = $instance / $keyword_value;

    if ($result - int($result) == 0) {
        return 1;
    }
    else {
        JSV::Exception->throw(
            "The instance doesn't multiple of schema value",
            $opts,
        );
    }
}

1;
