import Mathlib
import BookProof.ChapterEsaClosure
import BookProof.ChapterNavierStokesHashimoto
import BookProof.ChapterHermiteRelativeBound

/-!
# The Hashimoto/SIRK shift-invert limit selects the *differential* Navier–Stokes generator

`BookProof.ChapterNavierStokesHashimoto` proves the Hashimoto/SIRK selection theorem for
the Navier–Stokes fiber generator in its **abstract sequence-space** realization: the
Hermite matrix `velCore` on `ℓ²(Vel)`, `Vel = Fin 3 → ℕ`.  The **differential**
realization — the same Hamiltonian written with `πᵢ = −i ∂/∂uᵢ` and `uᵢ` a genuine
multiplication operator on the Gauss–polynomial (product Hermite) core of
`L²(du₁du₂du₃)`, `BookProof.NavierStokesFlow.DifferentialL2.nsDiffH` — was proved
essentially self-adjoint (`nsDiffH_essentiallySelfAdjointOn_core`) but carried no
selection theorem.  This module supplies it.

## What is proved

* `nsDiffPoly`, `nsDiffH_eq_coreOp` — the differentially written Weyl-ordered
  Hamiltonian is the transport of a polynomial-level operator, namely the sum of the
  Weyl products `½(πᵢ Vᵢ + Vᵢ πᵢ)` of the momentum with the affine fiber field;
* `nsDiffPoly_polySym`, `nsDiffH_symmetricOn` — it is Gauss symmetric, hence symmetric
  on the Hermite core of `L²(ℝ³)`;
* `nsDiffH_selfAdjoint_extension`, `nsDiffH_selfAdjoint_extension_unique` — the
  differential operator has exactly one self-adjoint extension, its closure (no
  positivity: the strain, vorticity and constant hoppings carry arbitrary signs);
* `nsDiffH_hashimoto_selects` — **the headline**: for an arbitrary sequence of non-real
  shifts `γⱼ` the shift-inverted resolvents `Xⱼ = (γⱼ − G)⁻¹` of the differential
  Navier–Stokes generator exist, are bounded by `1/|Im γⱼ|`, share the domain of `G`,
  satisfy the resolvent identity, commute, satisfy the Hashimoto–Nodera SIRK relation,
  have strongly convergent Galerkin truncations, and each determines `G` completely;
* `nsDiffH_shiftInvert_selects` — the single-shift form;
* `nsQuadraticDiffH_hashimoto_selects` — the same with the coefficients spelled out as
  `(ν, u_{i,j}, u_{i,jj})`;
* `exists_l2dHilbertBasisNat` — non-vacuity: `L²(ℝ³)` carries an `ℕ`-indexed Hilbert
  basis (the product Hermite functions, enumerated).

## Honest boundary

Unchanged (Contention D5): the theorem is a statement about the Hilbert-space operator
at one Eulerian fiber, where the derivative fields `u_{i,j}`, `u_{i,jj}` are independent
canonical coordinates.  Nothing here claims global regularity of the classical
Navier–Stokes equation.
-/

open Filter Topology

namespace BookProof.NavierStokesFlow

namespace DiffHashimoto

open MvPolynomial
open BookProof.FarisLavine BookProof.HashimotoShiftInvert BookProof.EsaClosure
open BookProof.HermiteGalerkin
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteRelative
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

/-! ## The polynomial-level form of the differential Hamiltonian -/

/-- Gauss symmetry is preserved by finite sums. -/
theorem polySym_sum {d : ℕ} {ι : Type*} (s : Finset ι)
    (T : ι → Module.End ℂ (MvPolynomial (Fin d) ℂ))
    (hT : ∀ i ∈ s, BookProof.YangMillsHermite.PolySym (T i)) :
    BookProof.YangMillsHermite.PolySym (∑ i ∈ s, T i) := by
  classical
  induction s using Finset.induction with
  | empty =>
      intro p q
      simp
  | insert i s hi ih =>
      rw [Finset.sum_insert hi]
      exact (hT i (Finset.mem_insert_self i s)).add
        (ih fun j hj => hT j (Finset.mem_insert_of_mem hj))

/-- The identity is Gauss symmetric. -/
theorem polySym_id {d : ℕ} :
    BookProof.YangMillsHermite.PolySym (LinearMap.id (R := ℂ) (M := MvPolynomial (Fin d) ℂ)) :=
  fun _ _ => rfl

/-- **The affine fiber field on polynomial coordinates**: `Vᵢ = ∑ₖ A_{ik} uₖ + cᵢ`. -/
def fieldPoly (i : Fin 3) : Module.End ℂ (MvPolynomial (Fin 3) ℂ) :=
  (∑ k, ((A i k : ℝ) : ℂ) • mulXPoly k) + (((c i : ℝ) : ℂ) • LinearMap.id)

theorem fieldPoly_polySym (i : Fin 3) :
    BookProof.YangMillsHermite.PolySym (fieldPoly A c i) :=
  (polySym_sum _ _ fun k _ => (polySym_mulXPoly (d := 3) k).real_smul).add
    (polySym_id.real_smul)

set_option maxHeartbeats 4000000 in
-- The core operators unfold through several linear equivalences on a submodule of `L²(ℝ³)`,
-- so the default heartbeat budget is not enough.
theorem coreOp_id {d : ℕ} :
    coreOp (LinearMap.id (R := ℂ) (M := MvPolynomial (Fin d) ℂ))
      = LinearMap.id (R := ℂ) (M := (polyGaussCore (d := d))) := by
  refine LinearMap.ext fun y => ?_
  obtain ⟨p, rfl⟩ := (coreEquiv (d := d)).surjective y
  simp [coreOp_coreEquiv]

set_option maxHeartbeats 4000000 in
-- The core operators unfold through several linear equivalences on a submodule of `L²(ℝ³)`,
-- so the default heartbeat budget is not enough.
theorem coreOp_fieldPoly (i : Fin 3) : coreOp (fieldPoly A c i) = fieldOp A c i := by
  rw [fieldPoly, fieldOp, coreOp_add, coreOp_smul, coreOp_id, coreOp_sum]
  congr 1
  exact Finset.sum_congr rfl fun k _ => by rw [coreOp_smul, posOp]

/-- **The differentially written Weyl-ordered Navier–Stokes Hamiltonian on polynomial
coordinates**: `∑ᵢ ½(πᵢ Vᵢ + Vᵢ πᵢ)`. -/
def nsDiffPoly : Module.End ℂ (MvPolynomial (Fin 3) ℂ) :=
  ∑ i, BookProof.YangMillsHermite.weylProd (momPoly i) (fieldPoly A c i)

theorem nsDiffPoly_polySym : BookProof.YangMillsHermite.PolySym (nsDiffPoly A c) :=
  polySym_sum _ _ fun i _ =>
    BookProof.YangMillsHermite.weylProd_polySym (polySym_momPoly (d := 3) i)
      (fieldPoly_polySym A c i)

theorem half_cast : (((1 / 2 : ℝ) : ℂ)) = (1 : ℂ) / 2 := by norm_num

set_option maxHeartbeats 4000000 in
-- The core operators unfold through several linear equivalences on a submodule of `L²(ℝ³)`,
-- so the default heartbeat budget is not enough.
/-- The polynomial operator transports to the differential Hamiltonian. -/
theorem nsDiffH_eq_coreOp : coreOp (nsDiffPoly A c) = nsDiffH A c := by
  rw [nsDiffPoly, nsDiffH, coreOp_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [BookProof.YangMillsHermite.weylProd, coreOp_smul, coreOp_add, coreOp_comp, coreOp_comp,
    coreOp_fieldPoly, half_cast]
  rfl

/-! ## Symmetry of the differential operator -/

set_option maxHeartbeats 4000000 in
-- The core operators unfold through several linear equivalences on a submodule of `L²(ℝ³)`,
-- so the default heartbeat budget is not enough.
/-- **The differentially written Navier–Stokes Hamiltonian is symmetric on the Hermite
core of `L²(du₁du₂du₃)`** — Gaussian integration by parts, with the Weyl ordering making
the non-commuting `πV` cross terms Hermitian. -/
theorem nsDiffH_symmetricOn :
    SymmetricOn (polyGaussCore (d := 3))
      ((polyGaussCore (d := 3)).subtype.comp (nsDiffH A c)) := by
  have h := symmetricOn_of_polySym (nsDiffPoly_polySym A c)
  rwa [nsDiffH_eq_coreOp] at h

/-! ## The self-adjoint differential generator -/

set_option maxHeartbeats 4000000 in
-- The core operators unfold through several linear equivalences on a submodule of `L²(ℝ³)`,
-- so the default heartbeat budget is not enough.
/-- **The differential Navier–Stokes generator is self-adjoint on the closure of the
Hermite core.**  No positivity is used. -/
theorem nsDiffH_selfAdjoint_extension :
    ∃ (Dom : Submodule ℂ (L2d 3)) (G : Dom →ₗ[ℂ] L2d 3),
      IsSelfAdjointExtension ((polyGaussCore (d := 3)).subtype.comp (nsDiffH A c)) G :=
  exists_isSelfAdjointExtension_of_esa _ nsDiffH_domain_dense (nsDiffH_symmetricOn A c)
    (nsDiffH_essentiallySelfAdjointOn_core A c)

/-- **And it is the only one**: the differential core determines the generator. -/
theorem nsDiffH_selfAdjoint_extension_unique {Dom₁ Dom₂ : Submodule ℂ (L2d 3)}
    {G₁ : Dom₁ →ₗ[ℂ] L2d 3} {G₂ : Dom₂ →ₗ[ℂ] L2d 3}
    (h₁ : IsSelfAdjointExtension ((polyGaussCore (d := 3)).subtype.comp (nsDiffH A c)) G₁)
    (h₂ : IsSelfAdjointExtension ((polyGaussCore (d := 3)).subtype.comp (nsDiffH A c)) G₂) :
    Dom₁ = Dom₂ ∧ ∀ (x : L2d 3) (h : x ∈ Dom₁) (h' : x ∈ Dom₂), G₁ ⟨x, h⟩ = G₂ ⟨x, h'⟩ :=
  isSelfAdjointExtension_unique_of_esa (nsDiffH_essentiallySelfAdjointOn_core A c) h₁ h₂

/-! ## The Hashimoto/SIRK selection on `L²(du₁du₂du₃)` -/

set_option maxHeartbeats 4000000 in
-- The core operators unfold through several linear equivalences on a submodule of `L²(ℝ³)`,
-- so the default heartbeat budget is not enough.
/-- **The Hashimoto/SIRK shift-invert limit selects the differential Navier–Stokes
generator.**  For an arbitrary sequence of non-real shifts, the algorithm's resolvents
of the operator written with `πᵢ = −i ∂/∂uᵢ` on `L²(du₁du₂du₃)` exist, are bounded,
share the domain of the generator, satisfy the resolvent identity, commute, satisfy the
Hashimoto–Nodera SIRK relation, have strongly convergent Galerkin truncations, and each
determines the (unique) self-adjoint generator completely. -/
theorem nsDiffH_hashimoto_selects (b : HilbertBasis ℕ ℂ (L2d 3)) (γ : ℕ → ℂ)
    (hγ : ∀ j, (γ j).im ≠ 0) :
    ∃ (Dom : Submodule ℂ (L2d 3)) (G : Dom →ₗ[ℂ] L2d 3) (X : ℕ → L2d 3 →L[ℂ] L2d 3),
      IsSelfAdjointExtension ((polyGaussCore (d := 3)).subtype.comp (nsDiffH A c)) G ∧
      (∀ j, IsShiftInvertC G (γ j) (X j)) ∧
      (∀ j, ‖X j‖ ≤ |(γ j).im|⁻¹) ∧
      (∀ j, Dom = LinearMap.range ((X j : L2d 3 →ₗ[ℂ] L2d 3))) ∧
      (∀ j k u, X j u - X k u = (γ k - γ j) • X j (X k u)) ∧
      (∀ j k, X j ∘L X k = X k ∘L X j) ∧
      (∀ j m, X j ∘L (ContinuousLinearMap.id ℂ (L2d 3) - (γ m - γ j) • X m) = X m) ∧
      (∀ m v k, sirkDen (X m) (fun i => γ m - γ i) k (rkVec X v k) = (X m ^ k) v) ∧
      (∀ j u, Tendsto (fun n : ℕ => galerkinCompression (X j) b n u) atTop (nhds (X j u))) ∧
      (∀ j (Dom' : Submodule ℂ (L2d 3)) (G' : Dom' →ₗ[ℂ] L2d 3),
        IsShiftInvertC G' (γ j) (X j) →
        Dom' = Dom ∧ ∀ (x : L2d 3) (hx : x ∈ Dom) (hx' : x ∈ Dom'),
          G' ⟨x, hx'⟩ = G ⟨x, hx⟩) :=
  hashimoto_multishift_selects_esa b _ nsDiffH_domain_dense (nsDiffH_symmetricOn A c)
    (nsDiffH_essentiallySelfAdjointOn_core A c) γ hγ

set_option maxHeartbeats 4000000 in
-- The core operators unfold through several linear equivalences on a submodule of `L²(ℝ³)`,
-- so the default heartbeat budget is not enough.
/-- **The single-shift form.**  At one non-real shift `γ` the shift-inverted resolvent
`X = (γ − G)⁻¹` of the differential Navier–Stokes generator exists, is bounded by
`1/|Im γ|`, has the domain of `G` as its range, and determines `G` uniquely. -/
theorem nsDiffH_shiftInvert_selects {γ : ℂ} (hγ : γ.im ≠ 0) :
    ∃ (Dom : Submodule ℂ (L2d 3)) (G : Dom →ₗ[ℂ] L2d 3) (X : L2d 3 →L[ℂ] L2d 3),
      IsSelfAdjointExtension ((polyGaussCore (d := 3)).subtype.comp (nsDiffH A c)) G ∧
      IsShiftInvertC G γ X ∧
      ‖X‖ ≤ |γ.im|⁻¹ ∧ Dom = LinearMap.range ((X : L2d 3 →ₗ[ℂ] L2d 3)) ∧
      (∀ (Dom' : Submodule ℂ (L2d 3)) (G' : Dom' →ₗ[ℂ] L2d 3), IsShiftInvertC G' γ X →
        Dom' = Dom ∧ ∀ (x : L2d 3) (hx : x ∈ Dom) (hx' : x ∈ Dom'),
          G' ⟨x, hx'⟩ = G ⟨x, hx⟩) := by
  obtain ⟨Dom, G, hG⟩ := nsDiffH_selfAdjoint_extension A c
  obtain ⟨hext, hsym, hsa⟩ := hG
  obtain ⟨X, hX⟩ := exists_isShiftInvertC hsym hγ (cshiftMap_surjective hsym hsa hγ)
  refine ⟨Dom, G, X, ⟨hext, hsym, hsa⟩, hX, hX.opNorm_le hsym hγ, hX.dom_eq_range, ?_⟩
  intro Dom' G' hG'
  obtain ⟨hdom, hval⟩ := shiftInvertC_determines hG' hX
  exact ⟨hdom, fun x hx hx' => hval x hx' hx⟩

/-- **The Navier–Stokes reading of the coefficients.**  The same selection theorem for
`∑ᵢ ½(πᵢ Aᵢ + Aᵢ πᵢ)` with `Aᵢ(u) = ∑ⱼ (grad i j) uⱼ − ν (lap i)`. -/
theorem nsQuadraticDiffH_hashimoto_selects (nu : ℝ) (grad : Matrix (Fin 3) (Fin 3) ℝ)
    (lap : Fin 3 → ℝ) (b : HilbertBasis ℕ ℂ (L2d 3)) (γ : ℕ → ℂ) (hγ : ∀ j, (γ j).im ≠ 0) :
    ∃ (Dom : Submodule ℂ (L2d 3)) (G : Dom →ₗ[ℂ] L2d 3) (X : ℕ → L2d 3 →L[ℂ] L2d 3),
      IsSelfAdjointExtension
        ((polyGaussCore (d := 3)).subtype.comp (nsQuadraticDiffH nu grad lap)) G ∧
      (∀ j, IsShiftInvertC G (γ j) (X j)) ∧
      (∀ j, ‖X j‖ ≤ |(γ j).im|⁻¹) ∧
      (∀ j, Dom = LinearMap.range ((X j : L2d 3 →ₗ[ℂ] L2d 3))) ∧
      (∀ j u, Tendsto (fun n : ℕ => galerkinCompression (X j) b n u) atTop (nhds (X j u))) ∧
      (∀ j (Dom' : Submodule ℂ (L2d 3)) (G' : Dom' →ₗ[ℂ] L2d 3),
        IsShiftInvertC G' (γ j) (X j) →
        Dom' = Dom ∧ ∀ (x : L2d 3) (hx : x ∈ Dom) (hx' : x ∈ Dom'),
          G' ⟨x, hx'⟩ = G ⟨x, hx⟩) := by
  obtain ⟨Dom, G, X, hext, hsi, hnorm, hdom, _, _, _, _, hgal, hdet⟩ :=
    nsDiffH_hashimoto_selects grad (fun i => -(nu * lap i)) b γ hγ
  exact ⟨Dom, G, X, hext, hsi, hnorm, hdom, hgal, hdet⟩

/-! ## Non-vacuity -/

/-- `L²(ℝ³)` carries an `ℕ`-indexed Hilbert basis — the product Hermite functions,
enumerated — so the selection theorems above are not vacuous. -/
theorem exists_l2dHilbertBasisNat (e : ℕ ≃ (Fin 3 →₀ ℕ)) :
    Nonempty (HilbertBasis ℕ ℂ (L2d 3)) := by
  classical
  set b : HilbertBasis (Fin 3 →₀ ℕ) ℂ (L2d 3) := hermiteMvBasis (d := 3) with hb
  refine ⟨HilbertBasis.mk (v := fun n : ℕ => b (e n)) (b.orthonormal.comp _ e.injective) ?_⟩
  have hspan := b.dense_span
  have hrange : Set.range (fun n : ℕ => b (e n)) = Set.range (b : (Fin 3 →₀ ℕ) → L2d 3) := by
    rw [show (fun n : ℕ => b (e n)) = (b : (Fin 3 →₀ ℕ) → L2d 3) ∘ e from rfl, Set.range_comp,
      e.surjective.range_eq, Set.image_univ]
  rw [hrange]
  exact hspan.ge

/-- The Hermite multi-indices of `L²(ℝ³)` are countably infinite, so an enumeration
exists and `exists_l2dHilbertBasisNat` applies. -/
theorem exists_hermiteEnum : Nonempty (ℕ ≃ (Fin 3 →₀ ℕ)) := nonempty_equiv_of_countable

end

end DiffHashimoto

end BookProof.NavierStokesFlow
