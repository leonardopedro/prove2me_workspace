import Mathlib
import BookProof.ChapterUnboundedPosition

/-!
# Unitary transport of the unbounded layer

`BookProof.ChapterUnboundedPosition` proves the whole unbounded package — dense
natural domain, symmetry, self-adjointness, and a strongly continuous unitary
group of which the operator is the generator — for *multiplication* operators on
`ℓ²(ℤ)`.  That is the concrete half of the spectral picture.  This module supplies
the abstract half: **all of it is invariant under a unitary change of Hilbert
space.**

For a unitary `W : H ≃ₗᵢ[ℂ] K` and a densely defined operator `A` on a domain
`D ⊆ H`, the transported operator is `W A W⁻¹` on `W(D)` (`transportDomain`,
`transportOp`), and each structural property moves across:

* `transportDomain_dense` — the transported domain is dense;
* `transportOp_symmetric` — symmetry;
* `transport_adjointDomain` / `transport_isSelfAdjointOn` — the adjoint domain is
  the image of the adjoint domain, so **self-adjointness** transports;
* `tendsto_transportUnitary` — strong continuity of the transported group;
* `tendsto_slope_transportUnitary` — **Stone's relation** `dV/dt|₀ = i(WAW⁻¹)`.

Combining the two halves, `IsSelfAdjointOn` and the full Stone package hold for
*every* operator unitarily equivalent to a lattice multiplication operator, on any
complex Hilbert space:
`transported_position_isSelfAdjointOn`, `transported_position_group`,
`tendsto_transported_position_unitary`, `tendsto_slope_transported_position`.

This is exactly the reduction the spectral theorem is used for: an unbounded
self-adjoint operator with a diagonalizing unitary inherits its group.  What is
still missing for a general Stone theorem is the *existence* of the diagonalizing
unitary, i.e. the spectral theorem for unbounded self-adjoint operators.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped InnerProductSpace

namespace BookProof.ChapterUnitaryTransport

variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

/-! ## Abstract vocabulary for a densely defined operator -/

/-- The **domain of the adjoint** of an operator `A` defined on the domain `D`:
the vectors `φ` for which `ψ ↦ ⟪Aψ, φ⟫` is represented by an inner product. -/
def adjointDomain (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) : Set H :=
  {phi | ∃ eta : H, ∀ psi : D, ⟪A psi, phi⟫_ℂ = ⟪(psi : H), eta⟫_ℂ}

/-- `A` is **symmetric** on its domain. -/
def IsSymmetricOn (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) : Prop :=
  ∀ psi phi : D, ⟪A psi, (phi : H)⟫_ℂ = ⟪(psi : H), A phi⟫_ℂ

/-- `A` is **self-adjoint** on its domain: the adjoint domain is not merely
contained in but *equal* to `D`. -/
def IsSelfAdjointOn (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) : Prop :=
  adjointDomain D A = (D : Set H)

theorem inner_map_symm (W : H ≃ₗᵢ[ℂ] K) (x : H) (y : K) :
    ⟪W x, y⟫_ℂ = ⟪x, W.symm y⟫_ℂ := by
  conv_lhs => rw [← W.apply_symm_apply y]
  exact W.inner_map_map _ _

theorem map_real_smul (W : H ≃ₗᵢ[ℂ] K) (r : ℝ) (x : H) : W (r • x) = r • W x := by
  rw [← Complex.coe_smul, ← Complex.coe_smul, map_smul]

/-! ## Transporting the domain and the operator -/

/-- The transported domain `W(D) ⊆ K`. -/
def transportDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) : Submodule ℂ K :=
  D.map (W.toLinearEquiv : H →ₗ[ℂ] K)

theorem coe_transportDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) :
    ((transportDomain W D : Submodule ℂ K) : Set K) = W '' (D : Set H) := rfl

/-- `W` restricts to a linear equivalence `D ≃ W(D)`. -/
noncomputable def transportEquiv (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) :
    D ≃ₗ[ℂ] transportDomain W D :=
  W.toLinearEquiv.submoduleMap D

@[simp] theorem transportEquiv_coe (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (x : D) :
    ((transportEquiv W D x : transportDomain W D) : K) = W (x : H) := rfl

/-- The **transported operator** `W A W⁻¹`, defined on `W(D)`. -/
noncomputable def transportOp (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) :
    transportDomain W D →ₗ[ℂ] K :=
  (W.toLinearEquiv : H →ₗ[ℂ] K) ∘ₗ A ∘ₗ ((transportEquiv W D).symm : transportDomain W D →ₗ[ℂ] D)

theorem transportOp_apply (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) (x : D) :
    transportOp W D A (transportEquiv W D x) = W (A x) := by
  simp [transportOp]

/-! ## The structural properties transport -/

/-- A unitary carries a dense domain to a dense domain. -/
theorem transportDomain_dense (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H)
    (hD : Dense ((D : Submodule ℂ H) : Set H)) :
    Dense ((transportDomain W D : Submodule ℂ K) : Set K) := by
  rw [coe_transportDomain]
  exact W.toHomeomorph.isDenseEmbedding.dense_image.2 hD

/-- Symmetry transports. -/
theorem transportOp_symmetric (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (hA : IsSymmetricOn D A) : IsSymmetricOn (transportDomain W D) (transportOp W D A) := by
  intro y z
  obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
  obtain ⟨b, rfl⟩ := (transportEquiv W D).surjective z
  rw [transportOp_apply, transportOp_apply]
  simpa using hA a b

/-- The adjoint domain of the transported operator is the image of the adjoint
domain — the key step, since self-adjointness is an equality of domains. -/
theorem transport_adjointDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) :
    adjointDomain (transportDomain W D) (transportOp W D A) = W '' adjointDomain D A := by
  ext phi'
  constructor
  · rintro ⟨eta', h⟩
    refine ⟨W.symm phi', ⟨W.symm eta', fun psi => ?_⟩, by simp⟩
    have hkey := h (transportEquiv W D psi)
    rw [transportOp_apply, inner_map_symm] at hkey
    rw [hkey, transportEquiv_coe, inner_map_symm]
  · rintro ⟨phi, ⟨eta, h⟩, rfl⟩
    refine ⟨W eta, fun y => ?_⟩
    obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
    rw [transportOp_apply, transportEquiv_coe, W.inner_map_map, W.inner_map_map]
    exact h a

/-- **Self-adjointness transports along a unitary.** -/
theorem transport_isSelfAdjointOn (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (hA : IsSelfAdjointOn D A) :
    IsSelfAdjointOn (transportDomain W D) (transportOp W D A) := by
  rw [IsSelfAdjointOn, transport_adjointDomain, hA, coe_transportDomain]

/-! ## The unitary group transports -/

/-- The transported unitary `W U W⁻¹`. -/
noncomputable def transportUnitary (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) : K ≃ₗᵢ[ℂ] K :=
  (W.symm.trans U).trans W

@[simp] theorem transportUnitary_apply (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) (y : K) :
    transportUnitary W U y = W (U (W.symm y)) := rfl

/-- The one-parameter group law transports. -/
theorem transportUnitary_add (W : H ≃ₗᵢ[ℂ] K) (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ s t : ℝ, ∀ x : H, U (s + t) x = U s (U t x)) (s t : ℝ) (y : K) :
    transportUnitary W (U (s + t)) y
      = transportUnitary W (U s) (transportUnitary W (U t) y) := by
  simp [h]

/-- `V 0 = 1` transports. -/
theorem transportUnitary_zero (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) (h : ∀ x : H, U x = x)
    (y : K) : transportUnitary W U y = y := by
  simp [h]

/-- **Strong continuity transports.** -/
theorem tendsto_transportUnitary (W : H ≃ₗᵢ[ℂ] K) (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ x : H, Filter.Tendsto (fun t : ℝ => U t x) (nhds 0) (nhds x)) (y : K) :
    Filter.Tendsto (fun t : ℝ => transportUnitary W (U t) y) (nhds 0) (nhds y) := by
  have := (W.continuous.tendsto (W.symm y)).comp (h (W.symm y))
  simpa [Function.comp] using this

/-- **Stone's relation transports**: if `A` generates `U` on `D`, then `W A W⁻¹`
generates `W U W⁻¹` on `W(D)`. -/
theorem tendsto_slope_transportUnitary (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ x : D, Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (U t (x : H) - (x : H)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • A x)))
    (y : transportDomain W D) :
    Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (transportUnitary W (U t) (y : K) - (y : K)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • transportOp W D A y)) := by
  obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
  rw [transportOp_apply]
  have hW := (W.continuous.tendsto (Complex.I • A a)).comp (h a)
  have hlim : Filter.Tendsto
      (fun t : ℝ => W ((t⁻¹ : ℝ) • (U t (a : H) - (a : H))))
      (nhdsWithin 0 {0}ᶜ) (nhds (W (Complex.I • A a))) := by
    simpa [Function.comp] using hW
  rw [map_smul] at hlim
  refine hlim.congr fun t => ?_
  rw [map_real_smul, map_sub, transportUnitary_apply, transportEquiv_coe,
    LinearIsometryEquiv.symm_apply_apply]

/-! ## Consequence: everything unitarily equivalent to lattice multiplication -/

open BookProof.ChapterUnboundedPosition
open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

/-- The concrete `adjointDomain` of `ChapterUnboundedPosition` is the abstract one. -/
theorem adjointDomain_mulOp (f : ℤ → ℝ) :
    adjointDomain (mulDomain f) (mulOp f) = BookProof.ChapterUnboundedPosition.adjointDomain f :=
  rfl

/-- Lattice multiplication is self-adjoint in the abstract sense. -/
theorem mulOp_isSelfAdjointOn (f : ℤ → ℝ) : IsSelfAdjointOn (mulDomain f) (mulOp f) := by
  rw [IsSelfAdjointOn, adjointDomain_mulOp]
  exact adjointDomain_eq_mulDomain f

/-- **Any operator unitarily equivalent to a lattice multiplication operator is
self-adjoint on its (dense) domain.** -/
theorem transported_position_isSelfAdjointOn (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) :
    IsSelfAdjointOn (transportDomain W (mulDomain f)) (transportOp W (mulDomain f) (mulOp f)) :=
  transport_isSelfAdjointOn W _ _ (mulOp_isSelfAdjointOn f)

/-- ... on a dense domain. -/
theorem transported_position_domain_dense (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) :
    Dense ((transportDomain W (mulDomain f) : Submodule ℂ K) : Set K) :=
  transportDomain_dense W _ (mulDomain_dense f)

/-- ... and it carries a one-parameter unitary group. -/
theorem transported_position_group (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) (s t : ℝ) (y : K) :
    transportUnitary W (phaseUnitary f (s + t)) y
      = transportUnitary W (phaseUnitary f s) (transportUnitary W (phaseUnitary f t) y) :=
  transportUnitary_add W (phaseUnitary f) (fun s t x => phaseUnitary_add f s t x) s t y

/-- ... strongly continuous at `0`. -/
theorem tendsto_transported_position_unitary (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) (y : K) :
    Filter.Tendsto (fun t : ℝ => transportUnitary W (phaseUnitary f t) y) (nhds 0) (nhds y) :=
  tendsto_transportUnitary W (phaseUnitary f) (tendsto_phaseUnitary f) y

/-- ... with the transported operator as its generator: **Stone's relation** holds
for every operator unitarily equivalent to lattice multiplication. -/
theorem tendsto_slope_transported_position (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K)
    (y : transportDomain W (mulDomain f)) :
    Filter.Tendsto
      (fun t : ℝ => (t⁻¹ : ℝ) • (transportUnitary W (phaseUnitary f t) (y : K) - (y : K)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • transportOp W (mulDomain f) (mulOp f) y)) :=
  tendsto_slope_transportUnitary W _ _ (phaseUnitary f) (tendsto_slope_phaseUnitary f) y

end BookProof.ChapterUnitaryTransport
