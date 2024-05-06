class logger:

    def instanceEmptyAssertLog( instance ):
        raise AssertionError( instance + ' is Empty')

    def variableNoneAssertLog( variable ):
        raise AssertionError( variable + ' is None')

