-- Generated from ChapterWallEsaSemibounded.lean — theorem BookProof.WallEsaSemibounded.kinCcR_quadratic_form
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterWallEsaBddBelow
import Mathlib
import Definitions.Def_ChapterWallEsaSemibounded
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterStrichartzWave
open BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.StrichartzWave
open BookProof.WallEsaSemibounded

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa BookProof.WallEsaBddBelow

noncomputable section



      = -∫ x, (starRingEnd ℂ) (deriv (deriv f) x) * f x := by
    rw [← integral_neg]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp
  rw [hneg]
  linear_combination -hzero

theorem BookProof.WallEsaSemibounded.kinCcR_quadratic_form (g : 𝓢 := by sorry
