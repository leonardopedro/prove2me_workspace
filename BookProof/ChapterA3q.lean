import Mathlib
import BookProof.ChapterA3
import BookProof.ChapterA3j
import BookProof.ChapterA3n
import BookProof.ChapterA3o
import BookProof.ChapterA3p

/-!
# Chapter A, §A.3 — Note 50 / Lemma 52: general-`N` complete reducibility
(via the mixed-symmetry complement)

Source: `book.tex` §A.3, Note 50 (Weyl: finite-dimensional representations of
`SL(2,ℂ)` are completely reducible) and Lemma 52.

`ChapterA3n`/`ChapterA3o` built, for arbitrary `N`, the totally symmetric
projector `projSym N` and the totally antisymmetric projector `projAnti N`, both
full-Lorentz–invariant.  `ChapterA3p` recorded that at `N = 2` they are already
*complementary* (`projSym 2 + projAnti 2 = 1`), giving the concrete
`V ⊗ V = Sym²V ⊕ Λ²V`.

For `N ≥ 3` the symmetric and antisymmetric pieces no longer exhaust the tensor
power `V^{⊗N}`; the remainder carries the **mixed-symmetry** representations.
This file isolates that remainder as the complementary projector

  `projMixed N := 1 − projSym N − projAnti N`

and proves — *without* the `EXTERNAL` Weyl hypothesis — that the triple
`{projSym N, projAnti N, projMixed N}` is a **complete system of pairwise
orthogonal, idempotent, full-Lorentz–invariant projectors** for every `N ≥ 2`.
This is the general-`N` (mixed-symmetry) form of the complete-reducibility
payoff of Note 50, extending the `N = 2` headline of `ChapterA3p`.

## Deliverables

* `projMixed` — the mixed-symmetry complement `1 − projSym N − projAnti N`.
* Completeness `projSym_add_projAnti_add_projMixed` — the three sum to `1`.
* Orthogonality (`N ≥ 2`): `projSym_mul_projMixed`, `projMixed_mul_projSym`,
  `projAnti_mul_projMixed`, `projMixed_mul_projAnti` (all `= 0`).
* Idempotency (`N ≥ 2`): `projMixed_idem`.
* Full-Lorentz invariance: `projMixed_diagGen_comm`, `projMixed_uniform_comm`,
  and their §A.3 specializations `projMixed_spinGenDiag_comm`,
  `projMixed_parityDiag_comm`.
* `projMixed_two_eq_zero` — at `N = 2` the mixed piece is `0` (consistency with
  `ChapterA3p`).
* `tensorPow_complete_reducibility` — the bundled headline for arbitrary
  `N ≥ 2`: a complete orthogonal idempotent system realizing
  `V^{⊗N} = Sym^N V ⊕ Λ^N V ⊕ (mixed symmetry)`.

Everything is `sorry`-free / `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`), with **no `EXTERNAL` hypothesis**.
-/

open Matrix
open scoped BigOperators

namespace BookProof.ChapterA3q

open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o
open BookProof.ChapterA3p

/-- The **mixed-symmetry complement** `projMixed N = 1 − projSym N − projAnti N`
on the tensor power `V^{⊗N}`.  For `N = 2` it vanishes; for `N ≥ 3` it carries
the mixed-symmetry representations. -/
noncomputable def projMixed (N : ℕ) : MN N :=
  1 - projSym N - projAnti N

/-- **Completeness.** The three projectors sum to the identity. -/
theorem projSym_add_projAnti_add_projMixed (N : ℕ) :
    projSym N + projAnti N + projMixed N = 1 := by
  unfold projMixed; abel

/-- **Orthogonality (`N ≥ 2`).** `projSym · projMixed = 0`. -/
theorem projSym_mul_projMixed {N : ℕ} (hN : 2 ≤ N) :
    projSym N * projMixed N = 0 := by
  unfold projMixed
  simp only [mul_sub, mul_one, projSym_idem, projSym_mul_projAnti hN]
  abel

/-- **Orthogonality (`N ≥ 2`).** `projMixed · projSym = 0`. -/
theorem projMixed_mul_projSym {N : ℕ} (hN : 2 ≤ N) :
    projMixed N * projSym N = 0 := by
  unfold projMixed
  simp only [sub_mul, one_mul, projSym_idem, projAnti_mul_projSym hN]
  abel

/-- **Orthogonality (`N ≥ 2`).** `projAnti · projMixed = 0`. -/
theorem projAnti_mul_projMixed {N : ℕ} (hN : 2 ≤ N) :
    projAnti N * projMixed N = 0 := by
  unfold projMixed
  simp only [mul_sub, mul_one, projAnti_idem, projAnti_mul_projSym hN]
  abel

/-- **Orthogonality (`N ≥ 2`).** `projMixed · projAnti = 0`. -/
theorem projMixed_mul_projAnti {N : ℕ} (hN : 2 ≤ N) :
    projMixed N * projAnti N = 0 := by
  unfold projMixed
  simp only [sub_mul, one_mul, projAnti_idem, projSym_mul_projAnti hN]
  abel

/-- **Idempotency (`N ≥ 2`).** `projMixed` is a genuine projector. -/
theorem projMixed_idem {N : ℕ} (hN : 2 ≤ N) :
    projMixed N * projMixed N = projMixed N := by
  unfold projMixed
  simp only [sub_mul, mul_sub, mul_one, one_mul, projSym_idem, projAnti_idem,
    projSym_mul_projAnti hN, projAnti_mul_projSym hN]
  abel

/-- **Full-Lorentz invariance.** `projMixed` commutes with the diagonal `Spin⁺`
generator `diagGen A`. -/
theorem projMixed_diagGen_comm {N : ℕ} (A : Matrix (Fin 4) (Fin 4) ℂ) :
    projMixed N * diagGen A = diagGen A * projMixed N := by
  unfold projMixed
  simp only [sub_mul, mul_sub, one_mul, mul_one,
    projSym_diagGen_comm, projAnti_diagGen_comm]

/-- **Full-Lorentz invariance.** `projMixed` commutes with the uniform
(diagonal-parity) operator `uniform A`. -/
theorem projMixed_uniform_comm {N : ℕ} (A : Matrix (Fin 4) (Fin 4) ℂ) :
    projMixed N * uniform A = uniform A * projMixed N := by
  unfold projMixed
  simp only [sub_mul, mul_sub, one_mul, mul_one,
    projSym_uniform_comm, projAnti_uniform_comm]

/-- §A.3 specialization: `projMixed` commutes with every diagonal Lorentz
generator `γ^μγ^ν`. -/
theorem projMixed_spinGenDiag_comm {N : ℕ} (μ ν : Fin 4) :
    projMixed N * diagGen (spinGen μ ν) = diagGen (spinGen μ ν) * projMixed N :=
  projMixed_diagGen_comm _

/-- §A.3 specialization: `projMixed` commutes with diagonal parity `γ⁰⊗…⊗γ⁰`. -/
theorem projMixed_parityDiag_comm {N : ℕ} :
    projMixed N * uniform (mgamma 0) = uniform (mgamma 0) * projMixed N :=
  projMixed_uniform_comm _

/-- At `N = 2` the mixed piece vanishes (consistency with `ChapterA3p`:
`projSym 2 + projAnti 2 = 1`). -/
theorem projMixed_two_eq_zero : projMixed 2 = 0 := by
  unfold projMixed
  rw [← projSym_add_projAnti_two]; abel

/-- **Headline (Note 50, general `N ≥ 2`, `EXTERNAL`-free).** The triple
`projSym N`, `projAnti N`, `projMixed N` is a complete system of pairwise
orthogonal, idempotent projectors, realizing the complete-reducibility
decomposition `V^{⊗N} = Sym^N V ⊕ Λ^N V ⊕ (mixed symmetry)` of the Lorentz
representation.  Each summand is full-Lorentz invariant
(`projSym_diagGen_comm`/`projAnti_diagGen_comm`/`projMixed_diagGen_comm` and the
parity analogues). -/
theorem tensorPow_complete_reducibility {N : ℕ} (hN : 2 ≤ N) :
    projSym N + projAnti N + projMixed N = 1 ∧
    projSym N * projSym N = projSym N ∧
    projAnti N * projAnti N = projAnti N ∧
    projMixed N * projMixed N = projMixed N ∧
    projSym N * projAnti N = 0 ∧ projAnti N * projSym N = 0 ∧
    projSym N * projMixed N = 0 ∧ projMixed N * projSym N = 0 ∧
    projAnti N * projMixed N = 0 ∧ projMixed N * projAnti N = 0 :=
  ⟨projSym_add_projAnti_add_projMixed N, projSym_idem, projAnti_idem,
   projMixed_idem hN, projSym_mul_projAnti hN, projAnti_mul_projSym hN,
   projSym_mul_projMixed hN, projMixed_mul_projSym hN,
   projAnti_mul_projMixed hN, projMixed_mul_projAnti hN⟩

end BookProof.ChapterA3q
