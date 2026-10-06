-- Generated from ChapterLorentzRealRep.lean — solution of BookProof.ChapterLorentzRealRep.castR_mul
import Mathlib
import Definitions.Def_ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRep



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega

set_option maxHeartbeats 1000000 in
theorem solution (A B : Matrix (Fin 4) (Fin 4) ℤ) : castR (A * B) = castR A * castR B := map_mul ((Int.castRingHom ℝ).mapMatrix) A B
