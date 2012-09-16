package Todo::DB;

use Rose::DB;
our @ISA = qw(Rose::DB);

Todo::DB->register_db(
    domain   => 'development',
    type     => 'main',
    driver   => 'sqlite',
    database => 'db/todo',
);

Rose::DB->default_domain('development');
Rose::DB->default_type('main');

1;
