function completedPurchase() {
  window.setTimeout(function(){
      window.location.href = "http://localhost:3000/orders/new";
    }, 3000);
}

function soldOut(){
  window.setTimeout(function(){
      window.location.href = 'http://localhost:3000/products/:id/edit';
    }, 3000);
}
