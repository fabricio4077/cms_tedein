// validates dateEnd > dateStart (dateEnd = element)
$.validator.addMethod("after", function(value, element, param) {
    var dateStart = $("[name="+param+"]").val();
    var dateEnd = element.value;

    if(trim(dateStart) == "" && trim(dateEnd) == "") {
	return true;
    } else if(trim(dateEnd) == "") {
	return true;
    }
    var b = (dateEnd>dateStart);
    //alert(dateStart+" "+dateEnd+"\n"+b);
    //alert("sfd");
    return b;
}, jQuery.format("La fecha debe ser posterior a {0}"));
//validates letters only
$.validator.addMethod("letters", function(value, element) {
    return this.optional(element) || /^[a-zA-ZñÑ áéíóúÁÉÍÚÓüÜ]+$/.test(value);
}, 'Ingrese solo letras o espacios');
//validates no special chars
$.validator.addMethod("noSpecial", function(value, element) {
    return this.optional(element) || /^[a-zA-Z0-9ñÑ .,áéíóúÁÉÍÚÓüÜ#_-]+$/.test(value);
}, 'Ingrese solo letras, n&uacute;meros, espacios, #, -, _');
$.validator.addMethod("telefono", function(value, element) {
    return this.optional(element) || /^[0-9]{2,3}-{1}[0-9]{6,7}$/.test(value);
}, 'Ingrese un n&uacute;mero de tel&eacute;fono v&aacute;lido');
$.validator.addMethod("requiredCmb", function(value, element) {
    var a = true;
    if(value == 'null' || value == null || value == "" || value == -1 || value == "-1")
	a = false;
    return a;
}, 'Seleccione una opci&oacute;n v&aacute;lida');
$.validator.addMethod("positive", function(value, element) {
    var a = true;
    if(value <= 0)
	a = false;
    return a;
}, 'Ingrese un valor positivo mayor que 0');
//validates cedula ecuador + o -
$.validator.addMethod("cedulaRuc", function(value, element) {
    var cedula = this.optional(element) || /^[0-2]{1}[0-9]{9}$/.test(value);
    var ruc =  this.optional(element) || /^[0-2]{1}[0-9]{9}001$/.test(value);
    var a = false;
    if(cedula || ruc) {
	a = true;
    }
    return a;
}, 'Ingrese un n&uacute;mero de c&eacute;dula o RUC v&aacute;lido');
$.validator.addMethod("cedula", function(value, element) {
    var cedula = this.optional(element) || /^[0-2]{1}[0-9]{9}$/.test(value);
    var a = false;
    if(cedula) {
	a = true;
    }
    return a;
}, 'Ingrese un n&uacute;mero de c&eacute;dula v&aacute;lido');
$.validator.addMethod("ruc", function(value, element) {
    var ruc =  this.optional(element) || /^[0-2]{1}[0-9]{9}001$/.test(value);
    var a = false;
    if(ruc) {
	a = true;
    }
    return a;
}, 'Ingrese un RUC v&aacute;lido');
// valida q la cuenta corresponda al padre seleccionado
$.validator.addMethod("cuentaPadre", function(value, element, param) {

    var cuenta = value;
    var padre = $(param).val();

    var lc = cuenta.length;
    var lp = padre.length + 1;

    var lvl = $(param+" option:selected").attr("class");

    var parts = lvl.split(":");
    parts = parts[0].split("_");

    lvl = parts[1];

    var nivel = $(element).attr("nivel");

    nivel = $(nivel).val();

    var a = cuenta.startsWith(padre);
    var b = lc >= lp;
    var c = nivel == (lvl*1+1);

    if(padre == null || padre == "" || padre == "null") {
	a = true;
	b = true;
	if(nivel == 1 && lc == 1) {
	    c = true;
	} else {
	    c = false;
	}
    }

    //alert("cuenta: "+cuenta+" || padre: "+padre+" || lvl(padre): "+lvl+" || nivel(selected): "+nivel+"\na: "+a+"\nb: "+b+"\nc: "+c);

    return (a && b && c);
}, jQuery.format("La cuenta no corresponde al padre"));

$.validator.addMethod("equalToEdit", function(value, element, param) {

    var val = $(param).val();

    if(trim(val) != "" && trim(val) == trim(value)) {
	return true;
    } else if(trim(val) == "") {
	return true;
    } else {
	return false;
    }

}, 'No puede cambiar este valor.');