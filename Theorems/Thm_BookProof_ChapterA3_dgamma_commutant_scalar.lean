-- Generated from ChapterPauliCommutant.lean — theorem BookProof.ChapterA3.dgamma_commutant_scalar
import Mathlib
import Definitions.Def_ChapterPauliCommutant
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.dgamma_commutant_scalar (M : Matrix (Fin 4) (Fin 4) ℂ)
    (h : ∀ μ, M * dgamma μ = dgamma μ * M) :
    M = M 0 0 • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by sorry
