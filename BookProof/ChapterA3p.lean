import Mathlib
import BookProof.ChapterA3
import BookProof.ChapterA3j
import BookProof.ChapterA3n
import BookProof.ChapterA3o

/-!
# Chapter A, §A.3 — Note 50 / Lemma 52: concrete complete reducibility of the tensor square

Source: `book.tex` §A.3, Note 50 (Weyl: finite-dimensional representations of
`SL(2,ℂ)` are completely reducible) and Lemma 52, together with Def 57 (`Pinor₀`).

`ChapterA3n` built the totally *symmetric* power via the symmetrizer
`projSym N = (N!)⁻¹·Σ_{σ∈S_N} ρ(σ)` and `ChapterA3o` its dual, the totally
*antisymmetric* power via the antisymmetrizer
`projAnti N = (N!)⁻¹·Σ_{σ∈S_N} sgn(σ)·ρ(σ)`.  Both are full-Lorentz–invariant
projectors.  This file records the **concrete complete-reducibility payoff** of
Note 50 in the base case `N = 2`, *without* invoking the `EXTERNAL` Weyl
hypothesis at all: the tensor square splits as an internal direct sum

  `V ⊗ V  =  Sym²V ⊕ Λ²V`

of two full-Lorentz subrepresentations, realized by the pair of complementary
orthogonal projectors `projSym 2`, `projAnti 2`.

## Deliverables

* `sum_signC_eq_zero` — the signed group sum `Σ_{σ∈S_N} sgn(σ)` vanishes as soon
  as `N ≥ 2` (multiply by a fixed transposition: the bijection `σ ↦ t·σ` flips
  the sign, so the sum equals its own negative).
* `projSym_mul_projAnti`, `projAnti_mul_projSym` — for `N ≥ 2` the symmetrizer
  and antisymmetrizer are **orthogonal**: their products both vanish (reindex
  `ρ = στ`; the cross term factors as `(Σ_σ sgn σ)·(antisymmetrizer) = 0`).
* `projSym_add_projAnti_two` — for `N = 2` the two projectors are
  **complementary**: `projSym 2 + projAnti 2 = 1`.
* `tensorSquare_complete_reducibility` — the bundled headline: `projSym 2` and
  `projAnti 2` are complementary, orthogonal, idempotent projectors, so
  `V ⊗ V = Sym²V ⊕ Λ²V` is a direct-sum decomposition of the Lorentz
  representation (each summand full-Lorentz invariant by
  `ChapterA3n`/`ChapterA3o`).

Everything is `sorry`-free / `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`), with **no `EXTERNAL` hypothesis**: the `N = 2` instance of Weyl
complete reducibility (Note 50) is proved outright.
-/

open Matrix
open scoped BigOperators

namespace BookProof.ChapterA3p

open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o

/-
The signed group sum `Σ_{σ∈S_N} sgn(σ)` vanishes once `N ≥ 2`.

Proof: with `N ≥ 2` there is a transposition `t = Equiv.swap 0 1` (`sgn t = -1`).
The left-multiplication `σ ↦ t·σ` is a bijection of `S_N`, and
`sgn(t·σ) = sgn t · sgn σ = -sgn σ`.  Hence `Σ_σ sgn σ = Σ_σ sgn(t·σ) = -Σ_σ sgn σ`,
so the sum equals its own negative and therefore vanishes.
-/
theorem sum_signC_eq_zero {N : ℕ} (hN : 2 ≤ N) :
    ∑ σ : Equiv.Perm (Fin N), signC σ = 0 := by
  have h_transposition : ∃ t : Equiv.Perm (Fin N), Equiv.Perm.sign t = -1 := by
    exact ⟨ Equiv.swap ⟨ 0, by linarith ⟩ ⟨ 1, by linarith ⟩, by simp ⟩;
  obtain ⟨ t, ht ⟩ := h_transposition;    have := Equiv.sum_comp ( Equiv.mulLeft t ) ( fun x =>
      signC x ) ; simp_all only [signC, Equiv.coe_mulLeft, Equiv.Perm.sign_mul, neg_mul, one_mul,
          Units.val_neg, Int.cast_neg, Finset.sum_neg_distrib] ;
  linear_combination' -this / 2

/-
**Orthogonality (N ≥ 2).** The symmetrizer annihilates the antisymmetrizer.

Proof: `projSym N * projAnti N = (N!)⁻² • (S * A)` where `S = Σ_σ ρ(σ)`,
`A = Σ_τ sgn(τ)·ρ(τ)`.  Expanding and reindexing `ρ = σ·τ` gives
`S * A = (Σ_σ sgn σ) • A`, and `Σ_σ sgn σ = 0` by `sum_signC_eq_zero`.
-/
theorem projSym_mul_projAnti {N : ℕ} (hN : 2 ≤ N) :
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

/-
**Orthogonality (N ≥ 2), other order.** The antisymmetrizer annihilates the
symmetrizer.
-/
theorem projAnti_mul_projSym {N : ℕ} (hN : 2 ≤ N) :
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

/-
**Complementarity (N = 2).** On the tensor square the symmetrizer and
antisymmetrizer sum to the identity: `(1/2)(1+τ) + (1/2)(1-τ) = 1`.
-/
theorem projSym_add_projAnti_two :
    projSym 2 + projAnti 2 = 1 := by
  ext a b; simp only [projSym, Nat.factorial_two, Nat.cast_ofNat, projAnti, add_apply, smul_apply,
      smul_eq_mul] ;
  unfold permMat signC;
  rw [ Finset.sum_eq_multiset_sum, Finset.sum_eq_multiset_sum ] ; norm_cast;
  erw [ show ( Finset.univ.val : Multiset ( Equiv.Perm ( Fin 2 ) ) )
          = { Equiv.refl ( Fin 2 ), Equiv.swap 0 1 } by decide ] ; norm_num ; ring;
  exact if_congr ( by aesop ) rfl rfl

/-- **Headline (Note 50, N = 2, `EXTERNAL`-free).** The pair `projSym 2`,
`projAnti 2` is a complete system of complementary, orthogonal, idempotent
projectors, exhibiting the concrete complete-reducibility decomposition
`V ⊗ V = Sym²V ⊕ Λ²V` of the Lorentz representation. -/
theorem tensorSquare_complete_reducibility :
    projSym 2 + projAnti 2 = 1 ∧
    projSym 2 * projAnti 2 = 0 ∧
    projAnti 2 * projSym 2 = 0 ∧
    projSym 2 * projSym 2 = projSym 2 ∧
    projAnti 2 * projAnti 2 = projAnti 2 :=
  ⟨projSym_add_projAnti_two, projSym_mul_projAnti (by norm_num),
   projAnti_mul_projSym (by norm_num), projSym_idem, projAnti_idem⟩

end BookProof.ChapterA3p
