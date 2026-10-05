-- Generated from ChapterBookBrstYangMills.lean — solution of BookProof.BookBrstYangMills.bookOmega_nilpotent
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Theorems.Thm_BookProof_BookBrstYangMills_bookGhostCar
import Theorems.Thm_BookProof_BookBrstYangMills_bookOmega_eq_brstCharge
import Theorems.Thm_BookProof_BookBrstYangMills_bookConstraintAlgebra
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_brst_full_nilpotent
open BookProof.BookBrstYangMills




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution : bookOmega G * bookOmega G = 0 := by

  have hnil : brstCharge G.f (gaussGen G) chiOp betaOp * brstCharge G.f (gaussGen G) chiOp betaOp
      = 0 :=
    brst_full_nilpotent bookGhostCar (bookConstraintAlgebra G) G.antisymm
      (fun a b c d => G.jacobi a b c d)
  rw [bookOmega_eq_brstCharge, smul_mul_smul_comm, hnil, smul_zero]
