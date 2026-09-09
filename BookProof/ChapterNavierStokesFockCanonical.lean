import Mathlib
import BookProof.ChapterNavierStokesFockManyMode
import BookProof.ChapterNavierStokesHermiteCanonical

/-!
# The canonical pairs behind the many-mode Navier–Stokes Hamiltonian

`BookProof.ChapterNavierStokesFockManyMode` proves the two Faris–Lavine
inequalities for a concrete operator `fockH` on the Fock space `ℓ²(ℕᵈ)` of a
`d`-mode field, and for the diagonal comparison operator `diagMax (fockSym κ)`.
This module verifies that these two operators really *are* the Navier–Stokes
objects they are advertised to be:

* `Ĥ = ∑ᵢ ½(πᵢ Vᵢ + Vᵢ πᵢ)`, the symmetrised transport operator of the field, and
* `N̂ = ∑ᵢ (πᵢ² + Vᵢ²) + I`, the comparison operator built from the squares of the
  individual non-commuting pieces,

for the canonical pairs `πᵢ = -i ∂/∂uᵢ`, `uᵢ` of the modes and the *linear*
advection fields `Vᵢ(u) = κᵢ uᵢ`.  Everything is checked on the
finite-configuration core `lpFiniteModes (Occ d)`.

## Contents

* `ann i`, `cre i` — the annihilation and creation operators of the mode `i`,
  with `[aᵢ, aᵢ†] = I` (`comm_ann_cre`);
* `mom κ i`, `pos κ i`, `drift κ i` — the momentum `πᵢ`, the fiber coordinate
  `uᵢ` and the advection field `Vᵢ = κᵢ uᵢ`;
* `comm_mom_pos` — **`[πᵢ, uᵢ] = -i`**;
* `fock_comparison_eq` — **`∑ᵢ(πᵢ² + Vᵢ²) + I = N̂`**;
* `fock_hamiltonian_eq` — **`∑ᵢ ½(πᵢVᵢ + Vᵢπᵢ) = Ĥ`**;
* `fock_canonical_essentiallySelfAdjointOn_core` — hence the canonically written
  many-mode Navier–Stokes Hamiltonian is essentially self-adjoint on the
  finite-configuration core.
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow

namespace FockCanonical

open LpNat FarisLavine IkebeKato ShiftHamiltonian FockManyMode HermiteCanonical

variable {d : ℕ} {κ : Fin d → ℝ}

/-! ## Raising and lowering a single occupation number -/

/-- Add one quantum in the mode `i`. -/
def up (i : Fin d) (α : Occ d) : Occ d := Function.update α i (α i + 1)

/-- Remove one quantum from the mode `i` (nothing happens if the mode is
empty). -/
def dn (i : Fin d) (α : Occ d) : Occ d := Function.update α i (α i - 1)

@[simp] theorem up_self (i : Fin d) (α : Occ d) : up i α i = α i + 1 := by simp [up]

@[simp] theorem dn_self (i : Fin d) (α : Occ d) : dn i α i = α i - 1 := by simp [dn]

theorem up_injective (i : Fin d) : Function.Injective (up i : Occ d → Occ d) := by
  intro α β h
  funext j
  by_cases hj : j = i
  · subst hj
    have hji := congrFun h j
    simp only [up, Function.update_self] at hji
    omega
  · have hji := congrFun h j
    simpa [up, hj] using hji

@[simp] theorem dn_up (i : Fin d) (α : Occ d) : dn i (up i α) = α := by
  funext j
  by_cases hj : j = i
  · subst hj; simp [up, dn]
  · simp [up, dn, hj]

theorem up_dn (i : Fin d) {α : Occ d} (h : 1 ≤ α i) : up i (dn i α) = α := by
  funext j
  by_cases hj : j = i
  · subst hj
    simp only [up, dn, Function.update_self]
    omega
  · simp [up, dn, hj]

theorem up_up (i : Fin d) (α : Occ d) : up i (up i α) = modeShift i α := by
  funext j
  by_cases hj : j = i
  · subst hj; simp [up, modeShift]
  · simp [up, modeShift, hj]

theorem modeShift_dn_dn (i : Fin d) {β : Occ d} (h : 2 ≤ β i) :
    modeShift i (dn i (dn i β)) = β := by
  rw [← up_up]
  have h1 : 1 ≤ dn i β i := by simp only [dn_self]; omega
  rw [up_dn i h1, up_dn i (by omega : 1 ≤ β i)]

theorem dn_dn_self (i : Fin d) (β : Occ d) : (dn i (dn i β)) i = β i - 2 := by
  simp only [dn_self]
  omega

/-! ## Annihilation and creation in a single mode -/

/-- `aᵢ x` has coordinates `√(αᵢ+1) x_{α+eᵢ}`. -/
noncomputable def annFun (i : Fin d) (X : Occ d → ℂ) : Occ d → ℂ :=
  fun α => (Real.sqrt ((α i : ℝ) + 1) : ℂ) * X (up i α)

/-- `aᵢ† x` has coordinates `√(αᵢ) x_{α−eᵢ}`. -/
noncomputable def creFun (i : Fin d) (X : Occ d → ℂ) : Occ d → ℂ :=
  fun α => (Real.sqrt (α i : ℝ) : ℂ) * X (dn i α)

theorem support_annFun (i : Fin d) {X : Occ d → ℂ} (h : (Function.support X).Finite) :
    (Function.support (annFun i X)).Finite := by
  refine Set.Finite.subset (h.preimage (f := up i)
    (Set.injOn_of_injective (up_injective i))) ?_
  intro α hα
  simp only [Function.mem_support, annFun] at hα
  simp only [Set.mem_preimage, Function.mem_support]
  intro h0
  exact hα (by rw [h0, mul_zero])

theorem support_creFun (i : Fin d) {X : Occ d → ℂ} (h : (Function.support X).Finite) :
    (Function.support (creFun i X)).Finite := by
  refine Set.Finite.subset (h.image (up i)) ?_
  intro α hα
  simp only [Function.mem_support, creFun] at hα
  have hpos : 1 ≤ α i := by
    by_contra hc
    have h0 : α i = 0 := by omega
    apply hα
    rw [h0]
    simp
  refine ⟨dn i α, ?_, up_dn i hpos⟩
  simp only [Function.mem_support]
  intro h0
  exact hα (by rw [h0, mul_zero])

/-- **The annihilation operator of the mode `i`.** -/
noncomputable def ann (i : Fin d) : lpFiniteModes (Occ d) →ₗ[ℂ] lpFiniteModes (Occ d) where
  toFun x := ⟨⟨annFun i ((x : L2I (Occ d)) : Occ d → ℂ),
      memLpTwo_of_finite_support (support_annFun i x.2)⟩, support_annFun i x.2⟩
  map_add' x y := by
    refine Subtype.ext (lp.ext (funext fun α => ?_))
    simp only [annFun, Submodule.coe_add, lp.coeFn_add, Pi.add_apply]
    ring
  map_smul' a x := by
    refine Subtype.ext (lp.ext (funext fun α => ?_))
    simp only [annFun, Submodule.coe_smul, lp.coeFn_smul, Pi.smul_apply,
      smul_eq_mul, RingHom.id_apply]
    ring

/-- **The creation operator of the mode `i`.** -/
noncomputable def cre (i : Fin d) : lpFiniteModes (Occ d) →ₗ[ℂ] lpFiniteModes (Occ d) where
  toFun x := ⟨⟨creFun i ((x : L2I (Occ d)) : Occ d → ℂ),
      memLpTwo_of_finite_support (support_creFun i x.2)⟩, support_creFun i x.2⟩
  map_add' x y := by
    refine Subtype.ext (lp.ext (funext fun α => ?_))
    simp only [creFun, Submodule.coe_add, lp.coeFn_add, Pi.add_apply]
    ring
  map_smul' a x := by
    refine Subtype.ext (lp.ext (funext fun α => ?_))
    simp only [creFun, Submodule.coe_smul, lp.coeFn_smul, Pi.smul_apply,
      smul_eq_mul, RingHom.id_apply]
    ring

@[simp] theorem ann_coe (i : Fin d) (x : lpFiniteModes (Occ d)) (α : Occ d) :
    (((ann i x : lpFiniteModes (Occ d)) : L2I (Occ d)) : Occ d → ℂ) α
      = (Real.sqrt ((α i : ℝ) + 1) : ℂ)
        * ((x : L2I (Occ d)) : Occ d → ℂ) (up i α) := rfl

@[simp] theorem cre_coe (i : Fin d) (x : lpFiniteModes (Occ d)) (α : Occ d) :
    (((cre i x : lpFiniteModes (Occ d)) : L2I (Occ d)) : Occ d → ℂ) α
      = (Real.sqrt (α i : ℝ) : ℂ) * ((x : L2I (Occ d)) : Occ d → ℂ) (dn i α) := rfl

/-! ### The quadratic expressions -/

theorem ann_ann_coe (i : Fin d) (x : lpFiniteModes (Occ d)) (α : Occ d) :
    (((ann i (ann i x) : lpFiniteModes (Occ d)) : L2I (Occ d)) : Occ d → ℂ) α
      = (Real.sqrt ((α i : ℝ) + 1) : ℂ) * (Real.sqrt ((α i : ℝ) + 2) : ℂ)
        * ((x : L2I (Occ d)) : Occ d → ℂ) (modeShift i α) := by
  rw [ann_coe, ann_coe, up_self, up_up]
  push_cast
  ring_nf

theorem cre_cre_coe_of_two_le (i : Fin d) (x : lpFiniteModes (Occ d)) {β : Occ d}
    (h : 2 ≤ β i) :
    (((cre i (cre i x) : lpFiniteModes (Occ d)) : L2I (Occ d)) : Occ d → ℂ) β
      = (Real.sqrt (β i : ℝ) : ℂ) * (Real.sqrt ((β i : ℝ) - 1) : ℂ)
        * ((x : L2I (Occ d)) : Occ d → ℂ) (dn i (dn i β)) := by
  rw [cre_coe, cre_coe, dn_self]
  have hcast : ((β i - 1 : ℕ) : ℝ) = (β i : ℝ) - 1 := by
    have : (1 : ℕ) ≤ β i := by omega
    push_cast [Nat.cast_sub this]
    ring
  rw [hcast]
  ring

theorem cre_cre_coe_of_lt (i : Fin d) (x : lpFiniteModes (Occ d)) {β : Occ d}
    (h : β i < 2) :
    (((cre i (cre i x) : lpFiniteModes (Occ d)) : L2I (Occ d)) : Occ d → ℂ) β = 0 := by
  rw [cre_coe, cre_coe, dn_self]
  rcases Nat.lt_or_ge (β i) 1 with h0 | h1
  · have : β i = 0 := by omega
    rw [this]
    simp
  · have : β i - 1 = 0 := by omega
    rw [this]
    simp

theorem ann_cre_coe (i : Fin d) (x : lpFiniteModes (Occ d)) (α : Occ d) :
    (((ann i (cre i x) : lpFiniteModes (Occ d)) : L2I (Occ d)) : Occ d → ℂ) α
      = ((α i : ℂ) + 1) * ((x : L2I (Occ d)) : Occ d → ℂ) α := by
  rw [ann_coe, cre_coe, up_self, dn_up]
  push_cast
  rw [← mul_assoc, sqrt_mul_sqrt _ (by positivity)]
  push_cast
  ring

theorem cre_ann_coe (i : Fin d) (x : lpFiniteModes (Occ d)) (α : Occ d) :
    (((cre i (ann i x) : lpFiniteModes (Occ d)) : L2I (Occ d)) : Occ d → ℂ) α
      = (α i : ℂ) * ((x : L2I (Occ d)) : Occ d → ℂ) α := by
  rw [cre_coe]
  rcases Nat.eq_zero_or_pos (α i) with h0 | h1
  · rw [h0]
    simp
  · rw [ann_coe, dn_self, up_dn i h1]
    have hcast : ((α i - 1 : ℕ) : ℝ) + 1 = (α i : ℝ) := by
      have : (1 : ℕ) ≤ α i := h1
      push_cast [Nat.cast_sub this]
      ring
    rw [hcast, ← mul_assoc, sqrt_mul_sqrt _ (by positivity)]
    push_cast
    ring

/-- **The canonical commutation relation** `[aᵢ, aᵢ†] = I`. -/
theorem comm_ann_cre (i : Fin d) :
    (ann i).comp (cre i) - (cre i).comp (ann i) = LinearMap.id := by
  refine LinearMap.ext fun x => Subtype.ext (lp.ext (funext fun α => ?_))
  simp only [LinearMap.sub_apply, LinearMap.comp_apply, LinearMap.id_apply, Submodule.coe_sub,
    lp.coeFn_sub, Pi.sub_apply, ann_cre_coe, cre_ann_coe]
  ring

/-! ## The canonical pair and the advection field of a mode -/

/-- The momentum of the mode `i`: `πᵢ = i√(κᵢ/2)(aᵢ† − aᵢ)`. -/
noncomputable def mom (κ : Fin d → ℝ) (i : Fin d) :
    lpFiniteModes (Occ d) →ₗ[ℂ] lpFiniteModes (Occ d) :=
  (Complex.I * (Real.sqrt (κ i / 2) : ℂ)) • (cre i - ann i)

/-- The fiber coordinate of the mode `i`: `uᵢ = (2κᵢ)^(-1/2)(aᵢ + aᵢ†)`. -/
noncomputable def pos (κ : Fin d → ℝ) (i : Fin d) :
    lpFiniteModes (Occ d) →ₗ[ℂ] lpFiniteModes (Occ d) :=
  ((1 / Real.sqrt (2 * κ i) : ℝ) : ℂ) • (cre i + ann i)

/-- The linear advection field of the mode `i`: `Vᵢ(u) = κᵢ uᵢ = √(κᵢ/2)(aᵢ + aᵢ†)`. -/
noncomputable def drift (κ : Fin d → ℝ) (i : Fin d) :
    lpFiniteModes (Occ d) →ₗ[ℂ] lpFiniteModes (Occ d) :=
  ((Real.sqrt (κ i / 2) : ℝ) : ℂ) • (cre i + ann i)

/-! ### The algebraic identities of a mode -/

theorem bracket_DS (i : Fin d) :
    (cre i - ann i).comp (cre i + ann i) - (cre i + ann i).comp (cre i - ann i)
      = (-2 : ℂ) • LinearMap.id := by
  refine LinearMap.ext fun x => Subtype.ext (lp.ext (funext fun α => ?_))
  simp only [LinearMap.sub_apply, LinearMap.add_apply, LinearMap.comp_apply, LinearMap.smul_apply,
    LinearMap.id_apply, map_add, map_sub, Submodule.coe_sub, Submodule.coe_add, Submodule.coe_smul,
    lp.coeFn_sub, lp.coeFn_add, lp.coeFn_smul, Pi.sub_apply, Pi.add_apply, Pi.smul_apply,
    smul_eq_mul, ann_cre_coe, cre_ann_coe]
  ring

theorem sq_diff (i : Fin d) :
    (cre i + ann i).comp (cre i + ann i) - (cre i - ann i).comp (cre i - ann i)
      = (2 : ℂ) • ((cre i).comp (ann i) + (ann i).comp (cre i)) := by
  refine LinearMap.ext fun x => Subtype.ext (lp.ext (funext fun α => ?_))
  simp only [LinearMap.sub_apply, LinearMap.add_apply, LinearMap.comp_apply, LinearMap.smul_apply,
    map_add, map_sub, Submodule.coe_sub, Submodule.coe_add, Submodule.coe_smul,
    lp.coeFn_sub, lp.coeFn_add, lp.coeFn_smul, Pi.sub_apply, Pi.add_apply, Pi.smul_apply,
    smul_eq_mul]
  ring

theorem anti_DS (i : Fin d) :
    (cre i - ann i).comp (cre i + ann i) + (cre i + ann i).comp (cre i - ann i)
      = (2 : ℂ) • ((cre i).comp (cre i) - (ann i).comp (ann i)) := by
  refine LinearMap.ext fun x => Subtype.ext (lp.ext (funext fun α => ?_))
  simp only [LinearMap.sub_apply, LinearMap.add_apply, LinearMap.comp_apply, LinearMap.smul_apply,
    map_add, map_sub, Submodule.coe_sub, Submodule.coe_add, Submodule.coe_smul,
    lp.coeFn_sub, lp.coeFn_add, lp.coeFn_smul, Pi.sub_apply, Pi.add_apply, Pi.smul_apply,
    smul_eq_mul]
  ring

theorem sqrt_half_sq (i : Fin d) (hκ : 0 ≤ κ i) :
    (Real.sqrt (κ i / 2) : ℂ) * (Real.sqrt (κ i / 2) : ℂ) = (κ i : ℂ) / 2 := by
  rw [sqrt_mul_sqrt _ (by positivity)]
  push_cast
  ring

theorem sqrt_half_mul_inv (i : Fin d) (hκ : 0 < κ i) :
    (Real.sqrt (κ i / 2) : ℂ) * ((1 / Real.sqrt (2 * κ i) : ℝ) : ℂ) = 1 / 2 := by
  have hreal : Real.sqrt (κ i / 2) * (1 / Real.sqrt (2 * κ i)) = 1 / 2 := by
    rw [Real.sqrt_div hκ.le, Real.sqrt_mul (by norm_num : (0 : ℝ) ≤ 2)]
    have hk : 0 < Real.sqrt (κ i) := Real.sqrt_pos.mpr hκ
    have h2 : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
    field_simp
    nlinarith [h2, hk]
  rw [← Complex.ofReal_mul, hreal]
  norm_num

/-- **`[πᵢ, uᵢ] = -i`.**  The momentum and the fiber coordinate of a mode do not
commute; this is why `[Ĥ, N̂] ≠ 0`. -/
theorem comm_mom_pos (i : Fin d) (hκ : 0 < κ i) :
    (mom κ i).comp (pos κ i) - (pos κ i).comp (mom κ i) = (-Complex.I) • LinearMap.id := by
  have hs : Complex.I * (Real.sqrt (κ i / 2) : ℂ) * ((1 / Real.sqrt (2 * κ i) : ℝ) : ℂ) * (-2)
      = -Complex.I := by
    linear_combination (-2 * Complex.I) * sqrt_half_mul_inv i hκ
  refine LinearMap.ext fun x => Subtype.ext (lp.ext (funext fun α => ?_))
  simp only [LinearMap.sub_apply, LinearMap.comp_apply, mom, pos, LinearMap.smul_apply,
    LinearMap.id_apply, LinearMap.add_apply, map_smul, map_add, map_sub,
    Submodule.coe_sub, Submodule.coe_add, Submodule.coe_smul, lp.coeFn_sub, lp.coeFn_add,
    lp.coeFn_smul, Pi.sub_apply, Pi.add_apply, Pi.smul_apply, smul_eq_mul,
    ann_cre_coe, cre_ann_coe]
  linear_combination (((x : L2I (Occ d)) : Occ d → ℂ) α) * hs

/-! ## The comparison operator -/

/-- The mode `i` contributes `κᵢ(2αᵢ + 1)` to the total energy. -/
theorem mode_comparison_eq (i : Fin d) (hκ : 0 ≤ κ i) :
    (mom κ i).comp (mom κ i) + (drift κ i).comp (drift κ i)
      = (κ i : ℂ) • ((cre i).comp (ann i) + (ann i).comp (cre i)) := by
  have h1 : (mom κ i).comp (mom κ i)
      = (-((Real.sqrt (κ i / 2) : ℂ) * (Real.sqrt (κ i / 2) : ℂ))) •
        (cre i - ann i).comp (cre i - ann i) := by
    simp only [mom, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul]
    congr 1
    ring_nf
    rw [Complex.I_sq]
    ring
  have h2 : (drift κ i).comp (drift κ i)
      = ((Real.sqrt (κ i / 2) : ℂ) * (Real.sqrt (κ i / 2) : ℂ)) •
        (cre i + ann i).comp (cre i + ann i) := by
    simp only [drift, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul]
  have hexp : (cre i + ann i).comp (cre i + ann i)
      = (cre i - ann i).comp (cre i - ann i)
        + (2 : ℂ) • ((cre i).comp (ann i) + (ann i).comp (cre i)) := by
    rw [← sq_diff i]
    abel
  rw [h1, h2, sqrt_half_sq i hκ, hexp]
  module

/-- Coordinates of a finite sum of core states. -/
theorem coe_sum_apply (s : Finset (Fin d)) (v : Fin d → lpFiniteModes (Occ d)) (α : Occ d) :
    (((∑ i ∈ s, v i : lpFiniteModes (Occ d)) : L2I (Occ d)) : Occ d → ℂ) α
      = ∑ i ∈ s, (((v i : lpFiniteModes (Occ d)) : L2I (Occ d)) : Occ d → ℂ) α := by
  classical
  induction s using Finset.induction with
  | empty => simp
  | insert i t hi ih =>
      rw [Finset.sum_insert hi, Finset.sum_insert hi, ← ih]
      simp only [Submodule.coe_add, lp.coeFn_add, Pi.add_apply]

/-- Coordinates of a finite sum of states. -/
theorem coe_sum_apply' (s : Finset (Fin d)) (v : Fin d → L2I (Occ d)) (α : Occ d) :
    (((∑ i ∈ s, v i : L2I (Occ d))) : Occ d → ℂ) α
      = ∑ i ∈ s, ((v i : L2I (Occ d)) : Occ d → ℂ) α := by
  classical
  induction s using Finset.induction with
  | empty => simp
  | insert i t hi ih =>
      rw [Finset.sum_insert hi, Finset.sum_insert hi, ← ih]
      simp only [lp.coeFn_add, Pi.add_apply]

/-- **`∑ᵢ(πᵢ² + Vᵢ²) + I = N̂`**: the comparison operator of the Fock space is the
sum, over the modes, of the squares of the individual non-commuting pieces. -/
theorem fock_comparison_eq (hκ : ∀ i, 0 ≤ κ i) :
    (lpFiniteModes (Occ d)).subtype.comp
        ((∑ i, ((mom κ i).comp (mom κ i) + (drift κ i).comp (drift κ i))) + LinearMap.id)
      = (diagMax (fockSym κ)).comp
        (Submodule.inclusion (finiteModes_le_maxDom (fockSym κ))) := by
  refine LinearMap.ext fun x => lp.ext (funext fun α => ?_)
  have hmode : ∀ i : Fin d,
      ((((mom κ i) ((mom κ i) x) + (drift κ i) ((drift κ i) x) : lpFiniteModes (Occ d)) :
          L2I (Occ d)) : Occ d → ℂ) α
        = ((κ i * (2 * (α i : ℝ) + 1) : ℝ) : ℂ)
          * ((x : L2I (Occ d)) : Occ d → ℂ) α := by
    intro i
    have hcomp := congrArg
      (fun T : lpFiniteModes (Occ d) →ₗ[ℂ] lpFiniteModes (Occ d) =>
        (((T x : lpFiniteModes (Occ d)) : L2I (Occ d)) : Occ d → ℂ) α)
      (mode_comparison_eq i (hκ i))
    simp only [LinearMap.add_apply, LinearMap.comp_apply, LinearMap.smul_apply,
      Submodule.coe_add, Submodule.coe_smul, lp.coeFn_add, lp.coeFn_smul, Pi.add_apply,
      Pi.smul_apply, smul_eq_mul, ann_cre_coe, cre_ann_coe] at hcomp
    simp only [Submodule.coe_add, lp.coeFn_add, Pi.add_apply]
    rw [hcomp]
    push_cast
    ring
  simp only [LinearMap.comp_apply, LinearMap.add_apply, Submodule.subtype_apply,
    LinearMap.id_apply, LinearMap.coe_sum, Finset.sum_apply, Submodule.coe_add,
    lp.coeFn_add, Pi.add_apply, diagMax_coe, Submodule.inclusion_apply]
  rw [coe_sum_apply Finset.univ
    (fun i => (mom κ i) ((mom κ i) x) + (drift κ i) ((drift κ i) x)) α,
    Finset.sum_congr rfl (fun i _ => hmode i), ← Finset.sum_mul]
  simp only [fockSym]
  push_cast
  ring

/-! ## The Hamiltonian -/

/-- The transport of a sequence along the mode-`i` shift, in coordinates. -/
theorem hop_modeData_eq (hκ : ∀ i, 0 ≤ κ i) (i : Fin d) (g : Occ d → ℂ) (β : Occ d) :
    (modeData hκ i).hop g β = if 2 ≤ β i then g (dn i (dn i β)) else 0 := by
  by_cases h : 2 ≤ β i
  · rw [if_pos h]
    have hβ : modeShift i (dn i (dn i β)) = β := modeShift_dn_dn i h
    conv_lhs => rw [← hβ]
    exact ShiftData.hop_shift (modeData hκ i) g _
  · rw [if_neg h]
    refine ShiftData.hop_eq_zero (modeData hκ i) g ?_
    rintro ⟨α, hα⟩
    apply h
    have hs : (modeData hκ i).shift α = modeShift i α := rfl
    rw [hs] at hα
    rw [← hα, modeShift_self]
    omega

/-- The mode-`i` symmetrised transport operator is the mode-`i` shift
Hamiltonian. -/
theorem mode_hamiltonian_eq (hκ : ∀ i, 0 ≤ κ i) (i : Fin d) :
    (lpFiniteModes (Occ d)).subtype.comp
        (((1 : ℂ) / 2) • ((mom κ i).comp (drift κ i) + (drift κ i).comp (mom κ i)))
      = (ShiftData.shiftH (modeData hκ i)).comp
        (Submodule.inclusion (finiteModes_le_maxDom (fockSym κ))) := by
  have hsym : (mom κ i).comp (drift κ i) + (drift κ i).comp (mom κ i)
      = (Complex.I * (κ i : ℂ)) • ((cre i).comp (cre i) - (ann i).comp (ann i)) := by
    have h1 : (mom κ i).comp (drift κ i)
        = (Complex.I * ((Real.sqrt (κ i / 2) : ℂ) * (Real.sqrt (κ i / 2) : ℂ))) •
          (cre i - ann i).comp (cre i + ann i) := by
      simp only [mom, drift, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul]
      congr 1
      ring
    have h2 : (drift κ i).comp (mom κ i)
        = (Complex.I * ((Real.sqrt (κ i / 2) : ℂ) * (Real.sqrt (κ i / 2) : ℂ))) •
          (cre i + ann i).comp (cre i - ann i) := by
      simp only [mom, drift, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul]
      congr 1
      ring
    rw [h1, h2, ← smul_add, anti_DS i, sqrt_half_sq i (hκ i), smul_smul]
    congr 1
    ring
  refine LinearMap.ext fun x => lp.ext (funext fun β => ?_)
  simp only [LinearMap.comp_apply, hsym, Submodule.subtype_apply, LinearMap.smul_apply,
    Submodule.coe_smul, lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, LinearMap.sub_apply,
    Submodule.coe_sub, lp.coeFn_sub, Pi.sub_apply, ShiftData.shiftH_coe,
    Submodule.inclusion_apply]
  rw [ShiftData.hFun, hop_modeData_eq hκ i, ann_ann_coe]
  have hamp : ∀ γ : Occ d, ((modeData hκ i).amp γ : ℂ)
      = ((κ i / 2 : ℝ) : ℂ) * (Real.sqrt ((γ i : ℝ) + 1) : ℂ)
        * (Real.sqrt ((γ i : ℝ) + 2) : ℂ) := by
    intro γ
    have : (modeData hκ i).amp γ = modeAmp κ i γ := rfl
    rw [this, modeAmp, Real.sqrt_mul (by positivity)]
    push_cast
    ring
  have hshift : (modeData hκ i).shift β = modeShift i β := rfl
  rw [hshift, hamp β]
  by_cases h : 2 ≤ β i
  · rw [if_pos h, cre_cre_coe_of_two_le i x h, hamp (dn i (dn i β)), dn_dn_self]
    have hc1 : (((β i - 2 : ℕ) : ℝ) + 1) = (β i : ℝ) - 1 := by
      have h2 : (2 : ℕ) ≤ β i := h
      push_cast [Nat.cast_sub h2]
      ring
    have hc2 : (((β i - 2 : ℕ) : ℝ) + 2) = (β i : ℝ) := by
      have h2 : (2 : ℕ) ≤ β i := h
      push_cast [Nat.cast_sub h2]
      ring
    rw [hc1, hc2]
    push_cast
    ring
  · rw [if_neg h, cre_cre_coe_of_lt i x (by omega)]
    push_cast
    ring

/-- **`∑ᵢ ½(πᵢVᵢ + Vᵢπᵢ) = Ĥ`**: the many-mode Navier–Stokes Hamiltonian of the
Fock space is the sum over the modes of the symmetrised transport operators. -/
theorem fock_hamiltonian_eq (hκ : ∀ i, 0 ≤ κ i) :
    (lpFiniteModes (Occ d)).subtype.comp
        (∑ i, ((1 : ℂ) / 2) • ((mom κ i).comp (drift κ i) + (drift κ i).comp (mom κ i)))
      = (fockH hκ).comp (Submodule.inclusion (finiteModes_le_maxDom (fockSym κ))) := by
  refine LinearMap.ext fun x => lp.ext (funext fun β => ?_)
  have hmode : ∀ i : Fin d,
      (((((1 : ℂ) / 2) • ((mom κ i).comp (drift κ i) + (drift κ i).comp (mom κ i)) x :
          lpFiniteModes (Occ d)) : L2I (Occ d)) : Occ d → ℂ) β
        = ((ShiftData.shiftH (modeData hκ i)
            (Submodule.inclusion (finiteModes_le_maxDom (fockSym κ)) x) :
              L2I (Occ d)) : Occ d → ℂ) β := by
    intro i
    have h := congrFun (congrArg (fun v : L2I (Occ d) => (v : Occ d → ℂ))
      (congrFun (congrArg (fun T : lpFiniteModes (Occ d) →ₗ[ℂ] L2I (Occ d) =>
        (T : lpFiniteModes (Occ d) → L2I (Occ d))) (mode_hamiltonian_eq hκ i)) x)) β
    exact h
  have hsumleft : ((((∑ i, ((1 : ℂ) / 2) •
        ((mom κ i).comp (drift κ i) + (drift κ i).comp (mom κ i))) x :
          lpFiniteModes (Occ d)) : L2I (Occ d)) : Occ d → ℂ) β
      = ∑ i, (((((1 : ℂ) / 2) • ((mom κ i).comp (drift κ i) + (drift κ i).comp (mom κ i)) x :
          lpFiniteModes (Occ d)) : L2I (Occ d)) : Occ d → ℂ) β := by
    rw [LinearMap.sum_apply]
    induction (Finset.univ : Finset (Fin d)) using Finset.induction with
    | empty => simp
    | insert i s hi ih =>
        rw [Finset.sum_insert hi, Finset.sum_insert hi, ← ih]
        rfl
  have hsumright : ((fockH hκ (Submodule.inclusion (finiteModes_le_maxDom (fockSym κ)) x) :
        L2I (Occ d)) : Occ d → ℂ) β
      = ∑ i, ((ShiftData.shiftH (modeData hκ i)
          (Submodule.inclusion (finiteModes_le_maxDom (fockSym κ)) x) :
            L2I (Occ d)) : Occ d → ℂ) β := by
    rw [fockH_apply]
    induction (Finset.univ : Finset (Fin d)) using Finset.induction with
    | empty => simp
    | insert i s hi ih =>
        rw [Finset.sum_insert hi, Finset.sum_insert hi, ← ih]
        rfl
  simp only [LinearMap.comp_apply, Submodule.subtype_apply]
  rw [hsumleft, hsumright]
  exact Finset.sum_congr rfl fun i _ => hmode i

/-- **The canonically written many-mode Navier–Stokes Hamiltonian
`∑ᵢ ½(πᵢVᵢ + Vᵢπᵢ)` is essentially self-adjoint on the finite-configuration
core of the Fock space.** -/
theorem fock_canonical_essentiallySelfAdjointOn_core (hκ : ∀ i, 0 ≤ κ i) :
    EssentiallySelfAdjointOn (lpFiniteModes (Occ d))
      ((lpFiniteModes (Occ d)).subtype.comp
        (∑ i, ((1 : ℂ) / 2) • ((mom κ i).comp (drift κ i) + (drift κ i).comp (mom κ i)))) := by
  rw [fock_hamiltonian_eq hκ]
  exact fockH_essentiallySelfAdjointOn_core hκ

end FockCanonical

end BookProof.NavierStokesFlow
