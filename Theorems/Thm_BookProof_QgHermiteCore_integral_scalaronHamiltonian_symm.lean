-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.integral_scalaronHamiltonian_symm
import Definitions.Def_ChapterHermiteFunctions
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterStarobinskyPotential
open BookProof.Starobinsky
open BookProof.QgHermiteCore

variable {E : Type*} [NormedAddCommGroup E]
variable {d : ℕ}



open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

theorem BookProof.QgHermiteCore.integral_scalaronHamiltonian_symm (M alpha : ℝ) (hM : 0 < M) (p q : Polynomial ℝ) :
    ∫ x : ℝ, gaussPoly p x
        * (-deriv (deriv (gaussPoly q)) x + starobinskyV M alpha x * gaussPoly q x)
      = ∫ x : ℝ, (-deriv (deriv (gaussPoly p)) x + starobinskyV M alpha x * gaussPoly p x)
        * gaussPoly q x := by sorry
