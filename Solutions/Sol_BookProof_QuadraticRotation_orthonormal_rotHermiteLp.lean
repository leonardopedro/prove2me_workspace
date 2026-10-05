-- Generated from ChapterQuadraticRotationEsa.lean — solution of BookProof.QuadraticRotation.orthonormal_rotHermiteLp
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
import Theorems.Thm_BookProof_QuadraticRotation_inner_rotHermiteLp
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
    Orthonormal ℂ (rotHermiteLp (d := d) O) := by

  rw [orthonormal_iff_ite]
  intro a b
  rw [inner_rotHermiteLp hO]
  exact orthonormal_iff_ite.mp orthonormal_hermiteMvLp a b
