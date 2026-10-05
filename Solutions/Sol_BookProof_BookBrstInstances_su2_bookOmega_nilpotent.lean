-- Generated from ChapterBookBrstInstances.lean — solution of BookProof.BookBrstInstances.su2_bookOmega_nilpotent
import Mathlib
import Definitions.Def_ChapterBookBrstInstances
import Theorems.Thm_BookProof_BookBrstYangMills_bookOmega_nilpotent
open BookProof.BookBrstInstances




open BookProof.BookBrstYangMills BookProof.BookBrstGaugeFixing BookProof.SmBrstGhost
open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open MvPolynomial

noncomputable section

variable {N : ℕ} (f : Fin N → Fin N → Fin N → ℝ)

variable {N : ℕ} (f : Fin N → Fin N → Fin N → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (x : Fin 4 → Fin 3 → ℝ) :
    bookOmega (su2BookAlgebra x) * bookOmega (su2BookAlgebra x) = 0 := bookOmega_nilpotent _
