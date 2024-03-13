{...}: {
  programs.git = {
    userName = "Tiago Dinis";
    userEmail = "tiagodinis33@proton.me";
    extraConfig.fetch.prune = true;
  };
}
