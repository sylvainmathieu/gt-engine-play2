*{ 
	_arg:	(optional) fieldname to filter errors, if not specified all 
errors are returned 
	_field:	(optional) fieldname to filter errors, if not specified all 
errors are returned 
}* 

%{ 
        _field = _arg ?: _field 
        if (! _field) { 
                validations = _form.errors()
        } else { 
                validations = _form.errors(_field)
        } 
        size = validations.size()
        attrsList = [];
        validations.eachWithIndex() { item, i -> 
                attrs = [:] 
                attrs.put('error', item.getValue().get(0).message())
                attrs.put('error_index', i+1) 
                attrs.put('error_isLast', (i+1) == size) 
                attrs.put('error_isFirst', i==0) 
                attrs.put('error_parity', (i+1)%2==0?'even':'odd')
                attrsList.add(attrs)
        }
}%

    #{list items:attrsList, as: 'attrs'}
        #{doBody vars:attrs /}
    #{/list}
