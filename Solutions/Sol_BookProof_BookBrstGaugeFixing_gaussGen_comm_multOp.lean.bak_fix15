-- Generated from ChapterBookBrstGaugeFixing.lean — solution of BookProof.BookBrstGaugeFixing.gaussGen_comm_multOp
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
import Theorems.Thm_BookProof_BookBrstGaugeFixing_gaussGenPoly_comm_mulLeft
import Theorems.Thm_BookProof_BookBrstYangMills_bosOpN_mul
open BookProof.BookBrstGaugeFixing




open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}
variable {N : ℕ} (G : GaugeAlgebra N)
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β : Fin n → R}

set_option maxHeartbeats 1000000 in
theorem solution {p : FieldPoly N} (hp : ∀ c, gaussDer G c p = 0) (c : Fin N) :
    gaussGen G c * multOp p = multOp p * gaussGen G c := by

  have h := gaussGenPoly_comm_mulLeft G c p
  rw [hp c] at h
  have h0 : LinearMap.mulLeft ℂ (0 : FieldPoly N) = 0 := by
    refine LinearMap.ext fun q => ?_
    simp
  rw [h0, sub_eq_zero] at h
  rw [gaussGen, multOp, ← bosOpN_mul, ← bosOpN_mul, h]
