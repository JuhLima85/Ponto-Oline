<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Marcaçoes Feitas</title>
<link rel="stylesheet" href="style.css">

<style>
  .cpf {
    font-weight: bold;
    color: red;   
  }

  .horario-container {
    display: flex;
  }

  .horario-item {
    margin-right: 10px;
  }
</style>
</head>
<body>

<div class="container">	
	<h2 class="semMargem">Registro de ponto</h2>
	<h2 class="semMargem">Horário de Trabalho Previsto</h2>
	   
   <ul id="horariosList">
  <c:forEach var="horario" items="${horarios}">
    <li>
      <strong>CPF:</strong> <span class="cpf">${horario.getCpf()}</span><br><br>
      <div class="horario-container">
        <div class="horario-item">
          <strong>Entrada:</strong> ${horario.getEntrada()}
        </div>
        <div class="horario-item">
          <strong>Saída:</strong> ${horario.getSaida()}
        </div>
      </div>
    </li>
  </c:forEach>
  <c:if test="${empty horarios}">
    <li>Nenhum horário registrado.</li>
  </c:if>
</ul>
	
	<h2 class="comMargem">Marcações Feitas</h2>
	<form  method="POST" action="MarcacoesFeitasServlet">
		<input type="hidden" name="action" value="add"> <label>
			
		</label> Entrada: <input type="text" name="entrada" pattern="^([0-1][0-9]|2[0-3]):[0-5][0-9]$" placeholder="HH:MM" maxlength="5"> 				
				 Saída: <input type="text" name="saida" pattern="^([0-1][0-9]|2[0-3]):[0-5][0-9]$" placeholder="HH:MM" maxlength="5">
		<div>
			<br> <input type="submit" value="Cadastrar">
		</div>
	</form>
	
	<!-- Lista das marcações feitas -->
	<table class="horarios">
		<thead>
			<tr>
				<th>Entrada</th>				
				<th>Saída</th>
				<th>Período Alterado</th>
				<th>Horas Extras / Atrasos</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="marcacao" items="${marcacoes}">
				<tr>
					<td>${marcacao.entrada}</td>					
					<td>${marcacao.saida}</td>
					<td>${marcacao.periodoAtraso}</td>
					<td>${marcacao.qtdHorasNegativa}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<div class="clear"></div>	
	
	</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js"></script>

<script>
//ver se esse escript está sendo aplicado
var horarios = ${horarios}; // Obtém a lista de horários do atributo "horarios" do objeto request

var horariosListElement = document.getElementById("horariosList");
if (horarios.length > 0) {
  for (var i = 0; i < horarios.length; i++) {
    var horario = horarios[i];
    var listItem = document.createElement("li");
    listItem.innerHTML = "<strong>CPF:</strong> " + horario.cpf + "<br>" +
                         "<strong>Entrada:</strong> " + horario.entrada + "<br>" +
                         "<strong>Saída:</strong> " + horario.saida;
    horariosListElement.appendChild(listItem);
  }
} else {
  var noHorariosItem = document.createElement("li");
  noHorariosItem.textContent = "Nenhum horário registrado.";
  horariosListElement.appendChild(noHorariosItem);
}
</script>
	<script>
  	function editarHorario(id) {
        // Redireciona para a página de edição passando o ID como parâmetro na URL
	 window.location.href = "HoraDeTrabalhoServlet?action=edit&id=" + id;
    }
	
	function excluirHorario(id) {
	     if (confirm('Tem certeza que deseja excluir este horário?')) {
	        var form = document.createElement('form');
	        form.method = 'POST';
	        form.action = 'HoraDeTrabalhoServlet';
	        form.innerHTML = '<input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="' + id + '">';
	        document.body.appendChild(form);
	        form.submit();
	        
	        // Exibir mensagem de excluído com sucesso como pop-up
	        alert("Horário excluído com sucesso!");
	    }
	}		
	
  //para aplicar automaticamente a máscara ao campo de valor hora
  $(document).ready(function() {
  $('input[name="entrada"]').mask('00:00');
  $('input[name="saida"]').mask('00:00');
});
</script>
</body>
</html>