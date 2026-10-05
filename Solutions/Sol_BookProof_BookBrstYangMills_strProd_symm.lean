-- Generated from ChapterBookBrstYangMills.lean — solution of BookProof.BookBrstYangMills.strProd_symm
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
open BookProof.BookBrstYangMills




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution (p q r s : Fin N) : strProd G p q r s = strProd G r s p q := Finset.sum_congr rfl fun _ _ => mul_comm _ _
