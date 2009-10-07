package DBIx::Skinny::Schema::Loader::DBI::Pg;
use strict;
use warnings;

use base qw/DBIx::Skinny::Schema::Loader::DBI/;

sub tables {
    my $self   = shift;
    my $quoter = $self->quoter || q{"};
    my $dbh    = $self->{ dbh };

    my @tables = ( $DBD::Pg::VERSION >= 1.31 )
        ? $dbh->tables( undef, "public", "",
                        "table", { noprefix => 1, pg_noprefix => 1 } )
        : $dbh->tables;
    s/\Q$quoter\E//g for @tables;

    return [ sort @tables ];
}

1;
