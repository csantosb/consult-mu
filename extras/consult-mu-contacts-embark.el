;;; consult-mu-contacts-embark.el --- Emabrk Actions for consult-mu -*- lexical-binding: t -*-

;; Copyright (C) 2021-2023

;; Author: Armin Darvish
;; Maintainer: Armin Darvish
;; Created: 2023
;; Version: 1.0
;; Package-Requires: ((emacs "28.0") (consult "0.34"))
;; Homepage: https://github.com/armindarvish/consult-mu
;; Keywords: convenience, matching, tools, email

;;; Commentary:

;;; Code:

;;; Requirements
(require 'embark)
(require 'consult-mu)
(require 'consult-mu-embark)


(defun consult-mu-contacts-embark-compose (cand)
    (let* ((contact (get-text-property 0 :contact cand)))
      (unless (mu4e-running-p) (mu4e--server-start))
      ;;(mu4e-compose-new)
      ;;(insert contact)
      ))


(defun consult-mu-contacts-embark-default-action (cand)
  "Run `consult-mu-contacts-action' on the candidate."
  (let* ((contact (get-text-property 0 :contact cand))
         (query (get-text-property 0 :query cand))
         (newcand (cons cand `(:msg ,msg :query ,query))))
    (funcall consult-mu-contacts-action newcand))
  )


;;; Define Embark Keymaps

(defvar-keymap consult-mu-embark-contacts-actions-map
  :doc "Keymap for consult-mu-embark-contacts"
  :parent consult-mu-embark-general-actions-map
  "c" #'consult-mu-contacts-embark-compose
  )

(add-to-list 'embark-keymap-alist '(consult-mu-contacts . consult-mu-embark-contacts-actions-map))


;; change the default action on `consult-mu-contacts category.
(add-to-list 'embark-default-action-overrides '(consult-mu-contacts . consult-mu-contacts-embark-default-action))

;;; Provide `consult-mu-contacts-embark' module

(provide 'consult-mu-contacts-embark)
