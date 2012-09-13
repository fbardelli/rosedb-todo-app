package Todo::DB::ORM::DB::Object::AutoBase1;

use base 'Rose::DB::Object';

use Todo::DB;

sub init_db { Todo::DB->new() }

1;
