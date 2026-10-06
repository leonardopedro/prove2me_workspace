-- Generated from ChapterPauliCommutant.lean — theorem BookProof.ChapterA3.mgamma_conjugation_unique_up_to_scalar
import Mathlib
import Definitions.Def_ChapterPauliCommutant
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.mgamma_conjugation_unique_up_to_scalar
    {S T : Matrix (Fin 4) (Fin 4) ℂ} (hS : IsUnit S.det) (hT : IsUnit T.det)
    (h : ∀ μ, S * mgamma μ * S⁻¹ = T * mgamma μ * T⁻¹) :
    ∃ c : ℂ, c ≠ 0 ∧ S = c • T := by sorry
