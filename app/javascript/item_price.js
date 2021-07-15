const price_calculation = ()=>{
  const price_id = document.getElementById('item-price');
  const tax = Math.floor( price_id.value / 10 );
  const profit = price_id.value - tax;
  const view_tax = document.getElementById('add-tax-price');
  const view_profit = document.getElementById('profit');
  view_tax.innerHTML = tax;
  view_profit.innerHTML = profit;
};
addEventListener('keyup', price_calculation);