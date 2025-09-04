;; [nfnl-macro]

(fn if-work? [body]
  `(if (= (os.getenv "NEOVIM_ENVIRONMENT") "work")
      ,body))

{: if-work?}
