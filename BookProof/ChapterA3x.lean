import Mathlib
import BookProof.ChapterA3
import BookProof.ChapterA3j
import BookProof.ChapterA3n
import BookProof.ChapterA3o
import BookProof.ChapterA3p

/-!
# Chapter A, §A.3 — Note 50 at `N = 3`: the mixed-symmetry summand

Source: `book.tex` §A.3, Note 50 (Weyl: finite-dimensional representations are
completely reducible) and Lemma 52.

`ChapterA3p` proved the **`N = 2`** instance of Note 50 outright, with no
`EXTERNAL` hypothesis: the tensor square splits as `V ⊗ V = Sym²V ⊕ Λ²V`,
because at `N = 2` the symmetrizer and the antisymmetrizer are already
complementary (`projSym 2 + projAnti 2 = 1`).

From `N = 3` on that is *false*: symmetric plus antisymmetric no longer exhaust
the tensor power, and the leftover **mixed-symmetry** part is what makes the
general Weyl statement non-trivial.  This file lands the concrete `N = 3`
complete-reducibility witness the plan asks for, again with **no `EXTERNAL`
hypothesis**:

  `V ⊗ V ⊗ V  =  Sym³V ⊕ Λ³V ⊕ Mixed`,

realized by the three pairwise-orthogonal idempotents `projSym 3`, `projAnti 3`
and `projMixed 3 := 1 - projSym 3 - projAnti 3`, each of them a full-Lorentz
subrepresentation, and with the mixed summand **genuinely non-zero**.

## Deliverables

* `projMixed` — the mixed-symmetry projector `1 - projSym N - projAnti N`, and
  `projSym_add_projAnti_add_projMixed`: the three sum to `1` by construction;
* `projMixed_idem` (`N ≥ 2`) — it is idempotent, hence a genuine projector;
* `projSym_mul_projMixed`, `projMixed_mul_projSym`, `projAnti_mul_projMixed`,
  `projMixed_mul_projAnti` (`N ≥ 2`) — orthogonality to the other two summands;
* `projMixed_diagGen_comm`, `projMixed_uniform_comm`,
  `projMixed_spinGenDiag_comm`, `projMixed_parityDiag_comm` — the mixed summand
  is a **full-Lorentz** subrepresentation (diagonal `Spin⁺` generators *and*
  diagonal parity), inherited from `ChapterA3n`/`ChapterA3o`;
* `projMixed_two_eq_zero` — at `N = 2` the mixed part is empty, recovering
  `ChapterA3p`;
* `projMixed_three_ne_zero` — at `N = 3` it is **not** empty: the diagonal entry
  at the tuple `(0,0,1)` equals `2/3 ≠ 0` (only the identity and the
  transposition `(0 1)` stabilize that tuple, contributing `2/6` to the
  symmetrizer and `0` to the antisymmetrizer);
* `tensorCube_complete_reducibility` — the bundled headline.

Everything is `sorry`-free / `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix
open scoped BigOperators

namespace BookProof.ChapterA3x

open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o
open BookProof.ChapterA3p

/-- The **mixed-symmetry projector** on `V^{⊗N}`: whatever the symmetrizer and
the antisymmetrizer leave over. -/
noncomputable def projMixed (N : ℕ) : MN N := 1 - projSym N - projAnti N

/-- By construction the three projectors are a complete system. -/
theorem projSym_add_projAnti_add_projMixed (N : ℕ) :
    projSym N + projAnti N + projMixed N = 1 := by
  simp [projMixed]

/-! ## Orthogonality and idempotence -/

theorem projSym_mul_projMixed {N : ℕ} (hN : 2 ≤ N) :
    projSym N * projMixed N = 0 := by
  simp only [projMixed, mul_sub, mul_one, projSym_idem, projSym_mul_projAnti hN]
  abel

theorem projMixed_mul_projSym {N : ℕ} (hN : 2 ≤ N) :
    projMixed N * projSym N = 0 := by
  simp only [projMixed, sub_mul, one_mul, projSym_idem, projAnti_mul_projSym hN]
  abel

theorem projAnti_mul_projMixed {N : ℕ} (hN : 2 ≤ N) :
    projAnti N * projMixed N = 0 := by
  simp only [projMixed, mul_sub, mul_one, projAnti_idem, projAnti_mul_projSym hN]
  abel

theorem projMixed_mul_projAnti {N : ℕ} (hN : 2 ≤ N) :
    projMixed N * projAnti N = 0 := by
  simp only [projMixed, sub_mul, one_mul, projAnti_idem, projSym_mul_projAnti hN]
  abel

/-- The mixed-symmetry projector is idempotent: a genuine projector. -/
theorem projMixed_idem {N : ℕ} (hN : 2 ≤ N) :
    projMixed N * projMixed N = projMixed N := by
  conv_lhs => rw [show projMixed N * projMixed N
      = projMixed N * 1 - projMixed N * projSym N - projMixed N * projAnti N by
    simp only [projMixed, mul_sub, mul_one]]
  rw [projMixed_mul_projSym hN, projMixed_mul_projAnti hN, mul_one]
  abel

/-! ## Full-Lorentz invariance of the mixed summand -/

/-- The mixed projector commutes with the uniform (diagonal-parity) operator. -/
theorem projMixed_uniform_comm {N : ℕ} (A : Matrix (Fin 4) (Fin 4) ℂ) :
    projMixed N * uniform A = uniform A * projMixed N := by
  simp only [projMixed, sub_mul, mul_sub, one_mul, mul_one,
    projSym_uniform_comm, projAnti_uniform_comm]

/-- The mixed projector commutes with the diagonal `Spin⁺` generator. -/
theorem projMixed_diagGen_comm {N : ℕ} (A : Matrix (Fin 4) (Fin 4) ℂ) :
    projMixed N * diagGen A = diagGen A * projMixed N := by
  simp only [projMixed, sub_mul, mul_sub, one_mul, mul_one,
    projSym_diagGen_comm, projAnti_diagGen_comm]

/-- **Lemma 52, mixed case.** The mixed-symmetry summand is a diagonal `Spin⁺`
subrepresentation. -/
theorem projMixed_spinGenDiag_comm {N : ℕ} (μ ν : Fin 4) :
    projMixed N * diagGen (spinGen μ ν) = diagGen (spinGen μ ν) * projMixed N :=
  projMixed_diagGen_comm _

/-- **Lemma 52, mixed case.** The mixed-symmetry summand is parity-invariant,
hence a representation of the *full* Lorentz group. -/
theorem projMixed_parityDiag_comm {N : ℕ} :
    projMixed N * uniform (mgamma 0) = uniform (mgamma 0) * projMixed N :=
  projMixed_uniform_comm _

/-! ## `N = 2` versus `N = 3` -/

/-- At `N = 2` there is no mixed symmetry: `ChapterA3p`'s two-summand splitting
is complete. -/
theorem projMixed_two_eq_zero : projMixed 2 = 0 := by
  have h := BookProof.ChapterA3p.projSym_add_projAnti_two
  simp only [projMixed]
  rw [show (1 : MN 2) - projSym 2 - projAnti 2 = 1 - (projSym 2 + projAnti 2) by abel, h,
    sub_self]

/-! ### Entrywise formulas, used for the `N = 3` non-vanishing -/

theorem projSym_apply {N : ℕ} (a b : Idx N) :
    projSym N a b = (Nat.factorial N : ℂ)⁻¹ * ∑ σ : Equiv.Perm (Fin N),
      (if b = a ∘ σ then (1 : ℂ) else 0) := by
  simp [projSym, permMat, Matrix.sum_apply]

theorem projAnti_apply {N : ℕ} (a b : Idx N) :
    projAnti N a b = (Nat.factorial N : ℂ)⁻¹ * ∑ σ : Equiv.Perm (Fin N),
      signC σ * (if b = a ∘ σ then (1 : ℂ) else 0) := by
  simp [projAnti, permMat, Matrix.sum_apply, signC]

/-- **The mixed summand is non-empty at `N = 3`.**  Its diagonal entry at the
tuple `(0,0,1)` is `1 - 2/6 - 0 = 2/3 ≠ 0`. -/
theorem projMixed_three_ne_zero : projMixed 3 ≠ 0 := by
  intro h
  set a : Idx 3 := (![0, 0, 1] : Fin 3 → Fin 4) with hadef
  have ha : (projMixed 3) a a = 0 := by rw [h]; simp
  have hsym : ∑ σ : Equiv.Perm (Fin 3), (if a = a ∘ σ then (1 : ℂ) else 0) = 2 := by
    have hZ : ∑ σ : Equiv.Perm (Fin 3), (if a = a ∘ σ then (1 : ℤ) else 0) = 2 := by decide
    calc ∑ σ : Equiv.Perm (Fin 3), (if a = a ∘ σ then (1 : ℂ) else 0)
        = ((∑ σ : Equiv.Perm (Fin 3), (if a = a ∘ σ then (1 : ℤ) else 0) : ℤ) : ℂ) := by
          push_cast
          exact Finset.sum_congr rfl fun σ _ => by split <;> simp
      _ = 2 := by rw [hZ]; norm_num
  have hanti : ∑ σ : Equiv.Perm (Fin 3), signC σ * (if a = a ∘ σ then (1 : ℂ) else 0) = 0 := by
    have hZ : ∑ σ : Equiv.Perm (Fin 3),
        ((Equiv.Perm.sign σ : ℤ) * (if a = a ∘ σ then (1 : ℤ) else 0)) = 0 := by decide
    calc ∑ σ : Equiv.Perm (Fin 3), signC σ * (if a = a ∘ σ then (1 : ℂ) else 0)
        = ((∑ σ : Equiv.Perm (Fin 3),
            ((Equiv.Perm.sign σ : ℤ) * (if a = a ∘ σ then (1 : ℤ) else 0)) : ℤ) : ℂ) := by
          push_cast [signC]
          exact Finset.sum_congr rfl fun σ _ => by split <;> simp
      _ = 0 := by rw [hZ]; norm_num
  rw [projMixed] at ha
  simp only [Matrix.sub_apply, Matrix.one_apply_eq, projSym_apply, projAnti_apply,
    hsym, hanti] at ha
  norm_num [Nat.factorial] at ha

/-- **Headline (Note 50 at `N = 3`, `EXTERNAL`-free).**  The tensor cube of the
Dirac spinor space splits as an internal direct sum of three full-Lorentz
subrepresentations

  `V ⊗ V ⊗ V = Sym³V ⊕ Λ³V ⊕ Mixed`,

exhibited by three complementary, pairwise-orthogonal, idempotent projectors,
the third of which is non-zero — so, unlike `N = 2`, the decomposition genuinely
has three parts. -/
theorem tensorCube_complete_reducibility :
    projSym 3 + projAnti 3 + projMixed 3 = 1 ∧
    projSym 3 * projSym 3 = projSym 3 ∧
    projAnti 3 * projAnti 3 = projAnti 3 ∧
    projMixed 3 * projMixed 3 = projMixed 3 ∧
    projSym 3 * projAnti 3 = 0 ∧ projAnti 3 * projSym 3 = 0 ∧
    projSym 3 * projMixed 3 = 0 ∧ projMixed 3 * projSym 3 = 0 ∧
    projAnti 3 * projMixed 3 = 0 ∧ projMixed 3 * projAnti 3 = 0 ∧
    projMixed 3 ≠ 0 :=
  ⟨projSym_add_projAnti_add_projMixed 3, projSym_idem, projAnti_idem,
    projMixed_idem (by norm_num),
    projSym_mul_projAnti (by norm_num), projAnti_mul_projSym (by norm_num),
    projSym_mul_projMixed (by norm_num), projMixed_mul_projSym (by norm_num),
    projAnti_mul_projMixed (by norm_num), projMixed_mul_projAnti (by norm_num),
    projMixed_three_ne_zero⟩

end BookProof.ChapterA3x
