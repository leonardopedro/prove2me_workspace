-- Generated from ChapterBookBrstYangMills.lean — solution of BookProof.BookBrstYangMills.bookCCR
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Theorems.Thm_BookProof_BookBrstYangMills_bosOpN_mul
import Theorems.Thm_BookProof_BookBrstYangMills_bosOpN_zero
import Theorems.Thm_BookProof_BookBrstYangMills_bosOpN_sub
import Theorems.Thm_BookProof_BookBrstYangMills_bosOpN_one
import Theorems.Thm_BookProof_BookBrstYangMills_bosOpN_smul
import Theorems.Thm_BookProof_BookBrstYangMills_bookCCR_poly
open BookProof.BookBrstYangMills




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution (μ ν : Fin 4) (a b : Fin N) :
    Afield μ a * mom ν b - mom ν b * Afield μ a
      = if (μ, a) = (ν, b) then (Complex.I • 1 : Module.End ℂ (BookState N)) else 0 := by

  classical
  rw [Afield, mom, ← bosOpN_mul, ← bosOpN_mul, ← bosOpN_sub, bookCCR_poly]
  by_cases h : (μ, a) = (ν, b)
  · rw [if_pos h, if_pos h, bosOpN_smul, bosOpN_one]
  · rw [if_neg h, if_neg h, bosOpN_zero]
