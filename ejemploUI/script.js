 document.getElementById('searchInput').addEventListener('input', function() {
      const query = this.value.toLowerCase().trim();
      const cards = document.querySelectorAll('.infoforo-card-item');
      let visibleCount = 0;

      cards.forEach(card => {
        const title = card.querySelector('.card-title').textContent.toLowerCase();
        const text = card.querySelector('.card-text').textContent.toLowerCase();
        
        if (title.includes(query) || text.includes(query)) {
          card.style.display = 'block';
          visibleCount++;
        } else {
          card.style.display = 'none';
        }
      });

      const container = document.getElementById('cardsContainer');
      const noResults = document.getElementById('noResultsMsg');
      
      if (visibleCount === 0) {
        if (!noResults) {
          const msg = document.createElement('div');
          msg.id = 'noResultsMsg';
          msg.className = 'no-results';
          msg.textContent = 'No se encontraron categorías que coincidan con tu búsqueda.';
          container.appendChild(msg);
        }
      } else {
        if (noResults) noResults.remove();
      }
    });