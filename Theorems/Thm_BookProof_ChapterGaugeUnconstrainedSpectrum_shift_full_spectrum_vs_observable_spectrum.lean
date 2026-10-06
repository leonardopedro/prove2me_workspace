-- Generated from ChapterGaugeUnconstrainedSpectrum.lean — theorem BookProof.ChapterGaugeUnconstrainedSpectrum.shift_full_spectrum_vs_observable_spectrum
import Mathlib
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
open BookProof.ChapterGaugeUnconstrainedSpectrum

variable {X : Type*}
variable {G : Type*} [Group G]




theorem BookProof.ChapterGaugeUnconstrainedSpectrum.shift_full_spectrum_vs_observable_spectrum :
    IsUnconstrainedGaugeFixing (fun m : Multiplicative ℤ => permOp (shiftPerm m)) ∧
      constrainedSpectrum (fun m : Multiplicative ℤ => permOp (shiftPerm m)) =
        (Set.univ : Set ℤ) ∧
      (Set.univ : Set ℤ).Infinite ∧
      Subsingleton (observableSpectrum shiftPerm) := by sorry
