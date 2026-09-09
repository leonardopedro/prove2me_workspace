import Mathlib
import BookProof.ChapterEsaClosure
import BookProof.ChapterNavierStokesThreeComponent

/-!
# The Hashimoto/SIRK shift-invert limit selects the Navier–Stokes generator

`BookProof.ChapterNavierStokesThreeComponent` closes the abstract
sequence-space chain of the Eulerian Navier–Stokes route: the coupled
three-component fiber Hamiltonian

`H = ∑_i ½(π_i V_i + V_i π_i)`,  `V_i(u) = ∑_k A_{ik} u_k + c_i`,

written in the Hermite basis of the three velocity modes, is **essentially
self-adjoint on the finite-mode core** of `ℓ²(Vel)`, `Vel = Fin 3 → ℕ`, for an
arbitrary real velocity-gradient matrix `A` and an arbitrary real constant
vector `c` (`velH_essentiallySelfAdjointOn_core`).

The Yang–Mills route had a companion statement that the Navier–Stokes route did
not: the Hashimoto/SIRK *selection* theorem
(`BookProof.HashimotoShiftInvert.hashimoto_multishift_selects_friedrichs`,
instantiated by `ym_hermite_hashimoto_selects`), which says that the operator
the shift-invert rational Krylov algorithm computes with is the honest
self-adjoint one.  This module supplies it for Navier–Stokes.

The Yang–Mills instantiation went through *positivity* (the Friedrichs
extension of the positive sum of squares `½Σπ² + ½ΣB²`).  The Navier–Stokes
Hamiltonian is **not** positive — the strain, vorticity and constant hoppings
carry arbitrary signs — so the route here is the other one, and it is the one
essential self-adjointness was proved for: by
`BookProof.EsaClosure.exists_isSelfAdjointExtension_of_esa` the closure of the
core operator is self-adjoint, by
`BookProof.EsaClosure.isSelfAdjointExtension_unique_of_esa` it is the *only*
self-adjoint operator the core determines, and at any non-real shift the
resolvents exist and are bounded with no positivity at all.

## What is proved

* `velCore` — the coupled Navier–Stokes fiber Hamiltonian restricted to the
  finite-mode core, with `velCore_symmetricOn` and `velCore_esa`;
* `ns_selfAdjoint_extension` — the core operator has a self-adjoint extension
  (its closure), for every real `A` and `c`;
* `ns_selfAdjoint_extension_unique` — and only one;
* `ns_hashimoto_selects` — **the headline**: for an arbitrary sequence of
  non-real shifts `γ_j`, the shift-inverted resolvents `X_j = (γ_j − A)⁻¹` of
  the Navier–Stokes generator exist, are bounded by `1/|Im γ_j|`, share the
  domain of `A`, satisfy the resolvent identity, commute, satisfy the SIRK
  relation of Hashimoto–Nodera, have strongly convergent Galerkin truncations,
  and **each of them determines `A` completely**;
* `ns_shiftInvert_selects` — the single-shift form;
* `exists_velHilbertBasis` — the statement is not vacuous: `ℓ²(Vel)` does carry
  an `ℕ`-indexed Hilbert basis.

## Honest boundary

Unchanged from the rest of the Navier–Stokes thread (Contention D5): the
setting is the abstract sequence space `ℓ²(Vel)` carrying the Hermite matrix of
the fiber Hamiltonian; the differential realization on `L²(du₁du₂du₃)` is not
built here, and **nothing here claims global regularity for the classical
Navier–Stokes equation**.  What is claimed is exactly the operator statement:
the algorithm's shift-invert data determine one self-adjoint operator, the
closure of the essentially self-adjoint core Hamiltonian.
-/

open Filter Topology

namespace BookProof.NavierStokesFlow

namespace NSHashimoto

open BookProof.FarisLavine BookProof.HashimotoShiftInvert BookProof.EsaClosure
open BookProof.HermiteGalerkin
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.NavierStokesFlow.IkebeKato

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

/-- The coupled three-component Navier–Stokes fiber Hamiltonian, restricted to
the finite-mode core of `ℓ²(Vel)`. -/
noncomputable def velCore : lpFiniteModes Vel →ₗ[ℂ] L2I Vel :=
  (velH A c).comp (Submodule.inclusion (finiteModes_le_maxDom (velSym (velMu A c))))

theorem velCore_symmetricOn : SymmetricOn (lpFiniteModes Vel) (velCore A c) := fun x y =>
  velH_symmetricOn A c (Submodule.inclusion (finiteModes_le_maxDom (velSym (velMu A c))) x)
    (Submodule.inclusion (finiteModes_le_maxDom (velSym (velMu A c))) y)

theorem velCore_esa : EssentiallySelfAdjointOn (lpFiniteModes Vel) (velCore A c) :=
  velH_essentiallySelfAdjointOn_core A c

theorem velCore_dense : Dense ((lpFiniteModes Vel : Submodule ℂ (L2I Vel)) : Set (L2I Vel)) :=
  velH_domain_dense

/-! ## The self-adjoint Navier–Stokes generator -/

/-- **The Navier–Stokes fiber generator is self-adjoint on the closure of the
core.**  No positivity is used: the strain, vorticity and constant hoppings of
`velH` have arbitrary signs. -/
theorem ns_selfAdjoint_extension :
    ∃ (Dom : Submodule ℂ (L2I Vel)) (G : Dom →ₗ[ℂ] L2I Vel),
      IsSelfAdjointExtension (velCore A c) G :=
  exists_isSelfAdjointExtension_of_esa (velCore A c) velCore_dense
    (velCore_symmetricOn A c) (velCore_esa A c)

/-- **And it is the only one.**  Any two self-adjoint extensions of the
Navier–Stokes core Hamiltonian have the same domain and the same values — this
is what makes "the" generator of the flow well defined. -/
theorem ns_selfAdjoint_extension_unique {Dom₁ Dom₂ : Submodule ℂ (L2I Vel)}
    {G₁ : Dom₁ →ₗ[ℂ] L2I Vel} {G₂ : Dom₂ →ₗ[ℂ] L2I Vel}
    (h₁ : IsSelfAdjointExtension (velCore A c) G₁)
    (h₂ : IsSelfAdjointExtension (velCore A c) G₂) :
    Dom₁ = Dom₂ ∧ ∀ (x : L2I Vel) (h : x ∈ Dom₁) (h' : x ∈ Dom₂), G₁ ⟨x, h⟩ = G₂ ⟨x, h'⟩ :=
  isSelfAdjointExtension_unique_of_esa (velCore_esa A c) h₁ h₂

/-! ## The Hashimoto/SIRK selection -/

/-- **The Hashimoto/SIRK shift-invert limit selects the Navier–Stokes
generator.**  For an arbitrary sequence of non-real shifts the algorithm's
resolvents exist, are bounded, satisfy the resolvent identity, commute, satisfy
the Hashimoto–Nodera SIRK relation, have strongly convergent Galerkin
truncations, and each determines the (unique) self-adjoint Navier–Stokes
generator completely. -/
theorem ns_hashimoto_selects (b : HilbertBasis ℕ ℂ (L2I Vel)) (γ : ℕ → ℂ)
    (hγ : ∀ j, (γ j).im ≠ 0) :
    ∃ (Dom : Submodule ℂ (L2I Vel)) (G : Dom →ₗ[ℂ] L2I Vel) (X : ℕ → L2I Vel →L[ℂ] L2I Vel),
      IsSelfAdjointExtension (velCore A c) G ∧
      (∀ j, IsShiftInvertC G (γ j) (X j)) ∧
      (∀ j, ‖X j‖ ≤ |(γ j).im|⁻¹) ∧
      (∀ j, Dom = LinearMap.range ((X j : L2I Vel →ₗ[ℂ] L2I Vel))) ∧
      (∀ j k u, X j u - X k u = (γ k - γ j) • X j (X k u)) ∧
      (∀ j k, X j ∘L X k = X k ∘L X j) ∧
      (∀ j m, X j ∘L (ContinuousLinearMap.id ℂ (L2I Vel) - (γ m - γ j) • X m) = X m) ∧
      (∀ m v k, sirkDen (X m) (fun i => γ m - γ i) k (rkVec X v k) = (X m ^ k) v) ∧
      (∀ j u, Tendsto (fun n : ℕ => galerkinCompression (X j) b n u) atTop (nhds (X j u))) ∧
      (∀ j (Dom' : Submodule ℂ (L2I Vel)) (G' : Dom' →ₗ[ℂ] L2I Vel),
        IsShiftInvertC G' (γ j) (X j) →
        Dom' = Dom ∧ ∀ (x : L2I Vel) (hx : x ∈ Dom) (hx' : x ∈ Dom'),
          G' ⟨x, hx'⟩ = G ⟨x, hx⟩) :=
  hashimoto_multishift_selects_esa b (velCore A c) velCore_dense (velCore_symmetricOn A c)
    (velCore_esa A c) γ hγ

/-- **The single-shift form.**  At one non-real shift `γ` the shift-inverted
Navier–Stokes resolvent `X = (γ − G)⁻¹` exists, is bounded by `1/|Im γ|`, has
the domain of `G` as its range, and determines `G` uniquely. -/
theorem ns_shiftInvert_selects {γ : ℂ} (hγ : γ.im ≠ 0) :
    ∃ (Dom : Submodule ℂ (L2I Vel)) (G : Dom →ₗ[ℂ] L2I Vel) (X : L2I Vel →L[ℂ] L2I Vel),
      IsSelfAdjointExtension (velCore A c) G ∧ IsShiftInvertC G γ X ∧
      ‖X‖ ≤ |γ.im|⁻¹ ∧ Dom = LinearMap.range ((X : L2I Vel →ₗ[ℂ] L2I Vel)) ∧
      (∀ (Dom' : Submodule ℂ (L2I Vel)) (G' : Dom' →ₗ[ℂ] L2I Vel), IsShiftInvertC G' γ X →
        Dom' = Dom ∧ ∀ (x : L2I Vel) (hx : x ∈ Dom) (hx' : x ∈ Dom'),
          G' ⟨x, hx'⟩ = G ⟨x, hx⟩) := by
  obtain ⟨Dom, G, hG⟩ := ns_selfAdjoint_extension A c
  obtain ⟨hext, hsym, hsa⟩ := hG
  obtain ⟨X, hX⟩ := exists_isShiftInvertC hsym hγ (cshiftMap_surjective hsym hsa hγ)
  refine ⟨Dom, G, X, ⟨hext, hsym, hsa⟩, hX, hX.opNorm_le hsym hγ, hX.dom_eq_range, ?_⟩
  intro Dom' G' hG'
  obtain ⟨hdom, hval⟩ := shiftInvertC_determines hG' hX
  exact ⟨hdom, fun x hx hx' => hval x hx' hx⟩

/-! ## Non-vacuity -/

/-- `ℓ²(Vel)` carries an `ℕ`-indexed Hilbert basis, so `ns_hashimoto_selects` is
not vacuous. -/
theorem exists_velHilbertBasis (e : ℕ ≃ Vel) : Nonempty (HilbertBasis ℕ ℂ (L2I Vel)) := by
  classical
  let b : HilbertBasis Vel ℂ (L2I Vel) :=
    HilbertBasis.ofRepr (LinearIsometryEquiv.refl ℂ (L2I Vel))
  refine ⟨HilbertBasis.mk (v := fun n : ℕ => b (e n)) (b.orthonormal.comp _ e.injective) ?_⟩
  have hspan := b.dense_span
  have hrange : Set.range (fun n : ℕ => b (e n)) = Set.range (b : Vel → L2I Vel) := by
    rw [show (fun n : ℕ => b (e n)) = (b : Vel → L2I Vel) ∘ e from rfl, Set.range_comp,
      e.surjective.range_eq, Set.image_univ]
  rw [hrange]
  exact hspan.ge

/-- The Hermite multi-indices of the three velocity components are a countably
infinite set, so an enumeration `e` exists and `exists_velHilbertBasis` applies.
-/
theorem exists_velEnum : Nonempty (ℕ ≃ Vel) := nonempty_equiv_of_countable

end NSHashimoto

end BookProof.NavierStokesFlow
