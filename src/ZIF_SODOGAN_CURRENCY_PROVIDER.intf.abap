interface ZIF_SODOGAN_CURRENCY_PROVIDER
  public .

  "! <p class="shorttext synchronized" lang="en"></p>
  "!
  "! @parameter from | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter to | <p class="shorttext synchronized" lang="en"></p>
  "! @parameter result | <p class="shorttext synchronized" lang="en"></p>
  methods convert_currency importing from type string
                                    to type string
                                     value         type numeric
                            returning value(result) type decfloat16
                               raising cx_invalid_format.

endinterface.