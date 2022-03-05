<!DOCTYPE html>
<html lang="pt-br">

  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <title>Cadastrar Empresa</title>
  </head>

  <body class="bg-light">
    <div class="container d-flex flex-column justify-content-center">
      <div class="mb-5">
        <h1 class="text-center">Cadastrar Empresa</h1>
      </div>
      <form id="form" method="post" action="create-company.asp"
        class="row mx-auto g-3 needs-validation w-50 bg-white p-2 border border-1 rounded shadow">
        <div class="col-md-8">
          <label for="razao-social" class="form-label">Razão Social</label>
          <input type="text" class="form-control" id="razao-social" name="razaoSocial" value="<%=Request.QueryString("razaoSocial")%>" required>
        </div>
        <div class="col-md-4">
          <label for="cnpj" class="form-label">CNPJ</label>
          <input type="text" class="form-control" id="cnpj" name="cnpj" value="<%=Request.QueryString("cnpj")%>"
          required>
        </div>
        <div class="col-md-8">
          <label for="logadouro" class="form-label">Logradouro</label>
          <input type="text" class="form-control" id="logadouro" name="logadouro" value="<%=Request.QueryString("logadouro")%>" required>
        </div>
        <div class="col-md-4">
          <label for="numero" class="form-label">Número (opcional)</label>
          <input type="text" class="form-control" id="numero" name="numero" value="<%=Request.QueryString("numero")%>">
        </div>
        <div class="col-md-6">
          <label for="complemento" class="form-label">Complemento (opcional)</label>
          <input type="text" class="form-control" id="complemento" name="complemento" value="<%=Request.QueryString("complemento")%>">
        </div>
        <div class="col-md-4">
          <label for="municipio" class="form-label">Município</label>
          <input type="text" class="form-control" id="municipio" name="municipio" value="<%=Request.QueryString("municipio")%>" required>
        </div>
        <div class="col-md-2">
          <label for="uf" class="form-label">UF</label>
          <input type="text" class="form-control" id="uf" name="uf" value="<%=Request.QueryString("uf")%>" required>
        </div>
        <div class="col-12 d-flex justify-content-end mt-4">
          <button class="btn btn-primary" type="submit" onclick="e => onFormHandle(e)">Salvar</button>
        </div>
      </form>
    </div>
    <script>
      const form = document.getElementById('form');

      form.addEventListener('submit', onFormHandle);

      function onFormHandle(event) {
        event.preventDefault();

        const razaoSocial = document.getElementById('razao-social').value;
        const cnpj = document.getElementById('cnpj').value;
        const logadouro = document.getElementById('logadouro').value;
        const numero = document.getElementById('numero').value;
        const complemento = document.getElementById('complemento').value;
        const municipio = document.getElementById('municipio').value;
        const uf = document.getElementById('uf').value;

        const formData = new URLSearchParams();

        formData.append('razaoSocial', razaoSocial);
        formData.append('cnpj', cnpj);
        formData.append('logadouro', logadouro);
        formData.append('numero', numero);
        formData.append('complemento', complemento);
        formData.append('municipio', municipio);
        formData.append('uf', uf);

        fetch('http://localhost/ASPClassic/api/create-company.asp', {
          method: 'POST',
          body: formData
        })
          .then(data => data.json())
          .then(data => {
            if (data.code === 200) {
              window.location.assign('http://localhost/ASPClassic/pages/success.asp');
              return;
            }

            window.location.assign('http://localhost/ASPClassic/pages/error.asp');
          });
      }
    </script>
  </body>

</html>