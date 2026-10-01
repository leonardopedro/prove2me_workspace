-- Generated from ChapterScalaronWallEsa.lean — theorem BookProof.ScalaronWallEsa.wallHam_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterScalaronWallEsa
open BookProof.ScalaronWallEsa



open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.Starobinsky BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent
open BookProof.WeakSecondDeriv

noncomputable section

ode_solution_eq_zero hVnn hz hW hW' hintW
  refine Lp.eq_zero_iff_ae_eq_zero.mpr ?_
  filter_upwards [hWae] with x hx
  simp [hx, hzero x]

theorem BookProof.ScalaronWallEsa.wallHam_essentiallySelfAdjoint (V : ℝ → ℝ) (hV : C := by sorry
