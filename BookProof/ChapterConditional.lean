import Mathlib

/-!
# Chapter "Wave-function parametrization of a probability measure", §3 — the
converse: marginal and regular conditional probability of a bounded operator

Source: `book.tex`, chapter *"Wave-function parametrization of a probability
measure"*, §3 *"Any conditional probability measure in a standard measure space
is parametrized by a unitary operator"* (`book.tex` line ~1478, the paragraph
beginning *"The converse also holds"*).

The central theorem of this chapter parametrizes any joint probability density
`p(x,y)` as `|𝒰(y,x,0)|²` for a unitary `𝒰` (the finite version is
`ChapterJointUnitary`; the Hilbert–Schmidt boundedness step is `ChapterKernelBound`;
the singular-value expansion `Ψ = W D U†` is `ChapterB3`/`ChapterB3b`).  The book
then records the **converse**:

> *"Given a bounded operator `B`, such that `tr(BB†)=1`, then it defines a joint
> probability distribution of initial and final states `p(x,y)=|B(y,x)|²`. From
> the joint probability, if `p(x)={B†B}(x,x)>0` for all `x∈X`, then we can define
> a regular conditional probability density."*

`ChapterJointUnitary.sqAbs_isProb_of_frobenius_one` already shows `p(x,y)=|B(y,x)|²`
is a genuine joint distribution.  This file supplies the *marginal / regular
conditional* layer of the converse, over finite index sets (`X`, `Y`), `RCLike`
field-agnostic:

* `pMarg_eq_diagBHB` — the book's `p(x) = {B†B}(x,x)`: the marginal of the joint
  distribution is the diagonal of the Gram matrix `Bᴴ B`;
* `trace_gram_eq_one` — the book's normalization `tr(BᴴB) = tr(BB†) = 1` in trace
  form;
* `pMarg_sum_one` — the marginal is a probability distribution on `X`
  (`∑ₓ p(x) = 1`);
* `pJoint_sum_one` — the joint is a probability distribution on `X × Y`;
* `pCond_nonneg`, `pCond_sum_one` — for every `x` with `p(x) > 0` the conditional
  `p(y|x) = p(x,y)/p(x)` is a genuine probability distribution on `Y`
  (`∑_y p(y|x) = 1`): the *regular conditional probability density*;
* `pJoint_eq_cond_mul_marg` — the chain rule `p(x,y) = p(y|x) · p(x)`, so the
  joint is reconstructed from the marginal and the conditional.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped BigOperators Matrix
open Finset

namespace BookProof.ChapterConditional

variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X]
variable {𝕜 : Type*} [RCLike 𝕜]

/-- The joint probability density `p(x,y) = |B(y,x)|²` (`B` has rows indexed by
the "final" state `y` and columns by the "initial" state `x`). -/
noncomputable def pJoint (B : Matrix Y X 𝕜) (x : X) (y : Y) : ℝ := ‖B y x‖ ^ 2

/-- The marginal probability density `p(x) = ∑_y |B(y,x)|²`. -/
noncomputable def pMarg (B : Matrix Y X 𝕜) (x : X) : ℝ := ∑ y, ‖B y x‖ ^ 2

/-- The (regular) conditional probability density `p(y|x) = p(x,y) / p(x)`. -/
noncomputable def pCond (B : Matrix Y X 𝕜) (x : X) (y : Y) : ℝ :=
    pJoint B x y / pMarg B x

omit [Fintype X] [Fintype Y] [DecidableEq X] in
theorem pJoint_nonneg (B : Matrix Y X 𝕜) (x : X) (y : Y) : 0 ≤ pJoint B x y := by
  exact sq_nonneg _

omit [Fintype X] [DecidableEq X] in
theorem pMarg_nonneg (B : Matrix Y X 𝕜) (x : X) : 0 ≤ pMarg B x := by
  exact Finset.sum_nonneg fun _ _ => sq_nonneg _

omit [Fintype X] [DecidableEq X] in
theorem pMarg_eq_sum (B : Matrix Y X 𝕜) (x : X) :
    pMarg B x = ∑ y, pJoint B x y := by
  rfl

omit [Fintype X] [DecidableEq X] in
/-
**The book's `p(x) = {B†B}(x,x)`.** The marginal is the diagonal of the
Gram matrix `Bᴴ B`.
-/
theorem pMarg_eq_diagBHB (B : Matrix Y X 𝕜) (x : X) :
    ((Bᴴ * B) x x) = ((pMarg B x : ℝ) : 𝕜) := by
  -- By definition of matrix multiplication and the conjugate transpose, we have (Bᴴ * B) x x = ∑ y,
  -- (Bᴴ) x y * B y x.
  simp [Matrix.mul_apply, Matrix.conjTranspose_apply];
  simp [ mul_comm, pMarg, RCLike.mul_conj ]

omit [DecidableEq X] in
/-
**The book's normalization `tr(BᴴB) = 1`** (equal to `tr(BB†)`), given the
Hilbert–Schmidt normalization `∑_{x,y} |B(y,x)|² = 1`.
-/
theorem trace_gram_eq_one (B : Matrix Y X 𝕜)
    (hB : ∑ x, ∑ y, ‖B y x‖ ^ 2 = 1) :
    (Bᴴ * B).trace = ((1 : ℝ) : 𝕜) := by
  rw [ ← hB ] ; simp [ Matrix.trace, Matrix.mul_apply ] ; ring;
  simp [ mul_comm, RCLike.mul_conj ]

omit [DecidableEq X] in
/-
The joint distribution sums to `1`: it is a probability distribution on
`X × Y`.
-/
theorem pJoint_sum_one (B : Matrix Y X 𝕜)
    (hB : ∑ x, ∑ y, ‖B y x‖ ^ 2 = 1) :
    ∑ x, ∑ y, pJoint B x y = 1 := by
  exact hB

omit [DecidableEq X] in
/-
The marginal distribution sums to `1`: it is a probability distribution on
`X`.
-/
theorem pMarg_sum_one (B : Matrix Y X 𝕜)
    (hB : ∑ x, ∑ y, ‖B y x‖ ^ 2 = 1) :
    ∑ x, pMarg B x = 1 := by
  convert hB using 1

omit [Fintype X] [DecidableEq X] in
theorem pCond_nonneg (B : Matrix Y X 𝕜) (x : X) (y : Y) : 0 ≤ pCond B x y := by
  exact div_nonneg ( sq_nonneg _ ) ( Finset.sum_nonneg fun _ _ => sq_nonneg _ )

omit [Fintype X] [DecidableEq X] in
/-
**Regular conditional probability density.** Whenever the marginal `p(x)` is
strictly positive, the conditional `p(y|x) = p(x,y)/p(x)` is a genuine
probability distribution on `Y`.
-/
theorem pCond_sum_one (B : Matrix Y X 𝕜) (x : X) (hx : 0 < pMarg B x) :
    ∑ y, pCond B x y = 1 := by
  unfold pCond;
  rw [ ← Finset.sum_div, div_eq_iff ] <;> aesop

omit [Fintype X] [DecidableEq X] in
/-
**Chain rule** `p(x,y) = p(y|x) · p(x)`: the joint is reconstructed from the
marginal and the regular conditional.
-/
theorem pJoint_eq_cond_mul_marg (B : Matrix Y X 𝕜) (x : X) (y : Y)
    (hx : 0 < pMarg B x) :
    pJoint B x y = pCond B x y * pMarg B x := by
  simp_all [ pCond, div_mul_cancel₀ _ hx.ne' ]

end BookProof.ChapterConditional
