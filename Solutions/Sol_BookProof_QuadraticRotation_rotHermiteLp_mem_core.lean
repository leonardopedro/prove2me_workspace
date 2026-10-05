-- Generated from ChapterQuadraticRotationEsa.lean — solution of BookProof.QuadraticRotation.rotHermiteLp_mem_core
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
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
theorem solution (O : Matrix (Fin d) (Fin d) ℝ) (a : Fin d →₀ ℕ) :
    rotHermiteLp O a ∈ polyGaussCore (d := d) := Submodule.smul_mem _ _ (pgLp_mem_core _)
