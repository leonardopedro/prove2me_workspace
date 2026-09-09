import Mathlib
import BookProof.ChapterSirkPerSystem
import BookProof.ChapterNavierStokesLagrangianCanonical
import BookProof.ChapterNavierStokesFockLagrangian
import BookProof.ChapterStoneBridge

/-!
# Chapter SirkLagrangianCanonical — the two missing Lagrangian selections

`CONSOLIDATED_PLAN.md` §12.2 **Gap 2**, NS Lagrangian, lists two realizations of
the Lagrangian generator that had essential self-adjointness but **no
Hashimoto/SIRK companion**:

* the **canonical (ladder) realization** of
  `ChapterNavierStokesLagrangianCanonical`, in which the parcel momenta `Pᵢ` and
  the viscous gradients `Qᵢ` are genuinely non-commuting canonical pairs of the
  trajectory-space Hermite basis `ℓ²(Fin 3 → ℕ)` — the realization that removes
  the asymmetry of the commuting diagonal model `diagKR`; and
* the **Fock/momentum (continuum) realization** of
  `ChapterNavierStokesFockLagrangian`, where the constituents are multiplication
  operators by arbitrary measurable symbols, so the spectrum is in general purely
  continuous and there are no eigenvectors at all.

Both are `LagrangianFullData`, and both are essentially self-adjoint on their
core, so the abstract Lagrangian selection theory of
`ChapterNavierStokesLagrangianKatoRellich` applies verbatim.  This chapter draws
that consequence, for each realization:

* `lagCan_hashimoto_selects` / `fockLag_hashimoto_selects` — the multi-shift
  Hashimoto data determine one self-adjoint operator, the closure of the core
  Hamiltonian;
* `lagCan_shiftInvert_selects` / `fockLag_shiftInvert_selects` — the single-shift
  form, with `‖X‖ ≤ |Im γ|⁻¹`;
* `lagCan_sirk_crouzeix_domain` / `fockLag_sirk_crouzeix_domain` — the Crouzeix
  domain of §12.2 Gap 2: the disc of radius `|Im γ|⁻¹`, for the generator and for
  every order-`m` Krylov compression;
* `fockLag_stone_flow` — the Stone flow of the Fock/momentum realization (the
  canonical one already has `lagCan_stone_flow`).

## Honest boundary

Unchanged (Contention D5): nothing here claims global regularity of the classical
Navier–Stokes equation.  The statements are about the *selected generator* — the
unique self-adjoint operator the shift-invert data single out — and the region on
which the SIRK constants are measured.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

open MeasureTheory Filter Topology

namespace BookProof.ChapterSirkLagrangianCanonical

open BookProof.ChapterH4 BookProof.ChapterH9 BookProof.ChapterSirkSpectralGeometry
open BookProof.ChapterSirkPerSystem
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.IkebeKato
open BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin
open BookProof.NavierStokesFlow.LagrangianEsa
open BookProof.NavierStokesFlow.LagrangianKatoRellich
open BookProof.NavierStokesFlow.LagrangianCanonical
open BookProof.NavierStokesFlow.FockLagrangian

/-! ## 1. The canonical (non-commuting ladder) realization -/

variable {nu : ℝ}

/-- **The Hashimoto/SIRK selection for the canonical Lagrangian realization.**
The parcel momenta and viscous gradients are the non-commuting canonical pairs of
the trajectory-space Hermite basis; the multi-shift shift-invert data still
determine one self-adjoint operator, the closure of the core Hamiltonian. -/
theorem lagCan_hashimoto_selects (hnu : 0 < nu) (f : Fin 3 → ℝ)
    (b : HilbertBasis ℕ ℂ (L2I Vel)) (γ : ℕ → ℂ) (hγ : ∀ j, (γ j).im ≠ 0) :
    ∃ (Dom : Submodule ℂ (L2I Vel)) (A : Dom →ₗ[ℂ] L2I Vel)
      (X : ℕ → L2I Vel →L[ℂ] L2I Vel),
      IsSelfAdjointExtension (lagrangianCore (lagCanData nu hnu f)) A ∧
      (∀ j, IsShiftInvertC A (γ j) (X j)) ∧
      (∀ j, ‖X j‖ ≤ |(γ j).im|⁻¹) ∧
      (∀ j, Dom = LinearMap.range ((X j : L2I Vel →ₗ[ℂ] L2I Vel))) ∧
      (∀ j k u, X j u - X k u = (γ k - γ j) • X j (X k u)) ∧
      (∀ j k, X j ∘L X k = X k ∘L X j) ∧
      (∀ j m, X j ∘L (ContinuousLinearMap.id ℂ (L2I Vel) - (γ m - γ j) • X m) = X m) ∧
      (∀ m v k, sirkDen (X m) (fun i => γ m - γ i) k (rkVec X v k) = (X m ^ k) v) ∧
      (∀ j u, Tendsto (fun n : ℕ => galerkinCompression (X j) b n u) atTop (nhds (X j u))) ∧
      (∀ j (Dom' : Submodule ℂ (L2I Vel)) (A' : Dom' →ₗ[ℂ] L2I Vel),
        IsShiftInvertC A' (γ j) (X j) →
        Dom' = Dom ∧ ∀ (x : L2I Vel) (hx : x ∈ Dom) (hx' : x ∈ Dom'),
          A' ⟨x, hx'⟩ = A ⟨x, hx⟩) :=
  lagrangian_hashimoto_selects (lagCanData nu hnu f) (lagCan_esa nu hnu f) b γ hγ

/-- **The single-shift form** for the canonical Lagrangian realization. -/
theorem lagCan_shiftInvert_selects (hnu : 0 < nu) (f : Fin 3 → ℝ) {γ : ℂ} (hγ : γ.im ≠ 0) :
    ∃ (Dom : Submodule ℂ (L2I Vel)) (A : Dom →ₗ[ℂ] L2I Vel) (X : L2I Vel →L[ℂ] L2I Vel),
      IsSelfAdjointExtension (lagrangianCore (lagCanData nu hnu f)) A ∧
      IsShiftInvertC A γ X ∧ ‖X‖ ≤ |γ.im|⁻¹ ∧
      Dom = LinearMap.range ((X : L2I Vel →ₗ[ℂ] L2I Vel)) ∧
      (∀ (Dom' : Submodule ℂ (L2I Vel)) (A' : Dom' →ₗ[ℂ] L2I Vel), IsShiftInvertC A' γ X →
        Dom' = Dom ∧ ∀ (x : L2I Vel) (hx : x ∈ Dom) (hx' : x ∈ Dom'),
          A' ⟨x, hx'⟩ = A ⟨x, hx⟩) :=
  lagrangian_shiftInvert_selects (lagCanData nu hnu f) (lagCan_esa nu hnu f) hγ

/-- **The Crouzeix domain of the canonical Lagrangian shift-invert** (§12.2
Gap 2, NS Lagrangian, canonical realization): the disc of radius `|Im γ|⁻¹`, for
the generator and for every order-`m` Krylov compression. -/
theorem lagCan_sirk_crouzeix_domain (hnu : 0 < nu) (f : Fin 3 → ℝ) {γ : ℂ} (hγ : γ.im ≠ 0) :
    ∃ (Dom : Submodule ℂ (L2I Vel)) (A : Dom →ₗ[ℂ] L2I Vel) (X : L2I Vel →L[ℂ] L2I Vel),
      IsSelfAdjointExtension (lagrangianCore (lagCanData nu hnu f)) A ∧
      IsShiftInvertC A γ X ∧ ‖X‖ ≤ |γ.im|⁻¹ ∧
      numRange X ⊆ Metric.closedBall (0 : ℂ) |γ.im|⁻¹ ∧
      ∀ (m : ℕ) (V : EuclideanSpace ℂ (Fin m) →L[ℂ] L2I Vel), (∀ x, ‖V x‖ = ‖x‖) →
        convexHull ℝ (numRange (compress V X)) ⊆ Metric.closedBall (0 : ℂ) |γ.im|⁻¹ :=
  lagrangian_sirk_crouzeix_domain (lagCanData nu hnu f) (lagCan_esa nu hnu f) hγ

/-! ## 2. The Fock/momentum (continuum symbols) realization -/

variable {X : Type*} [MeasurableSpace X] {μ : Measure X}

/-- The Fock/momentum realization is essentially self-adjoint on its
bounded-energy core: the `EssentiallySelfAdjointOn` phrasing of
`FockLagrangian.LagSymbols.hFull_hasZeroDeficiencyOn`, which is what the
Lagrangian selection theory consumes. -/
theorem fockLag_esa (S : LagSymbols X μ) :
    EssentiallySelfAdjointOn S.data.D (lagrangianCore S.data) :=
  (essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn S.data.D S.data.hFull).mpr
    S.hFull_hasZeroDeficiencyOn

/-- **The Hashimoto/SIRK selection for the Fock/momentum realization.**  The
symbols are arbitrary measurable functions — the spectrum is in general purely
continuous, with no eigenvector at all — and the multi-shift data still determine
one self-adjoint operator. -/
theorem fockLag_hashimoto_selects (S : LagSymbols X μ) (b : HilbertBasis ℕ ℂ (Lp ℂ 2 μ))
    (γ : ℕ → ℂ) (hγ : ∀ j, (γ j).im ≠ 0) :
    ∃ (Dom : Submodule ℂ (Lp ℂ 2 μ)) (A : Dom →ₗ[ℂ] Lp ℂ 2 μ)
      (Xop : ℕ → Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ),
      IsSelfAdjointExtension (lagrangianCore S.data) A ∧
      (∀ j, IsShiftInvertC A (γ j) (Xop j)) ∧
      (∀ j, ‖Xop j‖ ≤ |(γ j).im|⁻¹) ∧
      (∀ j, Dom = LinearMap.range ((Xop j : Lp ℂ 2 μ →ₗ[ℂ] Lp ℂ 2 μ))) ∧
      (∀ j k u, Xop j u - Xop k u = (γ k - γ j) • Xop j (Xop k u)) ∧
      (∀ j k, Xop j ∘L Xop k = Xop k ∘L Xop j) ∧
      (∀ j m, Xop j ∘L (ContinuousLinearMap.id ℂ (Lp ℂ 2 μ) - (γ m - γ j) • Xop m) = Xop m) ∧
      (∀ m v k, sirkDen (Xop m) (fun i => γ m - γ i) k (rkVec Xop v k) = (Xop m ^ k) v) ∧
      (∀ j u, Tendsto (fun n : ℕ => galerkinCompression (Xop j) b n u) atTop
        (nhds (Xop j u))) ∧
      (∀ j (Dom' : Submodule ℂ (Lp ℂ 2 μ)) (A' : Dom' →ₗ[ℂ] Lp ℂ 2 μ),
        IsShiftInvertC A' (γ j) (Xop j) →
        Dom' = Dom ∧ ∀ (x : Lp ℂ 2 μ) (hx : x ∈ Dom) (hx' : x ∈ Dom'),
          A' ⟨x, hx'⟩ = A ⟨x, hx⟩) :=
  lagrangian_hashimoto_selects S.data (fockLag_esa S) b γ hγ

/-- **The single-shift form** for the Fock/momentum realization. -/
theorem fockLag_shiftInvert_selects (S : LagSymbols X μ) {γ : ℂ} (hγ : γ.im ≠ 0) :
    ∃ (Dom : Submodule ℂ (Lp ℂ 2 μ)) (A : Dom →ₗ[ℂ] Lp ℂ 2 μ)
      (Xop : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ),
      IsSelfAdjointExtension (lagrangianCore S.data) A ∧
      IsShiftInvertC A γ Xop ∧ ‖Xop‖ ≤ |γ.im|⁻¹ ∧
      Dom = LinearMap.range ((Xop : Lp ℂ 2 μ →ₗ[ℂ] Lp ℂ 2 μ)) ∧
      (∀ (Dom' : Submodule ℂ (Lp ℂ 2 μ)) (A' : Dom' →ₗ[ℂ] Lp ℂ 2 μ), IsShiftInvertC A' γ Xop →
        Dom' = Dom ∧ ∀ (x : Lp ℂ 2 μ) (hx : x ∈ Dom) (hx' : x ∈ Dom'),
          A' ⟨x, hx'⟩ = A ⟨x, hx⟩) :=
  lagrangian_shiftInvert_selects S.data (fockLag_esa S) hγ

/-- **The Crouzeix domain of the Fock/momentum Lagrangian shift-invert** (§12.2
Gap 2, NS Lagrangian, continuum realization): the disc of radius `|Im γ|⁻¹`. -/
theorem fockLag_sirk_crouzeix_domain (S : LagSymbols X μ) {γ : ℂ} (hγ : γ.im ≠ 0) :
    ∃ (Dom : Submodule ℂ (Lp ℂ 2 μ)) (A : Dom →ₗ[ℂ] Lp ℂ 2 μ)
      (Xop : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ),
      IsSelfAdjointExtension (lagrangianCore S.data) A ∧
      IsShiftInvertC A γ Xop ∧ ‖Xop‖ ≤ |γ.im|⁻¹ ∧
      numRange Xop ⊆ Metric.closedBall (0 : ℂ) |γ.im|⁻¹ ∧
      ∀ (m : ℕ) (V : EuclideanSpace ℂ (Fin m) →L[ℂ] Lp ℂ 2 μ), (∀ x, ‖V x‖ = ‖x‖) →
        convexHull ℝ (numRange (compress V Xop)) ⊆ Metric.closedBall (0 : ℂ) |γ.im|⁻¹ :=
  lagrangian_sirk_crouzeix_domain S.data (fockLag_esa S) hγ

/-- **The Stone flow of the Fock/momentum Lagrangian generator**: the selected
extension generates a complete unitary flow, so the reliability chain has a
continuous flow to compare the algorithm with in this realization too. -/
theorem fockLag_stone_flow (S : LagSymbols X μ) :
    ∃ (T : UnboundedSelfAdjoint (Lp ℂ 2 μ)) (U : ℝ → (Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ)),
      IsSelfAdjointExtension (lagrangianCore S.data) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa (lagrangianCore S.data) S.data.dense
    (lagrangianCore_symmetricOn S.data) (fockLag_esa S)

end BookProof.ChapterSirkLagrangianCanonical
