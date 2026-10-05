-- Generated from ChapterBddBelowWallEsa.lean — solution of BookProof.BddBelowWallEsa.wallHam_deficiencyTrivialAt_of_bddBelow
import Mathlib
import Definitions.Def_ChapterBddBelowWallEsa
import Theorems.Thm_BookProof_BddBelowWallEsa_ode_solution_eq_zero_of_bddBelow
import Theorems.Thm_BookProof_ScalaronWallEsa_wallHam_weak_eq
open BookProof.BddBelowWallEsa




open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

variable {V : ℝ → ℝ} {z : ℂ} {W W' : ℝ → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) {K : ℝ} (hVK : ∀ x, -K ≤ V x)
    {z : ℂ} (hzre : z.re = 0) (hzim : z.im ≠ 0) :
    DeficiencyTrivialAt (ccDomain ℝ) (wallHam V hV) z := by

  intro u hu
  have hloc : LocallyIntegrable (fun x => (u x : ℂ)) (volume : Measure ℝ) :=
    (Lp.memLp u).locallyIntegrable (by norm_num)
  have hc : Continuous fun x : ℝ => ((V x : ℝ) : ℂ) - z :=
    (Complex.continuous_ofReal.comp hV.continuous).sub continuous_const
  obtain ⟨W, W', hW, hW', hWae⟩ :=
    exists_deriv2_of_weak_eq hloc hc (fun g hg => wallHam_weak_eq V hV z u hu hg)
  have hintu : Integrable (fun x => ‖u x‖ ^ 2) (volume : Measure ℝ) :=
    (memLp_two_iff_integrable_sq_norm (Lp.aestronglyMeasurable u)).1 (Lp.memLp u)
  have hintW : Integrable (fun x => ‖W x‖ ^ 2) (volume : Measure ℝ) := by
    refine hintu.congr ?_
    filter_upwards [hWae] with x hx
    rw [hx]
  have hzero := ode_solution_eq_zero_of_bddBelow hV.continuous hVK hzre hzim hW hW' hintW
  refine Lp.eq_zero_iff_ae_eq_zero.mpr ?_
  filter_upwards [hWae] with x hx
  simp [hx, hzero x]
