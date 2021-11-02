(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))

;; pretty sure this is not needed
;;(add-to-list 'package-archives
;;             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)
;;(global-company-mode)
;; list of packages to sync
(setq pfl-packages
        '(
            flycheck-inline
            yaml-mode
            ggtags
            helm-gtags
            helm
            helm-core
            company
            flycheck
            terraform-mode
            markdown-mode
            git
            sr-speedbar
            ))

;; refresh package list if it is not already available
(when (not package-archive-contents) (package-refresh-contents))

;; install packages from the list that are not yet installed
(dolist (pkg pfl-packages)
    (when (and (not (package-installed-p pkg)) (assoc pkg package-archive-contents))
        (package-install pkg)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("dcdd1471fde79899ae47152d090e3551b889edf4b46f00df36d653adc2bf550d" "d0fe9efeaf9bbb6f42ce08cd55be3f63d4dfcb87601a55e36c3421f2b5dc70f3" default))
 '(package-selected-packages
   '(markdown-preview-mode markdown-mode json-mode yaml-mode helm-gtags ggtags racer company-racer flycheck-inline dracula-theme opencl-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; git repos
(require 'git)
;; set colors for *cl files
(require 'opencl-mode)
(add-to-list 'auto-mode-alist '("\\.cl\\'" . opencl-mode))
;; set colors for *tf files
(require 'terraform-mode)
(add-to-list 'auto-mode-alist '("\\.tf\\'" . terraform-mode))
;; spell check
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
;; ############################################################
;; rtags stuff taken from http://syamajala.github.io/c-ide.html
;;
;; Commented for a moment as I am not using it yet and there
;; were some problems with it on Lara (Mac)
;;
;; TODO: investigate and fix it
;; ############################################################
;; (require 'rtags)
;; (require 'company-rtags)
;;
;; (setq rtags-completions-enabled t)
;; (eval-after-load 'company
;;   '(add-to-list
;;     'company-backends 'company-rtags))
;; (setq rtags-autostart-diagnostics t)
;; (rtags-enable-standard-keybindings)
;; To enable Helm integration add
;; (require 'helm-rtags) ;; there seems to be no rtags-helm package there... there is helm-rtags though
;; (setq rtags-use-helm t)

;; ############################################################

;; some c stuff, still testing (15-10-2018 9:00)
(require 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))
(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)

(setq
 helm-gtags-ignore-case t
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor t
 helm-gtags-prefix-key "\C-cg"
 helm-gtags-suggested-key-mapping t
 )

(require 'helm-gtags)
;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'company-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
(define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)

(add-hook 'yaml-mode-hook
        (lambda ()
            (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; Use spaces only, no tabs
(setq-default indent-tabs-mode nil)

;; remove toolbars from non console version
;;(tool-bar-mode -1)
;;(menu-bar-mode -1)
;;(toggle-scroll-bar -1)

(set-frame-font "Monospace-9" t t)
(put 'downcase-region 'disabled nil)

;; set indent size to 4
(setq sh-basic-offset 4)
(setq js-indent-level 4)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; speedbar
(setq speedbar-use-images nil)
(sr-speedbar-open)
(speedbar-toggle-show-all-files)
(setq speedbar-directory-unshown-regexp
"^\\(CVS\\|RCS\\|SCCS\\|\\.\\.*$\\)\\'")
(setq speedbar-show-unknown-files t)
;;(custom-set-variables
;; '(speedbar-toggle-show-all-files t)
;;)

(global-display-line-numbers-mode)
;;(setq whitespace-style '(lines))
;;(setq whitespace-style '(tabs trailing lines tab-mark))
(setq whitespace-style '(face spaces tabs trailing newline space-mark tab-mark newline-mark))
(setq whitespace-line-column 120)
(global-whitespace-mode)


(put 'upcase-region 'disabled nil)
