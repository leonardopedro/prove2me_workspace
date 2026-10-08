-- Generated from ChapterGaugeParametrization.lean — theorem BookProof.ChapterGaugeParametrization.isComprehensiveGaugeFixing_iff_surjOn
import Mathlib
import Definitions.Def_ChapterGaugeParametrization
import Definitions.Def_ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeIncompleteFixing
open BookProof.ChapterGaugeParametrization



open BookProof.ChapterGaugeIncompleteFixing

variable {X Y : Type*}


theorem BookProof.ChapterGaugeParametrization.isComprehensiveGaugeFixing_iff_surjOn (π : X → Y) (S : Set X) :
    IsComprehensiveGaugeFixing (fiberGauge π) S ↔ ∀ x : X, ∃ s ∈ S, π s = π x := by sorry
