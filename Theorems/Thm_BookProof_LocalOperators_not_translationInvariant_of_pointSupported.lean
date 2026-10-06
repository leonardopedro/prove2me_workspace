-- Generated from ChapterLocalOperators.lean — theorem BookProof.LocalOperators.not_translationInvariant_of_pointSupported
import Mathlib
import Definitions.Def_ChapterLocalOperators
open BookProof.LocalOperators

variable {d : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]



open MeasureTheory


theorem BookProof.LocalOperators.not_translationInvariant_of_pointSupported
    (hd : 0 < d) (l : LocalField d E) (x₀ : Fin d → ℝ)
    (hne : l x₀ ≠ 0) (hsupp : ∀ z, z ≠ x₀ → l z = 0) :
    ¬ TranslationInvariant l := by sorry
