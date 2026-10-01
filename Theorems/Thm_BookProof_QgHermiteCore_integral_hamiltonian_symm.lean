-- Generated from ChapterQgHermiteCore.lean — theorem BookProof.QgHermiteCore.integral_hamiltonian_symm
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterStarobinskyPotential
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
open BookProof.QgHermiteCore

variable {E : Type*} [NormedAddCommGroup E]



open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

theorem BookProof.QgHermiteCore.integral_hamiltonian_symm {W : ℝ → ℝ} (hW : Continuous W) (hWb : ExpBounded W)
    (p q : Polynomial ℝ) :
    ∫ x : ℝ, gaussPoly p x * (-deriv (deriv (gaussPoly q)) x + W x * gaussPoly q x)
      = ∫ x : ℝ, (-deriv (deriv (gaussPoly p)) x + W x * gaussPoly p x) * gaussPoly q x := by sorry
