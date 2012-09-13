package Todo::DB::ORM::Task;

use strict;

use base qw(Todo::DB::ORM::DB::Object::AutoBase1);

__PACKAGE__->meta->setup(
    table   => 'tasks',

    columns => [
        id                => { type => 'integer' },
        short_description => { type => 'varchar', length => 100 },
        long_description  => { type => 'text' },
        start_date        => { type => 'datetime' },
        end_date          => { type => 'datetime' },
        status_id         => { type => 'integer' },
    ],

    primary_key_columns => [ 'id' ],

    foreign_keys => [
        status => {
            class       => 'Todo::DB::ORM::StatusCode',
            key_columns => { status_id => 'id' },
        },
    ],
);

1;

