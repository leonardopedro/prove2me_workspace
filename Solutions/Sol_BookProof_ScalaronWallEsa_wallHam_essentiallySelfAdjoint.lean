-- Generated from ChapterScalaronWallEsa.lean — solution of BookProof.ScalaronWallEsa.wallHam_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterScalaronWallEsa
import Theorems.Thm_BookProof_ScalaronWallEsa_wallHam_deficiencyTrivialAt
open BookProof.ScalaronWallEsa




open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.Starobinsky BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent
open BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
ode_solution_eq_zero hVnn hz hW hW' hintW
  refine Lp.eq_zero_iff_ae_eq_zero.mpr ?_
  filter_upwards [hWae] with x hx
  simp [hx, hzero x]

theorem solution (V : ℝ → ℝ) (hV : C :=
  ontDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V)
      (hVnn : ∀ x, 0 ≤ V x) :
      EssentiallySelfAdjointOn (
