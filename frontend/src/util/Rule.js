class Rule {
  required() {
    return (value) => (value === 0 || !!value) || 'Campo obrigatório';
  }

  maxCharacters({ max }) {
    return (value) => value.length <= max || `Máx.: ${max} caracteres`;
  }
}

export default new Rule();
