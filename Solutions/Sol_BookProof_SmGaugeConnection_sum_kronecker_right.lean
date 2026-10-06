-- Generated from ChapterSmGaugeConnection.lean — solution of BookProof.SmGaugeConnection.sum_kronecker_right
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
theorem solution {n : ℕ} (F : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ)
    (B : Matrix (Fin n) (Fin n) ℂ) : (∑ j : Fin 3, F j) ⊗ₖ B = ∑ j : Fin 3, (F j) ⊗ₖ B := by

  classical
  induction (Finset.univ : Finset (Fin 3)) using Finset.induction with
  | empty => simp
  | insert a s ha ih => rw [Finset.sum_insert ha, Finset.sum_insert ha, Matrix.add_kronecker, ih]
