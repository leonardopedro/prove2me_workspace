import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterWeakSecondDerivative
-- Generated from ChapterScalaronWallEsa.lean — solution of BookProof.ScalaronWallEsa.wallHam_deficiencyTrivialAt
import Mathlib
import Definitions.Def_ChapterScalaronWallEsa
import Theorems.Thm_BookProof_ScalaronWallEsa_ode_solution_eq_zero
import Theorems.Thm_BookProof_ScalaronWallEsa_wallHam_weak_eq
open BookProof.ScalaronWallEsa













open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.Starobinsky BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent
open BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V)
    (hVnn : ∀ x, 0 ≤ V x) {z : ℂ} (hz : z.re = 0) :
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
  have hzero := ode_solution_eq_zero hVnn hz hW hW' hintW
  refine Lp.eq_zero_iff_ae_eq_zero.mpr ?_
  filter_upwards [hWae] with x hx
  simp [hx, hzero x]
