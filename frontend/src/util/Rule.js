class Rule {
  required() {
    return (value) => (value === 0 || !!value) || 'Campo obrigatório';
  }
}

export default new Rule();
