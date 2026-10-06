-- Generated from ChapterPauliCommutant.lean — theorem BookProof.ChapterA3.mgamma5_of_commutes
import Mathlib
import Definitions.Def_ChapterPauliCommutant
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.mgamma5_of_commutes (M : Matrix (Fin 4) (Fin 4) ℂ)
    (h : ∀ μ, M * mgamma μ = mgamma μ * M) :
    M * mgamma5 = mgamma5 * M := by sorry
