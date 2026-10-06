-- Generated from ChapterA3c.lean — solution of BookProof.ChapterA3.lambda_two_to_one
import Mathlib
import Definitions.Def_ChapterA3c
import Theorems.Thm_BookProof_ChapterA3_mgammaR_clifford
import Theorems.Thm_BookProof_ChapterA3_hasLambda_LambdaOf
import Theorems.Thm_BookProof_ChapterA3_lambda_mem_lorentz
import Theorems.Thm_BookProof_ChapterA3_cliffordR_lorentz_comb
import Theorems.Thm_BookProof_ChapterA3_real_pauli
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (hpf : PauliFundamental)
    {S S' : Matrix (Fin 4) (Fin 4) ℝ} (hS : IsPin S) (hS' : IsPin S')
    (h : LambdaOf S = LambdaOf S') : S' = S ∨ S' = -S := by

  have h_conj : ∀ μ, S⁻¹ * mgammaR μ * S = ∑ ν, (LambdaOf S) μ ν • mgammaR ν ∧
      S'⁻¹ * mgammaR μ * S' = ∑ ν, (LambdaOf S') μ ν • mgammaR ν :=
    fun μ => ⟨hasLambda_LambdaOf S hS.2.2 μ, hasLambda_LambdaOf S' hS'.2.2 μ⟩
  have h_conj_eq : ∀ μ, mgammaR μ = S * (∑ ν, (LambdaOf S) μ ν • mgammaR ν) * S⁻¹ ∧
      mgammaR μ = S' * (∑ ν, (LambdaOf S') μ ν • mgammaR ν) * S'⁻¹ := by
    simp [← h_conj, mul_assoc, hS.1.ne_zero, hS'.1.ne_zero]
  have hβcliff := cliffordR_lorentz_comb (LambdaOf S) (lambda_mem_lorentz S hS)
  obtain ⟨S₀, hS₀₁, hS₀₂, hS₀₃⟩ :=
    real_pauli hpf (fun μ => ∑ ν, (LambdaOf S) μ ν • mgammaR ν) mgammaR hβcliff mgammaR_clifford
  cases hS₀₃ S hS.2.1 (fun μ => by simpa [h] using h_conj_eq μ |>.1) <;>
    cases hS₀₃ S' hS'.2.1 (fun μ => by simpa [h] using h_conj_eq μ |>.2) <;>
    simp_all +singlePass
