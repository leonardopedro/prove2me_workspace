-- Generated from ChapterQuadraticRotationPerturbed.lean — solution of BookProof.QuadraticRotationPerturbed.quadOpMat_add_firstOrder_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterQuadraticRotationPerturbed
import Theorems.Thm_BookProof_QuadraticRotationPerturbed_quadOpMat_rotConj_add_firstOrder_essentiallySelfAdjoint
import Theorems.Thm_BookProof_QuadraticRotationPerturbed_exists_lower_bound_eigenvalues
import Theorems.Thm_BookProof_QuadraticRotation_exists_rotConj_eigenvalues
open BookProof.QuadraticRotationPerturbed




open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic
open BookProof.HermiteRelative
open BookProof.QuadraticRotation
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {A : Matrix (Fin d) (Fin d) ℝ}
    (hA : A.PosDef) (b b' : Fin d → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (quadOpMat A + foOp b b') := by

  obtain ⟨O, hO, hAO⟩ := exists_rotConj_eigenvalues hA.isHermitian
  obtain ⟨c0, hc0, hle⟩ := exists_lower_bound_eigenvalues hA
  rw [hAO]
  exact quadOpMat_rotConj_add_firstOrder_essentiallySelfAdjoint hO _ hc0 hle b b'
