import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib


/-!
# The bosonic and the fermionic two-particle sector

`BookProof.TensorCore` builds the sector derivation `dΓ(A)⁽ⁿ⁾` on the **full** tensor power
`H^{⊗n}` and proves that a one-particle core lifts to a core of it.  The physical two-particle
spaces are the *symmetric* and the *antisymmetric* halves of `H^{⊗2}`, i.e. the two
eigenspaces of the swap `x ⊗ y ↦ y ⊗ x`.  This module carries essential self-adjointness from
the full power to those halves.

The mechanism is the general reduction principle of `BookProof.ReducedEsa`: the swap is a
self-inverse isometry, it preserves the domain `D₂^{⊗2}` and the core `D^{⊗2}`, and it
commutes with the derivation — the Leibniz rule is symmetric in the two factors.  Hence the
projections `(1 ± swap)/2` are reducing projections for the derivation, and essential
self-adjointness descends to each sector.

## Contents

* `swapTwo` — the swap of a two-fold (nested) tensor power `X ⊗ (X ⊗ ℂ)`, as a linear
  isometry equivalence; `swapTwo_tmul`, `swapTwo_involutive`, `swapTwo_inner`.
* `swapH`, `swapDom` — the swap on `H^{⊗2}` and on `D₂^{⊗2}`, and their compatibility with
  the inclusion (`inclPow_swapDom`) and with the derivation (`derPow_swapDom`).
* `swapH_mem_sectorDom`, `swapH_mem_sectorCore` — the swap preserves the domain and the core.
* `sectorOp_swapH`, `restrictOp_sectorOp_swapH` — the swap commutes with the two-particle
  derivation, on the domain and on the core.
* **`essentiallySelfAdjointOn_bosonic`**, **`essentiallySelfAdjointOn_fermionic`** — the two
  sector statements on the domain `D₂^{⊗2}`; **`essentiallySelfAdjointOn_bosonic_core`**,
  **`essentiallySelfAdjointOn_fermionic_core`** — the same on the symmetrized and the
  antisymmetrized one-particle core `D^{⊗2}`, for any core `D` of `A`.
* `mem_bosonic_iff`, `mem_fermionic_iff` — the two sectors are exactly the `+1` and the `-1`
  eigenspaces of the swap.

Nothing is assumed: the module contains no `axiom` and no `sorry`.
-/

namespace BookProof.TwoParticleSector

open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore

noncomputable section

/-! ## The swap of a two-fold tensor power -/

variable (X : Type) [NormedAddCommGroup X] [InnerProductSpace ℂ X]

/-- The **swap** `x ⊗ (y ⊗ c) ↦ y ⊗ (x ⊗ c)` of a two-fold tensor power, in the nested form
`X ⊗ (X ⊗ ℂ)` in which `BookProof.TensorCore.IPSpace.pow` presents `X^{⊗2}`.  It is built
from the associator and the commutor, so it is an isometry. -/
def swapTwo : X ⊗[ℂ] (X ⊗[ℂ] ℂ) ≃ₗᵢ[ℂ] X ⊗[ℂ] (X ⊗[ℂ] ℂ) :=
  (TensorProduct.assocIsometry ℂ X X ℂ).symm.trans
    ((TensorProduct.congrIsometry (TensorProduct.commIsometry ℂ X X)
      (LinearIsometryEquiv.refl ℂ ℂ)).trans (TensorProduct.assocIsometry ℂ X X ℂ))

@[simp] theorem swapTwo_tmul (x y : X) (c : ℂ) :
    swapTwo X (x ⊗ₜ[ℂ] (y ⊗ₜ[ℂ] c)) = y ⊗ₜ[ℂ] (x ⊗ₜ[ℂ] c) := by
  simp [swapTwo, TensorProduct.congrIsometry]

variable {X}





/-! ## The swap on the two-particle space and on its domain -/

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)

/-- The swap of `H^{⊗2}`, as a linear map. -/
def swapH : (Hs.pow 2).carrier →ₗ[ℂ] (Hs.pow 2).carrier :=
  (swapTwo (X := Hs.carrier)).toLinearEquiv.toLinearMap

/-- The swap of the algebraic tensor square `D₂^{⊗2}` of the domain. -/
def swapDom : ((domSpace Hs D₂).pow 2).carrier →ₗ[ℂ] ((domSpace Hs D₂).pow 2).carrier :=
  (swapTwo (X := D₂)).toLinearEquiv.toLinearMap

@[simp] theorem swapH_tmul (x y : Hs.carrier) (c : ℂ) :
    swapH Hs (x ⊗ₜ[ℂ] (y ⊗ₜ[ℂ] c) : (Hs.pow 2).carrier) = y ⊗ₜ[ℂ] (x ⊗ₜ[ℂ] c) :=
  swapTwo_tmul Hs.carrier x y c

@[simp] theorem swapDom_tmul (a b : D₂) (c : ℂ) :
    swapDom Hs D₂ (a ⊗ₜ[ℂ] (b ⊗ₜ[ℂ] c) : ((domSpace Hs D₂).pow 2).carrier)
      = b ⊗ₜ[ℂ] (a ⊗ₜ[ℂ] c) :=
  swapTwo_tmul (D₂ : Type) a b cThe bosonic and the fermionic two-particle sector

`BookProof.TensorCore` builds the sector derivation `dΓ(A)⁽ⁿ⁾` on the **full** tensor power
`H^{⊗n}` and proves that a one-particle core lifts to a core of it.  The physical two-particle
spaces are the *symmetric* and the *antisymmetric* halves of `H^{⊗2}`, i.e. the two
eigenspaces of the swap `x ⊗ y ↦ y ⊗ x`.  This module carries essential self-adjointness from
the full power to those halves.

The mechanism is the general reduction principle of `BookProof.ReducedEsa`: the swap is a
self-inverse isometry, it preserves the domain `D₂^{⊗2}` and the core `D^{⊗2}`, and it
commutes with the derivation — the Leibniz rule is symmetric in the two factors.  Hence the
projections `(1 ± swap)/2` are reducing projections for the derivation, and essential
self-adjointness descends to each sector.

## Contents

* `swapTwo` — the swap of a two-fold (nested) tensor power `X ⊗ (X ⊗ ℂ)`, as a linear
  isometry equivalence; `swapTwo_tmul`, `swapTwo_involutive`, `swapTwo_inner`.
* `swapH`, `swapDom` — the swap on `H^{⊗2}` and on `D₂^{⊗2}`, and their compatibility with
  the inclusion (`inclPow_swapDom`) and with the derivation (`derPow_swapDom`).
* `swapH_mem_sectorDom`, `swapH_mem_sectorCore` — the swap preserves the domain and the core.
* `sectorOp_swapH`, `restrictOp_sectorOp_swapH` — the swap commutes with the two-particle
  derivation, on the domain and on the core.
* **`essentiallySelfAdjointOn_bosonic`**, **`essentiallySelfAdjointOn_fermionic`** — the two
  sector statements on the domain `D₂^{⊗2}`; **`essentiallySelfAdjointOn_bosonic_core`**,
  **`essentiallySelfAdjointOn_fermionic_core`** — the same on the symmetrized and the
  antisymmetrized one-particle core `D^{⊗2}`, for any core `D` of `A`.
* `mem_bosonic_iff`, `mem_fermionic_iff` — the two sectors are exactly the `+1` and the `-1`
  eigenspaces of the swap.

Nothing is assumed: the module contains no `axiom` and no `sorry`.
-/

namespace BookProof.TwoParticleSector

open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore

noncomputable section

/-! ## The swap of a two-fold tensor power -/

variable (X : Type) [NormedAddCommGroup X] [InnerProductSpace ℂ X]

/-- The **swap** `x ⊗ (y ⊗ c) ↦ y ⊗ (x ⊗ c)` of a two-fold tensor power, in the nested form
`X ⊗ (X ⊗ ℂ)` in which `BookProof.TensorCore.IPSpace.pow` presents `X^{⊗2}`.  It is built
from the associator and the commutor, so it is an isometry. -/
def swapTwo : X ⊗[ℂ] (X ⊗[ℂ] ℂ) ≃ₗᵢ[ℂ] X ⊗[ℂ] (X ⊗[ℂ] ℂ) :=
  (TensorProduct.assocIsometry ℂ X X ℂ).symm.trans
    ((TensorProduct.congrIsometry (TensorProduct.commIsometry ℂ X X)
      (LinearIsometryEquiv.refl ℂ ℂ)).trans (TensorProduct.assocIsometry ℂ X X ℂ))

@[simp] theorem swapTwo_tmul (x y : X) (c : ℂ) :
    swapTwo X (x ⊗ₜ[ℂ] (y ⊗ₜ[ℂ] c)) = y ⊗ₜ[ℂ] (x ⊗ₜ[ℂ] c) := by
  simp [swapTwo, TensorProduct.congrIsometry]

variable {X}

/-- The swap is self-inverse. -/
theorem swapTwo_involutive (t : X ⊗[ℂ] (X ⊗[ℂ] ℂ)) : swapTwo X (swapTwo X t) = t := by
  induction t using TensorProduct.induction_on with
  | zero => simp
  | tmul x b =>
      induction b using TensorProduct.induction_on with
      | zero => simp
      | tmul y c => simp
      | add u v hu hv => simp [TensorProduct.tmul_add, hu, hv]
  | add u v hu hv => simp [hu, hv]

/-- The swap preserves the inner product. -/
theorem swapTwo_inner (t s : X ⊗[ℂ] (X ⊗[ℂ] ℂ)) :
    (inner ℂ (swapTwo X t) (swapTwo X s) : ℂ) = inner ℂ t s :=
  (swapTwo X).inner_map_map t s

/-! ## The swap on the two-particle space and on its domain -/

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)

/-- The swap of `H^{⊗2}`, as a linear map. -/
def swapH : (Hs.pow 2).carrier →ₗ[ℂ] (Hs.pow 2).carrier :=
  (swapTwo (X := Hs.carrier)).toLinearEquiv.toLinearMap

/-- The swap of the algebraic tensor square `D₂^{⊗2}` of the domain. -/
def swapDom : ((domSpace Hs D₂).pow 2).carrier →ₗ[ℂ] ((domSpace Hs D₂).pow 2).carrier :=
  (swapTwo (X := D₂)).toLinearEquiv.toLinearMap

@[simp] theorem swapH_tmul (x y : Hs.carrier) (c : ℂ) :
    swapH Hs (x ⊗ₜ[ℂ] (y ⊗ₜ[ℂ] c) : (Hs.pow 2).carrier) = y ⊗ₜ[ℂ] (x ⊗ₜ[ℂ] c) :=
  swapTwo_tmul Hs.carrier x y c

@[simp] theorem swapDom_tmul (a b : D₂) (c : ℂ) :
    swapDom Hs D₂ (a ⊗ₜ[ℂ] (b ⊗ₜ[ℂ] c) : ((domSpace Hs D₂).pow 2).carrier)
      = b ⊗ₜ[ℂ] (a ⊗ₜ[ℂ] c) :=
  swapTwo_tmul (D₂ : Type) a b c



theorem swapH_inner (t s : (Hs.pow 2).carrier) :
    (inner ℂ (swapH Hs t) (swapH Hs s) : ℂ) = inner ℂ t s :=
  swapTwo_inner t s





variable (A : D₂ →ₗ[ℂ] Hs.carrier)





/-! ## The swap preserves the domain and the core -/



variable (D : Submodule ℂ Hs.carrier)

⁾` on the **full** tensor power
`H^{⊗n}` and proves that a one-particle core lifts to a core of it.  The physical two-particle
spaces are the *symmetric* and the *antisymmetric* halves of `H^{⊗2}`, i.e. the two
eigenspaces of the swap `x ⊗ y ↦ y ⊗ x`.  This module carries essential self-adjointness from
the full power to those halves.

The mechanism is the general reduction principle of `BookProof.ReducedEsa`: the swap is a
self-inverse isometry, it preserves the domain `D₂^{⊗2}` and the core `D^{⊗2}`, and it
commutes with the derivation — the Leibniz rule is symmetric in the two factors.  Hence the
projections `(1 ± swap)/2` are reducing projections for the derivation, and essential
self-adjointness descends to each sector.

## Contents

* `swapTwo` — the swap of a two-fold (nested) tensor power `X ⊗ (X ⊗ ℂ)`, as a linear
  isometry equivalence; `swapTwo_tmul`, `swapTwo_involutive`, `swapTwo_inner`.
* `swapH`, `swapDom` — the swap on `H^{⊗2}` and on `D₂^{⊗2}`, and their compatibility with
  the inclusion (`inclPow_swapDom`) and with the derivation (`derPow_swapDom`).
* `swapH_mem_sectorDom`, `swapH_mem_sectorCore` — the swap preserves the domain and the core.
* `sectorOp_swapH`, `restrictOp_sectorOp_swapH` — the swap commutes with the two-particle
  derivation, on the domain and on the core.
* **`essentiallySelfAdjointOn_bosonic`**, **`essentiallySelfAdjointOn_fermionic`** — the two
  sector statements on the domain `D₂^{⊗2}`; **`essentiallySelfAdjointOn_bosonic_core`**,
  **`essentiallySelfAdjointOn_fermionic_core`** — the same on the symmetrized and the
  antisymmetrized one-particle core `D^{⊗2}`, for any core `D` of `A`.
* `mem_bosonic_iff`, `mem_fermionic_iff` — the two sectors are exactly the `+1` and the `-1`
  eigenspaces of the swap.

Nothing is assumed: the module contains no `axiom` and no `sorry`.
-/

namespace BookProof.TwoParticleSector

open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore

noncomputable section

/-! ## The swap of a two-fold tensor power -/

variable (X : Type) [NormedAddCommGroup X] [InnerProductSpace ℂ X]

/-- The **swap** `x ⊗ (y ⊗ c) ↦ y ⊗ (x ⊗ c)` of a two-fold tensor power, in the nested form
`X ⊗ (X ⊗ ℂ)` in which `BookProof.TensorCore.IPSpace.pow` presents `X^{⊗2}`.  It is built
from the associator and the commutor, so it is an isometry. -/
def swapTwo : X ⊗[ℂ] (X ⊗[ℂ] ℂ) ≃ₗᵢ[ℂ] X ⊗[ℂ] (X ⊗[ℂ] ℂ) :=
  (TensorProduct.assocIsometry ℂ X X ℂ).symm.trans
    ((TensorProduct.congrIsometry (TensorProduct.commIsometry ℂ X X)
      (LinearIsometryEquiv.refl ℂ ℂ)).trans (TensorProduct.assocIsometry ℂ X X ℂ))

@[simp] theorem swapTwo_tmul (x y : X) (c : ℂ) :
    swapTwo X (x ⊗ₜ[ℂ] (y ⊗ₜ[ℂ] c)) = y ⊗ₜ[ℂ] (x ⊗ₜ[ℂ] c) := by
  simp [swapTwo, TensorProduct.congrIsometry]

variable {X}

/-- The swap is self-inverse. -/
theorem swapTwo_involutive (t : X ⊗[ℂ] (X ⊗[ℂ] ℂ)) : swapTwo X (swapTwo X t) = t := by
  induction t using TensorProduct.induction_on with
  | zero => simp
  | tmul x b =>
      induction b using TensorProduct.induction_on with
      | zero => simp
      | tmul y c => simp
      | add u v hu hv => simp [TensorProduct.tmul_add, hu, hv]
  | add u v hu hv => simp [hu, hv]

/-- The swap preserves the inner product. -/
theorem swapTwo_inner (t s : X ⊗[ℂ] (X ⊗[ℂ] ℂ)) :
    (inner ℂ (swapTwo X t) (swapTwo X s) : ℂ) = inner ℂ t s :=
  (swapTwo X).inner_map_map t s

/-! ## The swap on the two-particle space and on its domain -/

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)

/-- The swap of `H^{⊗2}`, as a linear map. -/
def swapH : (Hs.pow 2).carrier →ₗ[ℂ] (Hs.pow 2).carrier :=
  (swapTwo (X := Hs.carrier)).toLinearEquiv.toLinearMap

/-- The swap of the algebraic tensor square `D₂^{⊗2}` of the domain. -/
def swapDom : ((domSpace Hs D₂).pow 2).carrier →ₗ[ℂ] ((domSpace Hs D₂).pow 2).carrier :=
  (swapTwo (X := D₂)).toLinearEquiv.toLinearMap

@[simp] theorem swapH_tmul (x y : Hs.carrier) (c : ℂ) :
    swapH Hs (x ⊗ₜ[ℂ] (y ⊗ₜ[ℂ] c) : (Hs.pow 2).carrier) = y ⊗ₜ[ℂ] (x ⊗ₜ[ℂ] c) :=
  swapTwo_tmul Hs.carrier x y c

@[simp] theorem swapDom_tmul (a b : D₂) (c : ℂ) :
    swapDom Hs D₂ (a ⊗ₜ[ℂ] (b ⊗ₜ[ℂ] c) : ((domSpace Hs D₂).pow 2).carrier)
      = b ⊗ₜ[ℂ] (a ⊗ₜ[ℂ] c) :=
  swapTwo_tmul (D₂ : Type) a b c

theorem swapH_involutive (t : (Hs.pow 2).carrier) : swapH Hs (swapH Hs t) = t :=
  swapTwo_involutive t

theorem swapH_inner (t s : (Hs.pow 2).carrier) :
    (inner ℂ (swapH Hs t) (swapH Hs s) : ℂ) = inner ℂ t s :=
  swapTwo_inner t s

/-- A double induction principle for the nested tensor square, used repeatedly below. -/
theorem tensorSquare_induction {Y : Type} [NormedAddCommGroup Y] [InnerProductSpace ℂ Y]
    {P : Y ⊗[ℂ] (Y ⊗[ℂ] ℂ) → Prop} (hzero : P 0)
    (htmul : ∀ (x y : Y) (c : ℂ), P (x ⊗ₜ[ℂ] (y ⊗ₜ[ℂ] c)))
    (hadd : ∀ u v, P u → P v → P (u + v)) (t : Y ⊗[ℂ] (Y ⊗[ℂ] ℂ)) : P t := by
  induction t using TensorProduct.induction_on with
  | zero => exact hzero
  | tmul x b =>
      induction b using TensorProduct.induction_on with
      | zero => simpa using hzero
      | tmul y c => exact htmul x y c
      | add u v hu hv => rw [TensorProduct.tmul_add]; exact hadd _ _ hu hv
  | add u v hu hv => exact hadd _ _ hu hv

/-- The swap is compatible with the inclusion of the domain square. -/
theorem inclPow_swapDom (t : ((domSpace Hs D₂).pow 2).carrier) :
    inclPow Hs D₂ 2 (swapDom Hs D₂ t) = swapH Hs (inclPow Hs D₂ 2 t) := by
  refine tensorSquare_induction (Y := (D₂ : Type))
    (P := fun t => inclPow Hs D₂ 2 (swapDom Hs D₂ t) = swapH Hs (inclPow Hs D₂ 2 t))
    ?_ ?_ ?_ t
  · simp
  · intro a b c
    have h1 : inclPow Hs D₂ 2 (a ⊗ₜ[ℂ] (b ⊗ₜ[ℂ] c) : ((domSpace Hs D₂).pow 2).carrier)
        = (a : Hs.carrier) ⊗ₜ[ℂ] ((b : Hs.carrier) ⊗ₜ[ℂ] c) := rfl
    have h2 : inclPow Hs D₂ 2 (b ⊗ₜ[ℂ] (a ⊗ₜ[ℂ] c) : ((domSpace Hs D₂).pow 2).carrier)
        = (b : Hs.carrier) ⊗ₜ[ℂ] ((a : Hs.carrier) ⊗ₜ[ℂ] c) := rfl
    rw [swapDom_tmul, h1, h2, swapH_tmul]
  · intro u v hu hv
    simp [map_add, hu, hv]

variable (A : D₂ →ₗ[ℂ] Hs.carrier)

/-- The derivation on the nested tensor square, computed on elementary tensors. -/
theorem derPow_two_tmul (a b : D₂) (c : ℂ) :
    derPow Hs D₂ A 2 (a ⊗ₜ[ℂ] (b ⊗ₜ[ℂ] c) : ((domSpace Hs D₂).pow 2).carrier)
      = (A a) ⊗ₜ[ℂ] ((b : Hs.carrier) ⊗ₜ[ℂ] c)
        + (a : Hs.carrier) ⊗ₜ[ℂ] ((A b) ⊗ₜ[ℂ] c) := by
  have h1 : derPow Hs D₂ A 2 (a ⊗ₜ[ℂ] (b ⊗ₜ[ℂ] c) : ((domSpace Hs D₂).pow 2).carrier)
      = (A a) ⊗ₜ[ℂ] inclPow Hs D₂ 1 (b ⊗ₜ[ℂ] c)
        + (a : Hs.carrier) ⊗ₜ[ℂ] derPow Hs D₂ A 1 (b ⊗ₜ[ℂ] c) := rfl
  have h2 : inclPow Hs D₂ 1 (b ⊗ₜ[ℂ] c : ((domSpace Hs D₂).pow 1).carrier)
      = (b : Hs.carrier) ⊗ₜ[ℂ] c := rfl
  have h3 : derPow Hs D₂ A 1 (b ⊗ₜ[ℂ] c : ((domSpace Hs D₂).pow 1).carrier)
      = (A b) ⊗ₜ[ℂ] (c : (Hs.pow 0).carrier) := by
    have : derPow Hs D₂ A 1 (b ⊗ₜ[ℂ] c : ((domSpace Hs D₂).pow 1).carrier)
        = (A b) ⊗ₜ[ℂ] inclPow Hs D₂ 0 c
          + (b : Hs.carrier) ⊗ₜ[ℂ] derPow Hs D₂ A 0 c := rfl
    rw [this, derPow_zero]
    simp [inclPow]
  rw [h1, h2, h3]

/-- **The swap commutes with the derivation**: the Leibniz rule is symmetric in the two
factors. -/
theorem derPow_swapDom (t : ((domSpace Hs D₂).pow 2).carrier) :
    derPow Hs D₂ A 2 (swapDom Hs D₂ t) = swapH Hs (derPow Hs D₂ A 2 t) := by
  refine tensorSquare_induction (Y := (D₂ : Type))
    (P := fun t => derPow Hs D₂ A 2 (swapDom Hs D₂ t) = swapH Hs (derPow Hs D₂ A 2 t))
    ?_ ?_ ?_ t
  · simp
  · intro a b c
    rw [swapDom_tmul, derPow_two_tmul, derPow_two_tmul]
    rw [map_add, swapH_tmul, swapH_tmul]
    abel
  · intro u v hu hv
    simp [map_add, hu, hv]

/-! ## The swap preserves the domain and the core -/

theorem swapH_mem_sectorDom {x : (Hs.pow 2).carrier} (hx : x ∈ sectorDom Hs D₂ 2) :
    swapH Hs x ∈ sectorDom Hs D₂ 2 := by
  obtain ⟨t, rfl⟩ := hx
  exact ⟨swapDom Hs D₂ t, inclPow_swapDom Hs D₂ t⟩

variable (D : Submodule ℂ Hs.carrier)

/-- The swap preserves the algebraic tensor square of the one-particle core. -/
theorem swapDom_mem_corePow {t : ((domSpace Hs D₂).pow 2).carrier}
    (ht : t ∈ corePow Hs D₂ D 2) : swapDom Hs D₂ t ∈ corePow Hs D₂ D 2 := by
  induction ht using Submodule.span_induction with
  | mem u hu =>
      obtain ⟨a, haD, b, hb, rfl⟩ := hu
      -- `b` lies in the one-particle core power, which is spanned by `b' ⊗ c`
      induction hb using Submodule.span_induction with
      | mem v hv =>
          obtain ⟨b', hb'D, c, -, rfl⟩ := hv
          rw [swapDom_tmul]
          exact tmul_mem_corePow Hs D₂ D hb'D
            (tmul_mem_corePow Hs D₂ D haD (by trivial))
      | zero => simp
      | add s s' _ _ hs hs' =>
          rw [TensorProduct.tmul_add, map_add]
          exact Submodule.add_mem _ hs hs'
      | smul r s _ hs =>
          rw [TensorProduct.tmul_smul, map_smul]
          exact Submodule.smul_mem _ r hs
  | zero => simp
  | add u v _ _ hu hv => rw [map_add]; exact Submodule.add_mem _ hu hv
  | smul r u _ hu => rw [map_smul]; exact Submodule.smul_mem _ r hu



/-! ## The swap commutes with the two-particle operator -/

theorem sectorOp_swapH (x : sectorDom Hs D₂ 2) :
    sectorOp Hs D₂ A 2 ⟨swapH Hs (x : (Hs.pow 2).carrier),
        swapH_mem_sectorDom Hs D₂ x.2⟩
      = swapH Hs (sectorOp Hs D₂ A 2 x) := by
  obtain ⟨t, ht⟩ := x.2
  have hx : (x : (Hs.pow 2).carrier) = inclPow Hs D₂ 2 t := ht.symm
  have hsw : swapH Hs (x : (Hs.pow 2).carrier) = inclPow Hs D₂ 2 (swapDom Hs D₂ t) := by
    rw [inclPow_swapDom, hx]
  rw [sectorOp_apply Hs D₂ A 2 _ _ hsw, sectorOp_apply Hs D₂ A 2 x t hx,
    derPow_swapDom]



/-! ## The two sectors -/

/-- The bosonic (symmetric) two-particle sector: the range of `(1 + swap)/2`. -/
def bosonicProj : (Hs.pow 2).carrier →ₗ[ℂ] (Hs.pow 2).carrier := symProj (swapH Hs)

/-- The fermionic (antisymmetric) two-particle sector: the range of `(1 - swap)/2`. -/
def fermionicProj : (Hs.pow 2).carrier →ₗ[ℂ] (Hs.pow 2).carrier := asymProj (swapH Hs)









/-! ## Essential self-adjointness on the two sectors -/









/-! ## Non-vacuity of the two sectors -/



 *antisymmetric* halves of `H^{⊗2}`, i.e. the two
eigenspaces of the swap `x ⊗ y ↦ y ⊗ x`.  This module carries essential self-adjointness from
the full power to those halves.

The mechanism is the general reduction principle of `BookProof.ReducedEsa`: the swap is a
self-inverse isometry, it preserves the domain `D₂^{⊗2}` and the core `D^{⊗2}`, and it
commutes with the derivation — the Leibniz rule is symmetric in the two factors.  Hence the
projections `(1 ± swap)/2` are reducing projections for the derivation, and essential
self-adjointness descends to each sector.

## Contents

* `swapTwo` — the swap of a two-fold (nested) tensor power `X ⊗ (X ⊗ ℂ)`, as a linear
  isometry equivalence; `swapTwo_tmul`, `swapTwo_involutive`, `swapTwo_inner`.
* `swapH`, `swapDom` — the swap on `H^{⊗2}` and on `D₂^{⊗2}`, and their compatibility with
  the inclusion (`inclPow_swapDom`) and with the derivation (`derPow_swapDom`).
* `swapH_mem_sectorDom`, `swapH_mem_sectorCore` — the swap preserves the domain and the core.
* `sectorOp_swapH`, `restrictOp_sectorOp_swapH` — the swap commutes with the two-particle
  derivation, on the domain and on the core.
* **`essentiallySelfAdjointOn_bosonic`**, **`essentiallySelfAdjointOn_fermionic`** — the two
  sector statements on the domain `D₂^{⊗2}`; **`essentiallySelfAdjointOn_bosonic_core`**,
  **`essentiallySelfAdjointOn_fermionic_core`** — the same on the symmetrized and the
  antisymmetrized one-particle core `D^{⊗2}`, for any core `D` of `A`.
* `mem_bosonic_iff`, `mem_fermionic_iff` — the two sectors are exactly the `+1` and the `-1`
  eigenspaces of the swap.

Nothing is assumed: the module contains no `axiom` and no `sorry`.
-/

namespace BookProof.TwoParticleSector

open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore

noncomputable section

/-! ## The swap of a two-fold tensor power -/

variable (X : Type) [NormedAddCommGroup X] [InnerProductSpace ℂ X]

/-- The **swap** `x ⊗ (y ⊗ c) ↦ y ⊗ (x ⊗ c)` of a two-fold tensor power, in the nested form
`X ⊗ (X ⊗ ℂ)` in which `BookProof.TensorCore.IPSpace.pow` presents `X^{⊗2}`.  It is built
from the associator and the commutor, so it is an isometry. -/
def swapTwo : X ⊗[ℂ] (X ⊗[ℂ] ℂ) ≃ₗᵢ[ℂ] X ⊗[ℂ] (X ⊗[ℂ] ℂ) :=
  (TensorProduct.assocIsometry ℂ X X ℂ).symm.trans
    ((TensorProduct.congrIsometry (TensorProduct.commIsometry ℂ X X)
      (LinearIsometryEquiv.refl ℂ ℂ)).trans (TensorProduct.assocIsometry ℂ X X ℂ))

@[simp] theorem swapTwo_tmul (x y : X) (c : ℂ) :
    swapTwo X (x ⊗ₜ[ℂ] (y ⊗ₜ[ℂ] c)) = y ⊗ₜ[ℂ] (x ⊗ₜ[ℂ] c) := by
  simp [swapTwo, TensorProduct.congrIsometry]

variable {X}

/-- The swap is self-inverse. -/
theorem swapTwo_involutive (t : X ⊗[ℂ] (X ⊗[ℂ] ℂ)) : swapTwo X (swapTwo X t) = t := by
  induction t using TensorProduct.induction_on with
  | zero => simp
  | tmul x b =>
      induction b using TensorProduct.induction_on with
      | zero => simp
      | tmul y c => simp
      | add u v hu hv => simp [TensorProduct.tmul_add, hu, hv]
  | add u v hu hv => simp [hu, hv]

/-- The swap preserves the inner product. -/
theorem swapTwo_inner (t s : X ⊗[ℂ] (X ⊗[ℂ] ℂ)) :
    (inner ℂ (swapTwo X t) (swapTwo X s) : ℂ) = inner ℂ t s :=
  (swapTwo X).inner_map_map t s

/-! ## The swap on the two-particle space and on its domain -/

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)

/-- The swap of `H^{⊗2}`, as a linear map. -/
def swapH : (Hs.pow 2).carrier →ₗ[ℂ] (Hs.pow 2).carrier :=
  (swapTwo (X := Hs.carrier)).toLinearEquiv.toLinearMap

/-- The swap of the algebraic tensor square `D₂^{⊗2}` of the domain. -/
def swapDom : ((domSpace Hs D₂).pow 2).carrier →ₗ[ℂ] ((domSpace Hs D₂).pow 2).carrier :=
  (swapTwo (X := D₂)).toLinearEquiv.toLinearMap

@[simp] theorem swapH_tmul (x y : Hs.carrier) (c : ℂ) :
    swapH Hs (x ⊗ₜ[ℂ] (y ⊗ₜ[ℂ] c) : (Hs.pow 2).carrier) = y ⊗ₜ[ℂ] (x ⊗ₜ[ℂ] c) :=
  swapTwo_tmul Hs.carrier x y c

@[simp] theorem swapDom_tmul (a b : D₂) (c : ℂ) :
    swapDom Hs D₂ (a ⊗ₜ[ℂ] (b ⊗ₜ[ℂ] c) : ((domSpace Hs D₂).pow 2).carrier)
      = b ⊗ₜ[ℂ] (a ⊗ₜ[ℂ] c) :=
  swapTwo_tmul (D₂ : Type) a b c

theorem swapH_involutive (t : (Hs.pow 2).carrier) : swapH Hs (swapH Hs t) = t :=
  swapTwo_involutive t

theorem swapH_inner (t s : (Hs.pow 2).carrier) :
    (inner ℂ (swapH Hs t) (swapH Hs s) : ℂ) = inner ℂ t s :=
  swapTwo_inner t s

/-- A double induction principle for the nested tensor square, used repeatedly below. -/
theorem tensorSquare_induction {Y : Type} [NormedAddCommGroup Y] [InnerProductSpace ℂ Y]
    {P : Y ⊗[ℂ] (Y ⊗[ℂ] ℂ) → Prop} (hzero : P 0)
    (htmul : ∀ (x y : Y) (c : ℂ), P (x ⊗ₜ[ℂ] (y ⊗ₜ[ℂ] c)))
    (hadd : ∀ u v, P u → P v → P (u + v)) (t : Y ⊗[ℂ] (Y ⊗[ℂ] ℂ)) : P t := by
  induction t using TensorProduct.induction_on with
  | zero => exact hzero
  | tmul x b =>
      induction b using TensorProduct.induction_on with
      | zero => simpa using hzero
      | tmul y c => exact htmul x y c
      | add u v hu hv => rw [TensorProduct.tmul_add]; exact hadd _ _ hu hv
  | add u v hu hv => exact hadd _ _ hu hv

/-- The swap is compatible with the inclusion of the domain square. -/
theorem inclPow_swapDom (t : ((domSpace Hs D₂).pow 2).carrier) :
    inclPow Hs D₂ 2 (swapDom Hs D₂ t) = swapH Hs (inclPow Hs D₂ 2 t) := by
  refine tensorSquare_induction (Y := (D₂ : Type))
    (P := fun t => inclPow Hs D₂ 2 (swapDom Hs D₂ t) = swapH Hs (inclPow Hs D₂ 2 t))
    ?_ ?_ ?_ t
  · simp
  · intro a b c
    have h1 : inclPow Hs D₂ 2 (a ⊗ₜ[ℂ] (b ⊗ₜ[ℂ] c) : ((domSpace Hs D₂).pow 2).carrier)
        = (a : Hs.carrier) ⊗ₜ[ℂ] ((b : Hs.carrier) ⊗ₜ[ℂ] c) := rfl
    have h2 : inclPow Hs D₂ 2 (b ⊗ₜ[ℂ] (a ⊗ₜ[ℂ] c) : ((domSpace Hs D₂).pow 2).carrier)
        = (b : Hs.carrier) ⊗ₜ[ℂ] ((a : Hs.carrier) ⊗ₜ[ℂ] c) := rfl
    rw [swapDom_tmul, h1, h2, swapH_tmul]
  · intro u v hu hv
    simp [map_add, hu, hv]

variable (A : D₂ →ₗ[ℂ] Hs.carrier)

/-- The derivation on the nested tensor square, computed on elementary tensors. -/
theorem derPow_two_tmul (a b : D₂) (c : ℂ) :
    derPow Hs D₂ A 2 (a ⊗ₜ[ℂ] (b ⊗ₜ[ℂ] c) : ((domSpace Hs D₂).pow 2).carrier)
      = (A a) ⊗ₜ[ℂ] ((b : Hs.carrier) ⊗ₜ[ℂ] c)
        + (a : Hs.carrier) ⊗ₜ[ℂ] ((A b) ⊗ₜ[ℂ] c) := by
  have h1 : derPow Hs D₂ A 2 (a ⊗ₜ[ℂ] (b ⊗ₜ[ℂ] c) : ((domSpace Hs D₂).pow 2).carrier)
      = (A a) ⊗ₜ[ℂ] inclPow Hs D₂ 1 (b ⊗ₜ[ℂ] c)
        + (a : Hs.carrier) ⊗ₜ[ℂ] derPow Hs D₂ A 1 (b ⊗ₜ[ℂ] c) := rfl
  have h2 : inclPow Hs D₂ 1 (b ⊗ₜ[ℂ] c : ((domSpace Hs D₂).pow 1).carrier)
      = (b : Hs.carrier) ⊗ₜ[ℂ] c := rfl
  have h3 : derPow Hs D₂ A 1 (b ⊗ₜ[ℂ] c : ((domSpace Hs D₂).pow 1).carrier)
      = (A b) ⊗ₜ[ℂ] (c : (Hs.pow 0).carrier) := by
    have : derPow Hs D₂ A 1 (b ⊗ₜ[ℂ] c : ((domSpace Hs D₂).pow 1).carrier)
        = (A b) ⊗ₜ[ℂ] inclPow Hs D₂ 0 c
          + (b : Hs.carrier) ⊗ₜ[ℂ] derPow Hs D₂ A 0 c := rfl
    rw [this, derPow_zero]
    simp [inclPow]
  rw [h1, h2, h3]

/-- **The swap commutes with the derivation**: the Leibniz rule is symmetric in the two
factors. -/
theorem derPow_swapDom (t : ((domSpace Hs D₂).pow 2).carrier) :
    derPow Hs D₂ A 2 (swapDom Hs D₂ t) = swapH Hs (derPow Hs D₂ A 2 t) := by
  refine tensorSquare_induction (Y := (D₂ : Type))
    (P := fun t => derPow Hs D₂ A 2 (swapDom Hs D₂ t) = swapH Hs (derPow Hs D₂ A 2 t))
    ?_ ?_ ?_ t
  · simp
  · intro a b c
    rw [swapDom_tmul, derPow_two_tmul, derPow_two_tmul]
    rw [map_add, swapH_tmul, swapH_tmul]
    abel
  · intro u v hu hv
    simp [map_add, hu, hv]

/-! ## The swap preserves the domain and the core -/

theorem swapH_mem_sectorDom {x : (Hs.pow 2).carrier} (hx : x ∈ sectorDom Hs D₂ 2) :
    swapH Hs x ∈ sectorDom Hs D₂ 2 := by
  obtain ⟨t, rfl⟩ := hx
  exact ⟨swapDom Hs D₂ t, inclPow_swapDom Hs D₂ t⟩

variable (D : Submodule ℂ Hs.carrier)

/-- The swap preserves the algebraic tensor square of the one-particle core. -/
theorem swapDom_mem_corePow {t : ((domSpace Hs D₂).pow 2).carrier}
    (ht : t ∈ corePow Hs D₂ D 2) : swapDom Hs D₂ t ∈ corePow Hs D₂ D 2 := by
  induction ht using Submodule.span_induction with
  | mem u hu =>
      obtain ⟨a, haD, b, hb, rfl⟩ := hu
      -- `b` lies in the one-particle core power, which is spanned by `b' ⊗ c`
      induction hb using Submodule.span_induction with
      | mem v hv =>
          obtain ⟨b', hb'D, c, -, rfl⟩ := hv
          rw [swapDom_tmul]
          exact tmul_mem_corePow Hs D₂ D hb'D
            (tmul_mem_corePow Hs D₂ D haD (by trivial))
      | zero => simp
      | add s s' _ _ hs hs' =>
          rw [TensorProduct.tmul_add, map_add]
          exact Submodule.add_mem _ hs hs'
      | smul r s _ hs =>
          rw [TensorProduct.tmul_smul, map_smul]
          exact Submodule.smul_mem _ r hs
  | zero => simp
  | add u v _ _ hu hv => rw [map_add]; exact Submodule.add_mem _ hu hv
  | smul r u _ hu => rw [map_smul]; exact Submodule.smul_mem _ r hu

theorem swapH_mem_sectorCore {x : (Hs.pow 2).carrier} (hx : x ∈ sectorCore Hs D₂ D 2) :
    swapH Hs x ∈ sectorCore Hs D₂ D 2 := by
  obtain ⟨t, ht, rfl⟩ := hx
  exact ⟨swapDom Hs D₂ t, swapDom_mem_corePow Hs D₂ D ht, inclPow_swapDom Hs D₂ t⟩

/-! ## The swap commutes with the two-particle operator -/

theorem sectorOp_swapH (x : sectorDom Hs D₂ 2) :
    sectorOp Hs D₂ A 2 ⟨swapH Hs (x : (Hs.pow 2).carrier),
        swapH_mem_sectorDom Hs D₂ x.2⟩
      = swapH Hs (sectorOp Hs D₂ A 2 x) := by
  obtain ⟨t, ht⟩ := x.2
  have hx : (x : (Hs.pow 2).carrier) = inclPow Hs D₂ 2 t := ht.symm
  have hsw : swapH Hs (x : (Hs.pow 2).carrier) = inclPow Hs D₂ 2 (swapDom Hs D₂ t) := by
    rw [inclPow_swapDom, hx]
  rw [sectorOp_apply Hs D₂ A 2 _ _ hsw, sectorOp_apply Hs D₂ A 2 x t hx,
    derPow_swapDom]

theorem restrictOp_sectorOp_swapH (x : sectorCore Hs D₂ D 2) :
    restrictOp (sectorOp Hs D₂ A 2) (sectorCore_le_sectorDom Hs D₂ D 2)
        ⟨swapH Hs (x : (Hs.pow 2).carrier), swapH_mem_sectorCore Hs D₂ D x.2⟩
      = swapH Hs (restrictOp (sectorOp Hs D₂ A 2) (sectorCore_le_sectorDom Hs D₂ D 2) x) := by
  simpa using
    sectorOp_swapH Hs D₂ A ⟨(x : (Hs.pow 2).carrier), sectorCore_le_sectorDom Hs D₂ D 2 x.2⟩

/-! ## The two sectors -/

/-- The bosonic (symmetric) two-particle sector: the range of `(1 + swap)/2`. -/
def bosonicProj : (Hs.pow 2).carrier →ₗ[ℂ] (Hs.pow 2).carrier := symProj (swapH Hs)

/-- The fermionic (antisymmetric) two-particle sector: the range of `(1 - swap)/2`. -/
def fermionicProj : (Hs.pow 2).carrier →ₗ[ℂ] (Hs.pow 2).carrier := asymProj (swapH Hs)

theorem isReducingProjection_bosonicProj : IsReducingProjection (bosonicProj Hs) :=
  isReducingProjection_symProj (swapH_involutive Hs)
    (fun x y => swapH_inner Hs x y)

theorem isReducingProjection_fermionicProj : IsReducingProjection (fermionicProj Hs) :=
  isReducingProjection_asymProj (swapH_involutive Hs)
    (fun x y => swapH_inner Hs x y)

/-- The bosonic sector consists exactly of the swap-invariant vectors. -/
theorem mem_bosonic_iff {x : (Hs.pow 2).carrier} :
    x ∈ sector (bosonicProj Hs) ↔ swapH Hs x = x :=
  mem_sector_symProj_iff (swapH_involutive Hs)

/-- The fermionic sector consists exactly of the swap-anti-invariant vectors. -/
theorem mem_fermionic_iff {x : (Hs.pow 2).carrier} :
    x ∈ sector (fermionicProj Hs) ↔ swapH Hs x = -x :=
  mem_sector_asymProj_iff (swapH_involutive Hs)

/-! ## Essential self-adjointness on the two sectors -/

/-- **The bosonic two-particle derivation is essentially self-adjoint**, on the symmetric
part of the domain `D₂^{⊗2}`, as soon as the full two-particle derivation is. -/
theorem essentiallySelfAdjointOn_bosonic
    (hesa : EssentiallySelfAdjointOn (sectorDom Hs D₂ 2) (sectorOp Hs D₂ A 2)) :
    EssentiallySelfAdjointOn
      (redDom (bosonicProj Hs) (sectorDom Hs D₂ 2))
      (redOp (sectorOp Hs D₂ A 2) (isReducingProjection_bosonicProj Hs)
        (commutes_symProj (T := sectorOp Hs D₂ A 2)
          (hUD := fun _ hx => swapH_mem_sectorDom Hs D₂ hx) (sectorOp_swapH Hs D₂ A))) :=
  essentiallySelfAdjointOn_red _ _ hesa

/-- **The fermionic two-particle derivation is essentially self-adjoint**, on the
antisymmetric part of the domain `D₂^{⊗2}`, as soon as the full two-particle derivation is. -/
theorem essentiallySelfAdjointOn_fermionic
    (hesa : EssentiallySelfAdjointOn (sectorDom Hs D₂ 2) (sectorOp Hs D₂ A 2)) :
    EssentiallySelfAdjointOn
      (redDom (fermionicProj Hs) (sectorDom Hs D₂ 2))
      (redOp (sectorOp Hs D₂ A 2) (isReducingProjection_fermionicProj Hs)
        (commutes_asymProj (T := sectorOp Hs D₂ A 2)
          (hUD := fun _ hx => swapH_mem_sectorDom Hs D₂ hx) (sectorOp_swapH Hs D₂ A))) :=
  essentiallySelfAdjointOn_red _ _ hesa

/-- **The bosonic two-particle derivation is essentially self-adjoint on the symmetrized
one-particle core.**  Here `D` is any core of the one-particle operator `A`: the core
estimate of `BookProof.TensorCore` lifts it to `D^{⊗2}`, and the reduction principle then
restricts to the symmetric half. -/
theorem essentiallySelfAdjointOn_bosonic_core (hcore : IsGraphCore D A)
    (hesa : EssentiallySelfAdjointOn (sectorDom Hs D₂ 2) (sectorOp Hs D₂ A 2)) :
    EssentiallySelfAdjointOn
      (redDom (bosonicProj Hs) (sectorCore Hs D₂ D 2))
      (redOp (restrictOp (sectorOp Hs D₂ A 2) (sectorCore_le_sectorDom Hs D₂ D 2))
        (isReducingProjection_bosonicProj Hs)
        (commutes_symProj
          (T := restrictOp (sectorOp Hs D₂ A 2) (sectorCore_le_sectorDom Hs D₂ D 2))
          (hUD := fun _ hx => swapH_mem_sectorCore Hs D₂ D hx)
          (restrictOp_sectorOp_swapH Hs D₂ A D))) :=
  essentiallySelfAdjointOn_red _ _
    (essentiallySelfAdjointOn_sectorCore Hs D₂ A D hcore 2 hesa)

/-- **The fermionic two-particle derivation is essentially self-adjoint on the
antisymmetrized one-particle core.** -/
theorem essentiallySelfAdjointOn_fermionic_core (hcore : IsGraphCore D A)
    (hesa : EssentiallySelfAdjointOn (sectorDom Hs D₂ 2) (sectorOp Hs D₂ A 2)) :
    EssentiallySelfAdjointOn
      (redDom (fermionicProj Hs) (sectorCore Hs D₂ D 2))
      (redOp (restrictOp (sectorOp Hs D₂ A 2) (sectorCore_le_sectorDom Hs D₂ D 2))
        (isReducingProjection_fermionicProj Hs)
        (commutes_asymProj
          (T := restrictOp (sectorOp Hs D₂ A 2) (sectorCore_le_sectorDom Hs D₂ D 2))
          (hUD := fun _ hx => swapH_mem_sectorCore Hs D₂ D hx)
          (restrictOp_sectorOp_swapH Hs D₂ A D))) :=
  essentiallySelfAdjointOn_red _ _
    (essentiallySelfAdjointOn_sectorCore Hs D₂ A D hcore 2 hesa)

/-! ## Non-vacuity of the two sectors -/

/-- The symmetrized square `a ⊗ a` of a vector of the one-particle core is a nonzero vector
of the bosonic sector core: the bosonic statement is not vacuous. -/
theorem exists_ne_zero_bosonic (hD : D ≤ D₂) {a : Hs.carrier} (haD : a ∈ D) (ha0 : a ≠ 0) :
    ∃ x : redDom (bosonicProj Hs) (sectorCore Hs D₂ D 2), x ≠ 0 := by
  set a' : D₂ := ⟨a, hD haD⟩ with ha'
  set v : (Hs.pow 2).carrier := a ⊗ₜ[ℂ] (a ⊗ₜ[ℂ] (1 : ℂ)) with hv
  have hcore : v ∈ sectorCore Hs D₂ D 2 :=
    ⟨a' ⊗ₜ[ℂ] (a' ⊗ₜ[ℂ] (1 : ℂ)),
      tmul_mem_corePow Hs D₂ D haD (tmul_mem_corePow Hs D₂ D haD (by trivial)), rfl⟩
  have hsec : v ∈ sector (bosonicProj Hs) := (mem_bosonic_iff Hs).mpr (by rw [hv, swapH_tmul])
  have hv0 : v ≠ 0 := by
    have hnorm : ‖v‖ = ‖a‖ * (‖a‖ * ‖(1 : ℂ)‖) := by
      rw [hv, TensorProduct.norm_tmul, TensorProduct.norm_tmul]
    intro h
    rw [h, norm_zero] at hnorm
    simp only [norm_one, mul_one] at hnorm
    exact ha0 (norm_eq_zero.mp (by nlinarith [norm_nonneg a]))
  refine ⟨⟨⟨v, hsec⟩, hcore⟩, ?_⟩
  intro h
  exact hv0 (by simpa using congrArg Subtype.val (congrArg Subtype.val h))

/-- Two orthogonal nonzero vectors of the one-particle core give a nonzero vector of the
fermionic sector core: the fermionic statement is not vacuous either. -/
theorem exists_ne_zero_fermionic (hD : D ≤ D₂) {a b : Hs.carrier} (haD : a ∈ D) (hbD : b ∈ D)
    (ha0 : a ≠ 0) (hb0 : b ≠ 0) (hab : (inner ℂ a b : ℂ) = 0) :
    ∃ x : redDom (fermionicProj Hs) (sectorCore Hs D₂ D 2), x ≠ 0 := by
  set a' : D₂ := ⟨a, hD haD⟩ with ha'
  set b' : D₂ := ⟨b, hD hbD⟩ with hb'
  set w : (Hs.pow 2).carrier := a ⊗ₜ[ℂ] (b ⊗ₜ[ℂ] (1 : ℂ)) with hw
  set v : (Hs.pow 2).carrier :=
    a ⊗ₜ[ℂ] (b ⊗ₜ[ℂ] (1 : ℂ)) - b ⊗ₜ[ℂ] (a ⊗ₜ[ℂ] (1 : ℂ)) with hv
  have hcore : v ∈ sectorCore Hs D₂ D 2 := by
    have h1 : (a ⊗ₜ[ℂ] (b ⊗ₜ[ℂ] (1 : ℂ)) : (Hs.pow 2).carrier) ∈ sectorCore Hs D₂ D 2 :=
      ⟨a' ⊗ₜ[ℂ] (b' ⊗ₜ[ℂ] (1 : ℂ)),
        tmul_mem_corePow Hs D₂ D haD (tmul_mem_corePow Hs D₂ D hbD (by trivial)), rfl⟩
    have h2 : (b ⊗ₜ[ℂ] (a ⊗ₜ[ℂ] (1 : ℂ)) : (Hs.pow 2).carrier) ∈ sectorCore Hs D₂ D 2 :=
      ⟨b' ⊗ₜ[ℂ] (a' ⊗ₜ[ℂ] (1 : ℂ)),
        tmul_mem_corePow Hs D₂ D hbD (tmul_mem_corePow Hs D₂ D haD (by trivial)), rfl⟩
    exact Submodule.sub_mem _ h1 h2
  have hsec : v ∈ sector (fermionicProj Hs) := by
    refine (mem_fermionic_iff Hs).mpr ?_
    rw [hv, map_sub, swapH_tmul, swapH_tmul]
    abel
  have hba : (inner ℂ b a : ℂ) = 0 := by
    have := congrArg (starRingEnd ℂ) hab
    rwa [inner_conj_symm, map_zero] at this
  have hone : (inner ℂ ((1 : ℂ) : (Hs.pow 0).carrier) ((1 : ℂ) : (Hs.pow 0).carrier) : ℂ)
      = 1 := by
    show (inner ymmetric* halves of `H^{⊗2}`, i.e. the two
eigenspaces of the swap `x ⊗ y ↦ y ⊗ x`.  This module carries essential self-adjointness from
the full power to those halves.

The mechanism is the general reduction principle of `BookProof.ReducedEsa`: the swap is a
self-inverse isometry, it preserves the domain `D₂^{⊗2}` and the core `D^{⊗2}`, and it
commutes with the derivation — the Leibniz rule is symmetric in the two factors.  Hence the
projections `(1 ± swap)/2` are reducing projections for the derivation, and essential
self-adjointness descends to each sector.

## Contents

* `swapTwo` — the swap of a two-fold (nested) tensor power `X ⊗ (X ⊗ ℂ)`, as a linear
  isometry equivalence; `swapTwo_tmul`, `swapTwo_involutive`, `swapTwo_inner`.
* `swapH`, `swapDom` — the swap on `H^{⊗2}` and on `D₂^{⊗2}`, and their compatibility with
  the inclusion (`inclPow_swapDom`) and with the derivation (`derPow_swapDom`).
* `swapH_mem_sectorDom`, `swapH_mem_sectorCore` — the swap preserves the domain and the core.
* `sectorOp_swapH`, `restrictOp_sectorOp_swapH` — the swap commutes with the two-particle
  derivation, on the domain and on the core.
* **`essentiallySelfAdjointOn_bosonic`**, **`essentiallySelfAdjointOn_fermionic`** — the two
  sector statements on the domain `D₂^{⊗2}`; **`essentiallySelfAdjointOn_bosonic_core`**,
  **`essentiallySelfAdjointOn_fermionic_core`** — the same on the symmetrized and the
  antisymmetrized one-particle core `D^{⊗2}`, for any core `D` of `A`.
* `mem_bosonic_iff`, `mem_fermionic_iff` — the two sectors are exactly the `+1` and the `-1`
  eigenspaces of the swap.

Nothing is assumed: the module contains no `axiom` and no `sorry`.
-/

namespace BookProof.TwoParticleSector

open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore

noncomputable section

/-! ## The swap of a two-fold tensor power -/

variable (X : Type) [NormedAddCommGroup X] [InnerProductSpace ℂ X]

/-- The **swap** `x ⊗ (y ⊗ c) ↦ y ⊗ (x ⊗ c)` of a two-fold tensor power, in the nested form
`X ⊗ (X ⊗ ℂ)` in which `BookProof.TensorCore.IPSpace.pow` presents `X^{⊗2}`.  It is built
from the associator and the commutor, so it is an isometry. -/
def swapTwo : X ⊗[ℂ] (X ⊗[ℂ] ℂ) ≃ₗᵢ[ℂ] X ⊗[ℂ] (X ⊗[ℂ] ℂ) :=
  (TensorProduct.assocIsometry ℂ X X ℂ).symm.trans
    ((TensorProduct.congrIsometry (TensorProduct.commIsometry ℂ X X)
      (LinearIsometryEquiv.refl ℂ ℂ)).trans (TensorProduct.assocIsometry ℂ X X ℂ))

@[simp] theorem swapTwo_tmul (x y : X) (c : ℂ) :
    swapTwo X (x ⊗ₜ[ℂ] (y ⊗ₜ[ℂ] c)) = y ⊗ₜ[ℂ] (x ⊗ₜ[ℂ] c) := by
  simp [swapTwo, TensorProduct.congrIsometry]

variable {X}

/-- The swap is self-inverse. -/
theorem swapTwo_involutive (t : X ⊗[ℂ] (X ⊗[ℂ] ℂ)) : swapTwo X (swapTwo X t) = t := by
  induction t using TensorProduct.induction_on with
  | zero => simp
  | tmul x b =>
      induction b using TensorProduct.induction_on with
      | zero => simp
      | tmul y c => simp
      | add u v hu hv => simp [TensorProduct.tmul_add, hu, hv]
  | add u v hu hv => simp [hu, hv]

/-- The swap preserves the inner product. -/
theorem swapTwo_inner (t s : X ⊗[ℂ] (X ⊗[ℂ] ℂ)) :
    (inner ℂ (swapTwo X t) (swapTwo X s) : ℂ) = inner ℂ t s :=
  (swapTwo X).inner_map_map t s

/-! ## The swap on the two-particle space and on its domain -/

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)

/-- The swap of `H^{⊗2}`, as a linear map. -/
def swapH : (Hs.pow 2).carrier →ₗ[ℂ] (Hs.pow 2).carrier :=
  (swapTwo (X := Hs.carrier)).toLinearEquiv.toLinearMap

/-- The swap of the algebraic tensor square `D₂^{⊗2}` of the domain. -/
def swapDom : ((domSpace Hs D₂).pow 2).carrier →ₗ[ℂ] ((domSpace Hs D₂).pow 2).carrier :=
  (swapTwo (X := D₂)).toLinearEquiv.toLinearMap

@[simp] theorem swapH_tmul (x y : Hs.carrier) (c : ℂ) :
    swapH Hs (x ⊗ₜ[ℂ] (y ⊗ₜ[ℂ] c) : (Hs.pow 2).carrier) = y ⊗ₜ[ℂ] (x ⊗ₜ[ℂ] c) :=
  swapTwo_tmul Hs.carrier x y c

@[simp] theorem swapDom_tmul (a b : D₂) (c : ℂ) :
    swapDom Hs D₂ (a ⊗ₜ[ℂ] (b ⊗ₜ[ℂ] c) : ((domSpace Hs D₂).pow 2).carrier)
      = b ⊗ₜ[ℂ] (a ⊗ₜ[ℂ] c) :=
  swapTwo_tmul (D₂ : Type) a b c

theorem swapH_involutive (t : (Hs.pow 2).carrier) : swapH Hs (swapH Hs t) = t :=
  swapTwo_involutive t

theorem swapH_inner (t s : (Hs.pow 2).carrier) :
    (inner ℂ (swapH Hs t) (swapH Hs s) : ℂ) = inner ℂ t s :=
  swapTwo_inner t s

/-- A double induction principle for the nested tensor square, used repeatedly below. -/
theorem tensorSquare_induction {Y : Type} [NormedAddCommGroup Y] [InnerProductSpace ℂ Y]
    {P : Y ⊗[ℂ] (Y ⊗[ℂ] ℂ) → Prop} (hzero : P 0)
    (htmul : ∀ (x y : Y) (c : ℂ), P (x ⊗ₜ[ℂ] (y ⊗ₜ[ℂ] c)))
    (hadd : ∀ u v, P u → P v → P (u + v)) (t : Y ⊗[ℂ] (Y ⊗[ℂ] ℂ)) : P t := by
  induction t using TensorProduct.induction_on with
  | zero => exact hzero
  | tmul x b =>
      induction b using TensorProduct.induction_on with
      | zero => simpa using hzero
      | tmul y c => exact htmul x y c
      | add u v hu hv => rw [TensorProduct.tmul_add]; exact hadd _ _ hu hv
  | add u v hu hv => exact hadd _ _ hu hv

/-- The swap is compatible with the inclusion of the domain square. -/
theorem inclPow_swapDom (t : ((domSpace Hs D₂).pow 2).carrier) :
    inclPow Hs D₂ 2 (swapDom Hs D₂ t) = swapH Hs (inclPow Hs D₂ 2 t) := by
  refine tensorSquare_induction (Y := (D₂ : Type))
    (P := fun t => inclPow Hs D₂ 2 (swapDom Hs D₂ t) = swapH Hs (inclPow Hs D₂ 2 t))
    ?_ ?_ ?_ t
  · simp
  · intro a b c
    have h1 : inclPow Hs D₂ 2 (a ⊗ₜ[ℂ] (b ⊗ₜ[ℂ] c) : ((domSpace Hs D₂).pow 2).carrier)
        = (a : Hs.carrier) ⊗ₜ[ℂ] ((b : Hs.carrier) ⊗ₜ[ℂ] c) := rfl
    have h2 : inclPow Hs D₂ 2 (b ⊗ₜ[ℂ] (a ⊗ₜ[ℂ] c) : ((domSpace Hs D₂).pow 2).carrier)
        = (b : Hs.carrier) ⊗ₜ[ℂ] ((a : Hs.carrier) ⊗ₜ[ℂ] c) := rfl
    rw [swapDom_tmul, h1, h2, swapH_tmul]
  · intro u v hu hv
    simp [map_add, hu, hv]

variable (A : D₂ →ₗ[ℂ] Hs.carrier)

/-- The derivation on the nested tensor square, computed on elementary tensors. -/
theorem derPow_two_tmul (a b : D₂) (c : ℂ) :
    derPow Hs D₂ A 2 (a ⊗ₜ[ℂ] (b ⊗ₜ[ℂ] c) : ((domSpace Hs D₂).pow 2).carrier)
      = (A a) ⊗ₜ[ℂ] ((b : Hs.carrier) ⊗ₜ[ℂ] c)
        + (a : Hs.carrier) ⊗ₜ[ℂ] ((A b) ⊗ₜ[ℂ] c) := by
  have h1 : derPow Hs D₂ A 2 (a ⊗ₜ[ℂ] (b ⊗ₜ[ℂ] c) : ((domSpace Hs D₂).pow 2).carrier)
      = (A a) ⊗ₜ[ℂ] inclPow Hs D₂ 1 (b ⊗ₜ[ℂ] c)
        + (a : Hs.carrier) ⊗ₜ[ℂ] derPow Hs D₂ A 1 (b ⊗ₜ[ℂ] c) := rfl
  have h2 : inclPow Hs D₂ 1 (b ⊗ₜ[ℂ] c : ((domSpace Hs D₂).pow 1).carrier)
      = (b : Hs.carrier) ⊗ₜ[ℂ] c := rfl
  have h3 : derPow Hs D₂ A 1 (b ⊗ₜ[ℂ] c : ((domSpace Hs D₂).pow 1).carrier)
      = (A b) ⊗ₜ[ℂ] (c : (Hs.pow 0).carrier) := by
    have : derPow Hs D₂ A 1 (b ⊗ₜ[ℂ] c : ((domSpace Hs D₂).pow 1).carrier)
        = (A b) ⊗ₜ[ℂ] inclPow Hs D₂ 0 c
          + (b : Hs.carrier) ⊗ₜ[ℂ] derPow Hs D₂ A 0 c := rfl
    rw [this, derPow_zero]
    simp [inclPow]
  rw [h1, h2, h3]

/-- **The swap commutes with the derivation**: the Leibniz rule is symmetric in the two
factors. -/
theorem derPow_swapDom (t : ((domSpace Hs D₂).pow 2).carrier) :
    derPow Hs D₂ A 2 (swapDom Hs D₂ t) = swapH Hs (derPow Hs D₂ A 2 t) := by
  refine tensorSquare_induction (Y := (D₂ : Type))
    (P := fun t => derPow Hs D₂ A 2 (swapDom Hs D₂ t) = swapH Hs (derPow Hs D₂ A 2 t))
    ?_ ?_ ?_ t
  · simp
  · intro a b c
    rw [swapDom_tmul, derPow_two_tmul, derPow_two_tmul]
    rw [map_add, swapH_tmul, swapH_tmul]
    abel
  · intro u v hu hv
    simp [map_add, hu, hv]

/-! ## The swap preserves the domain and the core -/

theorem swapH_mem_sectorDom {x : (Hs.pow 2).carrier} (hx : x ∈ sectorDom Hs D₂ 2) :
    swapH Hs x ∈ sectorDom Hs D₂ 2 := by
  obtain ⟨t, rfl⟩ := hx
  exact ⟨swapDom Hs D₂ t, inclPow_swapDom Hs D₂ t⟩

variable (D : Submodule ℂ Hs.carrier)

/-- The swap preserves the algebraic tensor square of the one-particle core. -/
theorem swapDom_mem_corePow {t : ((domSpace Hs D₂).pow 2).carrier}
    (ht : t ∈ corePow Hs D₂ D 2) : swapDom Hs D₂ t ∈ corePow Hs D₂ D 2 := by
  induction ht using Submodule.span_induction with
  | mem u hu =>
      obtain ⟨a, haD, b, hb, rfl⟩ := hu
      -- `b` lies in the one-particle core power, which is spanned by `b' ⊗ c`
      induction hb using Submodule.span_induction with
      | mem v hv =>
          obtain ⟨b', hb'D, c, -, rfl⟩ := hv
          rw [swapDom_tmul]
          exact tmul_mem_corePow Hs D₂ D hb'D
            (tmul_mem_corePow Hs D₂ D haD (by trivial))
      | zero => simp
      | add s s' _ _ hs hs' =>
          rw [TensorProduct.tmul_add, map_add]
          exact Submodule.add_mem _ hs hs'
      | smul r s _ hs =>
          rw [TensorProduct.tmul_smul, map_smul]
          exact Submodule.smul_mem _ r hs
  | zero => simp
  | add u v _ _ hu hv => rw [map_add]; exact Submodule.add_mem _ hu hv
  | smul r u _ hu => rw [map_smul]; exact Submodule.smul_mem _ r hu

theorem swapH_mem_sectorCore {x : (Hs.pow 2).carrier} (hx : x ∈ sectorCore Hs D₂ D 2) :
    swapH Hs x ∈ sectorCore Hs D₂ D 2 := by
  obtain ⟨t, ht, rfl⟩ := hx
  exact ⟨swapDom Hs D₂ t, swapDom_mem_corePow Hs D₂ D ht, inclPow_swapDom Hs D₂ t⟩

/-! ## The swap commutes with the two-particle operator -/

theorem sectorOp_swapH (x : sectorDom Hs D₂ 2) :
    sectorOp Hs D₂ A 2 ⟨swapH Hs (x : (Hs.pow 2).carrier),
        swapH_mem_sectorDom Hs D₂ x.2⟩
      = swapH Hs (sectorOp Hs D₂ A 2 x) := by
  obtain ⟨t, ht⟩ := x.2
  have hx : (x : (Hs.pow 2).carrier) = inclPow Hs D₂ 2 t := ht.symm
  have hsw : swapH Hs (x : (Hs.pow 2).carrier) = inclPow Hs D₂ 2 (swapDom Hs D₂ t) := by
    rw [inclPow_swapDom, hx]
  rw [sectorOp_apply Hs D₂ A 2 _ _ hsw, sectorOp_apply Hs D₂ A 2 x t hx,
    derPow_swapDom]

theorem restrictOp_sectorOp_swapH (x : sectorCore Hs D₂ D 2) :
    restrictOp (sectorOp Hs D₂ A 2) (sectorCore_le_sectorDom Hs D₂ D 2)
        ⟨swapH Hs (x : (Hs.pow 2).carrier), swapH_mem_sectorCore Hs D₂ D x.2⟩
      = swapH Hs (restrictOp (sectorOp Hs D₂ A 2) (sectorCore_le_sectorDom Hs D₂ D 2) x) := by
  simpa using
    sectorOp_swapH Hs D₂ A ⟨(x : (Hs.pow 2).carrier), sectorCore_le_sectorDom Hs D₂ D 2 x.2⟩

/-! ## The two sectors -/

/-- The bosonic (symmetric) two-particle sector: the range of `(1 + swap)/2`. -/
def bosonicProj : (Hs.pow 2).carrier →ₗ[ℂ] (Hs.pow 2).carrier := symProj (swapH Hs)

/-- The fermionic (antisymmetric) two-particle sector: the range of `(1 - swap)/2`. -/
def fermionicProj : (Hs.pow 2).carrier →ₗ[ℂ] (Hs.pow 2).carrier := asymProj (swapH Hs)

theorem isReducingProjection_bosonicProj : IsReducingProjection (bosonicProj Hs) :=
  isReducingProjection_symProj (swapH_involutive Hs)
    (fun x y => swapH_inner Hs x y)

theorem isReducingProjection_fermionicProj : IsReducingProjection (fermionicProj Hs) :=
  isReducingProjection_asymProj (swapH_involutive Hs)
    (fun x y => swapH_inner Hs x y)

/-- The bosonic sector consists exactly of the swap-invariant vectors. -/
theorem mem_bosonic_iff {x : (Hs.pow 2).carrier} :
    x ∈ sector (bosonicProj Hs) ↔ swapH Hs x = x :=
  mem_sector_symProj_iff (swapH_involutive Hs)

/-- The fermionic sector consists exactly of the swap-anti-invariant vectors. -/
theorem mem_fermionic_iff {x : (Hs.pow 2).carrier} :
    x ∈ sector (fermionicProj Hs) ↔ swapH Hs x = -x :=
  mem_sector_asymProj_iff (swapH_involutive Hs)

/-! ## Essential self-adjointness on the two sectors -/

/-- **The bosonic two-particle derivation is essentially self-adjoint**, on the symmetric
part of the domain `D₂^{⊗2}`, as soon as the full two-particle derivation is. -/
theorem essentiallySelfAdjointOn_bosonic
    (hesa : EssentiallySelfAdjointOn (sectorDom Hs D₂ 2) (sectorOp Hs D₂ A 2)) :
    EssentiallySelfAdjointOn
      (redDom (bosonicProj Hs) (sectorDom Hs D₂ 2))
      (redOp (sectorOp Hs D₂ A 2) (isReducingProjection_bosonicProj Hs)
        (commutes_symProj (T := sectorOp Hs D₂ A 2)
          (hUD := fun _ hx => swapH_mem_sectorDom Hs D₂ hx) (sectorOp_swapH Hs D₂ A))) :=
  essentiallySelfAdjointOn_red _ _ hesa

/-- **The fermionic two-particle derivation is essentially self-adjoint**, on the
antisymmetric part of the domain `D₂^{⊗2}`, as soon as the full two-particle derivation is. -/
theorem essentiallySelfAdjointOn_fermionic
    (hesa : EssentiallySelfAdjointOn (sectorDom Hs D₂ 2) (sectorOp Hs D₂ A 2)) :
    EssentiallySelfAdjointOn
      (redDom (fermionicProj Hs) (sectorDom Hs D₂ 2))
      (redOp (sectorOp Hs D₂ A 2) (isReducingProjection_fermionicProj Hs)
        (commutes_asymProj (T := sectorOp Hs D₂ A 2)
          (hUD := fun _ hx => swapH_mem_sectorDom Hs D₂ hx) (sectorOp_swapH Hs D₂ A))) :=
  essentiallySelfAdjointOn_red _ _ hesa

/-- **The bosonic two-particle derivation is essentially self-adjoint on the symmetrized
one-particle core.**  Here `D` is any core of the one-particle operator `A`: the core
estimate of `BookProof.TensorCore` lifts it to `D^{⊗2}`, and the reduction principle then
restricts to the symmetric half. -/
theorem essentiallySelfAdjointOn_bosonic_core (hcore : IsGraphCore D A)
    (hesa : EssentiallySelfAdjointOn (sectorDom Hs D₂ 2) (sectorOp Hs D₂ A 2)) :
    EssentiallySelfAdjointOn
      (redDom (bosonicProj Hs) (sectorCore Hs D₂ D 2))
      (redOp (restrictOp (sectorOp Hs D₂ A 2) (sectorCore_le_sectorDom Hs D₂ D 2))
        (isReducingProjection_bosonicProj Hs)
        (commutes_symProj
          (T := restrictOp (sectorOp Hs D₂ A 2) (sectorCore_le_sectorDom Hs D₂ D 2))
          (hUD := fun _ hx => swapH_mem_sectorCore Hs D₂ D hx)
          (restrictOp_sectorOp_swapH Hs D₂ A D))) :=
  essentiallySelfAdjointOn_red _ _
    (essentiallySelfAdjointOn_sectorCore Hs D₂ A D hcore 2 hesa)

/-- **The fermionic two-particle derivation is essentially self-adjoint on the
antisymmetrized one-particle core.** -/
theorem essentiallySelfAdjointOn_fermionic_core (hcore : IsGraphCore D A)
    (hesa : EssentiallySelfAdjointOn (sectorDom Hs D₂ 2) (sectorOp Hs D₂ A 2)) :
    EssentiallySelfAdjointOn
      (redDom (fermionicProj Hs) (sectorCore Hs D₂ D 2))
      (redOp (restrictOp (sectorOp Hs D₂ A 2) (sectorCore_le_sectorDom Hs D₂ D 2))
        (isReducingProjection_fermionicProj Hs)
        (commutes_asymProj
          (T := restrictOp (sectorOp Hs D₂ A 2) (sectorCore_le_sectorDom Hs D₂ D 2))
          (hUD := fun _ hx => swapH_mem_sectorCore Hs D₂ D hx)
          (restrictOp_sectorOp_swapH Hs D₂ A D))) :=
  essentiallySelfAdjointOn_red _ _
    (essentiallySelfAdjointOn_sectorCore Hs D₂ A D hcore 2 hesa)

/-! ## Non-vacuity of the two sectors -/

/-- The symmetrized square `a ⊗ a` of a vector of the one-particle core is a nonzero vector
of the bosonic sector core: the bosonic statement is not vacuous. -/
theorem exists_ne_zero_bosonic (hD : D ≤ D₂) {a : Hs.carrier} (haD : a ∈ D) (ha0 : a ≠ 0) :
    ∃ x : redDom (bosonicProj Hs) (sectorCore Hs D₂ D 2), x ≠ 0 := by
  set a' : D₂ := ⟨a, hD haD⟩ with ha'
  set v : (Hs.pow 2).carrier := a ⊗ₜ[ℂ] (a ⊗ₜ[ℂ] (1 : ℂ)) with hv
  have hcore : v ∈ sectorCore Hs D₂ D 2 :=
    ⟨a' ⊗ₜ[ℂ] (a' ⊗ₜ[ℂ] (1 : ℂ)),
      tmul_mem_corePow Hs D₂ D haD (tmul_mem_corePow Hs D₂ D haD (by trivial)), rfl⟩
  have hsec : v ∈ sector (bosonicProj Hs) := (mem_bosonic_iff Hs).mpr (by rw [hv, swapH_tmul])
  have hv0 : v ≠ 0 := by
    have hnorm : ‖v‖ = ‖a‖ * (‖a‖ * ‖(1 : ℂ)‖) := by
      rw [hv, TensorProduct.norm_tmul, TensorProduct.norm_tmul]
    intro h
    rw [h, norm_zero] at hnorm
    simp only [norm_one, mul_one] at hnorm
    exact ha0 (norm_eq_zero.mp (by nlinarith [norm_nonneg a]))
  refine ⟨⟨⟨v, hsec⟩, hcore⟩, ?_⟩
  intro h
  exact hv0 (by simpa using congrArg Subtype.val (congrArg Subtype.val h))

/-- Two orthogonal nonzero vectors of the one-particle core give a nonzero vector of the
fermionic sector core: the fermionic statement is not vacuous either. -/
theorem exists_ne_zero_fermionic (hD : D ≤ D₂) {a b : Hs.carrier} (haD : a ∈ D) (hbD : b ∈ D)
    (ha0 : a ≠ 0) (hb0 : b ≠ 0) (hab : (inner ℂ a b : ℂ) = 0) :
    ∃ x : redDom (fermionicProj Hs) (sectorCore Hs D₂ D 2), x ≠ 0 := by
  set a' : D₂ := ⟨a, hD haD⟩ with ha'
  set b' : D₂ := ⟨b, hD hbD⟩ with hb'
  set w : (Hs.pow 2).carrier := a ⊗ₜ[ℂ] (b ⊗ₜ[ℂ] (1 : ℂ)) with hw
  set v : (Hs.pow 2).carrier :=
    a ⊗ₜ[ℂ] (b ⊗ₜ[ℂ] (1 : ℂ)) - b ⊗ₜ[ℂ] (a ⊗ₜ[ℂ] (1 : ℂ)) with hv
  have hcore : v ∈ sectorCore Hs D₂ D 2 := by
    have h1 : (a ⊗ₜ[ℂ] (b ⊗ₜ[ℂ] (1 : ℂ)) : (Hs.pow 2).carrier) ∈ sectorCore Hs D₂ D 2 :=
      ⟨a' ⊗ₜ[ℂ] (b' ⊗ₜ[ℂ] (1 : ℂ)),
        tmul_mem_corePow Hs D₂ D haD (tmul_mem_corePow Hs D₂ D hbD (by trivial)), rfl⟩
    have h2 : (b ⊗ₜ[ℂ] (a ⊗ₜ[ℂ] (1 : ℂ)) : (Hs.pow 2).carrier) ∈ sectorCore Hs D₂ D 2 :=
      ⟨b' ⊗ₜ[ℂ] (a' ⊗ₜ[ℂ] (1 : ℂ)),
        tmul_mem_corePow Hs D₂ D hbD (tmul_mem_corePow Hs D₂ D haD (by trivial)), rfl⟩
    exact Submodule.sub_mem _ h1 h2
  have hsec : v ∈ sector (fermionicProj Hs) := by
    refine (mem_fermionic_iff Hs).mpr ?_
    rw [hv, map_sub, swapH_tmul, swapH_tmul]
    abel
  have hba : (inner ℂ b a : ℂ) = 0 := by
    have := congrArg (starRingEnd ℂ) hab
    rwa [inner_conj_symm, map_zero] at this
  have hone : (inner ℂ ((1 : ℂ) : (Hs.pow 0).carrier) ((1 : ℂ) : (Hs.pow 0).carrier) : ℂ)
      = 1 := by
    show (inner ℂ (1 : ℂ) (1 : ℂ) : ℂ) = 1
    simp
  have hinner : (inner ℂ v w : ℂ) = inner ℂ a a * inner ℂ b b := by
    rw [hv, hw, inner_sub_left, inner_tmul_pow Hs 1, inner_tmul_pow Hs 1,
      inner_tmul_pow Hs 0, inner_tmul_pow Hs 0, hba, hone]
    ring
  have hv0 : v ≠ 0 := by
    intro h
    rw [h, inner_zero_left] at hinner
    have ha : (inner ℂ a a : ℂ) ≠ 0 := inner_self_ne_zero.mpr ha0
    have hb : (inner ℂ b b : ℂ) ≠ 0 := inner_self_ne_zero.mpr hb0
    exact (mul_ne_zero ha hb) hinner.symm
  refine ⟨⟨⟨v, hsec⟩, hcore⟩, ?_⟩
  intro h
  exact hv0 (by simpa using congrArg Subtype.val (congrArg Subtype.val h))

/-! ## Symmetry of the sector operators -/

theorem symmetricOn_bosonic (hA : SymmetricOn D₂ A) :
    SymmetricOn (redDom (bosonicProj Hs) (sectorDom Hs D₂ 2))
      (redOp (sectorOp Hs D₂ A 2) (isReducingProjection_bosonicProj Hs)
        (commutes_symProj (T := sectorOp Hs D₂ A 2)
          (hUD := fun _ hx => swapH_mem_sectorDom Hs D₂ hx) (sectorOp_swapH Hs D₂ A))) :=
  symmetricOn_redOp _ _ (symmetricOn_sectorOp Hs D₂ A hA 2)

theorem symmetricOn_fermionic (hA : SymmetricOn D₂ A) :
    SymmetricOn (redDom (fermionicProj Hs) (sectorDom Hs D₂ 2))
      (redOp (sectorOp Hs D₂ A 2) (isReducingProjection_fermionicProj Hs)
        (commutes_asymProj (T := sectorOp Hs D₂ A 2)
          (hUD := fun _ hx => swapH_mem_sectorDom Hs D₂ hx) (sectorOp_swapH Hs D₂ A))) :=
  symmetricOn_redOp _ _ (symmetricOn_sectorOp Hs D₂ A hA 2)

end

end BookProof.TwoParticleSector
