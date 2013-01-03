pass_manager (put your name here if you want)
============

This app was created some time ago. Since then I've learnt something more about Ruby and Rails
and today I would do all the things in a bit different way.

Just messing around with Devise and ActiveRecord. User model is a try to force users to change
their passwords in specified number of days (yaml configuration file). Also, password must be different
from last 10 used and can't be trivial (it has to contain both big and small caps, special characters and digits).

Provided test case includes fixtures with digests of old passwords and unit tests for model.
