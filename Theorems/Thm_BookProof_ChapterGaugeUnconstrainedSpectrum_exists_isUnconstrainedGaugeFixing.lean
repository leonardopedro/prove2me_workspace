-- Generated from ChapterGaugeUnconstrainedSpectrum.lean — theorem BookProof.ChapterGaugeUnconstrainedSpectrum.exists_isUnconstrainedGaugeFixing
import Mathlib
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
open BookProof.ChapterGaugeUnconstrainedSpectrum

variable {X : Type*}
variable {G : Type*} [Group G]




theorem BookProof.ChapterGaugeUnconstrainedSpectrum.exists_isUnconstrainedGaugeFixing :
    ∃ (G : Type) (_ : Group G) (X : Type) (U : G → Op X),
      Nontrivial G ∧ IsUnconstrainedGaugeFixing U ∧
        constrainedSpectrum U = Set.univ := by sorry
