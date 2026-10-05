-- Generated from ChapterWallDeficiencyObstruction.lean — solution of BookProof.WallDeficiencyObstruction.no_l2_solution_of_nonneg
import Mathlib
import Definitions.Def_ChapterWallDeficiencyObstruction
import Theorems.Thm_BookProof_ScalaronWallEsa_ode_solution_eq_zero
open BookProof.WallDeficiencyObstruction




open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {V : ℝ → ℝ} (hVnn : ∀ x, 0 ≤ V x) {z : ℂ} (hz : z.re = 0)
    {W : ℝ → ℂ} (hsol : IsL2Ode V z W) : ∀ x, W x = 0 := by

  obtain ⟨W', hW, hW', hmem⟩ := hsol
  have hint : Integrable (fun x => ‖W x‖ ^ 2) (volume : Measure ℝ) := by
    have hW2 : MemLp W 2 (volume : Measure ℝ) := hmem
    exact (memLp_two_iff_integrable_sq_norm hW2.aestronglyMeasurable).1 hW2
  exact ode_solution_eq_zero hVnn hz hW hW' hint
