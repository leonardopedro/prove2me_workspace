-- Generated from ChapterWallEsaSemibounded.lean — theorem BookProof.WallEsaSemibounded.integral_conj_neg_deriv2_mul
import Mathlib
import Definitions.Def_ChapterWallEsaSemibounded
open BookProof.WallEsaSemibounded










open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa BookProof.WallEsaBddBelow

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.WallEsaSemibounded.integral_conj_neg_deriv2_mul (f : ℝ → ℂ)
    (hf : ContDiff ℝ 2 f) (hs : HasCompactSupport f) :
    ∫ x, (starRingEnd ℂ) (-deriv (deriv f) x) * f x = ((∫ x, ‖deriv f x‖ ^ 2 : ℝ) : ℂ) := by sorry
