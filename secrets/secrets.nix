let
  local = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF4xbd0SvaUGdrLcMQJkqdxCAWa6qirD0KTFTL6zFAhV";
in
{
  "kagi.age".publicKeys = [ local ];
}
