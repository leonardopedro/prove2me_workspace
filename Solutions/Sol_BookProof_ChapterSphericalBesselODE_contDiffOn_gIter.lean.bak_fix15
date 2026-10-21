-- Generated from ChapterSphericalBesselODE.lean — solution of BookProof.ChapterSphericalBesselODE.contDiffOn_gIter
import Mathlib
import Definitions.Def_ChapterSphericalBesselODE
import Theorems.Thm_BookProof_ChapterSphericalBesselODE_contDiffOn_sbesselBase
open BookProof.ChapterSphericalBesselODE




open BookProof.ChapterSphericalBessel

set_option maxHeartbeats 1000000 in
theorem solution (l : ℕ) : ContDiffOn ℝ (⊤ : ℕ∞) (gIter l) {r : ℝ | r ≠ 0} := by

  induction l with
  | zero => simpa [gIter] using contDiffOn_sbesselBase
  | succ n ih =>
      have hstep : gIter (n + 1) = rayleighOp (gIter n) := by
        simp [gIter, Function.iterate_succ_apply']
      rw [hstep]
      have hd : ContDiffOn ℝ (⊤ : ℕ∞) (deriv (gIter n)) {r : ℝ | r ≠ 0} :=
        ih.deriv_of_isOpen (m := (⊤ : ℕ∞)) isOpen_ne (by simp)
      have hinv : ContDiffOn ℝ (⊤ : ℕ∞) (fun r : ℝ => -(1 / r)) {r : ℝ | r ≠ 0} := by
        apply ContDiffOn.neg
        apply ContDiffOn.div contDiffOn_const contDiff_id.contDiffOn
        intro x hx; exact hx
      exact hinv.mul hd
