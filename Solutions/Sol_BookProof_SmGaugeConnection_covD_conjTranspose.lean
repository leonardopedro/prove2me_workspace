-- Generated from ChapterSmGaugeConnection.lean — solution of BookProof.SmGaugeConnection.covD_conjTranspose
import Mathlib
import Definitions.Def_ChapterSmGaugeConnection
import Theorems.Thm_BookProof_SmGaugeConnection_conn_conjTranspose
open BookProof.SmGaugeConnection




open Matrix Kronecker
open BookProof.YangMillsSU3 BookProof.ChapterCPTHamiltonian BookProof.SmCar
open BookProof.SmDiracYukawa BookProof.SmDiracSpinor BookProof.FarisLavine

noncomputable section

variable {N d : ℕ}

variable {N d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {k : Fin 3 → ℝ} {g : ℝ} {T : Fin d → Matrix (Fin N) (Fin N) ℂ}
    {A : Fin d → Fin 3 → ℝ} (hT : ∀ a, (T a)ᴴ = T a) (j : Fin 3) :
    (covD k g T A j)ᴴ = -covD k g T A j := by

  rw [covD, Matrix.conjTranspose_smul, Matrix.conjTranspose_add, Matrix.conjTranspose_smul,
    conn_conjTranspose hT, Matrix.conjTranspose_one]
  have hI : star Complex.I = -Complex.I := by simp
  rw [hI, Complex.star_def, Complex.conj_ofReal, neg_smul]
