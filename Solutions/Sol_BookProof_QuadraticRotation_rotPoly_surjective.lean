-- Generated from ChapterQuadraticRotationEsa.lean — solution of BookProof.QuadraticRotation.rotPoly_surjective
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
import Theorems.Thm_BookProof_QuadraticRotation_rotPoly_rotPoly_transpose
open BookProof.QuadraticRotation




open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1) :
    Function.Surjective (rotPoly O) :=
  fun p =>
    ⟨rotPoly Oᵀ p, rotPoly_rotPoly_transpose hO p⟩
