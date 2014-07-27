App.Mixins.UnknownValues =
  maybeUnknown: (key, unknown) ->
    value = (@get key) ? ""

    if value.length is 0
      unknown ? "Unknown"
    else
      value
