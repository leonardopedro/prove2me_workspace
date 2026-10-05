-- Generated from ChapterQuadraticRotationEsa.lean — solution of BookProof.QuadraticRotation.wave_rotated_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
import Theorems.Thm_BookProof_QuadraticRotation_quadOpMat_rotConj_essentiallySelfAdjoint
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
theorem solution {n : ℕ}
    {O : Matrix (Fin (1 + n)) (Fin (1 + n)) ℝ} (hO : Oᵀ * O = 1) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 1 + n))
      (quadOpMat (rotConj O (minkowskiCoeff n))) := quadOpMat_rotConj_essentiallySelfAdjoint hO (minkowskiCoeff n)
