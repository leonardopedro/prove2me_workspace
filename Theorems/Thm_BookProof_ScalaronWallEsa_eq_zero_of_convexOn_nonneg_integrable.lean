-- Generated from ChapterScalaronWallEsa.lean — theorem BookProof.ScalaronWallEsa.eq_zero_of_convexOn_nonneg_integrable
import Mathlib
import Definitions.Def_ChapterScalaronWallEsa
open BookProof.ScalaronWallEsa












open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.Starobinsky BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent
open BookProof.WeakSecondDeriv

noncomputable section

theorem BookProof.ScalaronWallEsa.eq_zero_of_convexOn_nonneg_integrable {F : ℝ → ℝ} (hconv : ConvexOn ℝ univ F)
    (hnn : ∀ x, 0 ≤ F x) (hint : Integrable F volume) (a : ℝ) : F a = 0 := by sorry
