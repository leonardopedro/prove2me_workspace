-- Generated from ChapterA3p.lean — solution of BookProof.ChapterA3p.projSym_mul_projAnti
import Mathlib
import Definitions.Def_ChapterA3p
import Theorems.Thm_BookProof_ChapterA3p_sum_signC_eq_zero
open BookProof.ChapterA3p



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (hN : 2 ≤ N) :
    projSym N * projAnti N = 0 := by

  unfold projSym projAnti;
  -- By Fubini's theorem, we can interchange the order of summation.
  have h_fubini : ∑ σ : Equiv.Perm (Fin N),    ∑ τ : Equiv.Perm (Fin N),    (signC τ • permMat (σ *
      τ)) = ∑ ρ : Equiv.Perm (Fin N),    (∑ σ : Equiv.Perm (Fin N), signC (σ * ρ)) • permMat ρ := by
    have h_fubini : ∀ σ : Equiv.Perm (Fin N),      ∑ τ : Equiv.Perm (Fin N),      (signC τ • permMat
        (σ * τ)) = ∑ ρ : Equiv.Perm (Fin N), (signC (σ * ρ) • permMat ρ) := by
      intro σ;
      apply Finset.sum_bij (fun τ _ => σ * τ);
      · simp;
      · aesop;
      · exact fun b _ => ⟨ σ⁻¹ * b, Finset.mem_univ _, by simp ⟩;
      · simp [ ← mul_assoc, signC ];
    rw [ Finset.sum_congr rfl fun σ _ => h_fubini σ, Finset.sum_comm ];
    simp only [Finset.sum_smul];
  convert congr_arg ( fun x : MN N => ( N.factorial : ℂ ) ⁻¹ ^ 2 • x ) h_fubini using 1;
  · simp [ sq, smul_smul, Finset.smul_sum, Finset.sum_mul ];
    simp [ Finset.mul_sum _ _ _, mul_assoc, Finset.smul_sum, smul_smul,
        BookProof.ChapterA3n.permMat_mul ];
  · -- By definition of $signC$, we know that $\sum_{\sigma} signC(\sigma \rho) = \sum_{\sigma}
    -- signC(\sigma)$ for any $\rho$.
    have h_signC_sum : ∀ ρ : Equiv.Perm (Fin N),      ∑ σ : Equiv.Perm (Fin N), signC (σ * ρ) = ∑ σ
        : Equiv.Perm (Fin N), signC σ := by
      exact fun ρ => Equiv.sum_comp ( Equiv.mulRight ρ ) fun σ => signC σ;
    simp [ h_signC_sum, sum_signC_eq_zero hN ]
