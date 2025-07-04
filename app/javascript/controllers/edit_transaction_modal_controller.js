import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "modalContent"]

  connect() {
    document.querySelectorAll('.edit-transaction-btn').forEach(btn => {
      btn.addEventListener('click', this.openModal.bind(this))
    })
    document.getElementById('edit-transaction-modal-close').addEventListener('click', this.closeModal.bind(this))
    window.addEventListener('keydown', (e) => {
      if (e.key === 'Escape') this.closeModal()
    })
  }

  openModal(event) {
    event.preventDefault()
    const url = event.currentTarget.getAttribute('href')
    const modal = document.getElementById('edit-transaction-modal')
    const modalContent = document.getElementById('edit-transaction-modal-content')
    modal.style.display = 'flex'
    fetch(url, { headers: { 'Accept': 'text/vnd.turbo-stream.html, text/html, application/xhtml+xml' } })
      .then(response => response.text())
      .then(html => {
        modalContent.innerHTML = html
      })
  }

  closeModal() {
    document.getElementById('edit-transaction-modal').style.display = 'none'
    document.getElementById('edit-transaction-modal-content').innerHTML = ''
  }
} 