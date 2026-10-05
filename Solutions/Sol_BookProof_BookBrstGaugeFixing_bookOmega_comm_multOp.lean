-- Generated from ChapterBookBrstGaugeFixing.lean — solution of BookProof.BookBrstGaugeFixing.bookOmega_comm_multOp
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
import Theorems.Thm_BookProof_BookBrstGaugeFixing_bookOmega_comm_of_comm
import Theorems.Thm_BookProof_BookBrstGaugeFixing_gaussGen_comm_multOp
import Theorems.Thm_BookProof_BookBrstYangMills_bosOpN_ghostOpN_comm
open BookProof.BookBrstGaugeFixing




open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}
variable {N : ℕ} (G : GaugeAlgebra N)
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β : Fin n → R}

set_option maxHeartbeats 1000000 in
theorem solution {p : FieldPoly N} (hp : ∀ c, gaussDer G c p = 0) :
    bookOmega G * multOp p = multOp p * bookOmega G :=
  bookOmega_comm_of_comm G (gaussGen_comm_multOp G hp)
      (fun _ => (bosOpN_ghostOpN_comm _ _).symm) (fun _ => (bosOpN_ghostOpN_comm _ _).symm)
