-- Generated from ChapterSmGaugeConnection.lean — solution of BookProof.SmGaugeConnection.conn_conjTranspose
import Mathlib
import Definitions.Def_ChapterSmGaugeConnection
open BookProof.SmGaugeConnection




open Matrix Kronecker
open BookProof.YangMillsSU3 BookProof.ChapterCPTHamiltonian BookProof.SmCar
open BookProof.SmDiracYukawa BookProof.SmDiracSpinor BookProof.FarisLavine

noncomputable section

variable {N d : ℕ}

variable {N d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {g : ℝ} {T : Fin d → Matrix (Fin N) (Fin N) ℂ}
    {A : Fin d → Fin 3 → ℝ} (hT : ∀ a, (T a)ᴴ = T a) (j : Fin 3) :
    (conn g T A j)ᴴ = conn g T A j := by

  rw [conn, Matrix.conjTranspose_sum]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [Matrix.conjTranspose_smul, hT a, Complex.star_def, Complex.conj_ofReal]
