package Todo::DB::ORM::StatusCode;

use strict;

use base qw(Todo::DB::ORM::DB::Object::AutoBase1);

__PACKAGE__->meta->setup(
    table   => 'status_code',

    columns => [
        id          => { type => 'integer' },
        name        => { type => 'varchar', length => 25 },
        description => { type => 'varchar', length => 200 },
    ],

    primary_key_columns => [ 'id' ],

    unique_key => [ 'name' ],

    relationships => [
        tasks => {
            class      => 'Todo::DB::ORM::Task',
            column_map => { id => 'status_id' },
            type       => 'one to many',
        },
    ],
);

1;

