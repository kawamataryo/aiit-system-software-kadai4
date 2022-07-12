Describe 'greatest_common_divisor.sh'
  Describe 'calculate g.c.d'
    Parameters
      32 12 4
      12 32 4
      6 2 2
      120 60 60
      230 15 5
      120 32 8
      7 2 1
    End
    Example "should return g.c.d of $1 and $2"
      When call ./greatest_common_divisor.sh "$1" "$2"
      The output should equal "$3"
      The status should be success
    End
  End

  Describe 'exception handling'
    Parameters
      "-10" 20
      20 "-10"
      "a" "b"
      1
      1 2.1
      2.111 2
    End
    Example "should return error of $1 and $2"
      When call ./greatest_common_divisor.sh "$1" "$2"
      The error should include "Error:"
      The status should be failure
    End
  End
End