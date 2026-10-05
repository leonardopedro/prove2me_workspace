-- Generated from ChapterA4h.lean — solution of BookProof.ChapterA4h.prop87_assembled
import Mathlib
import Definitions.Def_ChapterA4h
import Theorems.Thm_BookProof_ChapterA4h_localizable_iff_massShell
open BookProof.ChapterA4h



open Matrix


open BookProof.ChapterA4e BookProof.ChapterA4f BookProof.ChapterA5

variable (R : Type*)

set_option maxHeartbeats 1000000 in
theorem solution (Mk : MackeyImprimitivity R)
    (Wg : WignerClassification R Mk) (ρ : R) :
    PoincareType.of (Mk.massSq ρ) (Mk.contSpin ρ) = PoincareType.massive ∨
    PoincareType.of (Mk.massSq ρ) (Mk.contSpin ρ) = PoincareType.masslessDiscrete := by

  have hshell := (localizable_iff_massShell _ _ _).1 (Mk.induced ρ)
  have hnn : 0 ≤ Mk.massSq ρ := by
    unfold MackeyImprimitivity.massSq
    rw [← hshell]; positivity
  unfold PoincareType.of
  rcases lt_or_eq_of_le hnn with h | h
  · left; simp [h]
  · right
    rw [← h]
    simp [Wg.no_continuous_spin ρ h.symm]
