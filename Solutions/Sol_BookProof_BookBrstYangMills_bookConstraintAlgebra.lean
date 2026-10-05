-- Generated from ChapterBookBrstYangMills.lean — solution of BookProof.BookBrstYangMills.bookConstraintAlgebra
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Theorems.Thm_BookProof_BookBrstYangMills_bosOpN_ghostOpN_comm
import Theorems.Thm_BookProof_BookBrstYangMills_gaussGen_bracket
open BookProof.BookBrstYangMills




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution : ConstraintAlgebra G.f (gaussGen G) chiOp betaOp where
  comm_chi _ _ :=
  where
    comm_chi _ _ := bosOpN_ghostOpN_comm _ _
    comm_beta _ _ := bosOpN_ghostOpN_comm _ _
    bracket a b := gaussGen_bracket G a b
