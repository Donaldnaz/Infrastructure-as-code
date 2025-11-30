# Keypair Access

resource "aws_key_pair" "ikenna" {

  key_name   = "ikenna"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA0/brj+K77fW1NZVorNtZty92JOwz8JpgliioQ3CihV apple@Champ.local"

}