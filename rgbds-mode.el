;;; rgbds-mode --- Major mode for Gameboy assembly
;;; Commentary:
;;; Based on https://www.cemetech.net/forum/viewtopic.php?t=6413&start=0
;;; Code:
(require 'mwim)

(defconst rgbds-font-lock-keywords-1
  (list
   '(";.*" . font-lock-comment-face)
   '("^\\*.*" . font-lock-comment-face)
   '("\\<\\(adc\\|add\\|and\\|cp\\|dec\\|inc\\|or\\|sbc\\|sub\\|xor\\|call\\|jp\\|jr\\|ret\\|rst\\|bit\\|res\\|rl\\|rlc\\|rr\\|rrc\\|set\\|sla\\|sra\\|srl\\|swap\\|ccf\\|cpl\\|daa\\|di\\|ei\\|halt\\|nop\\|scf\\|stop\\|ld\\|pop\\|push\\|reti\\|rla\\|rlca\\|rra\\|rrca\\)\\>" . font-lock-builtin-face)
   '("\\<\\(ADC\\|ADD\\|AND\\|CP\\|DEC\\|INC\\|OR\\|SBC\\|SUB\\|XOR\\|CALL\\|JP\\|JR\\|RET\\|RST\\|BIT\\|RES\\|RL\\|RLC\\|RR\\|RRC\\|SET\\|SLA\\|SRA\\|SRL\\|SWAP\\|CCF\\|CPL\\|DAA\\|DI\\|EI\\|HALT\\|NOP\\|SCF\\|STOP\\|LD\\|POP\\|PUSH\\|RETI\\|RLA\\|RLCA\\|RRA\\|RRCA\\)\\>" . font-lock-builtin-face)
   '("\\<\\(a\\|b\\|c\\|d\\|e\\|h\\|l\\|af\\|bc\\|de\\|hl\\|sp\\|A\\|B\\|C\\|D\\|E\\|H\\|L\\|AF\\|BC\\|DE\\|HL\\|SP\\)\\>" . font-lock-variable-name-face)
   '("\\(\\w*:\\)"  . font-lock-variable-name-face))
  "Minimal highlighting expressions for rgbds mode.")
(defconst rgbds-font-lock-keywords-2
  (append rgbds-font-lock-keywords-1
          (list
           '("\\<\\(\\([0-9][0-9A-Fa-f]*[Hh]\\|\\(0[Xx]\\|[0-9]\\|\\$[0-9A-Fa-f]\\)[0-9A-Fa-f]*\\)\\|[01][01]*[Bb]\\|%[01][01]*\\|[0-9]*\\)\\>" . font-lock-constant-face)
           '("\\(\\$\\)" . font-lock-function-name-face)))
  "Additional Keywords to highlight in rgbds mode.")
(defconst rgbds-font-lock-keywords-3
  (append rgbds-font-lock-keywords-2
          (list
           '("\\(\\.\\w*\\|#\\w*\\)" . font-lock-preprocessor-face)
           '("\\<\\(DB\\|DW\\|DS\\|SECTION\\|EQU\\|EQUS\\|SET\\|POPS\\|PUSHS\\|MACRO\\|ENDM\\|RSSET\\|RSRESET\\|RB\\|RW\\|SHIFT\\|EXPORT\\|GLOBAL\\|PURGE\\|INCBIN\\|UNION\\|NEXTU\\|ENDU\\|PRINTT\\|PRINTI\\|PRINTV\\|PRINTF\\|REPT\\|ENDR\\|FAIL\\|WARN\\|INCLUDE\\|IF\\|ELIF\\|ELSE\\|ENDC\\|CHARMAP\\)\\>" . font-lock-preprocessor-face)
           '("\\<\\(db\\|dw\\|ds\\|section\\|equ\\|equs\\|set\\|pops\\|pushs\\|macro\\|endm\\|rsset\\|rsreset\\|rb\\|rw\\|shift\\|export\\|global\\|purge\\|incbin\\|union\\|nextu\\|endu\\|printt\\|printi\\|printv\\|printf\\|rept\\|endr\\|fail\\|warn\\|include\\|if\\|elif\\|else\\|endc\\|charmap\\)\\>" . font-lock-preprocessor-face)))
  "Balls-out highlighting in rgbds mode.")
(defvar rgbds-font-lock-keywords rgbds-font-lock-keywords-3
  "Default highlighting expressions for rgbds mode.")

;; DON'T SREFACTOR THIS SEXP - there's a bug in srefactor that treats semicolons
;; as comments, even when they're not.
(define-derived-mode rgbds-mode
  prog-mode
  "RGBDS"
  "Major mode for Gameboy assembly, to be assembled with rgbasm."
  (setq font-lock-defaults '(rgbds-font-lock-keywords))
  :syntax-table (let ((st (make-syntax-table)))
                  (modify-syntax-entry ?_ "w" st)
                  (modify-syntax-entry ?#"w" st)
                  (modify-syntax-entry ?. "w" st)
                  (modify-syntax-entry ?\; "<" st)
                  (modify-syntax-entry ?\n ">" st)
                  (modify-syntax-entry ?\t "-" st)
                  st))

(define-key rgbds-mode-map (kbd "C-j") 'newline-and-indent)
(define-key rgbds-mode-map (kbd "RET") 'newline-and-indent)
(define-key rgbds-mode-map (kbd "C-a") 'mwim-beginning-of-code-or-line)
(define-key rgbds-mode-map (kbd "C-e") 'mwim-end-of-code-or-line)

(provide 'rgbds-mode)
;;; rgbds-mode ends here
