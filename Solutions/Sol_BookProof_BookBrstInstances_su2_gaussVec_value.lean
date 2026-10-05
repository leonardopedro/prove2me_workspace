-- Generated from ChapterBookBrstInstances.lean — solution of BookProof.BookBrstInstances.su2_gaussVec_value
import Mathlib
import Definitions.Def_ChapterBookBrstInstances
open BookProof.BookBrstInstances




open BookProof.BookBrstYangMills BookProof.BookBrstGaugeFixing BookProof.SmBrstGhost
open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open MvPolynomial

noncomputable section

variable {N : ℕ} (f : Fin N → Fin N → Fin N → ℝ)

variable {N : ℕ} (f : Fin N → Fin N → Fin N → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution :
    gaussVec (su2BookAlgebra 0) 0 (0, 1) = (X (0, 2) : FieldPoly 3) := by

  have hD : ∀ (μ : Fin 4) (a b : Fin 3), (su2BookAlgebra 0).D μ a b = 0 := by
    intro μ a b
    simp [su2BookAlgebra, gaugeAlgebraOfInner, innerDeriv]
  have hf : ∀ g : Fin 3, (su2BookAlgebra 0).f 1 g 0 = su2Struct 1 g 0 := fun _ => rfl
  have e0 : su2Struct 1 0 0 = 0 := by
    have : epsZ 1 0 0 = 0 := by decide
    rw [su2Struct, this]; norm_num
  have e1 : su2Struct 1 1 0 = 0 := by
    have : epsZ 1 1 0 = 0 := by decide
    rw [su2Struct, this]; norm_num
  have e2 : su2Struct 1 2 0 = 1 := by
    have : epsZ 1 2 0 = 1 := by decide
    rw [su2Struct, this]; norm_num
  simp only [gaussVec, vecComb, hD, hf, neg_zero]
  rw [Fin.sum_univ_three, e0, e1, e2]
  simp
