-- Generated from ChapterQuadraticRotationEsa.lean — solution of BookProof.QuadraticRotation.quadOpMat_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
import Theorems.Thm_BookProof_QuadraticRotation_quadOpMat_rotConj_essentiallySelfAdjoint
import Theorems.Thm_BookProof_QuadraticRotation_exists_rotConj
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
theorem solution {A : Matrix (Fin d) (Fin d) ℝ} (hA : A.IsHermitian) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (quadOpMat A) := by

  obtain ⟨O, c, hO, rfl⟩ := exists_rotConj hA
  exact quadOpMat_rotConj_essentiallySelfAdjoint hO c
