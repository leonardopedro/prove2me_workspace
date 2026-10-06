-- Generated from ChapterSmGaugeConnection.lean — solution of BookProof.SmGaugeConnection.covD_zero_coupling
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
theorem solution (k : Fin 3 → ℝ) (T : Fin d → Matrix (Fin N) (Fin N) ℂ)
    (A : Fin d → Fin 3 → ℝ) (j : Fin 3) :
    covD k 0 T A j = (Complex.I * ((k j : ℝ) : ℂ)) • (1 : Matrix (Fin N) (Fin N) ℂ) := by

  rw [covD, conn_zero_coupling, add_zero, smul_smul]
