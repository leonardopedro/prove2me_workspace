-- Generated from ChapterSchrodingerCutoffEsa.lean — theorem BookProof.SchrodingerCutoff.exists_scaled_cutoff
import Mathlib
import Definitions.Def_ChapterSchrodingerCutoffEsa
open BookProof.SchrodingerCutoff



open MeasureTheory Filter Complex

theorem BookProof.SchrodingerCutoff.exists_scaled_cutoff {C R : ℝ} (hC : ∀ y, |deriv chi y| ≤ C) (hR : 0 < R) :
    ∃ w wd : ℝ → ℝ, (∀ x, HasDerivAt w (wd x) x) ∧ Continuous w ∧ Continuous wd ∧
      (∀ x : ℝ, 2 * R < |x| → w x = 0) ∧ (∀ x : ℝ, 2 * R < |x| → wd x = 0) ∧
      (∀ x : ℝ, |x| ≤ R → w x = 1) ∧ (∀ x, |wd x| ≤ C / R) := by sorry
