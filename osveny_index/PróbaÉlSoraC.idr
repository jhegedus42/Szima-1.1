module PróbaÉlSoraC

-- PRÓBA C: import + Él típus + ugyanaz a klauzula-alak, mint az élekSora
import TudásGráf_v1

%default total

próbaÉlSora : List Él -> String
próbaÉlSora éllista =
  case éllista of
    [] => "üres"
    (_ :: _) => "van él"
