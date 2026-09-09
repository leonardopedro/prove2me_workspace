import Mathlib
import BookProof.ChapterA3
import BookProof.ChapterA3j
import BookProof.ChapterA3k

/-!
# Chapter A, §A.3 — Note 51 / Lemma 52: the symmetric tensor-square structure

Source: `book.tex` §A.3, Notes 50–51 and Lemma 52 (line ~5560).

`ChapterA3k` formalized the **tensor square** `V ⊗ V` of the Dirac spinor and its
four chirality blocks `V⁺⊗V⁺` (label `(1,0)`), `V⁻⊗V⁻` (`(0,1)`), and the two
mixed blocks `V⁺⊗V⁻`, `V⁻⊗V⁺` (`(½,½)`), showing that the *diagonal* `Spin⁺`
action preserves each block and that *diagonal parity* `γ⁰⊗γ⁰` glues `(1,0)` to
`(0,1)`.

This file takes the **next step**: Note 51 builds the general irreps `V_{(m,n)}`
as *symmetric* tensor powers of the chiral spinors, so we need the **braiding
(swap) operator** `τ : u ⊗ v ↦ v ⊗ u` on `V ⊗ V` and the symmetric /
antisymmetric decomposition it induces.  On the `4×4 ⊗ 4×4` Kronecker model of
§A.3 the swap is the commutation matrix `τ_{(i,j),(k,l)} = [i=l ∧ j=k]`, and we
prove:

* **Braiding relation** `swap_kronecker`: `τ · (A ⊗ B) = (B ⊗ A) · τ` for all
  `A, B`; in particular `τ` is an involution (`swap_sq`) and it *exchanges the
  two per-slot chirality operators* (`swap_chir1`, `swap_chir2`).
* **`τ` commutes with the diagonal Lorentz / parity action** (`swap_spinGenDiag_comm`,
  `swap_parityDiag_comm`), because `A ⊗ 1 + 1 ⊗ A` and `γ⁰ ⊗ γ⁰` are symmetric
  under the exchange of the two slots.
* **`τ` fixes the pure chirality blocks and exchanges the mixed ones**
  (`swap_projLL_comm`, `swap_projRR_comm`, `swap_swaps_LR_RL`): the two `(½,½)`
  blocks `V⁺⊗V⁻ ↔ V⁻⊗V⁺` are braided into each other, exactly as they are glued
  by parity in `ChapterA3k`.
* **Symmetric / antisymmetric projectors** `projSym = ½(1+τ)`, `projAsym = ½(1-τ)`
  (`projSym_idem`, `projAsym_idem`, `projSym_add_projAsym`): the symmetric part is
  the carrier of the **symmetric tensor square** — the Note-51 `V⁺_1 ⊕ V⁻_1 ⊕ …`
  layer.  It is a **full-Lorentz** subrepresentation: it commutes with both the
  diagonal `Spin⁺` action **and** diagonal parity (`projSym_spinGenDiag_comm`,
  `projSym_parityDiag_comm`) — the Lemma-52 payoff that the *real* (symmetric)
  tensor construction is automatically parity-invariant, unlike a single pure
  chirality block.

Everything is a Kronecker-algebra consequence of `ChapterA3j`/`ChapterA3k` and is
`sorry`-free / `axiom`-free (only `propext`, `Classical.choice`, `Quot.sound`),
with **no `EXTERNAL` hypothesis** (Note 50 / Weyl complete reducibility and the
extension to arbitrary `N`-fold symmetric powers remain the cited backbone).
-/

open Matrix
open scoped Kronecker

namespace BookProof.ChapterA3l

open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3k

/-- The braiding (commutation) matrix `τ` on `V ⊗ V`, i.e. the linear operator
`u ⊗ v ↦ v ⊗ u`.  Entrywise `τ_{(i,j),(k,l)} = [i = l ∧ j = k]`. -/
noncomputable def swap : M2 :=
  Matrix.of fun a b => if a.1 = b.2 ∧ a.2 = b.1 then (1 : ℂ) else 0

/-! ## The braiding relation and involutivity -/

/-
**Braiding relation.** `τ · (A ⊗ B) = (B ⊗ A) · τ` for all `A, B`.
-/
theorem swap_kronecker (A B : Matrix (Fin 4) (Fin 4) ℂ) :
    swap * (A ⊗ₖ B) = (B ⊗ₖ A) * swap := by
  ext ⟨ i, j ⟩ ⟨ k, l ⟩ ; simp only [swap, mul_apply, of_apply, kroneckerMap_apply, ite_mul,
      one_mul, zero_mul, mul_ite, mul_one, mul_zero];
  rw [ ← Finset.sum_filter ] ; rw [ ← Finset.sum_filter ] ;
  rw [ show ( Finset.univ.filter fun a : Fin 4 × Fin 4 => i = a.2 ∧ j = a.1 ) = { ( j, i ) } from
      ?_, show ( Finset.univ.filter fun a : Fin 4 × Fin 4 => a.1 = l ∧ a.2 = k ) = { ( l, k ) } from
          ?_ ] <;> norm_num;
  · ring;
  · grind;
  · grind

/-
The braiding is an involution: `τ² = 1`.
-/
theorem swap_sq : swap * swap = 1 := by
  ext ⟨i, j⟩ ⟨k, l⟩
  simp only [swap, mul_apply, of_apply, mul_ite, mul_one, mul_zero];
  rw [ Finset.sum_eq_single ( l, k ) ] <;> aesop

/-! ## The braiding exchanges the two per-slot chirality operators -/

/-- `τ · (iγ⁵ ⊗ 1) = (1 ⊗ iγ⁵) · τ`: the swap exchanges the two slots'
chirality. -/
theorem swap_chir1 : swap * chir1 = chir2 * swap := by
  unfold chir1 chir2
  rw [swap_kronecker]

/-- `τ · (1 ⊗ iγ⁵) = (iγ⁵ ⊗ 1) · τ`. -/
theorem swap_chir2 : swap * chir2 = chir1 * swap := by
  unfold chir1 chir2
  rw [swap_kronecker]

/-! ## The braiding commutes with the diagonal Lorentz / parity action -/

/-- `τ` commutes with the diagonal `Spin⁺` generator `γ^μγ^ν ⊗ 1 + 1 ⊗ γ^μγ^ν`
(which is symmetric under the exchange of the two slots). -/
theorem swap_spinGenDiag_comm (μ ν : Fin 4) :
    swap * spinGenDiag μ ν = spinGenDiag μ ν * swap := by
  unfold spinGenDiag
  rw [mul_add, add_mul, swap_kronecker, swap_kronecker, add_comm]

/-- `τ` commutes with the diagonal parity operator `γ⁰ ⊗ γ⁰`. -/
theorem swap_parityDiag_comm : swap * parityDiag = parityDiag * swap := by
  unfold parityDiag
  rw [swap_kronecker]

/-! ## The braiding fixes the pure blocks and exchanges the mixed ones -/

/-- `τ` commutes with the pure block projector `P_L ⊗ P_L` (symmetric). -/
theorem swap_projLL_comm : swap * projLL = projLL * swap := by
  unfold projLL
  rw [swap_kronecker]

/-- `τ` commutes with the pure block projector `P_R ⊗ P_R` (symmetric). -/
theorem swap_projRR_comm : swap * projRR = projRR * swap := by
  unfold projRR
  rw [swap_kronecker]

/-- `τ` exchanges the two mixed `(½,½)` blocks: `τ · (P_L ⊗ P_R) = (P_R ⊗ P_L) · τ`. -/
theorem swap_swaps_LR_RL : swap * projLR = projRL * swap := by
  unfold projLR projRL
  rw [swap_kronecker]

/-- Symmetrically, `τ · (P_R ⊗ P_L) = (P_L ⊗ P_R) · τ`. -/
theorem swap_swaps_RL_LR : swap * projRL = projLR * swap := by
  unfold projLR projRL
  rw [swap_kronecker]

/-! ## The symmetric / antisymmetric decomposition -/

/-- The symmetric projector `P_sym = ½(1 + τ)` onto the symmetric tensor square
`V ⊙ V` — the Note-51 symmetric-tensor-power carrier. -/
noncomputable def projSym : M2 := (2 : ℂ)⁻¹ • (1 + swap)

/-- The antisymmetric projector `P_asym = ½(1 - τ)` onto `V ∧ V`. -/
noncomputable def projAsym : M2 := (2 : ℂ)⁻¹ • (1 - swap)

/-- `P_sym + P_asym = 1`: the symmetric and antisymmetric parts are
complementary. -/
theorem projSym_add_projAsym : projSym + projAsym = 1 := by
  unfold projSym projAsym
  module

/-- `P_sym² = P_sym`: the symmetric projector is idempotent (uses `τ² = 1`). -/
theorem projSym_idem : projSym * projSym = projSym := by
  unfold projSym
  rw [Matrix.smul_mul, Matrix.mul_smul, smul_smul]
  have key : (1 + swap) * (1 + swap) = (2 : ℂ) • (1 + swap) := by
    rw [add_mul, mul_add, mul_add, one_mul, one_mul, mul_one, swap_sq]
    module
  rw [key, smul_smul]
  norm_num

/-- `P_asym² = P_asym`: the antisymmetric projector is idempotent. -/
theorem projAsym_idem : projAsym * projAsym = projAsym := by
  unfold projAsym
  rw [Matrix.smul_mul, Matrix.mul_smul, smul_smul]
  have key : (1 - swap) * (1 - swap) = (2 : ℂ) • (1 - swap) := by
    rw [sub_mul, mul_sub, mul_sub, one_mul, one_mul, mul_one, swap_sq]
    module
  rw [key, smul_smul]
  norm_num

/-- `P_sym P_asym = 0`: the two parts are orthogonal. -/
theorem projSym_mul_projAsym : projSym * projAsym = 0 := by
  unfold projSym projAsym
  rw [Matrix.smul_mul, Matrix.mul_smul, smul_smul]
  have key : (1 + swap) * (1 - swap) = 0 := by
    rw [add_mul, one_mul, mul_sub, mul_one, swap_sq]
    abel
  rw [key, smul_zero]

/-! ## The symmetric tensor square is a full-Lorentz subrepresentation -/

/-- **Note 51 core.** The symmetric tensor square `V ⊙ V` is a diagonal-`Spin⁺`
subrepresentation: `P_sym` commutes with every diagonal Lorentz generator. -/
theorem projSym_spinGenDiag_comm (μ ν : Fin 4) :
    projSym * spinGenDiag μ ν = spinGenDiag μ ν * projSym := by
  unfold projSym
  rw [Matrix.smul_mul, Matrix.mul_smul, add_mul, mul_add, one_mul, mul_one,
    swap_spinGenDiag_comm]

/-- **Lemma 52 payoff.** The symmetric tensor square is also **parity**-invariant:
`P_sym` commutes with diagonal parity `γ⁰ ⊗ γ⁰`.  Thus, unlike a single pure
chirality block (`ChapterA3k.projLL_not_parity_invariant`), the symmetric
(real) tensor construction is automatically a representation of the *full*
Lorentz group. -/
theorem projSym_parityDiag_comm : projSym * parityDiag = parityDiag * projSym := by
  unfold projSym
  rw [Matrix.smul_mul, Matrix.mul_smul, add_mul, mul_add, one_mul, mul_one,
    swap_parityDiag_comm]

/-- The antisymmetric part `V ∧ V` (the `Pinor₀` scalar block) is likewise a
full-Lorentz subrepresentation. -/
theorem projAsym_spinGenDiag_comm (μ ν : Fin 4) :
    projAsym * spinGenDiag μ ν = spinGenDiag μ ν * projAsym := by
  unfold projAsym
  rw [Matrix.smul_mul, Matrix.mul_smul, sub_mul, mul_sub, one_mul, mul_one,
    swap_spinGenDiag_comm]

/-- The antisymmetric part is parity-invariant as well. -/
theorem projAsym_parityDiag_comm :
    projAsym * parityDiag = parityDiag * projAsym := by
  unfold projAsym
  rw [Matrix.smul_mul, Matrix.mul_smul, sub_mul, mul_sub, one_mul, mul_one,
    swap_parityDiag_comm]

/-! ## The pure `(1,0)` block lies in the symmetric part -/

/-- The pure chirality block `V⁺⊗V⁺` sits inside the symmetric tensor square:
`P_LL` commutes with `P_sym`, so `P_LL P_sym` is a subprojector of `V ⊙ V`. -/
theorem projLL_projSym_comm : projLL * projSym = projSym * projLL := by
  unfold projSym
  rw [Matrix.mul_smul, Matrix.smul_mul, mul_add, add_mul, mul_one, one_mul,
    swap_projLL_comm]

end BookProof.ChapterA3l
