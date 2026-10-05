-- Generated from ChapterQuadraticRotationEsa.lean — solution of BookProof.QuadraticRotation.quadOpMat_rotConj_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
import Theorems.Thm_BookProof_QuadraticRotation_quadOpMat_rotConj_deficiencyTrivialAt
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
theorem solution {O : Matrix (Fin d) (Fin d) ℝ}
    (hO : Oᵀ * O = 1) (c : Fin d → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (quadOpMat (rotConj O c)) :=
  ⟨quadOpMat_rotConj_deficiencyTrivialAt hO c (by simp),
      quadOpMat_rotConj_deficiencyTrivialAt hO c (by simp)⟩
