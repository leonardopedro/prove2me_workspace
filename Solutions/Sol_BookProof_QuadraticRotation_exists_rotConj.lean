-- Generated from ChapterQuadraticRotationEsa.lean — solution of BookProof.QuadraticRotation.exists_rotConj
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
import Theorems.Thm_BookProof_QuadraticRotation_exists_rotConj_eigenvalues
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
    ∃ (O : Matrix (Fin d) (Fin d) ℝ) (c : Fin d → ℝ), Oᵀ * O = 1 ∧ A = rotConj O c := by

  obtain ⟨O, hO, hAO⟩ := exists_rotConj_eigenvalues hA
  exact ⟨O, hA.eigenvalues, hO, hAO⟩
