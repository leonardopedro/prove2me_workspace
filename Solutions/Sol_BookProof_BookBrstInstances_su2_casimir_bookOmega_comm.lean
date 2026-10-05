-- Generated from ChapterBookBrstInstances.lean — solution of BookProof.BookBrstInstances.su2_casimir_bookOmega_comm
import Mathlib
import Definitions.Def_ChapterBookBrstInstances
import Theorems.Thm_BookProof_BookBrstGaugeFixing_casimir_bookOmega_comm
open BookProof.BookBrstInstances




open BookProof.BookBrstYangMills BookProof.BookBrstGaugeFixing BookProof.SmBrstGhost
open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open MvPolynomial

noncomputable section

variable {N : ℕ} (f : Fin N → Fin N → Fin N → ℝ)

variable {N : ℕ} (f : Fin N → Fin N → Fin N → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution :
    bookOmega (su2BookAlgebra 0) * multOp (casimirPoly (N := 3))
      = multOp (casimirPoly (N := 3)) * bookOmega (su2BookAlgebra 0) :=
  casimir_bookOmega_comm _ fun _ _ _ => by
      simp [su2BookAlgebra, gaugeAlgebraOfInner, innerDeriv]
