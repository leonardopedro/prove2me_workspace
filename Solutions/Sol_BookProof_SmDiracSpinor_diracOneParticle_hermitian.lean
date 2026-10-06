-- Generated from ChapterSmDiracSpinor.lean — solution of BookProof.SmDiracSpinor.diracOneParticle_hermitian
import Mathlib
import Definitions.Def_ChapterSmDiracSpinor
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_diracHamOp_conjTranspose
open BookProof.SmDiracSpinor




open Matrix
open BookProof.ChapterCPTHamiltonian BookProof.SmCar BookProof.SmDiracYukawa
open BookProof.FarisLavine

noncomputable section

variable {k : Fin 3 → ℝ} {m1 m2 : ℝ}

variable {k : Fin 3 → ℝ} {m1 m2 : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution :
    (diracOneParticle k m1 m2).conjTranspose = diracOneParticle k m1 m2 := by

  rw [diracOneParticle, Matrix.conjTranspose_smul, diracHamOp_conjTranspose]
  have hI : star (-Complex.I) = Complex.I := by simp
  rw [hI]
  simp [smul_neg, neg_smul]
