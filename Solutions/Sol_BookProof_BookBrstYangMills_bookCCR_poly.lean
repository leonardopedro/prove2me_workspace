-- Generated from ChapterBookBrstYangMills.lean — solution of BookProof.BookBrstYangMills.bookCCR_poly
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Theorems.Thm_BookProof_BookBrstYangMills_AfieldPoly_apply
open BookProof.BookBrstYangMills




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution (μ ν : Fin 4) (a b : Fin N) :
    AfieldPoly μ a * momPoly ν b - momPoly ν b * AfieldPoly μ a
      = if (μ, a) = (ν, b) then (Complex.I • 1 : Module.End ℂ (FieldPoly N)) else 0 := by

  classical
  refine LinearMap.ext fun p => ?_
  have hd : (pderiv (ν, b) : Derivation ℂ (FieldPoly N) (FieldPoly N)) (X (μ, a) * p)
      = (if (ν, b) = (μ, a) then p else 0) + X (μ, a) * pderiv (ν, b) p := by
    rw [Derivation.leibniz]
    simp only [MvPolynomial.pderiv_X, Pi.single_apply]
    by_cases h : (ν, b) = (μ, a)
    · rw [if_pos h, if_pos h.symm]
      simp [add_comm]
    · rw [if_neg h, if_neg (fun hc => h hc.symm)]
      simp
  by_cases h : (μ, a) = (ν, b)
  · have h' : (ν, b) = (μ, a) := h.symm
    simp only [if_pos h, LinearMap.sub_apply, Module.End.mul_apply, AfieldPoly_apply,
      momPoly_apply, hd, if_pos h', LinearMap.smul_apply, Module.End.one_apply, smul_add,
      mul_smul_comm]
    rw [h]
    simp
  · have h' : ¬ (ν, b) = (μ, a) := fun hc => h hc.symm
    simp only [if_neg h, LinearMap.sub_apply, Module.End.mul_apply, AfieldPoly_apply,
      momPoly_apply, hd, if_neg h', LinearMap.zero_apply, zero_add, 
      mul_smul_comm]
    simp
