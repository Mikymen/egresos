<nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
        <div class="navbar-brand">Sistema de Egresos Diarios</div> 
        <!-- <div class="navbar-brand">
            <img style="margin-top: -10px;" src="assets/img/pharmaquick.png" />
        </div>  -->

        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-5" aria-expanded="false">
            <span class="sr-only">Menu</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
    </div>
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-5"> 
        <ul class="nav navbar-nav" data-bind="if:perfil==2">
            <li >
            <a href="#" data-bind="click:SeccionInicio">Inicio</a>
            </li>
            <li >
            <a href="#" data-bind="click:SeccionGastos">Correlativo</a>
            </li>
            <li >
            <a href="#" data-bind="click:SeccionNuevo">Nuevo egreso</a>
            </li>
            <li >
            <a href="#" data-bind="click:SeccionResumen">Resumen de gastos</a>
            </li>
            </ul>
            </li>
        </ul>
        <ul class="nav navbar-nav" data-bind="if:perfil==1">
           
            <li >
            <a href="#" data-bind="click:SeccionGastos">Reporte</a>
            </li>
            <li >
            <a href="#" data-bind="click:SeccionReportes">Prorrateo</a>
            </li>
            <li >
            <a href="#" data-bind="click:SeccionResumen">Resumen de gastos</a>
            </li>
            <li >
            <a href="#" data-bind="click:SeccionConfiguracion">Configuración</a>
            </li>
            </ul>
            </li>
        </ul>

        <ul class="nav navbar-nav navbar-right">
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><?php echo $nombre ?> <span class="caret"></span></a>
            <ul class="dropdown-menu">
                <li><a href="#" data-bind="click:SeccionCuenta" >Mi cuenta</a></li>
            </ul>
            </li>
        <li><a href="<?php echo base_url() ?>AuthController/LogOut" class="navbar-link">Cerrar Sesión</a><li>       
        
        </ul> 
    </div>
  </div>
</nav>

<div class="container" data-bind="visible:seccion()=='inicio'">
    <h3 class="text-center" style="margin-top: 30pt;">Bienvenido <?php echo $nombre; ?>!</h3>
    <p class="text-center">Desde aquí podrá ver o crear gastos</p>
    <div class="row" style="margin-top: 30pt;">
        <div class="col-md-offset-3 col-md-6" data-bind="if:perfil==2, visible:perfil==2" style="display:none">
            <div class="col-md-6" style="margin-bottom:10px;">
                <button class="btn btn-lg btn-block" data-bind="click:SeccionGastos">Mis egresos</button>
            </div>
            <div class="col-md-6">
                <button class="btn btn-lg btn-block" data-bind="click:SeccionNuevo">Nuevo egreso</button>
            </div>
            <div class="col-md-12">
                <button class="btn btn-lg btn-block" data-bind="click:SeccionResumen">Resumen de gastos</button>
            </div>
        </div>
        <div class="col-md-offset-3 col-md-6" data-bind="if:perfil==1, visible:perfil==1" style="display:none">
            
            <div class="col-md-6" style="margin-bottom:10px;">
                <button class="btn btn-lg btn-block" data-bind="click:SeccionGastos">Reportes</button>
            </div>
            <div class="col-md-6" style="margin-bottom:10px;">
                <button class="btn btn-lg btn-block" data-bind="click:SeccionReportes">Prorrateos</button>
            </div>
            <div class="col-md-12">
                <button class="btn btn-lg btn-block" data-bind="click:SeccionResumen">Resumen de gastos</button>
            </div>
        </div>
    </div>
</div>

<div class="container" data-bind="visible:seccion()=='nuevo'">
    <div class="row">
        <h3 class="text-center">Nuevo registro de egreso</h3>
        
        <div class="col-md-offset-3 col-md-6">            
            <div class="form-group">
                <label for="concepto">Concepto *</label>
                <select data-bind="options: lista_conceptos, optionsText:'nombre', optionsValue:'idConcepto', optionsCaption:'Seleccione un concepto...', value:conceptoSeleccionado" class="form-control" id="concepto"><select>
            </div>

            <div class="form-group" data-bind="visible:lista_grupos()!=null">
                <label for="concepto">Grupo *</label>
                <select data-bind="options: lista_grupos, optionsText:'nombregrupo', optionsValue:'idGrupo', optionsCaption:'Seleccione una opcion...', value:grupoSeleccionado" class="form-control" id="grupo"><select>
            </div> 

            <div class="form-group" data-bind="visible:lista_opciones()!=null">
                <label for="concepto">Opción *</label>
                <select data-bind="options: lista_opciones, optionsText:'nombreopcion', optionsValue:'idOpcion', optionsCaption:'Seleccione una opcion...', value:opcionSeleccionado" class="form-control" id="opcion"><select>
            </div>            
            <div class="form-group col-md-6" style="padding:0px;">
                <label for="monto">Monto (Bs.) *</label>
                <input data-bind="value:monto" class="form-control" id="monto" style="max-width:250px;" />
            </div>
            <div class="form-group col-md-6" style="padding:0px;">
                <label for="factura">Factura</label>
                <input data-bind="value:factura" class="form-control" id="factura" style="max-width:250px;" />
            </div>
        
            
            
            <div class="form-group">
                <label for="glosa">Detalle</label>
                <textarea data-bind="value:detalle" class="form-control" rows="3" id="glosa"></textarea>
            </div>
            <p style="padding: 15px;" data-bind="css: Aviso().clase, visible: Aviso().texto!=null">
                <span data-bind="text:Aviso().texto"></span> 
                <button style="float:right" class="btn btn-sm btn-danger" data-bind="click:$root.VerDetalleEgreso.bind($data,Aviso().modeloEgreso), visible:Aviso().codigo==1">Ver correlativo <span class="glyphicon glyphicon-file"></span></button>
            </p>
            <div class="row text-center">
                <button class="btn btn-primary" type="button" data-bind="click:GuardarEgreso" >Guardar egreso</button>
            </div>
            <br>
            <sub><b>Nota:</b> se registrara el egreso con la fecha de hoy.</sub>
        </div>
    </div>
</div>

<div class="container" data-bind="visible: seccion()=='egresos'">
    <h3>Lista de egresos diarios</h3>
    <div class="table-responsive col-md-offset-1 col-md-10">
        <table  class="table table-striped" >
            <tr>
                <th>Fecha</th>
                <th>No. Correlativo</th>
                <th>Usuario</th>
                <th>No. registros</th>
                <th> </th>
            </tr>
            <!-- ko foreach:egresos -->
            <tr>
                <td data-bind="text:fecha"></td>
                <td data-bind="text:ncorrelativo"></td>
                <td data-bind="text:nombreUsuario"></td> 
                <td data-bind="text:registros"></td> 
                <td>
                    <button data-bind="click: $root.VerDetalleEgreso" type="button" class="btn btn-sm btn-primary">Detalles <span class="glyphicon glyphicon-eye-open"></span></button>
                </td>
            </tr>
            <!-- /ko -->
        </table>
        <div id="btnPaginacionEgresos"></div>
    </div>
</div>

<div class="container" data-bind="visible: seccion()=='reportes'">

<h3>Consolidado de gastos y Prorrateo</h3>
<div class="row">
    <div class="col-md-2">
    <h4 >
        <strong>Declarado por: </strong>
    </h4>
    </div>
    <div class="col-md-4">
        <select data-bind="options: lista_asistentes, optionsText:'nombre', optionsValue:'idUsuario', value:asistenteSeleccionado" class="form-control" ><select>
    </div>
</div>
   
    <div class="row">
        <div class="col-md-2">
            <h4>
            <strong>Concepto: </strong>
            </h4>
        </div>
        <div class="col-md-4">
            <select data-bind="options: lista_conceptos, optionsText:'nombre', optionsValue:'idConcepto', optionsCaption:'- TODOS -', value:conceptoResumenSeleccionado" class="form-control" id="concepto"><select>
        </div>
    </div>
    <div class="col-md-2">
        <h4>
        <strong>Fecha: </strong>
        </h4>
    </div>
    <div class="row">
        <div class="col-md-2" style="padding:15px 0px;">
            <label for="fechas">Todas las fechas </label>
            <input id="fechas" type="checkbox" value="fecha" data-bind="checked:fecha">
        </div>
    </div>
    <div class="row" data-bind="visible:fecha()==false">
        <div class="col-sm-offset-2 col-sm-4">
            <div class="form-group">
                <label for="fechaInicial">Fecha Inicial</label>
                <div class="input-group date" id="fechaInicial">
                    <input type="text" class="form-control">
                    <div class="input-group-addon">
                        <span class="glyphicon glyphicon-th"></span>
                    </div>
                </div>
            </div>
                
        </div>
        <div class="col-sm-4">
            <div class="form-group">
                <label for="fechaInicial">Fecha Final</label>
                <div class="input-group date" id="fechaFinal">
                    <input type="text" class="form-control">
                    <div class="input-group-addon">
                        <span class="glyphicon glyphicon-th"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-6 col-md-offset-3">
        <table class="table">
            <tr style="font-weight:bold">
                <td>Linea</td>
                <td>Monto (Bs.)</td>
            </tr>
            <!-- ko foreach:listaresumengastoslinea -->
            <tr>
                <td data-bind="text:linea"></td>
                <td data-bind="text:total"></td>
            </tr>
            <!-- /ko -->
            <tr style="font-weight:bold">
                <td>Total gastos</td>
                <td data-bind="text:sumaResumenTotal">0</td>
            </tr>
        </table>
    </div>
    <div class="col-md-12 text-center">
        <button type="button" class="btn btn-danger" data-bind="click:PdfResumenConsolidado" >Imprimir consolidado <span class="glyphicon glyphicon-print"></span></button>
    </div>
</div>

<div class="container" data-bind="visible: seccion()=='configuracion'">
    <div class="row">
        <div class=" col-md-offset-2 col-md-2">
            <h4>
                <strong>Configuración: </strong>
            </h4>
        </div>
        <!-- Nav tabs -->
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active"><a href="#mProrrateos" aria-controls="home" role="tab" data-toggle="tab">Prorrateos</a></li>
            <li role="presentation"><a href="#mOpciones" aria-controls="profile" role="tab" data-toggle="tab">Opciones</a></li>
            <li role="presentation"><a href="#mOpcionConcepto" aria-controls="messages" role="tab" data-toggle="tab">Opcion->Concepto</a></li>
            <li role="presentation"><a href="#opConcepto" aria-controls="settings" role="tab" data-toggle="tab">Conceptos</a></li>
        </ul>

        <!-- Tab panes -->
        <div class="tab-content col-md-offset-2 col-md-8">
            <div role="tabpanel" class="tab-pane active" id="mProrrateos">
                <h3>Edite el porcentaje de los grupos de prorrateo</h2>
                <!-- ko foreach:listaLineas -->
                <div class="panel panel-success col-md-12">
                <div class="panel-heading" data-bind="text:nombreperfil"></div>
                <div class="form-horizontal" style="padding-top:10pt;">
                
                    <!-- ko foreach:prorrateos -->
                    <div class="form-group">
                        <label class="col-sm-4 control-label" data-bind="text:nombre +':'"> </label>
                        <div class="col-sm-3">
                            <div class="input-group">
                                <input type="text" class="form-control" placeholder="porcentaje" name="idSanfer" data-bind="value:porcentaje">
                                <div class="input-group-addon">%</div>
                            </div>
                        </div>
                    </div>
                    <!-- /ko -->
                    
                </div>
                </div>
                <!-- /ko -->
                <div class="form-group">
                    <div class="col-sm-offset-4 col-sm-4"  style="margin-bottom:20pt;">
                    <button type="button" data-bind="click:$root.GuardarProrrateos" class="btn btn-block btn-primary ">Guardar cambios</button>
                    </div>
                </div>
            </div>
            <div role="tabpanel" class="tab-pane" id="mOpciones">
            <div class="row">
                    <div class="col-md-6">
                        <h4>Opciones</h4>
                        <div class="text-center">
                            <button type="button" style="margin-bottom:15px;" class="btn btn-primary" data-bind="click: $root.AbrirModalOpcion.bind($data,null,1,2)">Nueva opción <span class="glyphicon glyphicon-plus"></span></button>
                        </div>
                        <table class="table table-condensed" >
                            <tr style="font-weight:bold">
                                <td>Nombre</td>
                                <td>Acción</td>
                            </tr>
                        <!-- ko foreach:{data:lista_solo_opciones, as: 'item'} -->
                            <tr>
                                <td data-bind="text:nombre"></td>
                                <td>
                                    <button type="button" data-bind="click: $root.AbrirModalOpcion.bind($data,item,2,2)" class="btn btn-sm btn-warning" >
                                        <span class="glyphicon glyphicon-pencil"></span>
                                    </button>
                                    <button type="button" data-bind="click: $root.AbrirModalOpcion.bind($data,item,3,2)" class="btn btn-sm btn-danger" >
                                        <span class="glyphicon glyphicon-trash"></span>
                                    </button>
                                </td>
                            </tr>
                        <!-- /ko -->
                        </table>
                    </div>
                    <div class="col-md-6">
                        <h4>Personas</h4>
                        <div class="text-center">
                            <button style="margin-bottom:15px;" class="btn btn-primary" data-bind="click: $root.AbrirModalOpcion.bind($data,null,1,1)">Agregar persona <span class="glyphicon glyphicon-plus"></span></button>
                        </div>
                        <table class="table table-condensed" >
                            <tr style="font-weight:bold">
                                <td>Nombre</td>
                                <td>Acción</td>
                            </tr>
                        <!-- ko foreach:{data:lista_solo_personas, as: 'item'} -->
                            <tr>
                                <td data-bind="text:nombre"></td>
                                <td>
                                <button type="button" data-bind="click: $root.AbrirModalOpcion.bind($data,item,2,1)" class="btn btn-sm btn-warning" >
                                        <span class="glyphicon glyphicon-pencil"></span>
                                    </button>
                                    <button type="button" data-bind="click: $root.AbrirModalOpcion.bind($data,item,3,1)" class="btn btn-sm btn-danger" >
                                        <span class="glyphicon glyphicon-trash"></span>
                                    </button>
                                </td>
                            </tr>
                        <!-- /ko -->
                        </table>
                    </div>
                </div>
            </div>
            <div role="tabpanel" class="tab-pane" id="mOpcionConcepto">
                <div class="row">
                    <div class="col-md-12 text-center" style="padding-top:15pt;">
                        <!-- ko foreach:listaLineas -->
                            <span ><span data-bind="text:nombreperfil"></span>:<div data-bind="style:{background:color}" style="height: 20px;width: 20px;display: inline-block;margin-right:10px;"></div> </span>
                        <!-- /ko --> 
                    </div>
                    <div class="row">
                        <table>
                        <tr>
                            <td>
                                <select data-bind="options: lista_conceptos, optionsText:'nombre', optionsValue:'idConcepto', optionsCaption:'- SELECCIONAR CONCEPTO -', value:conceptoSeleccionado" class="form-control" ><select>
                                
                                <div class="form-group" data-bind="visible:lista_grupos()!=null">
                                    <label for="grupoConf">Grupo</label>
                                    <select data-bind="options: lista_grupos, optionsText:'nombregrupo', optionsValue:'idGrupo', optionsCaption:'Seleccione una opcion...', value:grupoSeleccionado" class="form-control" id="grupoConf"><select>
                                </div>
                            </td>
                        </tr>
                            <tr style="vertical-align: top;">
                                <td style="width:50%;">
                                    <div style="padding-right:25pt;">
                                    <h4>Opciones asignadas:</h4>
                                        <div class="list-group" data-bind="foreach: {data:listaAsigConceptoProrrateo, as:'item'}">
                                            <div  class="list-group-item" data-bind="visible:idGrupo===$root.grupoSeleccionado()  || ($root.lista_grupos()==null && idConcepto!=null )">
                                            <span data-bind="style:{color:color}" class="glyphicon glyphicon-stop"></span>
                                                <span data-bind="text:nombreopcion" style="display:inline-block"></span>
                                                <button type="button" class="btn btn-warning btn-xs" style="float:right" data-bind="click: function(){$root.QuitarOpcion(item) }" >
                                                <span class="glyphicon glyphicon-menu-right"></span>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <!-- <td>
                                    <button class="btn btn-primary" type="button"><</button>
                                </td> -->
                                <td style="width:50%;">
                                <h4>Opciones disponibles:</h4>
                                <div class="list-group" data-bind="foreach:{data: listaAsigConceptoProrrateo(), as:'item'}">
                                        <div class="list-group-item" data-bind="visible:idConcepto==null && typeof $root.idConceptoSelecc()!='undefined' ">
                                            <button type="button" class="btn btn-success btn-xs" data-bind="click: function(){$root.AgregarOpcion(item) }" >
                                            <span class="glyphicon glyphicon-menu-left"></span>
                                            </button>
                                            <span data-bind="text:nombreopcion" ></span>
                                            
                                            <select data-bind="options: $root.listaLineas, optionsText:'nombreperfil', optionsValue:'idPerfilProrrateo', value:opSelect" style="width:130px; display:inline-block; float:right" class="form-control input-sm" ><select>
                                        </div>
                                    </div>

                                    <!-- <ul class="list-group">
                                        <li class="list-group-item">sad <select style="width:100px; display:inline; float:right" class="form-control input-sm" name="idConcepto">
                                        <option>1</option>
                                        <option>1</option>
                                    </select></li>
                                        <li class="list-group-item">sad</li>
                                        <li class="list-group-item">sad</li>
                                        <li class="list-group-item">sad</li>
                                    </ul> -->
                                </td>
                            </tr>
                        </table>
                        

                    </div>

                </div>
            </div>
            <div role="tabpanel" class="tab-pane" id="opConcepto">...</div>
        </div>
    </div>



    
</div>

<div class="modal fade" tabindex="-1" role="dialog" id="modal_detalle_egreso">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Detalle del egreso</h4>
      </div>
      <div class="modal-body" data-bind="with:detalleEgreso">
        <h5 data-bind="html:'<b>No. Correlativo:</b> ' + ncorrelativo"></h5> 
        <h5 data-bind="html:'<b>Declarado por:</b> ' + nombreUsuario"></h5>        
        <h5 data-bind="html:'<b>Fecha de egreso:</b> ' + fecha"></h5>
        <table  class="table table-condensed table" >
                <tr>
                    <!-- <th>Codigo</th> -->
                    <th>Fecha y hora</th>
                    <th>Concepto</th>
                    <th>Factura No.</th>
                    <th>Detalle </th>
                    <th>Monto (Bs.)</th>
                    
                </tr>
                <!-- ko foreach:detalle -->
                <tr>
                        <!-- <td data-bind="text:codigo"></td> -->
                        <td data-bind="text:fechacompleta"></td>
                        <td data-bind="text:conceptoNombre"> 
                        <td data-bind="text:factura"></td> 
                        <td data-bind="text:montoTotal"></td>  
                        <td>
                            <a class="btn btn-sm btn-primary" role="button" data-toggle="collapse" data-bind="attr:{href:'#c_'+$index()}"  aria-expanded="false" aria-controls="collapseExample">
                            <span class="glyphicon glyphicon-info-sign"></span>
                            </a>
                            
                        </td> 
                        </td>
                    </tr>
                    <tr>
                        <td style="padding:0px"></td>
                        <td colspan="4"  style="padding:0px">
                            <div style="padding:2px 10px;"  class="collapse" data-bind="attr:{id:'c_'+$index()}">
                                <div >
                                    <strong>Detalle: </strong>
                                    <span data-bind="text:glosa"></span>
                                </div>
                                <div data-bind="if:gruponombre!=null">
                                    <strong>Grupo: </strong>
                                    <span data-bind="text:gruponombre"></span>
                                </div>
                                <div data-bind="if:nombreopcion!=null">
                                    <strong>Opcion: </strong>
                                    <span data-bind="text:nombreopcion"></span>
                                </div>
                                <div data-bind="if:perfil==1">
                                
                                </div>
                            </div>
                        </td>
                    </tr>
                <!-- /ko -->
                <tr style="font-weight:bold">
                    <td colspan="3">TOTAL:</td>
                    <!-- <td colspan="5" data-bind="text:$root.sumaTotalLiteral"></td>                     -->
                    <td data-bind="text:$root.sumaTotal() +' Bs.'"></td>
                </tr>
            </table>
            <!-- <object id="preview-pane" type="application/pdf" width="750" height="600">
            alt : <a href="your.pdf">your.pdf</a> -->
        </object>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bind="click:PdfBoleta" >Vista previa de boleta</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
      </div>
    </div>
  </div>
</div>

<div class="container"  data-bind="visible: seccion()=='cuenta'">
    <div class="row">
        <h3>Aqui puede editar la cuenta de usuario:</h3>
        <div class="col-md-offset-4 col-md-4" data-bind="with:datosCuenta">
            <p><b>Nombre completo:</p> </b><p data-bind="text:nombre"></p>            
            <div class="form-group">
                <label for="usuario">Usuario</label>
                <input type="text" data-bind="value:usuario" class="form-control" id="usuario" placeholder="Ingrese aqui su nombre de usuario">
            </div>
            <div class="form-group">
                <label for="password">Contraseña</label>
                <input type="password" data-bind="value:password" class="form-control" id="password" placeholder="Ingrese aqui su contraseña">
                <!-- <sub>Deje en blanco el campo si no desea cambiar su contraseña</sub> -->
            </div>
            <div data-bind="visible:$root.avisoCuenta()==1" class="alert alert-success" role="alert">Se ha guardado el usuario, es necesario volver a iniciar sesión para aplicar los cambios</div>
            <div data-bind="visible:$root.avisoCuenta()==2" class="alert alert-danger" role="alert">Ocurrio un error al guardar el usuario</div>

            <button type="button" data-bind="click:$root.GuardarCuenta" class="btn btn-primary">Guardar Cambios</button>
        </div>
    </div>
</div>

<div class="container"  data-bind="visible: seccion()=='resumen'">
    <div class="row">
        <h3>Egresos</h3>
        <div class="col-md-offset-2 col-md-8">
        <div class="row" >
            <div class="col-sm-4">
            <div class="form-group">
                    <label for="conceptoResGas">Concepto</label>
                <select data-bind="options: lista_conceptos, optionsText:'nombre', optionsValue:'idConcepto', optionsCaption:'- TODOS -', value:conceptoResumenGastoSelec" class="form-control" id="conceptoResGas"><select>
</label>
</div>

    </div>
            <div class="col-sm-4">
                <div class="form-group">
                    <label for="fechaInicialRes">Fecha Inicial</label>
                    <div class="input-group date" id="fechaInicialRes">
                        <input type="text" class="form-control">
                        <div class="input-group-addon">
                            <span class="glyphicon glyphicon-th"></span>
                        </div>
                    </div>
                </div>
                    
            </div>
            <div class="col-sm-4">
                <div class="form-group">
                    <label for="fechaFinalRes">Fecha Final</label>
                    <div class="input-group date" id="fechaFinalRes">
                        <input type="text" class="form-control">
                        <div class="input-group-addon">
                            <span class="glyphicon glyphicon-th"></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div data-bind="visible:resumen().length>0">
        <div class="text-center" style="margin-bottom:15px;" >
            <a class="btn btn-danger"  href="#" data-bind="click:ImprimirResumenGastos">Imprimir resumen PDF <span class="glyphicon glyphicon-print"></span></a>
            <button class="btn btn-success" data-bind="click:GenerarExcel">Crear archivo Excel <span class="glyphicon glyphicon-save-file"></span></a>
            
        </div>
            <table class="table table-strip">
                <tr style="font-weight:bold">
                    <td>Fecha</td>
                    <td>Detalle Gasto (Concepto)</td>
                    <td>No. Factura</td>
                    <td>Monto</td>
                    <td>Observación</td>
                    <td></td>
                </tr>

                <!-- ko foreach:resumen -->
                    <tr>
                        <td data-bind="text:fecha"></td>
                        <td data-bind="text:detalle"></td>
                        <td data-bind="text:factura"></td>
                        <td data-bind="text:monto"></td>
                        <td data-bind="text:observacion"></td>
                        <td><a href="#" data-bind="click:$root.SeleccionarEgreso" class="text-danger"><span class="glyphicon glyphicon-remove"></span></a> </td>
                    </tr>
                <!-- /ko -->
            </table>
            <!-- <table class="table">
                <tr>
                <td>TOTAL:</td>
                <td data-bind="text:sumaMontoResumenGastosTotal"></td>
                </tr>
            </table> -->
            <div id="btnPaginacionResumen"></div>
            </div>
            <div data-bind="visible:resumen().length==0">
                <div class="bg-warning" style="padding:15px;">No se encontraron registros en este rango de fechas o concepto</div>
            </div>
        </div>        
    </div>
</div>


<div class="modal fade" tabindex="-1" role="dialog" id="modal_opcion">
  <div class="modal-dialog" role="document">
    <div class="modal-content" data-bind="with:nuevaOpcion">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" data-bind="text:titulo"></h4>
      </div>
      <div class="modal-body" data-bind="visible:tipo < 3">
       
            <p>Escriba dentro de la caja de texto:</p>
            <input class="form-control" data-bind="value:nombre" type="text" />
        
      </div>
      <div class="modal-body" data-bind="visible:tipo == 3">
        <p>Confirma eliminar el siguiente registro?</p>
        <pre class="text-center" data-bind="text:typeof nombre=='undefined'?'':nombre"></pre>
      </div>
      <div class="modal-footer">
        <!-- <div data-bind="if: typeof AvisoOpcion().texto!='undefined'"> -->
        <p style="padding: 15px;" data-bind="css: $root.AvisoOpcion().clase, visible: $root.AvisoOpcion().texto!=null">
            <span data-bind="text:$root.AvisoOpcion().texto"></span> 
        </p>
            
        <button type="button" class="btn btn-danger" data-bind="click:$root.CrudOpcion" >
            <span  data-bind="text:tipo==3?'Eliminar':'Guardar'"></span>
        </button>
        <button type="button" class="btn btn-default" data-dismiss="modal" >Cerrar</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" tabindex="-1" role="dialog" id="modal_eliminar_egreso">
  <div class="modal-dialog" role="document">
    <div class="modal-content" data-bind="with:egresoSeleccionado">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Eliminar</h4>
      </div>
      <div class="modal-body">
        <p class="text-danger">No podra restaurar el egreso eliminado</p>
        <p>Confirma eliminar permanentemente el siguiente egreso?</p>
        <pre class="text-center" data-bind="text:egreso().detalle"></pre>
      </div>
      <div class="modal-footer">            
      <button type="button" class="btn btn-danger" data-bind="click:EliminarEgreso.bind($data,egreso())" >
        Eliminar
      </button>
        <button type="button" class="btn btn-default" data-dismiss="modal" >Cancelar</button>
      </div>
    </div>
  </div>
</div>

<div class="cargador" data-bind="visible:onCarga()==true">
    <img src="assets/img/loader.gif" >
</div>

<script>
    var conceptos=<?php echo $conceptos ?>;
    var imgData="<?php echo $imgData ?>";
    var perfil=<?php echo $perfil ?>;
    var lista_asistentes = <?php echo $lista_asistentes ?>;
    var lista_todas_opciones = <?php echo $lista_todas_opciones ?>;
    var lista_lineas  = <?php echo $lista_lineas ?>;
</script>