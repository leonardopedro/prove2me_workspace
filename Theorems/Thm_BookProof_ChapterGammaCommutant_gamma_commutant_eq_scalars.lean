-- Generated from ChapterGammaCommutant.lean — theorem BookProof.ChapterGammaCommutant.gamma_commutant_eq_scalars
import Mathlib
import Definitions.Def_ChapterGammaCommutant
import Definitions.Def_ChapterA3
open BookProof.ChapterA3
open BookProof.ChapterGammaCommutant


open Matrix


open BookProof.ChapterA3

theorem BookProof.ChapterGammaCommutant.gamma_commutant_eq_scalars :
    {X : Matrix (Fin 4) (Fin 4) ℂ | ∀ μ, X * mgamma μ = mgamma μ * X}
      = {X | ∃ c : ℂ, X = c • (1 : Matrix (Fin 4) (Fin 4) ℂ)} := by sorry
