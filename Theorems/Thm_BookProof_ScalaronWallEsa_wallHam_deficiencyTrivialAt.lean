-- Generated from ChapterScalaronWallEsa.lean — theorem BookProof.ScalaronWallEsa.wallHam_deficiencyTrivialAt
import Mathlib
import Definitions.Def_ChapterScalaronWallEsa
open BookProof.ScalaronWallEsa



open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.Starobinsky BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent
open BookProof.WeakSecondDeriv

noncomputable section

ongr_ae (Filter.Eventually.of_forall fun x => ?_)
    ring
  rw [hsplit]
  linear_combination -h1

theorem BookProof.ScalaronWallEsa.wallHam_deficiencyTrivialAt (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ := by sorry
