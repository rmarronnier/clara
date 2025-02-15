// ***********************************************
// This example commands.js shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************
//
//
// -- This is a parent command --
// Cypress.Commands.add("login", (email, password) => { ... })
//
//
// -- This is a child command --
// Cypress.Commands.add("drag", { prevSubject: 'element'}, (subject, options) => { ... })
//
//
// -- This is a dual command --
// Cypress.Commands.add("dismiss", { prevSubject: 'optional'}, (subject, options) => { ... })
//
//
// -- This is will overwrite an existing command --
// Cypress.Commands.overwrite("visit", (originalFn, url, options) => { ... })
Cypress.Commands.add('connect_as_simple_admin', () => { 
    cy.visit('/sign_in')
    cy.get('#session_email')
      .type('admin@clara.com').should('have.value', 'admin@clara.com')
    cy.get('#session_password')
      .type('foo').should('have.value', 'foo')
    cy.get('.c-login-connect input').click()
    cy.location('pathname').should('include', '/admin')
    cy.get('body').should('have.attr', 'data-path', 'admin_aids_path')
 });
Cypress.Commands.add('connect_as_super_admin', () => { 
    cy.visit('/sign_in')
    cy.get('#session_email')
      .type('superadmin@clara.com').should('have.value', 'superadmin@clara.com')
    cy.get('#session_password')
      .type('foo').should('have.value', 'foo')
    cy.get('.c-login-connect input').click()
    cy.location('pathname').should('include', '/admin')
    cy.get('body').should('have.attr', 'data-path', 'admin_aids_path')
 });
Cypress.Commands.add('disconnect_from_admin', () => { 
    cy.get('.js-sign-out').click()
 });
