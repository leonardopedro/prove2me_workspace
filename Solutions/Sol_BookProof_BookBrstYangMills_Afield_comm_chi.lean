-- Generated from ChapterBookBrstYangMills.lean — solution of BookProof.BookBrstYangMills.Afield_comm_chi
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Theorems.Thm_BookProof_BookBrstYangMills_bosOpN_ghostOpN_comm
open BookProof.BookBrstYangMills




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution (μ : Fin 4) (a b : Fin N) :
    Afield (N := N) μ a * chiOp b = chiOp b * Afield μ a := bosOpN_ghostOpN_comm _ _
