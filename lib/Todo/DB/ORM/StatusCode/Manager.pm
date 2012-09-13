package Todo::DB::ORM::StatusCode::Manager;

use strict;

use base qw(Rose::DB::Object::Manager);

use Todo::DB::ORM::StatusCode;

sub object_class { 'Todo::DB::ORM::StatusCode' }

__PACKAGE__->make_manager_methods('status_code');

1;

