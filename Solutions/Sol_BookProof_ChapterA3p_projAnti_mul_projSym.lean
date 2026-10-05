-- Generated from ChapterA3p.lean — solution of BookProof.ChapterA3p.projAnti_mul_projSym
import Mathlib
import Definitions.Def_ChapterA3p
import Theorems.Thm_BookProof_ChapterA3p_sum_signC_eq_zero
open BookProof.ChapterA3p



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (hN : 2 ≤ N) :
    projAnti N * projSym N = 0 := by

  unfold projAnti; unfold projSym;
  have h_sum_zero : ∑ σ : Equiv.Perm (Fin N),    ∑ τ : Equiv.Perm (Fin N),    signC σ • permMat (σ *
      τ) = ∑ σ : Equiv.Perm (Fin N),    ∑ τ : Equiv.Perm (Fin N), signC σ • permMat τ := by
    exact Finset.sum_congr rfl fun σ _ => Equiv.sum_comp ( Equiv.mulLeft σ ) fun τ => signC σ •
        permMat τ;
  convert congr_arg ( fun x : MN N => ( N.factorial : ℂ ) ⁻¹ • ( N.factorial : ℂ ) ⁻¹ • x )
      h_sum_zero using 1;
  · simp [ Finset.sum_mul _ _ _, Finset.mul_sum, smul_smul, Finset.smul_sum,
      BookProof.ChapterA3n.permMat_mul ];
  · simp [ ← Finset.smul_sum, ← Finset.sum_smul, sum_signC_eq_zero hN ]
