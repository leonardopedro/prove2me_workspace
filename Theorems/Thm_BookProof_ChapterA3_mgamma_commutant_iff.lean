-- Generated from ChapterPauliCommutant.lean — theorem BookProof.ChapterA3.mgamma_commutant_iff
import Mathlib
import Definitions.Def_ChapterPauliCommutant
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.mgamma_commutant_iff (M : Matrix (Fin 4) (Fin 4) ℂ) :
    (∀ μ, M * mgamma μ = mgamma μ * M) ↔ ∃ c : ℂ, M = c • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by sorry
