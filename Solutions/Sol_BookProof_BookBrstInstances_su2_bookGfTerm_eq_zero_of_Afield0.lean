-- Generated from ChapterBookBrstInstances.lean — solution of BookProof.BookBrstInstances.su2_bookGfTerm_eq_zero_of_Afield0
import Mathlib
import Definitions.Def_ChapterBookBrstInstances
import Theorems.Thm_BookProof_BookBrstGaugeFixing_bookGfTerm_eq_zero_of_Afield0
open BookProof.BookBrstInstances




open BookProof.BookBrstYangMills BookProof.BookBrstGaugeFixing BookProof.SmBrstGhost
open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open MvPolynomial

noncomputable section

variable {N : ℕ} (f : Fin N → Fin N → Fin N → ℝ)

variable {N : ℕ} (f : Fin N → Fin N → Fin N → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (x : Fin 4 → Fin 3 → ℝ)
    (hA0 : ∀ a : Fin 3, Afield (N := 3) 0 a = 0) :
    bookGfTerm (su2BookAlgebra x) = 0 := bookGfTerm_eq_zero_of_Afield0 (su2BookAlgebra x) hA0
