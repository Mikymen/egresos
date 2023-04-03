$(function() {
    function AppViewModel() {
        self=this;
        self.seccion=ko.observable('inicio'); 
        
        self.perfil=perfil;
        self.idConceptoSelecc=ko.observable(0);
        self.conceptoSeleccionado=ko.observable();
        self.conceptoResumenSeleccionado=ko.observable();
        self.conceptoResumenGastoSelec=ko.observable('');
        self.lista_lineas=ko.observable(typeof lista_lineas == "undefined" ? null : lista_lineas);
        //CORREGIR OBJETO QUE DEVUELVE LISTA AGRUPADA POR PERFIL Y PRORRATEO
        self.listaLineas=ko.computed(function(){
            var salida=[];
            var grupos=[];
            var nombreperfil="";
            descripcion="";
            $.each(self.lista_lineas(), function(index,item){
                if(item.nombreperfil!= nombreperfil){
                    nombreperfil=item.nombreperfil;
                    var obj=[];
                    $.each(self.lista_lineas(), function(i,it){
                        if(it.nombreperfil==nombreperfil){
                            obj.push({nombre: it.nombre, porcentaje: it.porcentaje, idProrrateo: it.idProrrateo});                            
                        }
                    });
                    grupos.push({nombreperfil:nombreperfil, idPerfilProrrateo:item.idPerfilProrrateo, descripcion:item.descripcion, color:item.color, prorrateos:obj });
                    
                }
            });
            return grupos;
        });
        self.GuardarProrrateos=function(){
            $.post("InicioController/GuardarProrrateos" , {prorrateos:self.listaLineas()}, function(index,item){

            });
        }

        self.paginacionResumenGastos={
            pagInicial:1,
            tamPag:10,
            total:0
        }
        self.opcionSeleccionado=ko.observable();
        self.grupoSeleccionado=ko.observable(0);
        self.resumen=ko.observable([]);
        self.conceptosRaw= ko.observable(typeof conceptos=="undefined"?null:conceptos);  
        self.lista_grupos=ko.observable();
        self.lista_conceptos=ko.computed(function(){
            var aux=0;
            var arr=[];
            $.each(self.conceptosRaw(), function(i,item){
                if(aux!=item.idConcepto){
                    arr.push({idConcepto:item.idConcepto, nombre:item.nombre});
                }
                aux=item.idConcepto;
            });
            return arr;
        });
        self.lista_todas_opciones= ko.observable(lista_todas_opciones);
        self.lista_solo_opciones=ko.computed(function(){
            var lista=[];
            $.each(self.lista_todas_opciones(),function(i,item){
                if(item.tipo!=1){
                    lista.push(item);
                }
            });
            return lista;
        });
        self.lista_solo_personas=ko.computed(function(){
            var lista=[];
            $.each(self.lista_todas_opciones(),function(i,item){
                if(item.tipo==1){
                    lista.push(item);
                }
            });
            return lista;
        });
        self.lista_opciones=ko.computed(function(){
            var lista_opciones=[];
            var lista_grupos=[];
            var aux=0;
            $.each(self.conceptosRaw(), function(i,item){
                if(item.idGrupo==null || item.idGrupo==0){
                    if(self.conceptoSeleccionado()==item.idConcepto && item.idOpcion!=null){
                        lista_opciones.push({idOpcion:item.idOpcion, nombreopcion:item.nombreopcion});
                    }
                }else{
                    if(self.conceptoSeleccionado()==item.idConcepto && item.idGrupo!=null){
                        if(aux!=item.idGrupo){
                        lista_grupos.push({idGrupo:item.idGrupo, nombregrupo:item.nombregrupo});
                        }
                        aux=item.idGrupo;
                    }
                    if(self.conceptoSeleccionado()==item.idConcepto && self.grupoSeleccionado()==item.idGrupo){
                        lista_opciones.push({idOpcion:item.idOpcion, nombreopcion:item.nombreopcion});
                    }
                }
                
                // if(self.conceptoSeleccionado()==item.idConcepto && self.grupoSeleccionado()==item.idGrupo){
                //     lista_opciones.push(item);
                // }
            });
            self.lista_grupos(lista_grupos.length>0?lista_grupos :null);
            return lista_opciones.length>0? lista_opciones: null;
        });       
        
        self.onCarga = ko.observable(false);
        self.factura=ko.observable();
        self.monto=ko.observable("");
        self.detalle=ko.observable();
        self.Aviso=ko.observable({});
        self.AvisoOpcion=ko.observable({});
        self.detalleEgreso=ko.observable();
        self.seleccionados=ko.observableArray();
        self.fechaInicial=ko.observable();
        self.fechaFinal=ko.observable();
        self.egresoSeleccionado=ko.observable( {
            egreso:ko.observable({detalle:""}),
            EliminarEgreso:function(egreso){
                self.onCarga(true);
                $.post("InicioController/EliminarEgreso",{idGasto:egreso.idGasto},function(res){
                    if(res>0){
                        var fechaInicial=$('#fechaInicialRes').datepicker("getDate");
                        var fechaFinal=$('#fechaFinalRes').datepicker("getDate");
                        if(fechaInicial!=null && fechaFinal!=null){
                            self.CargarResumen(self.conceptoResumenGastoSelec(),self.paginacionResumenGastos.pagInicial,self.paginacionResumenGastos.tamPag, self.formatDate(fechaInicial),self.formatDate(fechaFinal));
                            $("#modal_eliminar_egreso").modal("hide");
                        }
                        self.IniciarPaginacionEgresos(1, 10);
                    }

                    self.onCarga(false);
                })
            }
        });
        self.SeleccionarEgreso=function(egreso){
            self.egresoSeleccionado().egreso(egreso);
            $("#modal_eliminar_egreso").modal("show");
        }
        // self.fechaInicialRes=ko.observable();
        // self.fechaFinalRes=ko.observable();
        self.listaresumengastoslinea=ko.observable([]);
        self.lista_asistentes=ko.observable(typeof lista_asistentes!="undefined"?lista_asistentes:null);
        self.asistenteSeleccionado=ko.observable();
        self.fecha=ko.observable(false);
        self.GetAsistente=function(id){
            var asistente=[];
            $.each(self.lista_asistentes(),function(i,item){
                if(item.idUsuario==id){
                    asistente={nombre:item.nombre,
                         idIsuario:item.idUsuario,
                        idRol:item.idRol};
                }
            })
            return asistente;
        };
             
        self.SetAviso=function(mensaje,codigo,egreso){
            var detEgreso;
            if(egreso!=null){
                
                $.each(self.egresos(),function(i,item){
                    if(item.fecha==egreso.fecha && item.idUsuario==egreso.idUsuario){
                        detEgreso= item;
                    }
                });
                //self.VerDetalleEgreso(detEgreso);
            }
           
            self.Aviso({
                codigo: codigo,
                clase: codigo==1?"bg-success text-succes":"bg-danger text-danger",
                texto: mensaje,
                modeloEgreso:detEgreso
            });
        };
        
        self.SetAvisoOpcion=function(mensaje,codigo){
            self.AvisoOpcion({
                codigo: codigo,
                clase: codigo==1?"bg-success text-succes":"bg-danger text-danger",
                texto: mensaje
            });
        };
        // self.CargaListaAsigConceptoProrrateo=function(){
        //     $.post("InicioController/CargaListaAsigConceptoProrrateo",{idConcepto:self.idConceptoSelecc()},function(data){

        //     });
        // }
        self.listaAsigConceptoProrrateo=ko.observable();
        self.GetlistaAsigConceptoProrrateo=ko.computed(function(){
            
            $.post("InicioController/CargaListaAsigConceptoProrrateo",{idConcepto:self.conceptoSeleccionado()},function(data){
                //self.listaAsigConceptoProrrateo( data);
                datos=[];
                $.each(data,function(index,item){
                    item.opSelect=ko.observable();
                    datos.push(item);
                });
                self.listaAsigConceptoProrrateo( datos);
            });
            
        });
        self.QuitarOpcion=function(modelo){
            console.log(modelo);
            $.post("InicioController/QuitarOpcion",{idConcepto:modelo.idConcepto, idOpcion:modelo.idOpcion, idGrupo:modelo.idGrupo},function(data){

            });
        }
        self.AgregarOpcion=function(modelo){
            console.log(modelo);
            $.post("InicioController/AgregarOpcion",{idConcepto:modelo.idConcepto, idOpcion:modelo.idOpcion, idGrupo:modelo.idGrupo},function(data){

            });
        }
        
        self.egresos=ko.observable();
        self.nuevaOpcion=ko.observable();
        self.inputopcion=ko.observable();
        self.AbrirModalOpcion=function(opcion, tipo, clase){
            if(opcion==null){
                opcion={nombre:""};
            }else{
                
            }
            //opcion.nombre=ko.observable(opcion.nombre);
            var titulo="";
            if(clase==1){
                switch(tipo){
                    case 1: titulo="Agregar persona"
                    break;
                    case 2: titulo="Editar"
                    break;
                    case 3: titulo="Eliminar"
                    break;
                }
            }else if(clase==2){
                switch(tipo){
                    case 1: titulo="Nueva opción"
                    break;
                    case 2: titulo="Editar opción"
                    break;
                    case 3: titulo="Eliminar opción"
                    break;
                }
            }
            
            opcion.titulo=titulo;
            opcion.tipo=tipo;
            opcion.clase=clase;
            self.nuevaOpcion(opcion);
            $("#modal_opcion").modal("show");
        }
        self.CrudOpcion=function(opcion){
            //opcion=self.nuevaOpcion();
            if(typeof opcion.idOpcion=="undefined"){
                opcion.idOpcion=0;
            }
            self.onCarga(true);
            $.post("InicioController/CrudOpcion", {
                idOpcion: opcion.idOpcion,
                tipo: opcion.tipo,
                clase: opcion.clase,
                nombre: opcion.nombre
            }, function(res){   
                self.onCarga(false); 
                if(res==-1){
                    self.SetAvisoOpcion("Ya existe una persona/opción con ese nombre", 0);
                }            
                if(res==0){
                    self.SetAvisoOpcion("No se pudo guardar la opción debido a un error interno del servidor", 0);
                }   
                if(res>0){
                    if(opcion.tipo==3){
                        self.SetAvisoOpcion("El registro se elimino correctamente", 1);
                    }else{
                        self.SetAvisoOpcion("El registro se guardo correctamente", 1);
                    }
                    
                    self.onCarga(true);
                    $.post("InicioController/ListaOpciones",{},function(data){
                        self.lista_todas_opciones(data);
                        self.onCarga(false);
                    })
                    
                }   
                
                
            },"json").fail(function(response){
                self.SetAvisoOpcion("Ocurrio un error al guardar, revise que la información enviada sea correcta", 0);
                self.onCarga(false);
            }); 
        }
        self.SeccionInicio=function(){            
            location.hash = "/home"
        }
        self.SeccionGastos=function(){
            location.hash = "/egresos"
        }
        self.SeccionNuevo=function(){
            location.hash = "/nuevo"
        }
        self.SeccionCuenta=function(){
            location.hash = "/cuenta"
        }
        self.SeccionReportes=function(){
            location.hash = "/reportes"
        }
        self.SeccionConfiguracion=function(){
            location.hash = "/configuracion"
        }
        self.SeccionResumen=function(){
            location.hash = "/resumen"
        }
        Sammy(function() {
            this.get('home', function() {
                self.seccion('inicio');
            });
            this.get('egresos', function() {
                self.seccion('egresos');
            });
            this.get('nuevo', function() {
                self.seccion('nuevo');
            });
            this.get('cuenta', function() {
                self.seccion('cuenta');
            });
            this.get('reportes', function() {
                self.seccion('reportes');
            });
            this.get('configuracion', function() {
                self.seccion('configuracion');
            });
            this.get('resumen', function() {
                self.seccion('resumen');
            });
            // this.get('', function() {
            //      this.app.runRoute('get', '#/home')
            // });
        }).run();

        self.GuardarEgreso=function(){
            if(typeof self.conceptoSeleccionado()=="undefined"){ 
                self.SetAviso("Debe seleccionar un concepto (*)",0);
                return false;
            }
            if(self.lista_grupos()!=null && typeof self.grupoSeleccionado()=="undefined"){
                self.SetAviso("Debe seleccionar un grupo (*)",0);
                return false;    
            }
            if(self.lista_opciones()!=null && typeof self.opcionSeleccionado()=="undefined"){
                self.SetAviso("Debe seleccionar una opción (*)",0);
                return false;    
            }
            if(self.monto().trim()==""){                
                self.SetAviso("Debe llenar el monto (*)",0);
                return false;
            }
            if(!self.monto().match(/^\d*[0-9]d{0,2}(\.\d{1,2})?$/)){
                self.SetAviso("El monto debe tener el formato como por ejemplo: 123.45",0);
                return false;
            }
            self.Aviso({});
            self.onCarga(true);
            $.post("InicioController/GuardarEgreso", {
                idConcepto:self.conceptoSeleccionado(),
                factura:self.factura(),
                monto:self.monto(),
                detalle:self.detalle(),
                idGrupo:self.grupoSeleccionado(),
                idOpcion:self.opcionSeleccionado()
            }, function(res){
                // if(res.Codigo==1){
                //     self.SetAviso("El registro fue guardado correctamente <button class='btn btn-sm btn-xs btn-danger' data-bind='click: VerDetalleEgreso'>Imprimir <span class='glyphicon glyphicon-print'></span></button>",1);
                // }
                
                self.IniciarPaginacionEgresos(1, 10, function(){
                    self.SetAviso(res.Respuesta, res.Codigo,res.Egreso);
                });
                
                //self.paginacionResumen(1, self.paginacionResumenGastos.total, self.paginacionResumenGastos.tamPag );
                var fechaInicial=$('#fechaInicialRes').datepicker("getDate");
                var fechaFinal=$('#fechaFinalRes').datepicker("getDate");
                if(fechaInicial!=null && fechaFinal!=null){
                    self.CargarResumen(self.conceptoResumenGastoSelec(),self.paginacionResumenGastos.pagInicial,self.paginacionResumenGastos.tamPag, self.formatDate(fechaInicial),self.formatDate(fechaFinal));
                }
                self.onCarga(false);
                self.grupoSeleccionado("");
                self.opcionSeleccionado("");
                self.monto("");
                self.factura("");
                self.detalle("");
                
            },"json").fail(function(response){
                self.SetAviso("Ocurrio un error al guardar, revise que la información enviada sea correcta", 0);
                self.onCarga(false);
            }); 
            
        }
        self.IniciarPaginacionEgresos=function(_pag, _tam, _callback=function(){}){
            self.onCarga(true);
            $.post("InicioController/GetListaEgresos", {npagina:_pag, tamPag:_tam}, function(allData){
                self.egresos(allData.res);
                self.PaginacionEgresos(allData.npagina,  allData.paginas, allData.tamPag);
                self.onCarga(false);
                _callback();
            },"json");
        };
        self.PaginacionEgresos=function(pagActual,paginas,tamPag){
            $("#btnPaginacionEgresos").pagination({
                items: paginas,
                itemsOnPage: tamPag,
                currentPage:pagActual,
                cssStyle: 'light-theme',
                onPageClick:function(pageNumber, event){
                    self.IniciarPaginacionEgresos(pageNumber, tamPag);
                },
                prevText:"Anterior",
                nextText:"Siguiente",

            });
        };
        self.IniciarPaginacionEgresos(1, 10);
        self.VerDetalleEgreso=function(egreso){
            self.onCarga(true);
            $.post("InicioController/GetEgresos", {fecha:egreso.fecha, idUsuario: egreso.idUsuario}, function(res){
                $("#modal_detalle_egreso").modal("show");
                // var egresos=$.map(res,function(item){
                //     return new Producto(item);
                // });
                self.seleccionados(res);
                egreso.detalle=self.seleccionados();
                
                self.detalleEgreso(egreso);                
                self.onCarga(false);
            },"json");
        };
        
        self.sumaTotal=ko.computed(function(){
            var suma = 0;
            $.each(self.seleccionados(),function (i, item){
                suma += parseFloat(item.montoTotal);
            }); 
            return suma.toFixed(2);
        });
        self.sumaResumenTotal=ko.computed(function(){
            var suma = 0;
            $.each(self.listaresumengastoslinea(),function (i, item){
                suma += parseFloat(item.total);
            }); 
            return suma.toFixed(2);
        });
        self.datosCuenta=ko.observable();
        self.CargarCuenta=function(){
            $.post("InicioController/GetCuenta", function(allData){
                allData.password="            ";
                self.datosCuenta(allData);
            },"json"); 
        }
        self.avisoCuenta=ko.observable(0);
        self.GuardarCuenta=function(){
            self.avisoCuenta(0);
            $.post("InicioController/GuardarCuenta", {datos:self.datosCuenta()}, function(res){
                self.avisoCuenta(res);
            },"json"); 
        };
        self.CargarCuenta();

        self.CargarResumen=function(_idConcepto, _npagina, _tamPag, _fechaInicial, _fechaFinal){
            self.onCarga(true);
            $.post("InicioController/GetResumenGastos",{idConcepto : _idConcepto,npagina : _npagina, tamPag : _tamPag, fechaInicial : _fechaInicial, fechaFinal : _fechaFinal}, function(allData){
                self.resumen(allData.res);
                self.paginacionResumenGastos.total=allData.paginas;
                self.paginacionResumen(allData.npagina,  allData.paginas, allData.tamPag);
                self.onCarga(false);
            },"json");
        }
        self.paginacionResumen=function(pagActual,paginas,tamPag){
            $("#btnPaginacionResumen").pagination({
                items: paginas,
                itemsOnPage: tamPag,
                currentPage:pagActual,
                cssStyle: 'light-theme',
                onPageClick:function(pageNumber, event){
                    //self.CargarResumen(pageNumber, tamPag);
                    var fechaInicial=$('#fechaInicialRes').datepicker("getDate");
                    var fechaFinal=$('#fechaFinalRes').datepicker("getDate");
                    if(fechaInicial!=null && fechaFinal!=null){
                        self.CargarResumen(self.conceptoResumenGastoSelec(), pageNumber, tamPag, self.formatDate(fechaInicial),self.formatDate(fechaFinal));
                    }
                },
                prevText:"Anterior",
                nextText:"Siguiente",
            });
        };
        // self.CargarResumenGastosLinea=function(idLinea, fechaInicial,fechaFinal){
        //     self.onCarga(true);
        //     $.post("InicioController/GetResumenGastosLinea", {idLinea, fechaInicial,fechaFinal}, function(allData){
        //         self.resumengastoslinea(allData.res);
        //         self.onCarga(false);
        //     },"json");
        // };
        self.PdfBoleta=function(){
            var doc = new jsPDF({
                unit: 'mm',
                format: [216, 279]
              }
            );
            
            // We'll make our own renderer to skip this editor
            var specialElementHandlers = {
                '#editor': function(element, renderer){
                    return true;
                },
                '.controls': function(element, renderer){
                    return true;
                }
            };

            // All units are in the set measurement for the document
            // This can be changed to "pt" (points), "mm" (Default), "cm", "in"
            // doc.fromHTML($('.modal-body').get(0), 15, 15, {
            //     'width': 170, 
            //     'elementHandlers': specialElementHandlers
            // });
            doc.setFontSize(14);
            doc.setFontType("bold");
            doc.text(105, 20, 'EGRESOS DIARIOS', null, null, 'center');
            doc.addImage(imgData, 'JPG', 20, 10, 30, 20);
            doc.setFontSize(12);
            doc.setFontType("normal");
            doc.text(20, 40, 'Declarado por: '+ self.detalleEgreso().nombreUsuario);
            doc.text(180, 40, 'No. '+ self.detalleEgreso().ncorrelativo);
            doc.text(20, 50, 'Fecha: '+ self.detalleEgreso().fecha);
            
            var columns = ["Fecha y hora", "Concepto", "Factura No.","Monto (Bs.)"];
            var rows = [];
            $.each(self.detalleEgreso().detalle,function(index,item){
                rows.push([item.fechacompleta, item.conceptoNombre, item.factura, item.montoTotal]);
            });
            rows.push(["TOTAL",'','',self.sumaTotal()+' Bs.']);
            doc.autoTable(columns, rows,{
                startY: 60, showHeader: 'firstPage'
            });
            doc.text("Firma", 14, doc.autoTable.previous.finalY + 20);            
            window.open(doc.output('bloburl'))
        }
        self.PdfResumenConsolidado=function(){
            var doc = new jsPDF({
                unit: 'mm',
                format: [216, 279]
              }
            );
            var rangoFechas="Todas las fechas";
            if(self.fecha()==false){
                if($("#fechainicial input").val()!="" && $("#fechaFinal input").val()!=""){
                    rangoFechas=$("#fechaInicial input").val()+' a '+$("#fechaFinal input").val();
                }
            }
            doc.setFontSize(14);
            doc.setFontType("bold");
            doc.text(105, 20, 'CONSOLIDADO DE GASTOS  MENSUAL', null, null, 'center');
            doc.addImage(imgData, 'JPG', 20, 10, 30, 20);
            doc.setFontSize(12);
            doc.setFontType("normal");
            doc.text(20, 40, 'Declarado por: '+ self.GetAsistente(self.asistenteSeleccionado()).nombre);
            doc.text(20, 50, 'Fecha: '+ rangoFechas);
            
            var columns = ["Linea", "Monto"];
            var rows = [];
            $.each(self.listaresumengastoslinea(),function(index,item){
                rows.push([item.linea, item.total]);
            });
            rows.push(["TOTAL",self.sumaResumenTotal()+' Bs.']);
            doc.autoTable(columns, rows,{
                startY: 60, showHeader: 'firstPage'
            });          
            window.open(doc.output('bloburl'))
        }
        self.ImprimirResumenGastos=function(){
            var doc = new jsPDF({
                unit: 'mm',
                format: [216, 279]
              }
            );
            var _fechaInicial=$('#fechaInicialRes').datepicker("getDate");
            var _fechaFinal=$('#fechaFinalRes').datepicker("getDate");
            if(_fechaInicial!=null && _fechaFinal!=null ){
                self.onCarga(true);
                $.post("InicioController/GetResumenGastosNoLimit",{idConcepto : self.conceptoResumenGastoSelec(), fechaInicial : self.formatDate(_fechaInicial), fechaFinal : self.formatDate(_fechaFinal)}, function(allData){

                    var rangoFechas=$("#fechaInicialRes input").val()+' a '+$("#fechaFinalRes input").val();
                
                    doc.setFontSize(14);
                    doc.setFontType("bold");
                    doc.text(105, 20, 'RESUMEN DE GASTOS', null, null, 'center');
                    doc.addImage(imgData, 'JPG', 20, 10, 30, 20);
                    doc.setFontSize(12);
                    doc.setFontType("normal");
                    //doc.text(20, 40, 'Declarado por: '+ self.GetAsistente(self.asistenteSeleccionado()).nombre);
                    doc.text(20, 50, 'Fecha: '+ rangoFechas);
                    
                    var columns = ["Fecha", "Detalle","No. Factura","Monto (Bs.)","Observación"];
                    var suma=0;
                    var rows=[];
                    $.each(allData,function(index,item){
                        rows.push([item.fecha, item.detalle, item.factura, item.monto, item.observacion]);
                        suma+=parseFloat(item.monto);
                    });
                    rows.push(["TOTAL","","", suma.toFixed(2),""]);
                    doc.autoTable(columns, rows,{
                        startY: 60, showHeader: 'firstPage'
                    });          
                    window.open(doc.output('bloburl'))
                    
                    self.onCarga(false);
                },"json");
                
            }
            

            
            
        }

        $('#fechaInicial').datepicker({
            language:"es",
            autoclose:true,
            todayHighlight:true
        }).on("changeDate", function(e) {
            self.fechaInicial(self.formatDate(e.date));
        });
        $('#fechaFinal').datepicker({
            language:"es",
            autoclose:true,
            todayHighlight:true
        }).on("changeDate", function(e) {
            self.fechaFinal(self.formatDate(e.date));
        });
        $('#fechaInicialRes').datepicker({
            language:"es",
            autoclose:true,
            todayHighlight:true
        }).on("changeDate", function(e) {
            //self.fechaInicialRes(self.formatDate(e.date));
            var fechaFinal=$('#fechaFinalRes').datepicker("getDate");
            if(fechaFinal!=null){
                self.CargarResumen(self.conceptoResumenGastoSelec(), self.paginacionResumenGastos.pagInicial,self.paginacionResumenGastos.tamPag,self.formatDate(e.date), self.formatDate(fechaFinal));
            }
            
        });
        $('#fechaFinalRes').datepicker({
            language:"es",
            autoclose:true,
            todayHighlight:true
        }).on("changeDate", function(e) {
            //self.fechaFinalRes(self.formatDate(e.date));
            var fechaInicial=$('#fechaInicialRes').datepicker("getDate");
            if(fechaInicial!=null){
                self.CargarResumen(self.conceptoResumenGastoSelec(), self.paginacionResumenGastos.pagInicial,self.paginacionResumenGastos.tamPag, self.formatDate(fechaInicial),self.formatDate(e.date));
            }
        });
        
        self.formatDate= function(date) {
            var d = new Date(date),
                month = '' + (d.getMonth() + 1),
                day = '' + d.getDate(),
                year = d.getFullYear();
        
            if (month.length < 2) month = '0' + month;
            if (day.length < 2) day = '0' + day;
        
            return [year, month, day].join('-');
        }
        $('#fechaInicial').datepicker("setDate",Date());
        $('#fechaFinal').datepicker("setDate",Date());
        self.resumengastoslinea=ko.computed(function(){
            if(self.fecha()==true){
                self.fechaInicial(null);
                self.fechaFinal(null);
            }else{
                // if(self.fechaInicial()==null || self.fechaFinal()==null){
                //     return false;
                // }
                self.fechaInicial(self.formatDate($('#fechaInicial').datepicker("getDate")));
                self.fechaFinal(self.formatDate($('#fechaFinal').datepicker("getDate")));
            }
            self.onCarga(true);
            $.post("InicioController/GetResumenGastosLinea", {
                idConcepto: self.conceptoResumenSeleccionado(),
                fechaInicial: self.fechaInicial(),
                fechaFinal: self.fechaFinal()
            }, function(allData){
                self.listaresumengastoslinea( allData);
                self.onCarga(false);
            },"json");
        });   

        $('#fechaInicialRes').datepicker("setDate",Date());
        $('#fechaFinalRes').datepicker("setDate",Date());
        $("#conceptoResGas").on("change",function(e){
            var idConcepto= e.target.value;
            var fechaInicial=$('#fechaInicialRes').datepicker("getDate");
            var fechaFinal=$('#fechaFinalRes').datepicker("getDate");
            if(fechaInicial!=null && fechaFinal!=null){
                self.CargarResumen(idConcepto,self.paginacionResumenGastos.pagInicial,self.paginacionResumenGastos.tamPag, self.formatDate(fechaInicial),self.formatDate(fechaFinal));
            }
        })
        $('#modal_opcion').on('hidden.bs.modal', function (e) {
            self.AvisoOpcion({});
          })
        // self.fechaInicial($('#fechaFinal').datepicker("getDate"));
        // self.fechaFinal(Date());
        self.GenerarExcel=function(){
            // $.get( "InicioController/GenerarExcel",
            // {   idConcepto:self.conceptoResumenGastoSelec(),
            //     fechaInicial:$('#fechaInicialRes').datepicker("getDate"),
            //     fechaFinal:$('#fechaFinalRes').datepicker("getDate")
            // } ,
            //  function( data ) {
            //     $( ".result" ).html( data );
            //     alert( "Load was performed." );
            //   });
            window.open('InicioController/GenerarExcel?idConcepto='+self.conceptoResumenGastoSelec()+'&fechaInicial='+self.formatDate($('#fechaInicialRes').datepicker("getDate"))+'&fechaFinal='+self.formatDate($('#fechaFinalRes').datepicker("getDate"))+' ','_blank');
        }
    }
    ko.applyBindings(new AppViewModel()); 
});