import { useState } from 'react';
import style from './style.module.css';

class BusinessData {
  razaoSocial = '';
  cnpj = '';
  logadouro = '';
  numero = '';
  complemento = '';
  municipio = '';
  uf = '';
}

export default function Home(): JSX.Element {
  const [cnpj, setCnpj] = useState('');
  const [data, setData] = useState(new BusinessData());
  const [formErrors, setFormErrors] = useState(new Array<string>());
  const [showResultElement, setShowResultElement] = useState(false);
  const [validResponse, setValidResponse] = useState(true);

  function validateCnpjOnInput(element: HTMLInputElement, value: string): void {
    value = value.replace(/(\/|\.|-|[A-z]|\s)/gi, '');

    setCnpj(value);

    if (value.length < 14 || value.length > 14) {
      element.classList.add('invalid_input');
      setFormErrors(['CNPJ deve conter 14 digitos.']);

      return;
    }

    element.classList.remove('invalid_input');
    setFormErrors([]);
  }

  function newSearch(): void {
    setCnpj('');
    setData(new BusinessData());
    setFormErrors([]);
    setShowResultElement(false);
    setValidResponse(true);
  }

  function createCompany(): void {
    const url = `http://localhost/ASPClassic/pages/cadastro.asp?` +
      `razaoSocial=${data.razaoSocial}&` +
      `cnpj=${data.cnpj}&` +
      `logadouro=${data.logadouro}&` +
      `numero=${data.numero}&` +
      `complemento=${data.complemento}&` +
      `municipio=${data.municipio}&` +
      `uf=${data.uf}`;

    window.location.assign(url);
  }

  function onHandleSubmit(e: any): void {
    e.preventDefault();

    if (cnpj.length === 0) {
      e.target[0].classList.add('invalid_input');
      setFormErrors(['Campo CNPJ não pode ser vazio.']);
    }

    if (formErrors.length > 0) {
      return;
    }

    fetch(`https://publica.cnpj.ws/cnpj/${cnpj}`, {
      method: 'GET'
    })
      .then(data => data.json())
      .then((data: any) => {
        setShowResultElement(true);

        if (data.status) {
          setValidResponse(false);
          return;
        }

        setData({
          razaoSocial: data.razao_social,
          cnpj: data.estabelecimento.cnpj,
          logadouro: data.estabelecimento.logradouro,
          numero: data.estabelecimento.numero,
          complemento: data.estabelecimento.complemento === null ? '' : data.estabelecimento.complemento,
          municipio: data.estabelecimento.estado.nome,
          uf: data.estabelecimento.estado.sigla
        });
      })
      .catch((error: any) => {
        console.log(error);
      });
  }

  return (
    <div className="container">
      <h1 className="text_center margin_bottom_2">Consulta CNPJ</h1>
      <div className={style.content}>
        {showResultElement === false &&
          <form onSubmit={(e) => onHandleSubmit(e)} className={style.form_cnpj}>
            <div className={style.container_input}>
              <label htmlFor="inputPassword2">CNPJ</label>
              <input
                type="text"
                className="form-control"
                id="input_cnpj"
                placeholder="e.g.: 01234567891011"
                value={cnpj}
                onChange={(e) => validateCnpjOnInput(e.target, e.target.value)}
                required
              />
            </div>
            {formErrors.length > 0 &&
              <div className={style.form_errors_content}>
                <ul>
                  {formErrors.map((error, index) => (
                    <li key={index}>{error}</li>
                  ))}
                </ul>
              </div>
            }
            <div className={style.button_container}>
              <button type="submit" className="btn_primary">Pesquisar</button>
            </div>
          </form>
        }
        {(showResultElement && validResponse) &&
          <div className={style.result_data}>
            <h2 className="text_center">🔎 Informações do CNPJ</h2>
            <div className="box">
              <ul>
                <li>Razão Social: <b>{data.razaoSocial}</b></li>
                <li>CNPJ: <b>{data.cnpj}</b></li>
                <li>Logadouro: <b>{data.logadouro}</b></li>
                <li>Número: <b>{data.numero}</b></li>
                <li>Complemento: <b>{data.complemento}</b></li>
                <li>Município: <b>{data.municipio}</b></li>
                <li>UF: <b>{data.uf}</b></li>
              </ul>
            </div>
            <div className={style.button_container}>
              <button type="button" className="btn_link" onClick={newSearch}>Nova Consulta</button>
              <button type="button" className="margin_left_1 btn_primary" onClick={createCompany}>Cadastrar Empresa</button>
            </div>
            <div></div>
          </div>
        }
        {(showResultElement && !validResponse) &&
          <div className={style.result_data}>
            <h4 className="text_center margin_bottom_1">Nenhum registro encontrado.</h4>
            <p>Verifique o CNPJ informado ou realize uma <a className="btn_link" href="!#" onClick={newSearch}>nova consulta</a>.</p>
          </div>
        }
      </div>
    </div>
  );
}