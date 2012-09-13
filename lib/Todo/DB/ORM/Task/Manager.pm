package Todo::DB::ORM::Task::Manager;

use strict;

use base qw(Rose::DB::Object::Manager);

use Todo::DB::ORM::Task;

sub object_class { 'Todo::DB::ORM::Task' }

__PACKAGE__->make_manager_methods('tasks');

1;

