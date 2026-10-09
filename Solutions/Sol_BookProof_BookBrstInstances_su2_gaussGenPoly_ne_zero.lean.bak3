-- Generated from ChapterBookBrstInstances.lean — solution of BookProof.BookBrstInstances.su2_gaussGenPoly_ne_zero
import Mathlib
import Definitions.Def_ChapterBookBrstInstances
import Theorems.Thm_BookProof_BookBrstInstances_su2_gaussVec_value
import Theorems.Thm_BookProof_BookBrstYangMills_gaussDer_X
open BookProof.BookBrstInstances




open BookProof.BookBrstYangMills BookProof.BookBrstGaugeFixing BookProof.SmBrstGhost
open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open MvPolynomial

noncomputable section

variable {N : ℕ} (f : Fin N → Fin N → Fin N → ℝ)

variable {N : ℕ} (f : Fin N → Fin N → Fin N → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution : gaussGenPoly (su2BookAlgebra 0) 0 ≠ 0 := by

  intro hzero
  have happ : gaussGenPoly (su2BookAlgebra 0) 0 (X (0, 1)) = (X (0, 2) : FieldPoly 3) := by
    have : gaussGenPoly (su2BookAlgebra 0) 0 (X (0, 1))
        = gaussDer (su2BookAlgebra 0) 0 (X (0, 1)) := rfl
    rw [this, gaussDer_X, su2_gaussVec_value]
  rw [hzero] at happ
  exact (MvPolynomial.X_ne_zero ((0 : Fin 4), (2 : Fin 3))) happ.symm
