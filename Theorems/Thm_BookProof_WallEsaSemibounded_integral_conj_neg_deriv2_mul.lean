-- Generated from ChapterWallEsaSemibounded.lean — theorem BookProof.WallEsaSemibounded.integral_conj_neg_deriv2_mul
import Mathlib
import Definitions.Def_ChapterWallEsaSemibounded
open BookProof.WallEsaSemibounded

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa BookProof.WallEsaBddBelow

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.WallEsaSemibounded.integral_conj_neg_deriv2_mul (f : ℝ → ℂ)
    (h1 : ∀ x, HasDerivAt f (deriv f x) x)
    (h2 : ∀ x, Ha := by sorry
