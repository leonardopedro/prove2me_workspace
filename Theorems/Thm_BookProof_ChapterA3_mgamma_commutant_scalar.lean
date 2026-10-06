-- Generated from ChapterPauliCommutant.lean — theorem BookProof.ChapterA3.mgamma_commutant_scalar
import Mathlib
import Definitions.Def_ChapterPauliCommutant
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.mgamma_commutant_scalar (M : Matrix (Fin 4) (Fin 4) ℂ)
    (h : ∀ μ, M * mgamma μ = mgamma μ * M) :
    M = M 0 0 • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by sorry
