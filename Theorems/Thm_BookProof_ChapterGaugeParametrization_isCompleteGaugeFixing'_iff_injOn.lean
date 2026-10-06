-- Generated from ChapterGaugeParametrization.lean — theorem BookProof.ChapterGaugeParametrization.isCompleteGaugeFixing'_iff_injOn
import Mathlib
import Definitions.Def_ChapterGaugeParametrization
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeParametrization

variable {X Y : Type*}



open BookProof.ChapterGaugeIncompleteFixing


theorem BookProof.ChapterGaugeParametrization.isCompleteGaugeFixing_prime_iff_injOn (π : X → Y) (S : Set X) :
    IsCompleteGaugeFixing' (fiberGauge π) S ↔ Set.InjOn π S := by sorry
