import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_memLpTwo_of_finite_support


import Definitions.Def_ChapterNavierStokesFockManyMode
import Definitions.Def_ChapterNavierStokesHermiteCanonical
import Mathlib


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

open LpNat BookProof.FarisLavine IkebeKato ShiftHamiltonian FockManyMode HermiteCanonical

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













/-! ## The comparison operator -/









/-! ## The Hamiltonian -/



βi)m (fockSym κ)) x) :
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
