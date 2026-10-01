-- Generated from ChapterWallEsaSemibounded.lean — theorem BookProof.WallEsaSemibounded.kinCcR_quadratic_form
import Mathlib
import Definitions.Def_ChapterWallEsaSemibounded
open BookProof.WallEsaSemibounded

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa BookProof.WallEsaBddBelow

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


      = -∫ x, (starRingEnd ℂ) (deriv (deriv f) x) * f x := by
    rw [← integral_neg]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp
  rw [hneg]
  linear_combination -hzero

theorem BookProof.WallEsaSemibounded.kinCcR_quadratic_form (g : 𝓢 := by sorry
