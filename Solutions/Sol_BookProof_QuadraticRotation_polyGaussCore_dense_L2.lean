-- Generated from ChapterQuadraticRotationEsa.lean — solution of BookProof.QuadraticRotation.polyGaussCore_dense_L2
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
theorem solution :
    Dense ((polyGaussCore (d := d) : Submodule ℂ (L2d d)) : Set (L2d d)) := polyGaussCore_dense
