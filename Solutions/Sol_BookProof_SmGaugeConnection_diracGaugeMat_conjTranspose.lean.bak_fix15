-- Generated from ChapterSmGaugeConnection.lean — solution of BookProof.SmGaugeConnection.diracGaugeMat_conjTranspose
import Mathlib
import Definitions.Def_ChapterSmGaugeConnection
import Theorems.Thm_BookProof_SmGaugeConnection_conn_conjTranspose
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_Kin_conjTranspose
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_MassA_conjTranspose
import Theorems.Thm_BookProof_ChapterCPTHamiltonian_MassB_conjTranspose
open BookProof.SmGaugeConnection




open Matrix Kronecker
open BookProof.YangMillsSU3 BookProof.ChapterCPTHamiltonian BookProof.SmCar
open BookProof.SmDiracYukawa BookProof.SmDiracSpinor BookProof.FarisLavine

noncomputable section

variable {N d : ℕ}

variable {N d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {k : Fin 3 → ℝ} {m1 m2 g : ℝ}
    {T : Fin d → Matrix (Fin N) (Fin N) ℂ} {A : Fin d → Fin 3 → ℝ} (hT : ∀ a, (T a)ᴴ = T a) :
    (diracGaugeMat k m1 m2 g T A)ᴴ = diracGaugeMat k m1 m2 g T A := by

  rw [diracGaugeMat, Matrix.conjTranspose_add, Matrix.conjTranspose_sum]
  congr 1
  · refine Finset.sum_congr rfl fun j _ => ?_
    rw [Matrix.conjTranspose_kronecker, Kin_conjTranspose, Matrix.conjTranspose_add,
      Matrix.conjTranspose_smul, Matrix.conjTranspose_one, conn_conjTranspose hT,
      Complex.star_def, Complex.conj_ofReal]
  · rw [Matrix.conjTranspose_kronecker, Matrix.conjTranspose_one, Matrix.conjTranspose_add,
      Matrix.conjTranspose_smul, Matrix.conjTranspose_smul, MassA_conjTranspose,
      MassB_conjTranspose]
    have h1 : star ((-Complex.I) * (m1 : ℂ)) = Complex.I * (m1 : ℂ) := by
      simp [mul_comm]
    have h2 : star ((-Complex.I) * (m2 : ℂ)) = Complex.I * (m2 : ℂ) := by
      simp [mul_comm]
    rw [h1, h2, smul_neg, smul_neg, ← neg_smul, ← neg_smul]
    congr 2 <;> ring
