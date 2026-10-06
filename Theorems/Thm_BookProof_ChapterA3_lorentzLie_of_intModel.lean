-- Generated from ChapterA3e.lean — theorem BookProof.ChapterA3.lorentzLie_of_intModel
import Mathlib
import Definitions.Def_ChapterA3e
import Definitions.Def_ChapterA3b
import Definitions.Def_ChapterA3d
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.lorentzLie_of_intModel (Az : Matrix (Fin 4) (Fin 4) ℤ)
    (h : Az * minkowskiMatZ + minkowskiMatZ * Azᵀ = 0) :
    (Int.castRingHom ℝ).mapMatrix Az ∈ LorentzLie := by sorry
