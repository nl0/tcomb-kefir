T = require 'tcomb'
K = require 'kefir'


mkComb = (name) ->
  kind = name.toLowerCase()
  Class = K[name]
  Type = T.irreducible name, (o) -> o instanceof Class

  comb = T.func([T.Type], T.Type, kind).of (type) ->
    class WrappedType
      @meta: {kind, type}
      @is: (x) -> Type.is(x) and x.type == type
      constructor: (x) -> return Type(x).map type

  {Type, comb}


for name in ['Observable', 'Stream', 'Property']
  {Type, comb} = mkComb name
  T[name] = Type
  T[name.toLowerCase()] = comb

T.obs = T.observable
T.prop = T.property


module.exports = T
