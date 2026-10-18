-- Generated from ChapterWallEsaSemibounded.lean — solution of BookProof.WallEsaSemibounded.integral_conj_neg_deriv2_mul
import Mathlib
import Definitions.Def_ChapterWallEsaSemibounded
import Theorems.Thm_BookProof_SchrodingerCutoff_integral_deriv_eq_zero_of_hasCompactSupport
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterWallEsaBddBelow
open BookProof.WallEsaSemibounded




open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa BookProof.WallEsaBddBelow

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (f : ℝ → ℂ)
    (h1 : ∀ x, HasDerivAt f (deriv f x) x)
    (h2 : ∀ x, HasDerivAt (deriv f) (deriv (deriv f) x) x) (x : ℝ) :
    HasDerivAt (fun t : ℝ => (starRingEnd ℂ) (deriv f t) * f t)
      ((starRingEnd ℂ) (deriv (deriv f) x) * f x + ((‖deriv f x‖ ^ 2 : ℝ) : ℂ)) x := by
    have hstar : HasDerivAt (fun y : ℝ => (starRingEnd ℂ) (deriv f y))
        ((starRingEnd ℂ) (deriv (deriv f) x)) x := (h2 x).star
    have hmul := hstar.mul (h1 x)
    have hsq : (starRingEnd ℂ) (deriv f x) * deriv f x = ((‖deriv f x‖ ^ 2 : ℝ) : ℂ) := by
      rw [Complex.normSq_eq_conj_mul_self.symm, Complex.sq_norm]
    rwa [hsq] at hmul
