-- Generated from ChapterQuadraticRotationEsa.lean — solution of BookProof.QuadraticRotation.exists_rotConj_eigenvalues
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
import Theorems.Thm_BookProof_QuadraticRotation_rotConj_eq
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
    ∃ O : Matrix (Fin d) (Fin d) ℝ, Oᵀ * O = 1 ∧ A = rotConj O hA.eigenvalues := by

  classical
  refine ⟨(hA.eigenvectorUnitary : Matrix (Fin d) (Fin d) ℝ), ?_, ?_⟩
  · have hu := hA.eigenvectorUnitary.2
    rw [Unitary.mem_iff] at hu
    have hkey : star (hA.eigenvectorUnitary : Matrix (Fin d) (Fin d) ℝ)
        = (hA.eigenvectorUnitary : Matrix (Fin d) (Fin d) ℝ)ᵀ := rfl
    rw [← hkey]
    exact hu.1
  · have hspec := hA.spectral_theorem
    rw [Unitary.conjStarAlgAut_apply] at hspec
    have hd : (Matrix.diagonal (RCLike.ofReal ∘ hA.eigenvalues) : Matrix (Fin d) (Fin d) ℝ)
        = Matrix.diagonal hA.eigenvalues := by congr 1
    have hst : star (hA.eigenvectorUnitary : Matrix (Fin d) (Fin d) ℝ)
        = (hA.eigenvectorUnitary : Matrix (Fin d) (Fin d) ℝ)ᵀ := by
      simp [Matrix.star_eq_conjTranspose, Matrix.conjTranspose]
      rfl
    rw [rotConj_eq, ← hd, ← hst]
    exact hspec
