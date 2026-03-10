*** Settings ***
Documentation    Arquivo de contendo as variáveis comumente usadas de carrinho de compras

Library          SeleniumLibrary


*** Variables ***
# --- PRODUCTS
${PRODUCT_NAME_SORT}           ${EMPTY}

# --- BOTOES
${BTN_CHECKOUT}                id=checkout
${BTN_CONTINUE_SHOPPING}       id=continue-shopping
${BTN_ADD_TO_CART}             css:button.btn_inventory
${BTN_CART_BADGE}              css:.shopping_cart_badge
${BTN_CONTINUE}                id=continue
${BTN_CANCEL}                  id=cancel
${BTN_FINISH}                  id=finish
${BTN_BACK_TO_PRODUCTS}        id=back-to-products
${BTN_REMOVE}                  id=remove-

# --- ITEM
${INVENTORY_ITEM_NAME}         css:.inventory_item_name
${INVENTORY_BTN_NAME}          css:.btn_inventory

# --- WARN/ERRORS
${ICON}                        css:svg.error_icon

# --- TITLES
${TITLE_PAGE}                  xpath=//span[@class="title"]
${TITLE_HEADER}                css:.complete-header
${ELEMENT_TEXT}                css:.complete-text

# --- TEXT
${TXT_FIST_NAME_REQUIRED}      Error: First Name is required
${TXT_LAST_NAME_REQUIRED}      Error: Last Name is required
${TXT_ZIP_CODE_REQUIRED}       Error: Postal Code is required
${TXT_OVERVIEW_CHECKOUT}       Checkout: Overview
${TXT_PAYMENT_INFORMATION}     Payment Information:
${TXT_SHIP_INFORMATION}        Shipping Information:
${TXT_PRICE_TOTAL}             Price Total
${TXT_YOUR_CART}               Your Cart
${TXT_YOUR_INFORMATION}        Checkout: Your Information
${TXT_CHECKOUT_COMPLETE}       Checkout: Complete!
${TXT_TKS_ORDER}               Thank you for your order!
${TXT_FINISH_ORDER}            Your order has been dispatched, and will arrive just as fast as the pony can get there!

# --- IMG
${IMG_FINISH_SHOPPING}         css:img.pony_express

# --- INPUTS
${INPUT_FIRST_NAME}            id=first-name
${INPUT_LAST_NAME}             id=last-name
${INPUT_POSTAL_CODE}           id=postal-code

# --- CALC
${SUBTOTAL}                    css:.summary_subtotal_label
${TAX}                         css:.summary_tax_label
${TOTAL}                       css:.summary_total_label
