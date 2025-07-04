// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
import EditTransactionModalController from "./edit_transaction_modal_controller"
eagerLoadControllersFrom("controllers", application)
application.register("edit-transaction-modal", EditTransactionModalController)
