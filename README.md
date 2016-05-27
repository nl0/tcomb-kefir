# tcomb-kefir

[tcomb](https://github.com/gcanti/tcomb) type definitions and combinators for
[kefir](https://github.com/rpominov/kefir) frp library.


## Installation

```shell
npm install nl0/tcomb-kefir
```

## Usage

```coffeescript
T = require 'tcomb-kefir'
K = require 'kefir'

User = T.struct
  name: T.String
  email: T.String
, 'User'

Selector = T.func [User], T.Any, 'Selector'

select = T.func [T.obs(User), Selector], T.prop(T.Any), 'select'
.of (obs, selector) ->
  obs.map(selector).skipDuplicates().toProperty()

userProp = K.constant User name: 'nl0', email: 'nl0@example.com'
nameProp = select uProp, ({name}) -> name
```

## API

The following types

* `Observable`
* `Stream`
* `Property`

and combinators

* `observable(type)` (aliased as `obs`)
* `stream(type)`
* `property(type)` (aliased as `prop`)

have been added to the `tcomb` namespace.
