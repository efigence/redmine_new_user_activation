# Redmine New User Activation plugin [![Build Status](https://travis-ci.org/efigence/redmine_new_user_activation.svg?branch=master)](https://travis-ci.org/efigence/redmine_new_user_activation)

#### Plugin which adds future activation date and pending status in model User in order to verify on daily basis if any accounts should be activated.
#### Version 0.0.2 adds a new feature: configurable user activation email.

## Requirements

Developed and tested on Redmine 3.0.3.

## Installation

1. Go to your Redmine installation's plugins/directory.
2. `git clone https://github.com/efigence/redmine_new_user_activation`
3. Go back to root directory.
4. `rake redmine:plugins:migrate RAILS_ENV=production`
5. Restart Redmine.

## Usage

* Admin defines future activation date for a user, this user's status is set by default to STATUS_PENDING
* `sidekiq` worker (see Sidekiq section below) scheduled by `clockwork` (see Clockwork section below) checks if there are any pending users with current activation date
* If there are, worker changes their status to STATUS_ACTIVE
* Additionally admin may configure user activation email

## Configuration

* Admin defines email domains (such as 'efigence' for '...@efigence.com' emails) which users should receive extended activation email
* This extended activation email is configurable as well, e.g. it may include internal instructions which should be seen only by internal employees and not clients

## Sidekiq

To use this plugin you must install and configure `sidekiq` first. To use `sidekiq` with redmine you should use `redmine_sidekiq` plugin. You can add it to redmine by following the instructions provided on its github page: https://github.com/ogom/redmine_sidekiq

You can find more information about sidekiq [here](https://github.com/mperham/sidekiq).

## Clockwork

In `clockwork.rb` you can define how often should `sidekiq` be called to schedule locking accounts process. Default interval is set to 24 hours. You can read more about `clockwork` and its configuration [here](https://github.com/tomykaira/clockwork).


## License

    Redmine New User Activation plugin
    Copyright (C) 2015  efigence S.A.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
