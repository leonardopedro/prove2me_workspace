-- Generated from ChapterPauliCommutant.lean — theorem BookProof.ChapterA3.mgamma_conj_eq_self_iff
import Mathlib
import Definitions.Def_ChapterPauliCommutant
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.mgamma_conj_eq_self_iff {S : Matrix (Fin 4) (Fin 4) ℂ} (hS : IsUnit S.det) :
    (∀ μ, S * mgamma μ * S⁻¹ = mgamma μ) ↔
      ∃ c : ℂ, c ≠ 0 ∧ S = c • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by sorry
