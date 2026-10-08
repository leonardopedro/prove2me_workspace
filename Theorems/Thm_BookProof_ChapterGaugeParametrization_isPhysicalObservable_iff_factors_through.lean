-- Generated from ChapterGaugeParametrization.lean — theorem BookProof.ChapterGaugeParametrization.isPhysicalObservable_iff_factors_through
import Mathlib
import Definitions.Def_ChapterGaugeParametrization
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeParametrization



open BookProof.ChapterGaugeIncompleteFixing

variable {X Y : Type*}


theorem BookProof.ChapterGaugeParametrization.isPhysicalObservable_iff_factors_through (π : X → Y) (f : X → ℝ) :
    IsPhysicalObservable (fiberGauge π) f ↔ ∃ F : Y → ℝ, ∀ x, f x = F (π x) := by sorry
