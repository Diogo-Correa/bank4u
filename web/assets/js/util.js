$( document ).ready(function() {
    
    $("#infosModal").modal("show");
    
    
    /* global bootstrap: false */
    (function () {
      'use strict'
      var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
      tooltipTriggerList.forEach(function (tooltipTriggerEl) {
        new bootstrap.Tooltip(tooltipTriggerEl);
      });
    })();
    
    // Definições de Máscaras
    $(".mascara-data").mask("99/99/9999");
    $(".mascara-cpf").mask("999.999.999-99");
    $(".mascara-cnpj").mask("99.999.999/9999-99");
    $(".mascara-telefone").mask("(99)9999-9999?9");
    $(".mascara-cep").mask("99.999-999");

    $('.mascara-telefone').focusout(function(){
     let phone, element;
     element = $(this);
     element.unmask();
     phone = element.val().replace(/\D/g, '');
     if(phone.length > 10) {
         element.mask("(99)99999-999?9");
     } else {
         element.mask("(99)9999-9999?9");
     }
 });
 
    $('#confirmaAction').on('show.bs.modal', function(e) {
        $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));
    });
});

function ValidaCPF(cpfEnviado) {
  Object.defineProperty(this, 'cpfLimpo', {
    enumerable: true,
    get: function() {
      return cpfEnviado.replace(/\D+/g, '');
    }
  });
}

ValidaCPF.prototype.valida = function() {
  if(this.cpfLimpo.length !== 11 || this.isSequencia() || typeof this.cpfLimpo === 'undefined') return false;

  const cpfParcial = this.cpfLimpo.slice(0, -2);
  const digito1 = this.criaDigito(cpfParcial);
  const digito2 = this.criaDigito(cpfParcial + digito1);
  
  const novoCpf = cpfParcial + digito1 + digito2;
  
  return novoCpf === this.cpfLimpo;
};

ValidaCPF.prototype.criaDigito = function(cpfParcial) {
  const cpfArray = Array.from(cpfParcial);

  let regressivo = cpfArray.length + 1;
  const total = cpfArray.reduce((ac, val) => {
    ac += (regressivo * Number(val));
    regressivo--;
    return ac;
  }, 0);

  const digito = 11 - (total % 11);
  return digito > 9 ? '0' : String(digito);
};

ValidaCPF.prototype.isSequencia = function() {
  const sequencia = this.cpfLimpo[0].repeat(this.cpfLimpo.length);
  return sequencia === this.cpfLimpo;
};

function checkCPF(value) {
    const cpfInput = document.getElementById('cpf');
    const passInput = document.getElementById('senha');
    const btn = document.getElementById('btnDisabled');
    const isValid = new ValidaCPF(value).valida();
    
    if(isValid) {
      cpfInput.classList.remove('is-invalid');
      cpfInput.classList.add('is-valid');
      passInput.classList.remove('d-none');
      btn.disabled = false;
    } else {
      cpfInput.classList.add('is-invalid'); 
      passInput.classList.add('d-none');
      btn.disabled = true;
    }
    
}