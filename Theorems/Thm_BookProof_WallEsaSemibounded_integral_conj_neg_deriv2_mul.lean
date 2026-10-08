-- Generated from ChapterWallEsaSemibounded.lean — theorem BookProof.WallEsaSemibounded.integral_conj_neg_deriv2_mul
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterWallEsaBddBelow
import Mathlib
import Definitions.Def_ChapterWallEsaSemibounded
open BookProof.WallEsaSemibounded



open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa BookProof.WallEsaBddBelow

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


theorem BookProof.WallEsaSemibounded.integral_conj_neg_deriv2_mul (f : ℝ → ℂ)
    (h1 : ∀ x, HasDerivAt f (deriv f x) x)
    (h2 : ∀ x, HasDerivAt (deriv f) (deriv (deriv f) x) x) (x : ℝ) :
    HasDerivAt (fun t : ℝ => (starRingEnd ℂ) (deriv f t) * f t)
      ((starRingEnd ℂ) (deriv (deriv f) x) * f x + ((‖deriv f x‖ ^ 2 : ℝ) : ℂ)) x := by sorry
