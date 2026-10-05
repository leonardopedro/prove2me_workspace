-- Generated from ChapterBookBrstYangMills.lean — solution of BookProof.BookBrstYangMills.sum_smul_der_apply
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
open BookProof.BookBrstYangMills




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (k : Fin n → ℂ)
    (D : Fin n → Derivation ℂ (FieldPoly N) (FieldPoly N)) (p : FieldPoly N) :
    (∑ h, k h • D h) p = ∑ h, k h • (D h) p := by

  classical
  induction (Finset.univ : Finset (Fin n)) using Finset.induction_on with
  | empty => simp
  | insert a s ha ih =>
      rw [Finset.sum_insert ha, Finset.sum_insert ha, Derivation.add_apply,
        Derivation.smul_apply, ih]
