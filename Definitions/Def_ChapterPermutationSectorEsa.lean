import Definitions.Def_ChapterTensorPermutation
import Definitions.Def_ChapterTwoParticleSectorEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterTensorGraphCore
import Mathlib


/-!
# The bosonic and the fermionic `n`-particle sector

`BookProof.TensorCore` proves that a one-particle core lifts to a core of the sector
derivation `dΓ(A)⁽ⁿ⁾` on the **full** tensor power `H^{⊗n}`;
`BookProof.TwoParticleSector` reduces that operator to the two halves of `H^{⊗2}`;
`BookProof.GroupAverage` reduces an operator to the invariant sector of a finite group of
unitaries; and `BookProof.TensorPerm` constructs the action of the symmetric group
`Equiv.Perm (Fin n)` on `H^{⊗n}`.  This module puts the four together and closes the
symmetrization programme for **every** particle number:

> **The `n`-particle sectors.**  The permutation action preserves the domain `D₂^{⊗n}` of the
> sector derivation and the tensor power `D^{⊗n}` of a one-particle core, and it commutes
> with the derivation.  Hence `dΓ(A)⁽ⁿ⁾` is essentially self-adjoint on the symmetric
> (bosonic) sector and on the antisymmetric (fermionic) sector — on the domain and on the
> core — as soon as it is essentially self-adjoint on `D₂^{⊗n}`.

The commutation is proved once and for all by *structural* induction: the two elementary
isometries out of which every permutation operator is built — the exchange `swapFirst` of the
first two factors and the lift `liftTail` of an operator to the last `n` factors — both
preserve the inclusion of the domain, the derivation and the core, and those three properties
are stable under composition.

## Contents

* `Good` — the conjunction of the three compatibilities, for a pair of operators on
  `D₂^{⊗n}` and on `H^{⊗n}`; `good_liftTail`, `good_swapFirst`, `good_trans`, `good_swap0`
  and **`good_permOp`**.
* `permOp_mem_sectorDom`, `permOp_mem_sectorCore`, `sectorOp_permOp` — the consequences for
  the operator `sectorOp = dΓ(A)⁽ⁿ⁾` inside `H^{⊗n}`.
* `bosonicProj`, `fermionicProj` — the symmetrizer `|Sₙ|⁻¹ Σ_σ U_σ` and the antisymmetrizer
  `|Sₙ|⁻¹ Σ_σ sgn(σ) U_σ`, with `mem_bosonicSector_iff` and `mem_fermionicSector_iff`.
* **`essentiallySelfAdjointOn_bosonic`**, **`essentiallySelfAdjointOn_fermionic`** — the two
  sector statements on the domain `D₂^{⊗n}`, and **`essentiallySelfAdjointOn_bosonic_core`**,
  **`essentiallySelfAdjointOn_fermionic_core`** on the symmetrized and the antisymmetrized
  one-particle core `D^{⊗n}`, for any core `D` of `A`; `symmetricOn_bosonic`,
  `symmetricOn_fermionic`.
* `exists_ne_zero_bosonic`, `exists_ne_zero_fermionic` — non-vacuity witnesses (the `n`-th
  power `a ⊗ ⋯ ⊗ a` of a core vector; the Slater determinant of `n` pairwise orthogonal core
  vectors).
* `permOp_two_eq_swapH` — consistency with the two-particle chapter: for `n = 2` the
  transposition operator is the swap used there.

Nothing is assumed: the module contains no `axiom` and no `sorry`.

The hypothesis `EssentiallySelfAdjointOn (sectorDom …) (sectorOp …)` carried by the four
headline statements below, and the passage from the fixed particle number to the direct sum
over all of them, are both settled in `BookProof.FockStatistics`
(`BookProof/ChapterFockStatisticsEsa.lean` and
`BookProof/ChapterFockStatisticsCompletion.lean`): the hypothesis is a theorem for a
symmetric, essentially self-adjoint one-particle operator on a dense domain of a Hilbert
space, and `dΓ(A)` is then essentially self-adjoint on the bosonic and on the fermionic Fock
space.
-/

namespace BookProof.PermSector

open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section



variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

/-! ## The three compatibilities -/

/-- A pair of operators — one on the algebraic tensor power `D₂^{⊗n}` of the domain, one on
`H^{⊗n}` — is **good** when the first is carried to the second by the inclusion, when the two
intertwine the sector derivation, and when the first preserves the tensor power `D^{⊗n}` of
the one-particle core. -/
structure Good (n : ℕ)
    (uD : ((domSpace Hs D₂).pow n).carrier ≃ₗᵢ[ℂ] ((domSpace Hs D₂).pow n).carrier)
    (uH : (Hs.pow n).carrier ≃ₗᵢ[ℂ] (Hs.pow n).carrier) : Prop where
  /-- compatibility with the inclusion of the domain -/
  incl : ∀ t, inclPow Hs D₂ n (uD t) = uH (inclPow Hs D₂ n t)
  /-- commutation with the sector derivation -/
  der : ∀ t, derPow Hs D₂ A n (uD t) = uH (derPow Hs D₂ A n t)
  /-- preservation of the core tensor power -/
  core : ∀ t ∈ corePow Hs D₂ D n, uD t ∈ corePow Hs D₂ D n



ticle sector

`BookProof.TensorCore` proves that a one-particle core lifts to a core of the sector
derivation `dΓ(A)⁽ⁿ⁾` on the **full** tensor power `H^{⊗n}`;
`BookProof.TwoParticleSector` reduces that operator to the two halves of `H^{⊗2}`;
`BookProof.GroupAverage` reduces an operator to the invariant sector of a finite group of
unitaries; and `BookProof.TensorPerm` constructs the action of the symmetric group
`Equiv.Perm (Fin n)` on `H^{⊗n}`.  This module puts the four together and closes the
symmetrization programme for **every** particle number:

> **The `n`-particle sectors.**  The permutation action preserves the domain `D₂^{⊗n}` of the
> sector derivation and the tensor power `D^{⊗n}` of a one-particle core, and it commutes
> with the derivation.  Hence `dΓ(A)⁽ⁿ⁾` is essentially self-adjoint on the symmetric
> (bosonic) sector and on the antisymmetric (fermionic) sector — on the domain and on the
> core — as soon as it is essentially self-adjoint on `D₂^{⊗n}`.

The commutation is proved once and for all by *structural* induction: the two elementary
isometries out of which every permutation operator is built — the exchange `swapFirst` of the
first two factors and the lift `liftTail` of an operator to the last `n` factors — both
preserve the inclusion of the domain, the derivation and the core, and those three properties
are stable under composition.

## Contents

* `Good` — the conjunction of the three compatibilities, for a pair of operators on
  `D₂^{⊗n}` and on `H^{⊗n}`; `good_liftTail`, `good_swapFirst`, `good_trans`, `good_swap0`
  and **`good_permOp`**.
* `permOp_mem_sectorDom`, `permOp_mem_sectorCore`, `sectorOp_permOp` — the consequences for
  the operator `sectorOp = dΓ(A)⁽ⁿ⁾` inside `H^{⊗n}`.
* `bosonicProj`, `fermionicProj` — the symmetrizer `|Sₙ|⁻¹ Σ_σ U_σ` and the antisymmetrizer
  `|Sₙ|⁻¹ Σ_σ sgn(σ) U_σ`, with `mem_bosonicSector_iff` and `mem_fermionicSector_iff`.
* **`essentiallySelfAdjointOn_bosonic`**, **`essentiallySelfAdjointOn_fermionic`** — the two
  sector statements on the domain `D₂^{⊗n}`, and **`essentiallySelfAdjointOn_bosonic_core`**,
  **`essentiallySelfAdjointOn_fermionic_core`** on the symmetrized and the antisymmetrized
  one-particle core `D^{⊗n}`, for any core `D` of `A`; `symmetricOn_bosonic`,
  `symmetricOn_fermionic`.
* `exists_ne_zero_bosonic`, `exists_ne_zero_fermionic` — non-vacuity witnesses (the `n`-th
  power `a ⊗ ⋯ ⊗ a` of a core vector; the Slater determinant of `n` pairwise orthogonal core
  vectors).
* `permOp_two_eq_swapH` — consistency with the two-particle chapter: for `n = 2` the
  transposition operator is the swap used there.

Nothing is assumed: the module contains no `axiom` and no `sorry`.

The hypothesis `EssentiallySelfAdjointOn (sectorDom …) (sectorOp …)` carried by the four
headline statements below, and the passage from the fixed particle number to the direct sum
over all of them, are both settled in `BookProof.FockStatistics`
(`BookProof/ChapterFockStatisticsEsa.lean` and
`BookProof/ChapterFockStatisticsCompletion.lean`): the hypothesis is a theorem for a
symmetric, essentially self-adjoint one-particle operator on a dense domain of a Hilbert
space, and `dΓ(A)` is then essentially self-adjoint on the bosonic and on the fermionic Fock
space.
-/

namespace BookProof.PermSector

open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

/-- A triple-tensor induction principle, used for the exchange of the first two factors. -/
theorem tensor_triple_induction {X Y Z : Type*} [AddCommGroup X] [Module ℂ X]
    [AddCommGroup Y] [Module ℂ Y] [AddCommGroup Z] [Module ℂ Z]
    {P : X ⊗[ℂ] (Y ⊗[ℂ] Z) → Prop} (hzero : P 0)
    (htmul : ∀ (x : X) (y : Y) (z : Z), P (x ⊗ₜ[ℂ] (y ⊗ₜ[ℂ] z)))
    (hadd : ∀ u v, P u → P v → P (u + v)) (t : X ⊗[ℂ] (Y ⊗[ℂ] Z)) : P t := by
  induction t using TensorProduct.induction_on with
  | zero => exact hzero
  | tmul x b =>
      induction b using TensorProduct.induction_on with
      | zero => simpa using hzero
      | tmul y z => exact htmul x y z
      | add u v hu hv => rw [TensorProduct.tmul_add]; exact hadd _ _ hu hv
  | add u v hu hv => exact hadd _ _ hu hv

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

/-! ## The three compatibilities -/

/-- A pair of operators — one on the algebraic tensor power `D₂^{⊗n}` of the domain, one on
`H^{⊗n}` — is **good** when the first is carried to the second by the inclusion, when the two
intertwine the sector derivation, and when the first preserves the tensor power `D^{⊗n}` of
the one-particle core. -/
structure Good (n : ℕ)
    (uD : ((domSpace Hs D₂).pow n).carrier ≃ₗᵢ[ℂ] ((domSpace Hs D₂).pow n).carrier)
    (uH : (Hs.pow n).carrier ≃ₗᵢ[ℂ] (Hs.pow n).carrier) : Prop where
  /-- compatibility with the inclusion of the domain -/
  incl : ∀ t, inclPow Hs D₂ n (uD t) = uH (inclPow Hs D₂ n t)
  /-- commutation with the sector derivation -/
  der : ∀ t, derPow Hs D₂ A n (uD t) = uH (derPow Hs D₂ A n t)
  /-- preservation of the core tensor power -/
  core : ∀ t ∈ corePow Hs D₂ D n, uD t ∈ corePow Hs D₂ D n

theorem good_refl (n : ℕ) :
    Good Hs D₂ A D n (LinearIsometryEquiv.refl ℂ _) (LinearIsometryEquiv.refl ℂ _) where
  incl _ := rfl
  der _ := rfl
  core _ ht := ht

theorem good_trans {n : ℕ}
    {uD vD : ((domSpace Hs D₂).pow n).carrier ≃ₗᵢ[ℂ] ((domSpace Hs D₂).pow n).carrier}
    {uH vH : (Hs.pow n).carrier ≃ₗᵢ[ℂ] (Hs.pow n).carrier}
    (hu : Good Hs D₂ A D n uD uH) (hv : Good Hs D₂ A D n vD vH) :
    Good Hs D₂ A D n (uD.trans vD) (uH.trans vH) where
  incl t := by
    change inclPow Hs D₂ n (vD (uD t)) = vH (uH (inclPow Hs D₂ n t))
    rw [hv.incl, hu.incl]
  der t := by
    change derPow Hs D₂ A n (vD (uD t)) = vH (uH (derPow Hs D₂ A n t))
    rw [hv.der, hu.der]
  core t ht := hv.core _ (hu.core t ht)

theorem good_liftTail {n : ℕ}
    {uD : ((domSpace Hs D₂).pow n).carrier ≃ₗᵢ[ℂ] ((domSpace Hs D₂).pow n).carrier}
    {uH : (Hs.pow n).carrier ≃ₗᵢ[ℂ] (Hs.pow n).carrier} (h : Good Hs D₂ A D n uD uH) :
    Good Hs D₂ A D (n + 1) (liftTail (domSpace Hs D₂) uD) (liftTail Hs uH) where
  incl t := by
    induction t using TensorProduct.induction_on with
    | zero => simp
    | tmul a b =>
        rw [liftTail_tmul, inclPow_tmul, inclPow_tmul, liftTail_tmul, h.incl]
    | add u v hu hv => simp only [map_add, hu, hv]
  der t := by
    induction t using TensorProduct.induction_on with
    | zero => simp
    | tmul a b =>
        rw [liftTail_tmul, derPow_tmul, derPow_tmul, map_add, liftTail_tmul, liftTail_tmul,
          h.incl, h.der]
    | add u v hu hv => simp only [map_add, hu, hv]
  core t ht := by
    induction ht using Submodule.span_induction with
    | mem u hu =>
        obtain ⟨a, haD, b, hb, rfl⟩ := hu
        rw [liftTail_tmul]
        exact tmul_mem_corePow Hs D₂ D haD (h.core b hb)
    | zero => simp
    | add u v _ _ hu hv => rw [map_add]; exact Submodule.add_mem _ hu hv
    | smul r u _ hu => rw [map_smul]; exact Submodule.smul_mem _ r hu







/-! ## The consequences for the sector operator -/















/-! ## The two sectors -/

/-- The **symmetrizer** of `H^{⊗n}`: the average of the permutation action. -/
def bosonicProj (n : ℕ) : (Hs.pow n).carrier →ₗ[ℂ] (Hs.pow n).carrier :=
  (permRep Hs n).avgProj

/-- The **antisymmetrizer** of `H^{⊗n}`: the average of the sign-twisted permutation
action. -/
def fermionicProj (n : ℕ) : (Hs.pow n).carrier →ₗ[ℂ] (Hs.pow n).carrier :=
  (signRep Hs n).avgProj









/-! ## The action preserves the domain and the core, and commutes with the operator -/









o halves of `H^{⊗2}`;
`BookProof.GroupAverage` reduces an operator to the invariant sector of a finite group of
unitaries; and `BookProof.TensorPerm` constructs the action of the symmetric group
`Equiv.Perm (Fin n)` on `H^{⊗n}`.  This module puts the four together and closes the
symmetrization programme for **every** particle number:

> **The `n`-particle sectors.**  The permutation action preserves the domain `D₂^{⊗n}` of the
> sector derivation and the tensor power `D^{⊗n}` of a one-particle core, and it commutes
> with the derivation.  Hence `dΓ(A)⁽ⁿ⁾` is essentially self-adjoint on the symmetric
> (bosonic) sector and on the antisymmetric (fermionic) sector — on the domain and on the
> core — as soon as it is essentially self-adjoint on `D₂^{⊗n}`.

The commutation is proved once and for all by *structural* induction: the two elementary
isometries out of which every permutation operator is built — the exchange `swapFirst` of the
first two factors and the lift `liftTail` of an operator to the last `n` factors — both
preserve the inclusion of the domain, the derivation and the core, and those three properties
are stable under composition.

## Contents

* `Good` — the conjunction of the three compatibilities, for a pair of operators on
  `D₂^{⊗n}` and on `H^{⊗n}`; `good_liftTail`, `good_swapFirst`, `good_trans`, `good_swap0`
  and **`good_permOp`**.
* `permOp_mem_sectorDom`, `permOp_mem_sectorCore`, `sectorOp_permOp` — the consequences for
  the operator `sectorOp = dΓ(A)⁽ⁿ⁾` inside `H^{⊗n}`.
* `bosonicProj`, `fermionicProj` — the symmetrizer `|Sₙ|⁻¹ Σ_σ U_σ` and the antisymmetrizer
  `|Sₙ|⁻¹ Σ_σ sgn(σ) U_σ`, with `mem_bosonicSector_iff` and `mem_fermionicSector_iff`.
* **`essentiallySelfAdjointOn_bosonic`**, **`essentiallySelfAdjointOn_fermionic`** — the two
  sector statements on the domain `D₂^{⊗n}`, and **`essentiallySelfAdjointOn_bosonic_core`**,
  **`essentiallySelfAdjointOn_fermionic_core`** on the symmetrized and the antisymmetrized
  one-particle core `D^{⊗n}`, for any core `D` of `A`; `symmetricOn_bosonic`,
  `symmetricOn_fermionic`.
* `exists_ne_zero_bosonic`, `exists_ne_zero_fermionic` — non-vacuity witnesses (the `n`-th
  power `a ⊗ ⋯ ⊗ a` of a core vector; the Slater determinant of `n` pairwise orthogonal core
  vectors).
* `permOp_two_eq_swapH` — consistency with the two-particle chapter: for `n = 2` the
  transposition operator is the swap used there.

Nothing is assumed: the module contains no `axiom` and no `sorry`.

The hypothesis `EssentiallySelfAdjointOn (sectorDom …) (sectorOp …)` carried by the four
headline statements below, and the passage from the fixed particle number to the direct sum
over all of them, are both settled in `BookProof.FockStatistics`
(`BookProof/ChapterFockStatisticsEsa.lean` and
`BookProof/ChapterFockStatisticsCompletion.lean`): the hypothesis is a theorem for a
symmetric, essentially self-adjoint one-particle operator on a dense domain of a Hilbert
space, and `dΓ(A)` is then essentially self-adjoint on the bosonic and on the fermionic Fock
space.
-/

namespace BookProof.PermSector

open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

/-- A triple-tensor induction principle, used for the exchange of the first two factors. -/
theorem tensor_triple_induction {X Y Z : Type*} [AddCommGroup X] [Module ℂ X]
    [AddCommGroup Y] [Module ℂ Y] [AddCommGroup Z] [Module ℂ Z]
    {P : X ⊗[ℂ] (Y ⊗[ℂ] Z) → Prop} (hzero : P 0)
    (htmul : ∀ (x : X) (y : Y) (z : Z), P (x ⊗ₜ[ℂ] (y ⊗ₜ[ℂ] z)))
    (hadd : ∀ u v, P u → P v → P (u + v)) (t : X ⊗[ℂ] (Y ⊗[ℂ] Z)) : P t := by
  induction t using TensorProduct.induction_on with
  | zero => exact hzero
  | tmul x b =>
      induction b using TensorProduct.induction_on with
      | zero => simpa using hzero
      | tmul y z => exact htmul x y z
      | add u v hu hv => rw [TensorProduct.tmul_add]; exact hadd _ _ hu hv
  | add u v hu hv => exact hadd _ _ hu hv

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

/-! ## The three compatibilities -/

/-- A pair of operators — one on the algebraic tensor power `D₂^{⊗n}` of the domain, one on
`H^{⊗n}` — is **good** when the first is carried to the second by the inclusion, when the two
intertwine the sector derivation, and when the first preserves the tensor power `D^{⊗n}` of
the one-particle core. -/
structure Good (n : ℕ)
    (uD : ((domSpace Hs D₂).pow n).carrier ≃ₗᵢ[ℂ] ((domSpace Hs D₂).pow n).carrier)
    (uH : (Hs.pow n).carrier ≃ₗᵢ[ℂ] (Hs.pow n).carrier) : Prop where
  /-- compatibility with the inclusion of the domain -/
  incl : ∀ t, inclPow Hs D₂ n (uD t) = uH (inclPow Hs D₂ n t)
  /-- commutation with the sector derivation -/
  der : ∀ t, derPow Hs D₂ A n (uD t) = uH (derPow Hs D₂ A n t)
  /-- preservation of the core tensor power -/
  core : ∀ t ∈ corePow Hs D₂ D n, uD t ∈ corePow Hs D₂ D n

theorem good_refl (n : ℕ) :
    Good Hs D₂ A D n (LinearIsometryEquiv.refl ℂ _) (LinearIsometryEquiv.refl ℂ _) where
  incl _ := rfl
  der _ := rfl
  core _ ht := ht

theorem good_trans {n : ℕ}
    {uD vD : ((domSpace Hs D₂).pow n).carrier ≃ₗᵢ[ℂ] ((domSpace Hs D₂).pow n).carrier}
    {uH vH : (Hs.pow n).carrier ≃ₗᵢ[ℂ] (Hs.pow n).carrier}
    (hu : Good Hs D₂ A D n uD uH) (hv : Good Hs D₂ A D n vD vH) :
    Good Hs D₂ A D n (uD.trans vD) (uH.trans vH) where
  incl t := by
    change inclPow Hs D₂ n (vD (uD t)) = vH (uH (inclPow Hs D₂ n t))
    rw [hv.incl, hu.incl]
  der t := by
    change derPow Hs D₂ A n (vD (uD t)) = vH (uH (derPow Hs D₂ A n t))
    rw [hv.der, hu.der]
  core t ht := hv.core _ (hu.core t ht)

theorem good_liftTail {n : ℕ}
    {uD : ((domSpace Hs D₂).pow n).carrier ≃ₗᵢ[ℂ] ((domSpace Hs D₂).pow n).carrier}
    {uH : (Hs.pow n).carrier ≃ₗᵢ[ℂ] (Hs.pow n).carrier} (h : Good Hs D₂ A D n uD uH) :
    Good Hs D₂ A D (n + 1) (liftTail (domSpace Hs D₂) uD) (liftTail Hs uH) where
  incl t := by
    induction t using TensorProduct.induction_on with
    | zero => simp
    | tmul a b =>
        rw [liftTail_tmul, inclPow_tmul, inclPow_tmul, liftTail_tmul, h.incl]
    | add u v hu hv => simp only [map_add, hu, hv]
  der t := by
    induction t using TensorProduct.induction_on with
    | zero => simp
    | tmul a b =>
        rw [liftTail_tmul, derPow_tmul, derPow_tmul, map_add, liftTail_tmul, liftTail_tmul,
          h.incl, h.der]
    | add u v hu hv => simp only [map_add, hu, hv]
  core t ht := by
    induction ht using Submodule.span_induction with
    | mem u hu =>
        obtain ⟨a, haD, b, hb, rfl⟩ := hu
        rw [liftTail_tmul]
        exact tmul_mem_corePow Hs D₂ D haD (h.core b hb)
    | zero => simp
    | add u v _ _ hu hv => rw [map_add]; exact Submodule.add_mem _ hu hv
    | smul r u _ hu => rw [map_smul]; exact Submodule.smul_mem _ r hu

theorem good_swapFirst (n : ℕ) :
    Good Hs D₂ A D (n + 2) (swapFirst (domSpace Hs D₂) n) (swapFirst Hs n) where
  incl t := by
    refine tensor_triple_induction (X := D₂) (Y := D₂)
      (Z := ((domSpace Hs D₂).pow n).carrier)
      (P := fun t => inclPow Hs D₂ (n + 2) (swapFirst (domSpace Hs D₂) n t)
        = swapFirst Hs n (inclPow Hs D₂ (n + 2) t)) ?_ ?_ ?_ t
    · simp
    · intro a b r
      rw [swapFirst_tmul, inclPow_tmul, inclPow_tmul, inclPow_tmul, inclPow_tmul,
        swapFirst_tmul]
    · intro u v hu hv
      simp only [map_add, hu, hv]
  der t := by
    refine tensor_triple_induction (X := D₂) (Y := D₂)
      (Z := ((domSpace Hs D₂).pow n).carrier)
      (P := fun t => derPow Hs D₂ A (n + 2) (swapFirst (domSpace Hs D₂) n t)
        = swapFirst Hs n (derPow Hs D₂ A (n + 2) t)) ?_ ?_ ?_ t
    · simp
    · intro a b r
      rw [swapFirst_tmul, derPow_tmul, derPow_tmul, derPow_tmul, derPow_tmul, inclPow_tmul,
        inclPow_tmul, TensorProduct.tmul_add, TensorProduct.tmul_add, map_add, map_add,
        swapFirst_tmul, swapFirst_tmul, swapFirst_tmul]
      abel
    · intro u v hu hv
      simp only [map_add, hu, hv]
  core t ht := by
    induction ht using Submodule.span_induction with
    | mem u hu =>
        obtain ⟨a, haD, b, hb, rfl⟩ := hu
        induction hb using Submodule.span_induction with
        | mem v hv =>
            obtain ⟨b', hb'D, r, hr, rfl⟩ := hv
            rw [swapFirst_tmul]
            exact tmul_mem_corePow Hs D₂ D hb'D (tmul_mem_corePow Hs D₂ D haD hr)
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

theorem good_swap0 : ∀ (n : ℕ) (p : Fin (n + 1)),
    Good Hs D₂ A D (n + 1) (swap0 (domSpace Hs D₂) (n + 1) p) (swap0 Hs (n + 1) p) := by
  intro n
  induction n with
  | zero =>
      intro p
      rw [swap0_one, swap0_one]
      exact good_refl Hs D₂ A D 1
  | succ n ih =>
      intro p
      refine Fin.cases ?_ ?_ p
      · rw [swap0_zero, swap0_zero]
        exact good_refl Hs D₂ A D (n + 2)
      · intro j
        rw [swap0_succ, swap0_succ]
        exact good_trans Hs D₂ A D (good_liftTail Hs D₂ A D (ih j))
          (good_trans Hs D₂ A D (good_swapFirst Hs D₂ A D n)
            (good_liftTail Hs D₂ A D (ih j)))

/-- **Every permutation operator is good**: it is compatible with the inclusion of the
domain, it commutes with the sector derivation, and it preserves the core. -/
theorem good_permOp : ∀ (n : ℕ) (σ : Equiv.Perm (Fin n)),
    Good Hs D₂ A D n (permOp (domSpace Hs D₂) n σ) (permOp Hs n σ) := by
  intro n
  induction n with
  | zero => intro σ; exact good_refl Hs D₂ A D 0
  | succ n ih =>
      intro σ
      rw [permOp_succ, permOp_succ]
      exact good_trans Hs D₂ A D (good_swap0 Hs D₂ A D n (Equiv.Perm.decomposeFin σ).1)
        (good_liftTail Hs D₂ A D (ih (Equiv.Perm.decomposeFin σ).2))

/-! ## The consequences for the sector operator -/

/-- The permutation operators are compatible with the inclusion of the domain. -/
theorem inclPow_permOp (n : ℕ) (σ : Equiv.Perm (Fin n))
    (t : ((domSpace Hs D₂).pow n).carrier) :
    inclPow Hs D₂ n (permOp (domSpace Hs D₂) n σ t) = permOp Hs n σ (inclPow Hs D₂ n t) :=
  (good_permOp Hs D₂ 0 ⊤ n σ).incl t

/-- **The permutation operators commute with the sector derivation.** -/
theorem derPow_permOp (n : ℕ) (σ : Equiv.Perm (Fin n))
    (t : ((domSpace Hs D₂).pow n).carrier) :
    derPow Hs D₂ A n (permOp (domSpace Hs D₂) n σ t)
      = permOp Hs n σ (derPow Hs D₂ A n t) :=
  (good_permOp Hs D₂ A ⊤ n σ).der t

/-- The permutation operators preserve the tensor power of the one-particle core. -/
theorem corePow_permOp (n : ℕ) (σ : Equiv.Perm (Fin n))
    {t : ((domSpace Hs D₂).pow n).carrier} (ht : t ∈ corePow Hs D₂ D n) :
    permOp (domSpace Hs D₂) n σ t ∈ corePow Hs D₂ D n :=
  (good_permOp Hs D₂ 0 D n σ).core t ht

theorem permOp_mem_sectorDom (n : ℕ) (σ : Equiv.Perm (Fin n)) {x : (Hs.pow n).carrier}
    (hx : x ∈ sectorDom Hs D₂ n) : permOp Hs n σ x ∈ sectorDom Hs D₂ n := by
  obtain ⟨t, rfl⟩ := hx
  exact ⟨permOp (domSpace Hs D₂) n σ t, inclPow_permOp Hs D₂ n σ t⟩

theorem permOp_mem_sectorCore (n : ℕ) (σ : Equiv.Perm (Fin n)) {x : (Hs.pow n).carrier}
    (hx : x ∈ sectorCore Hs D₂ D n) : permOp Hs n σ x ∈ sectorCore Hs D₂ D n := by
  obtain ⟨t, ht, rfl⟩ := hx
  exact ⟨permOp (domSpace Hs D₂) n σ t, corePow_permOp Hs D₂ D n σ ht,
    inclPow_permOp Hs D₂ n σ t⟩

/-- The permutation operators commute with the sector derivation, seen inside `H^{⊗n}`. -/
theorem sectorOp_permOp (n : ℕ) (σ : Equiv.Perm (Fin n)) (x : sectorDom Hs D₂ n) :
    sectorOp Hs D₂ A n ⟨permOp Hs n σ (x : (Hs.pow n).carrier),
        permOp_mem_sectorDom Hs D₂ n σ x.2⟩
      = permOp Hs n σ (sectorOp Hs D₂ A n x) := by
  obtain ⟨t, ht⟩ := x.2
  have hx : (x : (Hs.pow n).carrier) = inclPow Hs D₂ n t := ht.symm
  have hsw : permOp Hs n σ (x : (Hs.pow n).carrier)
      = inclPow Hs D₂ n (permOp (domSpace Hs D₂) n σ t) := by
    rw [inclPow_permOp, hx]
  rw [sectorOp_apply Hs D₂ A n _ _ hsw, sectorOp_apply Hs D₂ A n x t hx, derPow_permOp]

theorem restrictOp_sectorOp_permOp (n : ℕ) (σ : Equiv.Perm (Fin n))
    (x : sectorCore Hs D₂ D n) :
    restrictOp (sectorOp Hs D₂ A n) (sectorCore_le_sectorDom Hs D₂ D n)
        ⟨permOp Hs n σ (x : (Hs.pow n).carrier), permOp_mem_sectorCore Hs D₂ D n σ x.2⟩
      = permOp Hs n σ
          (restrictOp (sectorOp Hs D₂ A n) (sectorCore_le_sectorDom Hs D₂ D n) x) := by
  simpa using sectorOp_permOp Hs D₂ A n σ
    ⟨(x : (Hs.pow n).carrier), sectorCore_le_sectorDom Hs D₂ D n x.2⟩

/-! ## The two sectors -/

/-- The **symmetrizer** of `H^{⊗n}`: the average of the permutation action. -/
def bosonicProj (n : ℕ) : (Hs.pow n).carrier →ₗ[ℂ] (Hs.pow n).carrier :=
  (permRep Hs n).avgProj

/-- The **antisymmetrizer** of `H^{⊗n}`: the average of the sign-twisted permutation
action. -/
def fermionicProj (n : ℕ) : (Hs.pow n).carrier →ₗ[ℂ] (Hs.pow n).carrier :=
  (signRep Hs n).avgProj

theorem isReducingProjection_bosonicProj (n : ℕ) : IsReducingProjection (bosonicProj Hs n) :=
  (permRep Hs n).isReducingProjection_avgProj

theorem isReducingProjection_fermionicProj (n : ℕ) :
    IsReducingProjection (fermionicProj Hs n) :=
  (signRep Hs n).isReducingProjection_avgProj

/-- **The bosonic sector is the space of symmetric tensors.** -/
theorem mem_bosonicSector_iff (n : ℕ) {x : (Hs.pow n).carrier} :
    x ∈ sector (bosonicProj Hs n) ↔ ∀ σ : Equiv.Perm (Fin n), permOp Hs n σ x = x := by
  rw [sector, bosonicProj, (permRep Hs n).mem_range_avgProj_iff]
  constructor
  · intro h σ
    simpa using h σ⁻¹
  · intro h σ
    simpa using h σ⁻¹

/-- **The fermionic sector is the space of antisymmetric tensors.** -/
theorem mem_fermionicSector_iff (n : ℕ) {x : (Hs.pow n).carrier} :
    x ∈ sector (fermionicProj Hs n)
      ↔ ∀ σ : Equiv.Perm (Fin n),
          permOp Hs n σ x = ((Equiv.Perm.sign σ : ℤ) : ℂ) • x := by
  rw [sector, fermionicProj, (signRep Hs n).mem_range_avgProj_iff]
  have hsq : ∀ σ : Equiv.Perm (Fin n),
      ((Equiv.Perm.sign σ : ℤ) : ℂ) * ((Equiv.Perm.sign σ : ℤ) : ℂ) = 1 := by
    intro σ
    rcases Int.units_eq_one_or (Equiv.Perm.sign σ) with h | h <;> simp [h]
  constructor
  · intro h σ
    have hσ := h σ⁻¹
    rw [signRep_act, inv_inv, Equiv.Perm.sign_inv] at hσ
    calc permOp Hs n σ x
        = ((Equiv.Perm.sign σ : ℤ) : ℂ) •
            (((Equiv.Perm.sign σ : ℤ) : ℂ) • permOp Hs n σ x) := by
          rw [smul_smul, hsq, one_smul]
      _ = ((Equiv.Perm.sign σ : ℤ) : ℂ) • x := by rw [hσ]
  · intro h σ
    rw [signRep_act, h σ⁻¹, Equiv.Perm.sign_inv, smul_smul, hsq, one_smul]

/-! ## The action preserves the domain and the core, and commutes with the operator -/

theorem permRep_mem_sectorDom (n : ℕ) (σ : Equiv.Perm (Fin n)) (x : (Hs.pow n).carrier)
    (hx : x ∈ sectorDom Hs D₂ n) : (permRep Hs n).act σ x ∈ sectorDom Hs D₂ n :=
  permOp_mem_sectorDom Hs D₂ n σ⁻¹ hx

theorem signRep_mem_sectorDom (n : ℕ) (σ : Equiv.Perm (Fin n)) (x : (Hs.pow n).carrier)
    (hx : x ∈ sectorDom Hs D₂ n) : (signRep Hs n).act σ x ∈ sectorDom Hs D₂ n :=
  Submodule.smul_mem _ _ (permOp_mem_sectorDom Hs D₂ n σ⁻¹ hx)

theorem permRep_mem_sectorCore (n : ℕ) (σ : Equiv.Perm (Fin n)) (x : (Hs.pow n).carrier)
    (hx : x ∈ sectorCore Hs D₂ D n) : (permRep Hs n).act σ x ∈ sectorCore Hs D₂ D n :=
  permOp_mem_sectorCore Hs D₂ D n σ⁻¹ hx

theorem signRep_mem_sectorCore (n : ℕ) (σ : Equiv.Perm (Fin n)) (x : (Hs.pow n).carrier)
    (hx : x ∈ sectorCore Hs D₂ D n) : (signRep Hs n).act σ x ∈ sectorCore Hs D₂ D n :=
  Submodule.smul_mem _ _ (permOp_mem_sectorCore Hs D₂ D n σ⁻¹ hx)

theorem permRep_commutes_sectorDom (n : ℕ) (σ : Equiv.Perm (Fin n))
    (x : sectorDom Hs D₂ n) :
    sectorOp Hs D₂ A n ⟨(permRep Hs n).act σ (x : (Hs.pow n).carrier),
        permRep_mem_sectorDom Hs D₂ n σ _ x.2⟩
      = (permRep Hs n).act σ (sectorOp Hs D₂ A n x) :=
  sectorOp_permOp Hs D₂ A n σ⁻¹ x



theorem permRep_commutes_sectorCore (n : ℕ) (σ : Equiv.Perm (Fin n))
    (x : sectorCore Hs D₂ D n) :
    restrictOp (sectorOp Hs D₂ A n) (sectorCore_le_sectorDom Hs D₂ D n)
        ⟨(permRep Hs n).act σ (x : (Hs.pow n).carrier),
          permRep_mem_sectorCore Hs D₂ D n σ _ x.2⟩
      = (permRep Hs n).act σ
          (restrictOp (sectorOp Hs D₂ A n) (sectorCore_le_sectorDom Hs D₂ D n) x) :=
  restrictOp_sectorOp_permOp Hs D₂ A D n σ⁻¹ x



/-! ## Essential self-adjointness on the two sectors -/









/-! ## Symmetry of the sector operators -/





/-! ## Pure tensors inside the domain and the core -/







/-! ## Non-vacuity of the two sectors -/



H^{⊗n}`.  This module puts the four together and closes the
symmetrization programme for **every** particle number:

> **The `n`-particle sectors.**  The permutation action preserves the domain `D₂^{⊗n}` of the
> sector derivation and the tensor power `D^{⊗n}` of a one-particle core, and it commutes
> with the derivation.  Hence `dΓ(A)⁽ⁿ⁾` is essentially self-adjoint on the symmetric
> (bosonic) sector and on the antisymmetric (fermionic) sector — on the domain and on the
> core — as soon as it is essentially self-adjoint on `D₂^{⊗n}`.

The commutation is proved once and for all by *structural* induction: the two elementary
isometries out of which every permutation operator is built — the exchange `swapFirst` of the
first two factors and the lift `liftTail` of an operator to the last `n` factors — both
preserve the inclusion of the domain, the derivation and the core, and those three properties
are stable under composition.

## Contents

* `Good` — the conjunction of the three compatibilities, for a pair of operators on
  `D₂^{⊗n}` and on `H^{⊗n}`; `good_liftTail`, `good_swapFirst`, `good_trans`, `good_swap0`
  and **`good_permOp`**.
* `permOp_mem_sectorDom`, `permOp_mem_sectorCore`, `sectorOp_permOp` — the consequences for
  the operator `sectorOp = dΓ(A)⁽ⁿ⁾` inside `H^{⊗n}`.
* `bosonicProj`, `fermionicProj` — the symmetrizer `|Sₙ|⁻¹ Σ_σ U_σ` and the antisymmetrizer
  `|Sₙ|⁻¹ Σ_σ sgn(σ) U_σ`, with `mem_bosonicSector_iff` and `mem_fermionicSector_iff`.
* **`essentiallySelfAdjointOn_bosonic`**, **`essentiallySelfAdjointOn_fermionic`** — the two
  sector statements on the domain `D₂^{⊗n}`, and **`essentiallySelfAdjointOn_bosonic_core`**,
  **`essentiallySelfAdjointOn_fermionic_core`** on the symmetrized and the antisymmetrized
  one-particle core `D^{⊗n}`, for any core `D` of `A`; `symmetricOn_bosonic`,
  `symmetricOn_fermionic`.
* `exists_ne_zero_bosonic`, `exists_ne_zero_fermionic` — non-vacuity witnesses (the `n`-th
  power `a ⊗ ⋯ ⊗ a` of a core vector; the Slater determinant of `n` pairwise orthogonal core
  vectors).
* `permOp_two_eq_swapH` — consistency with the two-particle chapter: for `n = 2` the
  transposition operator is the swap used there.

Nothing is assumed: the module contains no `axiom` and no `sorry`.

The hypothesis `EssentiallySelfAdjointOn (sectorDom …) (sectorOp …)` carried by the four
headline statements below, and the passage from the fixed particle number to the direct sum
over all of them, are both settled in `BookProof.FockStatistics`
(`BookProof/ChapterFockStatisticsEsa.lean` and
`BookProof/ChapterFockStatisticsCompletion.lean`): the hypothesis is a theorem for a
symmetric, essentially self-adjoint one-particle operator on a dense domain of a Hilbert
space, and `dΓ(A)` is then essentially self-adjoint on the bosonic and on the fermionic Fock
space.
-/

namespace BookProof.PermSector

open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

noncomputable section

/-- A triple-tensor induction principle, used for the exchange of the first two factors. -/
theorem tensor_triple_induction {X Y Z : Type*} [AddCommGroup X] [Module ℂ X]
    [AddCommGroup Y] [Module ℂ Y] [AddCommGroup Z] [Module ℂ Z]
    {P : X ⊗[ℂ] (Y ⊗[ℂ] Z) → Prop} (hzero : P 0)
    (htmul : ∀ (x : X) (y : Y) (z : Z), P (x ⊗ₜ[ℂ] (y ⊗ₜ[ℂ] z)))
    (hadd : ∀ u v, P u → P v → P (u + v)) (t : X ⊗[ℂ] (Y ⊗[ℂ] Z)) : P t := by
  induction t using TensorProduct.induction_on with
  | zero => exact hzero
  | tmul x b =>
      induction b using TensorProduct.induction_on with
      | zero => simpa using hzero
      | tmul y z => exact htmul x y z
      | add u v hu hv => rw [TensorProduct.tmul_add]; exact hadd _ _ hu hv
  | add u v hu hv => exact hadd _ _ hu hv

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

/-! ## The three compatibilities -/

/-- A pair of operators — one on the algebraic tensor power `D₂^{⊗n}` of the domain, one on
`H^{⊗n}` — is **good** when the first is carried to the second by the inclusion, when the two
intertwine the sector derivation, and when the first preserves the tensor power `D^{⊗n}` of
the one-particle core. -/
structure Good (n : ℕ)
    (uD : ((domSpace Hs D₂).pow n).carrier ≃ₗᵢ[ℂ] ((domSpace Hs D₂).pow n).carrier)
    (uH : (Hs.pow n).carrier ≃ₗᵢ[ℂ] (Hs.pow n).carrier) : Prop where
  /-- compatibility with the inclusion of the domain -/
  incl : ∀ t, inclPow Hs D₂ n (uD t) = uH (inclPow Hs D₂ n t)
  /-- commutation with the sector derivation -/
  der : ∀ t, derPow Hs D₂ A n (uD t) = uH (derPow Hs D₂ A n t)
  /-- preservation of the core tensor power -/
  core : ∀ t ∈ corePow Hs D₂ D n, uD t ∈ corePow Hs D₂ D n

theorem good_refl (n : ℕ) :
    Good Hs D₂ A D n (LinearIsometryEquiv.refl ℂ _) (LinearIsometryEquiv.refl ℂ _) where
  incl _ := rfl
  der _ := rfl
  core _ ht := ht

theorem good_trans {n : ℕ}
    {uD vD : ((domSpace Hs D₂).pow n).carrier ≃ₗᵢ[ℂ] ((domSpace Hs D₂).pow n).carrier}
    {uH vH : (Hs.pow n).carrier ≃ₗᵢ[ℂ] (Hs.pow n).carrier}
    (hu : Good Hs D₂ A D n uD uH) (hv : Good Hs D₂ A D n vD vH) :
    Good Hs D₂ A D n (uD.trans vD) (uH.trans vH) where
  incl t := by
    change inclPow Hs D₂ n (vD (uD t)) = vH (uH (inclPow Hs D₂ n t))
    rw [hv.incl, hu.incl]
  der t := by
    change derPow Hs D₂ A n (vD (uD t)) = vH (uH (derPow Hs D₂ A n t))
    rw [hv.der, hu.der]
  core t ht := hv.core _ (hu.core t ht)

theorem good_liftTail {n : ℕ}
    {uD : ((domSpace Hs D₂).pow n).carrier ≃ₗᵢ[ℂ] ((domSpace Hs D₂).pow n).carrier}
    {uH : (Hs.pow n).carrier ≃ₗᵢ[ℂ] (Hs.pow n).carrier} (h : Good Hs D₂ A D n uD uH) :
    Good Hs D₂ A D (n + 1) (liftTail (domSpace Hs D₂) uD) (liftTail Hs uH) where
  incl t := by
    induction t using TensorProduct.induction_on with
    | zero => simp
    | tmul a b =>
        rw [liftTail_tmul, inclPow_tmul, inclPow_tmul, liftTail_tmul, h.incl]
    | add u v hu hv => simp only [map_add, hu, hv]
  der t := by
    induction t using TensorProduct.induction_on with
    | zero => simp
    | tmul a b =>
        rw [liftTail_tmul, derPow_tmul, derPow_tmul, map_add, liftTail_tmul, liftTail_tmul,
          h.incl, h.der]
    | add u v hu hv => simp only [map_add, hu, hv]
  core t ht := by
    induction ht using Submodule.span_induction with
    | mem u hu =>
        obtain ⟨a, haD, b, hb, rfl⟩ := hu
        rw [liftTail_tmul]
        exact tmul_mem_corePow Hs D₂ D haD (h.core b hb)
    | zero => simp
    | add u v _ _ hu hv => rw [map_add]; exact Submodule.add_mem _ hu hv
    | smul r u _ hu => rw [map_smul]; exact Submodule.smul_mem _ r hu

theorem good_swapFirst (n : ℕ) :
    Good Hs D₂ A D (n + 2) (swapFirst (domSpace Hs D₂) n) (swapFirst Hs n) where
  incl t := by
    refine tensor_triple_induction (X := D₂) (Y := D₂)
      (Z := ((domSpace Hs D₂).pow n).carrier)
      (P := fun t => inclPow Hs D₂ (n + 2) (swapFirst (domSpace Hs D₂) n t)
        = swapFirst Hs n (inclPow Hs D₂ (n + 2) t)) ?_ ?_ ?_ t
    · simp
    · intro a b r
      rw [swapFirst_tmul, inclPow_tmul, inclPow_tmul, inclPow_tmul, inclPow_tmul,
        swapFirst_tmul]
    · intro u v hu hv
      simp only [map_add, hu, hv]
  der t := by
    refine tensor_triple_induction (X := D₂) (Y := D₂)
      (Z := ((domSpace Hs D₂).pow n).carrier)
      (P := fun t => derPow Hs D₂ A (n + 2) (swapFirst (domSpace Hs D₂) n t)
        = swapFirst Hs n (derPow Hs D₂ A (n + 2) t)) ?_ ?_ ?_ t
    · simp
    · intro a b r
      rw [swapFirst_tmul, derPow_tmul, derPow_tmul, derPow_tmul, derPow_tmul, inclPow_tmul,
        inclPow_tmul, TensorProduct.tmul_add, TensorProduct.tmul_add, map_add, map_add,
        swapFirst_tmul, swapFirst_tmul, swapFirst_tmul]
      abel
    · intro u v hu hv
      simp only [map_add, hu, hv]
  core t ht := by
    induction ht using Submodule.span_induction with
    | mem u hu =>
        obtain ⟨a, haD, b, hb, rfl⟩ := hu
        induction hb using Submodule.span_induction with
        | mem v hv =>
            obtain ⟨b', hb'D, r, hr, rfl⟩ := hv
            rw [swapFirst_tmul]
            exact tmul_mem_corePow Hs D₂ D hb'D (tmul_mem_corePow Hs D₂ D haD hr)
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

theorem good_swap0 : ∀ (n : ℕ) (p : Fin (n + 1)),
    Good Hs D₂ A D (n + 1) (swap0 (domSpace Hs D₂) (n + 1) p) (swap0 Hs (n + 1) p) := by
  intro n
  induction n with
  | zero =>
      intro p
      rw [swap0_one, swap0_one]
      exact good_refl Hs D₂ A D 1
  | succ n ih =>
      intro p
      refine Fin.cases ?_ ?_ p
      · rw [swap0_zero, swap0_zero]
        exact good_refl Hs D₂ A D (n + 2)
      · intro j
        rw [swap0_succ, swap0_succ]
        exact good_trans Hs D₂ A D (good_liftTail Hs D₂ A D (ih j))
          (good_trans Hs D₂ A D (good_swapFirst Hs D₂ A D n)
            (good_liftTail Hs D₂ A D (ih j)))

/-- **Every permutation operator is good**: it is compatible with the inclusion of the
domain, it commutes with the sector derivation, and it preserves the core. -/
theorem good_permOp : ∀ (n : ℕ) (σ : Equiv.Perm (Fin n)),
    Good Hs D₂ A D n (permOp (domSpace Hs D₂) n σ) (permOp Hs n σ) := by
  intro n
  induction n with
  | zero => intro σ; exact good_refl Hs D₂ A D 0
  | succ n ih =>
      intro σ
      rw [permOp_succ, permOp_succ]
      exact good_trans Hs D₂ A D (good_swap0 Hs D₂ A D n (Equiv.Perm.decomposeFin σ).1)
        (good_liftTail Hs D₂ A D (ih (Equiv.Perm.decomposeFin σ).2))

/-! ## The consequences for the sector operator -/

/-- The permutation operators are compatible with the inclusion of the domain. -/
theorem inclPow_permOp (n : ℕ) (σ : Equiv.Perm (Fin n))
    (t : ((domSpace Hs D₂).pow n).carrier) :
    inclPow Hs D₂ n (permOp (domSpace Hs D₂) n σ t) = permOp Hs n σ (inclPow Hs D₂ n t) :=
  (good_permOp Hs D₂ 0 ⊤ n σ).incl t

/-- **The permutation operators commute with the sector derivation.** -/
theorem derPow_permOp (n : ℕ) (σ : Equiv.Perm (Fin n))
    (t : ((domSpace Hs D₂).pow n).carrier) :
    derPow Hs D₂ A n (permOp (domSpace Hs D₂) n σ t)
      = permOp Hs n σ (derPow Hs D₂ A n t) :=
  (good_permOp Hs D₂ A ⊤ n σ).der t

/-- The permutation operators preserve the tensor power of the one-particle core. -/
theorem corePow_permOp (n : ℕ) (σ : Equiv.Perm (Fin n))
    {t : ((domSpace Hs D₂).pow n).carrier} (ht : t ∈ corePow Hs D₂ D n) :
    permOp (domSpace Hs D₂) n σ t ∈ corePow Hs D₂ D n :=
  (good_permOp Hs D₂ 0 D n σ).core t ht

theorem permOp_mem_sectorDom (n : ℕ) (σ : Equiv.Perm (Fin n)) {x : (Hs.pow n).carrier}
    (hx : x ∈ sectorDom Hs D₂ n) : permOp Hs n σ x ∈ sectorDom Hs D₂ n := by
  obtain ⟨t, rfl⟩ := hx
  exact ⟨permOp (domSpace Hs D₂) n σ t, inclPow_permOp Hs D₂ n σ t⟩

theorem permOp_mem_sectorCore (n : ℕ) (σ : Equiv.Perm (Fin n)) {x : (Hs.pow n).carrier}
    (hx : x ∈ sectorCore Hs D₂ D n) : permOp Hs n σ x ∈ sectorCore Hs D₂ D n := by
  obtain ⟨t, ht, rfl⟩ := hx
  exact ⟨permOp (domSpace Hs D₂) n σ t, corePow_permOp Hs D₂ D n σ ht,
    inclPow_permOp Hs D₂ n σ t⟩

/-- The permutation operators commute with the sector derivation, seen inside `H^{⊗n}`. -/
theorem sectorOp_permOp (n : ℕ) (σ : Equiv.Perm (Fin n)) (x : sectorDom Hs D₂ n) :
    sectorOp Hs D₂ A n ⟨permOp Hs n σ (x : (Hs.pow n).carrier),
        permOp_mem_sectorDom Hs D₂ n σ x.2⟩
      = permOp Hs n σ (sectorOp Hs D₂ A n x) := by
  obtain ⟨t, ht⟩ := x.2
  have hx : (x : (Hs.pow n).carrier) = inclPow Hs D₂ n t := ht.symm
  have hsw : permOp Hs n σ (x : (Hs.pow n).carrier)
      = inclPow Hs D₂ n (permOp (domSpace Hs D₂) n σ t) := by
    rw [inclPow_permOp, hx]
  rw [sectorOp_apply Hs D₂ A n _ _ hsw, sectorOp_apply Hs D₂ A n x t hx, derPow_permOp]

theorem restrictOp_sectorOp_permOp (n : ℕ) (σ : Equiv.Perm (Fin n))
    (x : sectorCore Hs D₂ D n) :
    restrictOp (sectorOp Hs D₂ A n) (sectorCore_le_sectorDom Hs D₂ D n)
        ⟨permOp Hs n σ (x : (Hs.pow n).carrier), permOp_mem_sectorCore Hs D₂ D n σ x.2⟩
      = permOp Hs n σ
          (restrictOp (sectorOp Hs D₂ A n) (sectorCore_le_sectorDom Hs D₂ D n) x) := by
  simpa using sectorOp_permOp Hs D₂ A n σ
    ⟨(x : (Hs.pow n).carrier), sectorCore_le_sectorDom Hs D₂ D n x.2⟩

/-! ## The two sectors -/

/-- The **symmetrizer** of `H^{⊗n}`: the average of the permutation action. -/
def bosonicProj (n : ℕ) : (Hs.pow n).carrier →ₗ[ℂ] (Hs.pow n).carrier :=
  (permRep Hs n).avgProj

/-- The **antisymmetrizer** of `H^{⊗n}`: the average of the sign-twisted permutation
action. -/
def fermionicProj (n : ℕ) : (Hs.pow n).carrier →ₗ[ℂ] (Hs.pow n).carrier :=
  (signRep Hs n).avgProj

theorem isReducingProjection_bosonicProj (n : ℕ) : IsReducingProjection (bosonicProj Hs n) :=
  (permRep Hs n).isReducingProjection_avgProj

theorem isReducingProjection_fermionicProj (n : ℕ) :
    IsReducingProjection (fermionicProj Hs n) :=
  (signRep Hs n).isReducingProjection_avgProj

/-- **The bosonic sector is the space of symmetric tensors.** -/
theorem mem_bosonicSector_iff (n : ℕ) {x : (Hs.pow n).carrier} :
    x ∈ sector (bosonicProj Hs n) ↔ ∀ σ : Equiv.Perm (Fin n), permOp Hs n σ x = x := by
  rw [sector, bosonicProj, (permRep Hs n).mem_range_avgProj_iff]
  constructor
  · intro h σ
    simpa using h σ⁻¹
  · intro h σ
    simpa using h σ⁻¹

/-- **The fermionic sector is the space of antisymmetric tensors.** -/
theorem mem_fermionicSector_iff (n : ℕ) {x : (Hs.pow n).carrier} :
    x ∈ sector (fermionicProj Hs n)
      ↔ ∀ σ : Equiv.Perm (Fin n),
          permOp Hs n σ x = ((Equiv.Perm.sign σ : ℤ) : ℂ) • x := by
  rw [sector, fermionicProj, (signRep Hs n).mem_range_avgProj_iff]
  have hsq : ∀ σ : Equiv.Perm (Fin n),
      ((Equiv.Perm.sign σ : ℤ) : ℂ) * ((Equiv.Perm.sign σ : ℤ) : ℂ) = 1 := by
    intro σ
    rcases Int.units_eq_one_or (Equiv.Perm.sign σ) with h | h <;> simp [h]
  constructor
  · intro h σ
    have hσ := h σ⁻¹
    rw [signRep_act, inv_inv, Equiv.Perm.sign_inv] at hσ
    calc permOp Hs n σ x
        = ((Equiv.Perm.sign σ : ℤ) : ℂ) •
            (((Equiv.Perm.sign σ : ℤ) : ℂ) • permOp Hs n σ x) := by
          rw [smul_smul, hsq, one_smul]
      _ = ((Equiv.Perm.sign σ : ℤ) : ℂ) • x := by rw [hσ]
  · intro h σ
    rw [signRep_act, h σ⁻¹, Equiv.Perm.sign_inv, smul_smul, hsq, one_smul]

/-! ## The action preserves the domain and the core, and commutes with the operator -/

theorem permRep_mem_sectorDom (n : ℕ) (σ : Equiv.Perm (Fin n)) (x : (Hs.pow n).carrier)
    (hx : x ∈ sectorDom Hs D₂ n) : (permRep Hs n).act σ x ∈ sectorDom Hs D₂ n :=
  permOp_mem_sectorDom Hs D₂ n σ⁻¹ hx

theorem signRep_mem_sectorDom (n : ℕ) (σ : Equiv.Perm (Fin n)) (x : (Hs.pow n).carrier)
    (hx : x ∈ sectorDom Hs D₂ n) : (signRep Hs n).act σ x ∈ sectorDom Hs D₂ n :=
  Submodule.smul_mem _ _ (permOp_mem_sectorDom Hs D₂ n σ⁻¹ hx)

theorem permRep_mem_sectorCore (n : ℕ) (σ : Equiv.Perm (Fin n)) (x : (Hs.pow n).carrier)
    (hx : x ∈ sectorCore Hs D₂ D n) : (permRep Hs n).act σ x ∈ sectorCore Hs D₂ D n :=
  permOp_mem_sectorCore Hs D₂ D n σ⁻¹ hx

theorem signRep_mem_sectorCore (n : ℕ) (σ : Equiv.Perm (Fin n)) (x : (Hs.pow n).carrier)
    (hx : x ∈ sectorCore Hs D₂ D n) : (signRep Hs n).act σ x ∈ sectorCore Hs D₂ D n :=
  Submodule.smul_mem _ _ (permOp_mem_sectorCore Hs D₂ D n σ⁻¹ hx)

theorem permRep_commutes_sectorDom (n : ℕ) (σ : Equiv.Perm (Fin n))
    (x : sectorDom Hs D₂ n) :
    sectorOp Hs D₂ A n ⟨(permRep Hs n).act σ (x : (Hs.pow n).carrier),
        permRep_mem_sectorDom Hs D₂ n σ _ x.2⟩
      = (permRep Hs n).act σ (sectorOp Hs D₂ A n x) :=
  sectorOp_permOp Hs D₂ A n σ⁻¹ x

theorem signRep_commutes_sectorDom (n : ℕ) (σ : Equiv.Perm (Fin n))
    (x : sectorDom Hs D₂ n) :
    sectorOp Hs D₂ A n ⟨(signRep Hs n).act σ (x : (Hs.pow n).carrier),
        signRep_mem_sectorDom Hs D₂ n σ _ x.2⟩
      = (signRep Hs n).act σ (sectorOp Hs D₂ A n x) := by
  have hsplit : (⟨(signRep Hs n).act σ (x : (Hs.pow n).carrier),
        signRep_mem_sectorDom Hs D₂ n σ _ x.2⟩ : sectorDom Hs D₂ n)
      = ((Equiv.Perm.sign σ : ℤ) : ℂ) •
        (⟨permOp Hs n σ⁻¹ (x : (Hs.pow n).carrier),
          permOp_mem_sectorDom Hs D₂ n σ⁻¹ x.2⟩ : sectorDom Hs D₂ n) := by
    apply Subtype.ext
    rfl
  rw [hsplit, map_smul, sectorOp_permOp Hs D₂ A n σ⁻¹ x]
  rfl

theorem permRep_commutes_sectorCore (n : ℕ) (σ : Equiv.Perm (Fin n))
    (x : sectorCore Hs D₂ D n) :
    restrictOp (sectorOp Hs D₂ A n) (sectorCore_le_sectorDom Hs D₂ D n)
        ⟨(permRep Hs n).act σ (x : (Hs.pow n).carrier),
          permRep_mem_sectorCore Hs D₂ D n σ _ x.2⟩
      = (permRep Hs n).act σ
          (restrictOp (sectorOp Hs D₂ A n) (sectorCore_le_sectorDom Hs D₂ D n) x) :=
  restrictOp_sectorOp_permOp Hs D₂ A D n σ⁻¹ x

theorem signRep_commutes_sectorCore (n : ℕ) (σ : Equiv.Perm (Fin n))
    (x : sectorCore Hs D₂ D n) :
    restrictOp (sectorOp Hs D₂ A n) (sectorCore_le_sectorDom Hs D₂ D n)
        ⟨(signRep Hs n).act σ (x : (Hs.pow n).carrier),
          signRep_mem_sectorCore Hs D₂ D n σ _ x.2⟩
      = (signRep Hs n).act σ
          (restrictOp (sectorOp Hs D₂ A n) (sectorCore_le_sectorDom Hs D₂ D n) x) := by
  have hsplit : (⟨(signRep Hs n).act σ (x : (Hs.pow n).carrier),
        signRep_mem_sectorCore Hs D₂ D n σ _ x.2⟩ : sectorCore Hs D₂ D n)
      = ((Equiv.Perm.sign σ : ℤ) : ℂ) •
        (⟨permOp Hs n σ⁻¹ (x : (Hs.pow n).carrier),
          permOp_mem_sectorCore Hs D₂ D n σ⁻¹ x.2⟩ : sectorCore Hs D₂ D n) := by
    apply Subtype.ext
    rfl
  rw [hsplit, map_smul, restrictOp_sectorOp_permOp Hs D₂ A D n σ⁻¹ x]
  rfl

/-! ## Essential self-adjointness on the two sectors -/

/-- **The bosonic `n`-particle derivation is essentially self-adjoint**, on the symmetric
part of the domain `D₂^{⊗n}`, as soon as the full `n`-particle derivation is. -/
theorem essentiallySelfAdjointOn_bosonic (n : ℕ)
    (hesa : EssentiallySelfAdjointOn (sectorDom Hs D₂ n) (sectorOp Hs D₂ A n)) :
    EssentiallySelfAdjointOn
      (redDom (bosonicProj Hs n) (sectorDom Hs D₂ n))
      (redOp (sectorOp Hs D₂ A n) (isReducingProjection_bosonicProj Hs n)
        ((permRep Hs n).commutes_avgProj
          (hD := permRep_mem_sectorDom Hs D₂ n)
          (permRep_commutes_sectorDom Hs D₂ A n))) :=
  essentiallySelfAdjointOn_red _ _ hesa

/-- **The fermionic `n`-particle derivation is essentially self-adjoint**, on the
antisymmetric part of the domain `D₂^{⊗n}`. -/
theorem essentiallySelfAdjointOn_fermionic (n : ℕ)
    (hesa : EssentiallySelfAdjointOn (sectorDom Hs D₂ n) (sectorOp Hs D₂ A n)) :
    EssentiallySelfAdjointOn
      (redDom (fermionicProj Hs n) (sectorDom Hs D₂ n))
      (redOp (sectorOp Hs D₂ A n) (isReducingProjection_fermionicProj Hs n)
        ((signRep Hs n).commutes_avgProj
          (hD := signRep_mem_sectorDom Hs D₂ n)
          (signRep_commutes_sectorDom Hs D₂ A n))) :=
  essentiallySelfAdjointOn_red _ _ hesa

/-- **The bosonic `n`-particle derivation is essentially self-adjoint on the symmetrized
one-particle core**, for any core `D` of the one-particle operator. -/
theorem essentiallySelfAdjointOn_bosonic_core (n : ℕ) (hcore : IsGraphCore D A)
    (hesa : EssentiallySelfAdjointOn (sectorDom Hs D₂ n) (sectorOp Hs D₂ A n)) :
    EssentiallySelfAdjointOn
      (redDom (bosonicProj Hs n) (sectorCore Hs D₂ D n))
      (redOp (restrictOp (sectorOp Hs D₂ A n) (sectorCore_le_sectorDom Hs D₂ D n))
        (isReducingProjection_bosonicProj Hs n)
        ((permRep Hs n).commutes_avgProj
          (hD := permRep_mem_sectorCore Hs D₂ D n)
          (permRep_commutes_sectorCore Hs D₂ A D n))) :=
  essentiallySelfAdjointOn_red _ _
    (essentiallySelfAdjointOn_sectorCore Hs D₂ A D hcore n hesa)

/-- **The fermionic `n`-particle derivation is essentially self-adjoint on the
antisymmetrized one-particle core.** -/
theorem essentiallySelfAdjointOn_fermionic_core (n : ℕ) (hcore : IsGraphCore D A)
    (hesa : EssentiallySelfAdjointOn (sectorDom Hs D₂ n) (sectorOp Hs D₂ A n)) :
    EssentiallySelfAdjointOn
      (redDom (fermionicProj Hs n) (sectorCore Hs D₂ D n))
      (redOp (restrictOp (sectorOp Hs D₂ A n) (sectorCore_le_sectorDom Hs D₂ D n))
        (isReducingProjection_fermionicProj Hs n)
        ((signRep Hs n).commutes_avgProj
          (hD := signRep_mem_sectorCore Hs D₂ D n)
          (signRep_commutes_sectorCore Hs D₂ A D n))) :=
  essentiallySelfAdjointOn_red _ _
    (essentiallySelfAdjointOn_sectorCore Hs D₂ A D hcore n hesa)

/-! ## Symmetry of the sector operators -/

theorem symmetricOn_bosonic (n : ℕ) (hA : SymmetricOn D₂ A) :
    SymmetricOn (redDom (bosonicProj Hs n) (sectorDom Hs D₂ n))
      (redOp (sectorOp Hs D₂ A n) (isReducingProjection_bosonicProj Hs n)
        ((permRep Hs n).commutes_avgProj
          (hD := permRep_mem_sectorDom Hs D₂ n)
          (permRep_commutes_sectorDom Hs D₂ A n))) :=
  symmetricOn_redOp _ _ (symmetricOn_sectorOp Hs D₂ A hA n)

theorem symmetricOn_fermionic (n : ℕ) (hA : SymmetricOn D₂ A) :
    SymmetricOn (redDom (fermionicProj Hs n) (sectorDom Hs D₂ n))
      (redOp (sectorOp Hs D₂ A n) (isReducingProjection_fermionicProj Hs n)
        ((signRep Hs n).commutes_avgProj
          (hD := signRep_mem_sectorDom Hs D₂ n)
          (signRep_commutes_sectorDom Hs D₂ A n))) :=
  symmetricOn_redOp _ _ (symmetricOn_sectorOp Hs D₂ A hA n)

/-! ## Pure tensors inside the domain and the core -/

theorem inclPow_purePow : ∀ (n : ℕ) (f : Fin n → D₂),
    inclPow Hs D₂ n (purePow (domSpace Hs D₂) n f)
      = purePow Hs n (fun i => ((f i : Hs.carrier))) := by
  intro n
  induction n with
  | zero => intro f; rfl
  | succ n ih =>
      intro f
      rw [purePow_succ, inclPow_tmul, ih, purePow_succ]
      rfl

theorem purePow_mem_corePow : ∀ (n : ℕ) (f : Fin n → D₂),
    (∀ i, ((f i : Hs.carrier)) ∈ D) →
      purePow (domSpace Hs D₂) n f ∈ corePow Hs D₂ D n := by
  intro n
  induction n with
  | zero => intro f _; trivial
  | succ n ih =>
      intro f hf
      rw [purePow_succ]
      exact tmul_mem_corePow Hs D₂ D (hf 0) (ih (Fin.tail f) (fun i => hf i.succ))

/-- A pure tensor of core vectors lies in the sector core. -/
theorem purePow_mem_sectorCore (n : ℕ) (f : Fin n → Hs.carrier) (hD : D ≤ D₂)
    (hf : ∀ i, f i ∈ D) : purePow Hs n f ∈ sectorCore Hs D₂ D n := by
  refine ⟨purePow (domSpace Hs D₂) n (fun i => ⟨f i, hD (hf i)⟩),
    purePow_mem_corePow Hs D₂ D n _ (fun i => hf i), ?_⟩
  simpa using inclPow_purePow Hs D₂ n (fun i => ⟨f i, hD (hf i)⟩)

/-! ## Non-vacuity of the two sectors -/

/-- The `n`-th power `a ⊗ ⋯ ⊗ a` of a nonzero vector of the one-particle core is a nonzero
vector of the bosonic sector core: the bosonic statement is not vacuous. -/
theorem exists_ne_zero_bosonic (n : ℕ) (hD : D ≤ D₂) {a : Hs.carrier} (haD : a ∈ D)
    (ha0 : a ≠ 0) : ∃ x : redDom (bosonicProj Hs n) (sectorCore Hs D₂ D n), x ≠ 0 := by
  set v : (Hs.pow n).carrier := purePow Hs n (fun _ => a) with hv
  have hcore : v ∈ sectorCore Hs D₂ D n :=
    purePow_mem_sectorCore Hs D₂ D n _ hD (fun _ => haD)
  have hsec : v ∈ sector (bosonicProj Hs n) := by
    refine (mem_bosonicSector_iff Hs n).mpr (fun σ => ?_)
    rw [hv, permOp_purePow]
    rfl
  have hv0 : v ≠ 0 := purePow_ne_zero Hs (fun _ => ha0)
  refine ⟨⟨⟨v, hsec⟩, hcore⟩, ?_⟩
  intro h
  exact hv0 (by simpa using congrArg Subtype.val (congrArg Subtype.val h))

/-- The Slater determinant `Σ_σ sgn(σ) x_{σ 0} ⊗ ⋯ ⊗ x_{σ (n-1)}` of `n` pairwise orthogonal
nonzero vectors of the one-particle core is a nonzero vector of the fermionic sector core:
the fermionic statement is not vacuous either. -/
theorem exists_ne_zero_fermionic (n : ℕ) (hD : D ≤ D₂) (f : Fin n → Hs.carrier)
    (hfD : ∀ i, f i ∈ D) (hf0 : ∀ i, f i ≠ 0)
    (hortho : ∀ i j, i ≠ j → (inner ℂ (f i) (f j) : ℂ) = 0) :
    ∃ x : redDom (fermionicProj Hs n) (sectorCore Hs D₂ D n), x ≠ 0 := by
  classical
  have hsq : ∀ τ : Equiv.Perm (Fin n),
      ((Equiv.Perm.sign τ : ℤ) : ℂ) * ((Equiv.Perm.sign τ : ℤ) : ℂ) = 1 := by
    intro τ
    rcases Int.units_eq_one_or (Equiv.Perm.sign τ) with h | h <;> simp [h]
  have hmul : ∀ σ τ : Equiv.Perm (Fin n), ((Equiv.Perm.sign (σ * τ) : ℤ) : ℂ)
      = ((Equiv.Perm.sign σ : ℤ) : ℂ) * ((Equiv.Perm.sign τ : ℤ) : ℂ) := by
    intro σ τ
    rw [map_mul, Units.val_mul]
    push_cast
    ring
  set v : (Hs.pow n).carrier :=
    ∑ σ : Equiv.Perm (Fin n), ((Equiv.Perm.sign σ : ℤ) : ℂ) • purePow Hs n (f ∘ σ) with hv
  have hcore : v ∈ sectorCore Hs D₂ D n := by
    refine Submodule.sum_mem _ (fun σ _ => Submodule.smul_mem _ _ ?_)
    exact purePow_mem_sectorCore Hs D₂ D n _ hD (fun i => hfD (σ i))
  have hsec : v ∈ sector (fermionicProj Hs n) := by
    refine (mem_fermionicSector_iff Hs n).mpr (fun τ => ?_)
    rw [hv, map_sum, Finset.smul_sum]
    refine Fintype.sum_bijective (fun σ => σ * τ) (Group.mulRight_bijective τ) _ _ (fun σ => ?_)
    have hcomp : (f ∘ ⇑σ) ∘ ⇑τ = f ∘ ⇑(σ * τ) := by
      funext i
      rfl
    have hlhs : permOp Hs n τ (((Equiv.Perm.sign σ : ℤ) : ℂ) • purePow Hs n (f ∘ ⇑σ))
        = ((Equiv.Perm.sign σ : ℤ) : ℂ) • purePow Hs n (f ∘ ⇑(σ * τ)) := by
      rw [map_smul, permOp_purePow, hcomp]
    have hscal : ((Equiv.Perm.sign τ : ℤ) : ℂ)
        * (((Equiv.Perm.sign σ : ℤ) : ℂ) * ((Equiv.Perm.sign τ : ℤ) : ℂ))
        = ((Equiv.Perm.sign σ : ℤ) : ℂ) := by
      calc ((Equiv.Perm.sign τ : ℤ) : ℂ)
            * (((Equiv.Perm.sign σ : ℤ) : ℂ) * ((Equiv.Perm.sign τ : ℤ) : ℂ))
          = ((Equiv.Perm.sign σ : ℤ) : ℂ)
              * (((Equiv.Perm.sign τ : ℤ) : ℂ) * ((Equiv.Perm.sign τ : ℤ) : ℂ)) := by ring
        _ = ((Equiv.Perm.sign σ : ℤ) : ℂ) := by rw [hsq τ, mul_one]
    rw [hlhs, smul_smul, hmul σ τ, hscal]
  have hinner : (inner ℂ v (purePow Hs n f) : ℂ) = ∏ i, inner ℂ (f i) (f i) := by
    rw [hv, sum_inner]
    rw [Finset.sum_eq_single (1 : Equiv.Perm (Fin n))]
    · rw [inner_smul_left]
      simp only [Units.val_one, Int.cast_one, map_one, one_mul, Equiv.Perm.coe_one,
        Function.comp_id]
      rw [inner_purePow]
    · intro σ _ hσ
      rw [inner_smul_left, inner_purePow]
      have hex : ∃ i, σ i ≠ i := by
        by_contra hcon
        push_neg at hcon
        exact hσ (Equiv.ext (fun i => by simpa using hcon i))
      obtain ⟨i, hi⟩ := hex
      have hzero : (inner ℂ ((f ∘ σ) i) (f i) : ℂ) = 0 := hortho (σ i) i hi
      rw [Finset.prod_eq_zero (Finset.mem_univ i) hzero, mul_zero]
    · intro h
      exact absurd (Finset.mem_univ _) h
  have hv0 : v ≠ 0 := by
    intro h
    rw [h, inner_zero_left] at hinner
    obtain ⟨i, -, hi⟩ := Finset.prod_eq_zero_iff.mp hinner.symm
    exact (inner_self_ne_zero.mpr (hf0 i)) hi
  refine ⟨⟨⟨v, hsec⟩, hcore⟩, ?_⟩
  intro h
  exact hv0 (by simpa using congrArg Subtype.val (congrArg Subtype.val h))

/-! ## Consistency with the two-particle chapter -/

/-- For `n = 2` the transposition operator is the swap of `BookProof.TwoParticleSector`. -/
theorem permOp_two_eq_swapH (x : (Hs.pow 2).carrier) :
    permOp Hs 2 (Equiv.swap 0 1) x = BookProof.TwoParticleSector.swapH Hs x := by
  have h : ((permOp Hs 2 (Equiv.swap 0 1)).toLinearEquiv.toLinearMap :
      (Hs.pow 2).carrier →ₗ[ℂ] (Hs.pow 2).carrier) = BookProof.TwoParticleSector.swapH Hs := by
    refine linearMap_ext_purePow Hs (fun f => ?_)
    change permOp Hs 2 (Equiv.swap 0 1) (purePow Hs 2 f)
      = BookProof.TwoParticleSector.swapH Hs (purePow Hs 2 f)
    have hsw : BookProof.TwoParticleSector.swapH Hs (purePow Hs 2 f)
        = swapFirst Hs 0 (purePow Hs 2 f) := rfl
    rw [permOp_purePow, hsw, swapFirst_purePow]
  exact LinearMap.congr_fun h x

end

end BookProof.PermSector
