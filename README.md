# Redmine New User Activation plugin (work in progress)

#### Plugin which adds future activation date and pending status in model User in order to verify on daily basis if any accounts should be activated.

## Requirements

Developed and tested on Redmine 3.0.3.

## Installation

1. Go to your Redmine installation's plugins/directory.
2. `git clone https://github.com/efigence/redmine_new_user_activation`
3. Go back to root directory.
4. `rake redmine:plugins:migrate RAILS_ENV=production`
5. Restart Redmine.

## Usage

* Admin defines activation date for a user
* `sidekiq` worker scheduled by `clockwork` checks if there are any pending users with current activation date
* If there are, worker changes their status to STATUS_ACTIVE


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
