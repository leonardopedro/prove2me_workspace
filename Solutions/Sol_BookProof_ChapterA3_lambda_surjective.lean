-- Generated from ChapterA3c.lean — solution of BookProof.ChapterA3.lambda_surjective
import Mathlib
import Definitions.Def_ChapterA3c
import Theorems.Thm_BookProof_ChapterA3_mgammaR_clifford
import Theorems.Thm_BookProof_ChapterA3_hasLambda_LambdaOf
import Theorems.Thm_BookProof_ChapterA3_hasLambda_unique
import Theorems.Thm_BookProof_ChapterA3_cliffordR_lorentz_comb
import Theorems.Thm_BookProof_ChapterA3_real_pauli
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (hpf : PauliFundamental)
    (Λ : Matrix (Fin 4) (Fin 4) ℝ) (hΛ : Λ ∈ LorentzO) :
    ∃ S : Matrix (Fin 4) (Fin 4) ℝ, IsPin S ∧ LambdaOf S = Λ := by

  have := @cliffordR_lorentz_comb Λ hΛ;
  obtain ⟨S, hS⟩ : ∃ S : Matrix (Fin 4) (Fin 4) ℝ,    |S.det| = 1 ∧ (∀ μ, mgammaR μ = S * (∑ ν, Λ μ
      ν • mgammaR ν) * S⁻¹) := by
    have := @real_pauli hpf ( fun μ => ∑ ν, Λ μ ν • mgammaR ν ) mgammaR this mgammaR_clifford;
    exact ⟨ this.choose, this.choose_spec.1, this.choose_spec.2.1 ⟩;
  refine ⟨ S, ⟨ ?_, hS.1, ?_ ⟩, ?_ ⟩;
  · exact isUnit_iff_ne_zero.mpr ( by intro h; norm_num [ h ] at hS );
  · use Λ;
    intro μ;
    rw [ hS.2 μ ];
    simp [ ← mul_assoc, show S.det ≠ 0 from by intro h; simp [ h ] at hS ];
  · apply hasLambda_unique;
    focus (apply hasLambda_LambdaOf);
    · use Λ;
      intro μ;
      rw [ hS.2 μ ];
      simp [ ← mul_assoc, show S.det ≠ 0 from by intro h; simp [ h ] at hS ];
    · intro μ;
      rw [ hS.2 μ ];
      simp [ ← mul_assoc, show S.det ≠ 0 from by intro h; norm_num [ h ] at hS ]
