import Theorems.Thm_BookProof_NavierStokesFlow_mem_lpFiniteModes

import Definitions.Def_ChapterNavierStokesAffineBlockEsa
import Mathlib


/-!
# The sign-flip unitary: removing the `c ≥ 0` hypothesis

`BookProof.ChapterNavierStokesAffineFiberEsa` proves that the affine
Navier–Stokes fiber Hamiltonian `H = ½(π V + V π)` with `V(u) = κ u + c` is
essentially self-adjoint on the finite-mode core of `ℓ²(ℕ)`, but only for
`c ≥ 0`: the `±1`-hopping amplitude `(c/√2)√(n+1)` of a `ShiftData` is required
to be non-negative.  The recorded remedy was the **sign-flip unitary**
`(U x)_n = (−1)ⁿ x_n`, which reverses the sign of a `±1`-hopping and preserves a
`±2`-hopping.  This module formalizes it and removes the hypothesis.

## What is proved

* `deficiencyTrivialAt_of_intertwine`, `essentiallySelfAdjointOn_of_intertwine` —
  essential self-adjointness is a unitary invariant: if a unitary `U` of the
  ambient Hilbert space preserves the core and intertwines two operators on it,
  `U ∘ T = T' ∘ U`, then `T` is essentially self-adjoint iff `T'` is;
* `flipU` — the sign-flip unitary `(U x)_β = (−1)^{p β} x_β` attached to a parity
  function `p : ι → ℕ`, a `LinearIsometryEquiv` of `ℓ²(ι)` preserving the
  finite-mode core and every maximal domain;
* `hFun_flip`, `shiftH_flip` — the conjugation rule: a shift Hamiltonian whose
  shift changes the parity by `k` is conjugated by `U` into `(−1)^k` times
  itself;
* `saffH` — the affine fiber Hamiltonian for an **arbitrary real** constant `c`
  (the `±1`-hopping amplitude is the signed `(c/√2)√(n+1)`);
* `saffH_conj_flip` — the unitary equivalence `U (affH κ |c|) U = saffH κ c` for
  `c < 0`;
* `saffH_essentiallySelfAdjointOn_core` — **the headline for one fiber**: for
  every `κ ≥ 0` and **every** `c ∈ ℝ`, the affine fiber Hamiltonian is
  essentially self-adjoint on the finite-mode core;
* `saffBlockH_essentiallySelfAdjointOn_core` — the same over the strain-rate
  spectrum: on `ℓ²(ℕ × J)`, for arbitrary families `κ ≥ 0` and `c : J → ℝ` of
  **arbitrary sign**.

## Honest boundary

`κ ≥ 0` is still assumed (the sign-flip unitary preserves the `±2`-hopping, so
it cannot remove that one; it is removed instead in
`BookProof.ChapterNavierStokesSignedShift`).  As in the modules quoted above,
everything is stated on the abstract sequence space with the operator given by
its matrix in the Hermite basis, and nothing here claims global regularity for
the classical Navier–Stokes equation.
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow

namespace SignFlip

open LpNat FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

/-! ## Essential self-adjointness is a unitary invariant -/

section Transfer

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}







end Transfer

/-! ## The sign-flip unitary -/

variable {ι : Type*}

/-- The coordinates of the sign-flip: multiplication by `(−1)^{p β}`. -/
noncomputable def flipFun (p : ι → ℕ) (X : ι → ℂ) : ι → ℂ := fun β => (-1 : ℂ) ^ p β * X β

@[simp] theorem norm_flipFun (p : ι → ℕ) (X : ι → ℂ) (β : ι) :
    ‖flipFun p X β‖ = ‖X β‖ := by
  simp [flipFun]

theorem flipFun_flipFun (p : ι → ℕ) (X : ι → ℂ) : flipFun p (flipFun p X) = X := by
  funext β
  simp only [flipFun, ← mul_assoc, ← pow_add]
  rw [show p β + p β = 2 * p β by ring, pow_mul]
  norm_num

/-- **The sign-flip map** on `ℓ²(ι)`, as a linear map. -/
noncomputable def flipMap (p : ι → ℕ) : L2I ι →ₗ[ℂ] L2I ι where
  toFun x := ⟨flipFun p ((x : L2I ι) : ι → ℂ),
    memLpTwo_of_le x fun k => le_of_eq (norm_flipFun p _ k)⟩
  map_add' x y := by
    refine lp.ext (funext fun β => ?_)
    simp only [flipFun, lp.coeFn_add, Pi.add_apply]
    ring
  map_smul' a x := by
    refine lp.ext (funext fun β => ?_)
    simp only [flipFun, lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply]
    ring



theorem flipMap_flipMap (p : ι → ℕ) (x : L2I ι) : flipMap p (flipMap p x) = x := by
  refine lp.ext (funext fun β => ?_)
  have := congrFun (flipFun_flipFun p ((x : L2I ι) : ι → ℂ)) β
  simpa [flipMap_coe, flipFun] using this

theorem norm_flipMap (p : ι → ℕ) (x : L2I ι) : ‖flipMap p x‖ = ‖x‖ := by
  have h1 : HasSum (fun k => ‖((flipMap p x : L2I ι) : ι → ℂ) k‖ ^ 2) (‖flipMap p x‖ ^ 2) :=
    ShiftData.hasSum_normSq _
  have h2 : HasSum (fun k => ‖((flipMap p x : L2I ι) : ι → ℂ) k‖ ^ 2) (‖x‖ ^ 2) := by
    have := ShiftData.hasSum_normSq x
    refine this.congr_fun fun k => ?_
    simp [flipMap_coe]
  have hsq : ‖flipMap p x‖ ^ 2 = ‖x‖ ^ 2 := h1.unique h2
  have := abs_eq_abs.mpr (Or.inl (by nlinarith [norm_nonneg (flipMap p x), norm_nonneg x] :
    ‖flipMap p x‖ = ‖x‖))
  nlinarith [norm_nonneg (flipMap p x), norm_nonneg x, hsq]

/-- **The sign-flip unitary** `(U x)_β = (−1)^{p β} x_β` of `ℓ²(ι)`. -/
noncomputable def flipU (p : ι → ℕ) : L2I ι ≃ₗᵢ[ℂ] L2I ι where
  toLinearEquiv :=
    LinearEquiv.ofLinear (flipMap p) (flipMap p)
      (LinearMap.ext fun x => flipMap_flipMap p x) (LinearMap.ext fun x => flipMap_flipMap p x)
  norm_map' := norm_flipMap p









/-! ## Conjugating a shift Hamiltonian -/







/-! ## The affine fiber Hamiltonian with a constant of arbitrary sign -/

/-- The sign of the constant part of the fiber field, as a scalar. -/
noncomputable def esgn (c : ℝ) : ℂ := if c < 0 then -1 else 1











/-- **The affine Navier–Stokes fiber Hamiltonian for an arbitrary real
constant** `c`: the `±2`-hopping `(κ/2)√((n+1)(n+2))` of the linear part plus the
signed `±1`-hopping `(c/√2)√(n+1)` of the constant part.  For `c ≥ 0` it is
`AffineFiber.affH`; for `c < 0` it is its conjugate by the sign-flip unitary. -/
noncomputable def saffH {κ : ℝ} (hκ : 0 ≤ κ) (c : ℝ) :
    maxDom (oscSymbol (affMu κ |c|)) →ₗ[ℂ] L2I ℕ :=
  ShiftData.shiftH (affData hκ (abs_nonneg c)).fst
    + esgn c • ShiftData.shiftH (affData hκ (abs_nonneg c)).snd











/-! ## The signed `±1`-hopping is genuinely present -/







/-! ## The block assembly with constants of arbitrary sign -/

section Block

open BilinearEsa

variable {J : Type*}

/-- The coordinates of the Navier–Stokes generator whose block `j` carries the
affine field `V(u) = κ_j u + c_j` with `c_j` of **arbitrary sign**. -/
noncomputable def sblockFun (κ c : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) (X : ℕ × J → ℂ) : ℕ × J → ℂ :=
  fun q => (affData (hκ q.2) (abs_nonneg (c q.2))).fst.hFun (fun n => X (n, q.2)) q.1
    + esgn (c q.2)
      * (affData (hκ q.2) (abs_nonneg (c q.2))).snd.hFun (fun n => X (n, q.2)) q.1

theorem support_sblockFun (κ c : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) (X : ℕ × J → ℂ) :
    Function.support (sblockFun κ c hκ X)
      ⊆ (((fun q : ℕ × J => (q.1 + 2, q.2)) '' Function.support X)
          ∪ ((fun q : ℕ × J => (q.1 + 2, q.2)) ⁻¹' Function.support X))
        ∪ (((fun q : ℕ × J => (q.1 + 1, q.2)) '' Function.support X)
          ∪ ((fun q : ℕ × J => (q.1 + 1, q.2)) ⁻¹' Function.support X)) := by
  rintro ⟨m, j⟩ hq
  simp only [Function.mem_support, sblockFun] at hq
  by_cases h1 : (affData (hκ j) (abs_nonneg (c j))).fst.hFun (fun n => X (n, j)) m = 0
  · have h2 : (affData (hκ j) (abs_nonneg (c j))).snd.hFun (fun n => X (n, j)) m ≠ 0 := by
      intro h
      exact hq (by rw [h1, h]; ring)
    have hmem := support_hFun (affData (hκ j) (abs_nonneg (c j))).snd (fun n => X (n, j)) h2
    rcases hmem with ⟨a, ha, hae⟩ | hpre
    · refine Or.inr (Or.inl ⟨(a, j), ha, ?_⟩)
      simp only [Prod.mk.injEq]
      exact ⟨hae, trivial⟩
    · exact Or.inr (Or.inr hpre)
  · have hmem := support_hFun (affData (hκ j) (abs_nonneg (c j))).fst (fun n => X (n, j)) h1
    rcases hmem with ⟨a, ha, hae⟩ | hpre
    · refine Or.inl (Or.inl ⟨(a, j), ha, ?_⟩)
      simp only [Prod.mk.injEq]
      exact ⟨hae, trivial⟩
    · exact Or.inl (Or.inr hpre)

theorem sblockFun_finite_support (κ c : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) (x : lpFiniteModes (ℕ × J)) :
    (Function.support (sblockFun κ c hκ (((x : L2I (ℕ × J))) : ℕ × J → ℂ))).Finite := by
  have hx := mem_lpFiniteModes.mp x.2
  refine Set.Finite.subset
    (((hx.image _).union (Set.Finite.preimage (AffineBlock.shiftProd_injective 2).injOn hx)).union
      ((hx.image _).union (Set.Finite.preimage (AffineBlock.shiftProd_injective 1).injOn hx)))
    (support_sblockFun κ c hκ _)

/-- **The Navier–Stokes generator with affine fiber fields of arbitrary sign**,
on the finite-mode core of `ℓ²(ℕ × J)`. -/
noncomputable def sblockH (κ c : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) :
    lpFiniteModes (ℕ × J) →ₗ[ℂ] L2I (ℕ × J) where
  toFun x := ⟨sblockFun κ c hκ (((x : L2I (ℕ × J))) : ℕ × J → ℂ),
    memLpTwo_of_finite_support (sblockFun_finite_support κ c hκ x)⟩
  map_add' x y := by
    refine lp.ext (funext fun q => ?_)
    simp only [Submodule.coe_add, lp.coeFn_add, Pi.add_apply, sblockFun]
    rw [hFun_add, hFun_add]
    ring
  map_smul' a x := by
    refine lp.ext (funext fun q => ?_)
    simp only [Submodule.coe_smul, lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply,
      sblockFun]
    rw [hFun_smul, hFun_smul]
    ring















end Block

end SignFlip

end BookProof.NavierStokesFlow
