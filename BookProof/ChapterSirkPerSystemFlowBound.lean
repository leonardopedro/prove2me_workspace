import Mathlib
import BookProof.ChapterSirkPerSystem

/-!
# Chapter SirkPerSystemFlowBound — the per-system end-to-end SIRK bound

`CONSOLIDATED_PLAN.md` §12.4 (definition of done for §12) asks, for each of the
four physical systems, for a **named theorem**

  `‖flow v − V_m ψ(B_m) V_m∗ v‖ ≤ bound(m, {z_j}, t, constants)`

with *every hypothesis discharged from the existing modules* and the constants
explicit.  §12.3 item 1 lists the systems in order (QYM, NS Lagrangian, NS
Eulerian, QG) and item 2 records the standing convention that Crouzeix's
inequality and the `e^{−hm}` deformation stay **named hypotheses with
citations**, never axioms.

The two preceding chapters supply the halves:

* `ChapterSirkEndToEnd.sirk_end_to_end` composes the pipeline with abstract
  constants;
* `ChapterSirkSpectralGeometry` identifies the Crouzeix domain `Σ` of the
  shift-invert (a real segment in the positive regime, a disc at a non-real
  shift), and `ChapterSirkPerSystem` instantiates `Σ` for every system.

What is missing — and is what this chapter adds — is the *composition of the
two*: a single named statement per system in which the selected extension, its
shift-invert, the Crouzeix domain, the Krylov transfer and the reconstruction
projection are all discharged, and the only remaining inputs are the two
Crouzeix estimates on the fixed domain.

## What is new here

* `adjoint_comp_self_of_isometry` / `norm_adjoint_apply_le_of_isometry`: the two
  adjoint hypotheses that every previous statement carried (`hVV` and `hVadj`)
  are **not** independent assumptions — they follow from `‖V x‖ = ‖x‖` alone.
  Every theorem below therefore asks only for isometry.
* `RationalScheme` / `IsSirkScheme`: the data of one order-`m` SIRK step
  (the rational approximant `p/qX`, its reduced denominator inverse, the exact
  and reduced propagators) and the hypotheses on it, bundled so that a
  per-system statement fits on a page and so that a *family* over `m` can be
  quantified for the convergence statements.
* `sirk_scheme_bound`, `sirk_scheme_tendsto`: the generic bound and its `m → ∞`
  convergence in the bundled form.
* The five per-system theorems, each of which produces the generator, its
  shift-invert and the Crouzeix domain from the project's own selection
  theorems and then states the bound and the convergence:
  `ym_sirk_flow_error_bound` / `ym_sirk_flow_error_tendsto_zero` (QYM, the
  Friedrichs route, `Σ = [0, γ⁻¹]`), `ns_sirk_flow_error_bound`,
  `nsDiff_sirk_flow_error_bound` (NS Eulerian, sequence space and differential),
  `diagKR_sirk_flow_error_bound` (NS Lagrangian, the concrete Kato–Rellich
  model), `qgR2_sirk_flow_error_bound` (QG, the `R + αR²` mode Hamiltonian),
  each at a non-real shift with `Σ` the disc of radius `|Im γ|⁻¹`.

## Honest boundary

Crouzeix's inequality and the `e^{−hm}` deformation are the fields `cxX`/`cxB`
of `IsSirkScheme`: named hypotheses, exactly as in `ChapterH4`, and stated on the
*fixed* domain `Σ` so that the constants `C` and `Dmin` do not depend on the
reduction order or on the seed.  The spectral consistency `flow = ψ(X)`
(`ChapterH4.psi_shift_eq_phi`) is likewise a hypothesis of the composition.
Nothing here claims global existence, a continuum mass gap, or anything about
floating-point arithmetic (§12.2 Gap 6; see `ChapterSirkFinitePrecision` for the
certificate layer).  The bound is permitted to depend on `t` through the
constants: the requirement of §12.2 Gap 3 is finiteness for every `t`, not
uniformity in `t`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

open Filter Topology

namespace BookProof.ChapterSirkPerSystemFlowBound

open BookProof.ChapterH4 BookProof.ChapterH6 BookProof.ChapterH9
open BookProof.ChapterSirkEndToEnd BookProof.ChapterSirkSpectralGeometry
open BookProof.ChapterSirkPerSystem
open BookProof.HashimotoShiftInvert BookProof.FarisLavine BookProof.EsaClosure
open BookProof.YangMillsFriedrichs BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.Starobinsky
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.NavierStokesFlow.IkebeKato BookProof.NavierStokesFlow.NSHashimoto
open BookProof.NavierStokesFlow.DiffHashimoto BookProof.NavierStokesFlow.DifferentialL2
open BookProof.NavierStokesFlow.LagrangianEsa BookProof.NavierStokesFlow.LagrangianKatoRellich

variable {E G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

/-! ## 0. An isometric embedding needs no extra adjoint hypotheses -/

/-- **`V∗V = 1` for an isometric embedding.**  `ChapterSirkEndToEnd` carries this
as a separate hypothesis `hVV`; it is a consequence of `‖V x‖ = ‖x‖`, because a
norm-preserving complex-linear map preserves inner products. -/
theorem adjoint_comp_self_of_isometry (V : G →L[ℂ] E) (hV : ∀ x : G, ‖V x‖ = ‖x‖) :
    V.adjoint.comp V = ContinuousLinearMap.id ℂ G := by
  set Vi : G →ₗᵢ[ℂ] E := { toLinearMap := V.toLinearMap, norm_map' := hV } with hVi
  have hinner : ∀ a b : G, (inner ℂ (V a) (V b) : ℂ) = inner ℂ a b :=
    fun a b => Vi.inner_map_map a b
  ext x
  refine ext_inner_right ℂ ?_
  intro y
  rw [ContinuousLinearMap.comp_apply, ContinuousLinearMap.adjoint_inner_left]
  simpa using hinner x y

/-- **The adjoint of an isometric embedding is a contraction.**  This is the
second hypothesis (`hVadj`) that the earlier statements carried; it too follows
from isometry. -/
theorem norm_adjoint_apply_le_of_isometry (V : G →L[ℂ] E) (hV : ∀ x : G, ‖V x‖ = ‖x‖)
    (v : E) : ‖V.adjoint v‖ ≤ ‖v‖ := by
  have hop : ‖V‖ ≤ 1 := V.opNorm_le_bound zero_le_one (fun x => by rw [hV]; simp)
  have hadj : ‖V.adjoint‖ = ‖V‖ := LinearIsometryEquiv.norm_map ContinuousLinearMap.adjoint V
  calc ‖V.adjoint v‖ ≤ ‖V.adjoint‖ * ‖v‖ := V.adjoint.le_opNorm v
    _ ≤ 1 * ‖v‖ := by rw [hadj]; exact mul_le_mul_of_nonneg_right hop (norm_nonneg _)
    _ = ‖v‖ := one_mul _

/-! ## 1. One order-`m` SIRK step, bundled -/

/-- The data of one order-`m` SIRK step: the rational approximant `p / qX` with a
left inverse `qXinv` of its denominator, the inverse `qBinv` of the reduced
denominator, and the exact and reduced propagators `psiX`, `psiB`. -/
structure RationalScheme (E G : Type*)
    [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
    [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G] where
  /-- The denominator of the rational approximant, evaluated at the generator. -/
  qX : E →L[ℂ] E
  /-- A left inverse of `qX` (the rational approximant is `p(X) qX⁻¹`). -/
  qXinv : E →L[ℂ] E
  /-- A right inverse of the compressed denominator. -/
  qBinv : G →L[ℂ] G
  /-- The numerator polynomial. -/
  p : Polynomial ℂ
  /-- The exact propagator, as a function of the shift-invert. -/
  psiX : E →L[ℂ] E
  /-- The reduced (`m × m`) propagator. -/
  psiB : G →L[ℂ] G

/-- The hypotheses of one order-`m` SIRK step against the generator `X`, the
isometric Krylov embedding `V` and the Crouzeix domain `S`.

`invX`/`invq` are the Krylov invariance of the retained subspace, `qXl`/`qBr` the
invertibility of the denominators, and `cxX`/`cxB` the two Crouzeix estimates —
the named hypotheses of `ChapterH4`, stated *conditionally on the numerical range
lying in `S`*, so that a single pair `(C, Dmin)` measured on `S` serves both. -/
structure IsSirkScheme (X : E →L[ℂ] E) (V : G →L[ℂ] E) (S : Set ℂ) (C Dmin h : ℝ) (m : ℕ)
    (s : RationalScheme E G) : Prop where
  /-- `V` is an isometric embedding of the reduced space. -/
  iso : ∀ x : G, ‖V x‖ = ‖x‖
  /-- The retained subspace is invariant under the generator. -/
  invX : ∀ x : G, ∃ y : G, X (V x) = V y
  /-- The retained subspace is invariant under the denominator. -/
  invq : ∀ x : G, ∃ y : G, s.qX (V x) = V y
  /-- `qXinv` is a left inverse of the denominator. -/
  qXl : s.qXinv.comp s.qX = ContinuousLinearMap.id ℂ E
  /-- `qBinv` is a right inverse of the compressed denominator. -/
  qBr : (compress V s.qX).comp s.qBinv = ContinuousLinearMap.id ℂ G
  /-- Crouzeix on the generator side, on the domain `S`. -/
  cxX : numRange X ⊆ S →
    ‖s.psiX - (Polynomial.aeval X s.p).comp s.qXinv‖ ≤ C * (Real.exp (-(h * m)) * Dmin)
  /-- Crouzeix on the reduced side, on the same domain `S`. -/
  cxB : numRange (compress V X) ⊆ S →
    ‖s.psiB - (Polynomial.aeval (compress V X) s.p).comp s.qBinv‖
      ≤ C * (Real.exp (-(h * m)) * Dmin)

/-- **The end-to-end bound in bundled form.**  Given the Crouzeix domain `S` of
the generator and one order-`m` scheme, the SIRK approximant is within
`sirkBound C Dmin h ‖v‖ m` of the exact propagator at any seed lying in the
retained subspace. -/
theorem sirk_scheme_bound {X : E →L[ℂ] E} {V : G →L[ℂ] E} {S : Set ℂ} {C Dmin h : ℝ} {m : ℕ}
    {s : RationalScheme E G} (hs : IsSirkScheme X V S C Dmin h m s) (hS : numRange X ⊆ S)
    (flow : E →L[ℂ] E) (hflow : flow = s.psiX) (v : E) (hv : V (V.adjoint v) = v) :
    ‖flow v - sirkApprox V s.psiB v‖ ≤ sirkBound C Dmin h ‖v‖ m :=
  sirk_end_to_end_crouzeix_domain V X s.qX s.qXinv s.qBinv s.p flow s.psiX s.psiB
    C Dmin h m S hS (adjoint_comp_self_of_isometry V hs.iso) hs.iso
    (norm_adjoint_apply_le_of_isometry V hs.iso) hs.invX hs.invq hs.qXl hs.qBr hflow
    hs.cxX hs.cxB v hv

/-- **Convergence in the reduction order, bundled form.**  If a scheme exists at
every order `m` with the *same* constants on the same Crouzeix domain, the
reduced flows converge to the exact flow at the seed. -/
theorem sirk_scheme_tendsto {X : E →L[ℂ] E} {S : Set ℂ} {C Dmin h : ℝ} (hh : 0 < h)
    (hS : numRange X ⊆ S)
    {Gm : ℕ → Type*} [∀ m, NormedAddCommGroup (Gm m)] [∀ m, InnerProductSpace ℂ (Gm m)]
    [∀ m, CompleteSpace (Gm m)]
    (V : ∀ m, Gm m →L[ℂ] E) (s : ∀ m, RationalScheme E (Gm m))
    (hs : ∀ m, IsSirkScheme X (V m) S C Dmin h m (s m))
    (flow : E →L[ℂ] E) (hflow : ∀ m, flow = (s m).psiX) (v : E)
    (hv : ∀ m, V m ((V m).adjoint v) = v) :
    Tendsto (fun m => ‖flow v - sirkApprox (V m) (s m).psiB v‖) atTop (𝓝 0) :=
  tendsto_zero_of_le_sirkBound _ C Dmin h ‖v‖ hh (fun _ => norm_nonneg _)
    (fun m => sirk_scheme_bound (hs m) hS flow (hflow m) v (hv m))

/-! ## 2. Quantum Yang–Mills: the Friedrichs route, `Σ = [0, γ⁻¹]` -/

/-- **The end-to-end SIRK bound for Quantum Yang–Mills (§12.4, QYM).**  The
Hashimoto/Galerkin scheme applied to `½Σπ² + ½ΣB²` at a positive real shift `γ`
iterates the shift-invert of the *Friedrichs* extension; its Crouzeix domain is
the real segment `[0, γ⁻¹]`, fixed by the shift alone.  For every reduction order
`m`, every isometric Krylov embedding of `ℂᵐ` and every rational scheme whose two
Crouzeix estimates hold on that segment, the SIRK approximant is within
`2C e^{−hm} Dmin ‖v‖` of the exact propagator. -/
theorem ym_sirk_flow_error_bound (e : ℕ ≃ (Fin 99 →₀ ℕ))
    (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) {γ : ℝ} (hγ : 0 < γ) :
    ∃ (Dom : Submodule ℂ (L2d 99)) (A : Dom →ₗ[ℂ] L2d 99) (R : L2d 99 →L[ℂ] L2d 99),
      IsPositiveSelfAdjointExtension (ymHamiltonian (coreRepBasis e) fabc) A ∧
        IsShiftInvert A γ R ∧ IsSelfAdjoint R ∧
        numRange R ⊆ realSegment 0 γ⁻¹ ∧
        ∀ (m : ℕ) (V : EuclideanSpace ℂ (Fin m) →L[ℂ] L2d 99)
          (s : RationalScheme (L2d 99) (EuclideanSpace ℂ (Fin m))) (C Dmin h : ℝ),
          IsSirkScheme R V (realSegment 0 γ⁻¹) C Dmin h m s →
          ∀ (flow : L2d 99 →L[ℂ] L2d 99), flow = s.psiX →
          ∀ v : L2d 99, V (V.adjoint v) = v →
            ‖flow v - sirkApprox V s.psiB v‖ ≤ sirkBound C Dmin h ‖v‖ m := by
  obtain ⟨Dom, A, R, hpsa, hR, hsa, hseg, -⟩ := ym_sirk_crouzeix_domain e fabc hγ
  exact ⟨Dom, A, R, hpsa, hR, hsa, hseg,
    fun _ _ _ _ _ _ hs flow hflow v hv => sirk_scheme_bound hs hseg flow hflow v hv⟩

/-- **Convergence of the QYM reduced flows.**  With the constants of the segment
`[0, γ⁻¹]` fixed independently of the order and a positive deformation rate `h`,
the order-`m` SIRK approximants converge to the exact propagator at the seed. -/
theorem ym_sirk_flow_error_tendsto_zero (e : ℕ ≃ (Fin 99 →₀ ℕ))
    (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) {γ : ℝ} (hγ : 0 < γ) :
    ∃ (Dom : Submodule ℂ (L2d 99)) (A : Dom →ₗ[ℂ] L2d 99) (R : L2d 99 →L[ℂ] L2d 99),
      IsPositiveSelfAdjointExtension (ymHamiltonian (coreRepBasis e) fabc) A ∧
        IsShiftInvert A γ R ∧ numRange R ⊆ realSegment 0 γ⁻¹ ∧
        ∀ (V : ∀ m : ℕ, EuclideanSpace ℂ (Fin m) →L[ℂ] L2d 99)
          (s : ∀ m : ℕ, RationalScheme (L2d 99) (EuclideanSpace ℂ (Fin m))) (C Dmin h : ℝ),
          0 < h →
          (∀ m, IsSirkScheme R (V m) (realSegment 0 γ⁻¹) C Dmin h m (s m)) →
          ∀ (flow : L2d 99 →L[ℂ] L2d 99), (∀ m, flow = (s m).psiX) →
          ∀ v : L2d 99, (∀ m, V m ((V m).adjoint v) = v) →
            Tendsto (fun m => ‖flow v - sirkApprox (V m) (s m).psiB v‖) atTop (𝓝 0) := by
  obtain ⟨Dom, A, R, hpsa, hR, -, hseg, -⟩ := ym_sirk_crouzeix_domain e fabc hγ
  exact ⟨Dom, A, R, hpsa, hR, hseg,
    fun V s _ _ _ hh hs flow hflow v hv => sirk_scheme_tendsto hh hseg V s hs flow hflow v hv⟩

/-! ## 3. Navier–Stokes, Eulerian: `Σ` a disc of radius `|Im γ|⁻¹` -/

/-- **The end-to-end SIRK bound for the Eulerian Navier–Stokes generator in
sequence space (§12.4, NS Eulerian).**  The generator is indefinite, so the
scheme runs at non-real shifts; the Crouzeix domain of the `j`-th shift-invert is
the disc of radius `|Im γ_j|⁻¹`. -/
theorem ns_sirk_flow_error_bound (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)
    (b : HilbertBasis ℕ ℂ (L2I Vel)) (γ : ℕ → ℂ) (hγ : ∀ j, (γ j).im ≠ 0) :
    ∃ (Dom : Submodule ℂ (L2I Vel)) (G : Dom →ₗ[ℂ] L2I Vel)
      (X : ℕ → L2I Vel →L[ℂ] L2I Vel),
      IsSelfAdjointExtension (velCore A c) G ∧
      (∀ j, IsShiftInvertC G (γ j) (X j)) ∧
      (∀ j, numRange (X j) ⊆ Metric.closedBall (0 : ℂ) |(γ j).im|⁻¹) ∧
      ∀ (j m : ℕ) (V : EuclideanSpace ℂ (Fin m) →L[ℂ] L2I Vel)
        (s : RationalScheme (L2I Vel) (EuclideanSpace ℂ (Fin m))) (C Dmin h : ℝ),
        IsSirkScheme (X j) V (Metric.closedBall (0 : ℂ) |(γ j).im|⁻¹) C Dmin h m s →
        ∀ (flow : L2I Vel →L[ℂ] L2I Vel), flow = s.psiX →
        ∀ v : L2I Vel, V (V.adjoint v) = v →
          ‖flow v - sirkApprox V s.psiB v‖ ≤ sirkBound C Dmin h ‖v‖ m := by
  obtain ⟨Dom, Gop, X, hext, hX, hball, -⟩ := ns_sirk_crouzeix_domain A c b γ hγ
  exact ⟨Dom, Gop, X, hext, hX, hball,
    fun j _ _ _ _ _ _ hs flow hflow v hv => sirk_scheme_bound hs (hball j) flow hflow v hv⟩

/-- **The end-to-end SIRK bound for the Eulerian Navier–Stokes generator in its
differential realization** on the Hermite core of `L²(ℝ³)`: the same disc. -/
theorem nsDiff_sirk_flow_error_bound (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)
    {γ : ℂ} (hγ : γ.im ≠ 0) :
    ∃ (Dom : Submodule ℂ (L2d 3)) (G : Dom →ₗ[ℂ] L2d 3) (X : L2d 3 →L[ℂ] L2d 3),
      IsSelfAdjointExtension ((polyGaussCore (d := 3)).subtype.comp (nsDiffH A c)) G ∧
      IsShiftInvertC G γ X ∧ ‖X‖ ≤ |γ.im|⁻¹ ∧
      numRange X ⊆ Metric.closedBall (0 : ℂ) |γ.im|⁻¹ ∧
      ∀ (m : ℕ) (V : EuclideanSpace ℂ (Fin m) →L[ℂ] L2d 3)
        (s : RationalScheme (L2d 3) (EuclideanSpace ℂ (Fin m))) (C Dmin h : ℝ),
        IsSirkScheme X V (Metric.closedBall (0 : ℂ) |γ.im|⁻¹) C Dmin h m s →
        ∀ (flow : L2d 3 →L[ℂ] L2d 3), flow = s.psiX →
        ∀ v : L2d 3, V (V.adjoint v) = v →
          ‖flow v - sirkApprox V s.psiB v‖ ≤ sirkBound C Dmin h ‖v‖ m := by
  obtain ⟨Dom, Gop, X, hext, hX, hnorm, hball, -⟩ := nsDiff_sirk_crouzeix_domain A c hγ
  exact ⟨Dom, Gop, X, hext, hX, hnorm, hball,
    fun _ _ _ _ _ _ hs flow hflow v hv => sirk_scheme_bound hs hball flow hflow v hv⟩

/-! ## 4. Navier–Stokes, Lagrangian -/

/-- **The end-to-end SIRK bound for the Lagrangian Navier–Stokes generator
(§12.4, NS Lagrangian), abstract form**: for any Lagrangian data essentially
self-adjoint on its core, at a non-real shift. -/
theorem lagrangian_sirk_flow_error_bound {F : Type*} [NormedAddCommGroup F]
    [InnerProductSpace ℂ F] [CompleteSpace F] (L : LagrangianFullData F)
    (hesa : EssentiallySelfAdjointOn L.D (lagrangianCore L)) {γ : ℂ} (hγ : γ.im ≠ 0) :
    ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F) (X : F →L[ℂ] F),
      IsSelfAdjointExtension (lagrangianCore L) A ∧ IsShiftInvertC A γ X ∧
      ‖X‖ ≤ |γ.im|⁻¹ ∧ numRange X ⊆ Metric.closedBall (0 : ℂ) |γ.im|⁻¹ ∧
      ∀ (m : ℕ) (V : EuclideanSpace ℂ (Fin m) →L[ℂ] F)
        (s : RationalScheme F (EuclideanSpace ℂ (Fin m))) (C Dmin h : ℝ),
        IsSirkScheme X V (Metric.closedBall (0 : ℂ) |γ.im|⁻¹) C Dmin h m s →
        ∀ (flow : F →L[ℂ] F), flow = s.psiX →
        ∀ v : F, V (V.adjoint v) = v →
          ‖flow v - sirkApprox V s.psiB v‖ ≤ sirkBound C Dmin h ‖v‖ m := by
  obtain ⟨Dom, A, X, hext, hX, hnorm, hball, -⟩ := lagrangian_sirk_crouzeix_domain L hesa hγ
  exact ⟨Dom, A, X, hext, hX, hnorm, hball,
    fun _ _ _ _ _ _ hs flow hflow v hv => sirk_scheme_bound hs hball flow hflow v hv⟩

/-- **The concrete Kato–Rellich instance** of the Lagrangian bound, at every
shift of the multi-shift set. -/
theorem diagKR_sirk_flow_error_bound (γ : ℕ → ℂ) (hγ : ∀ j, (γ j).im ≠ 0) :
    ∃ (Dom : Submodule ℂ L2N) (A : Dom →ₗ[ℂ] L2N) (X : ℕ → L2N →L[ℂ] L2N),
      IsSelfAdjointExtension (lagrangianCore diagKR) A ∧
      (∀ j, IsShiftInvertC A (γ j) (X j)) ∧
      (∀ j, numRange (X j) ⊆ Metric.closedBall (0 : ℂ) |(γ j).im|⁻¹) ∧
      ∀ (j m : ℕ) (V : EuclideanSpace ℂ (Fin m) →L[ℂ] L2N)
        (s : RationalScheme L2N (EuclideanSpace ℂ (Fin m))) (C Dmin h : ℝ),
        IsSirkScheme (X j) V (Metric.closedBall (0 : ℂ) |(γ j).im|⁻¹) C Dmin h m s →
        ∀ (flow : L2N →L[ℂ] L2N), flow = s.psiX →
        ∀ v : L2N, V (V.adjoint v) = v →
          ‖flow v - sirkApprox V s.psiB v‖ ≤ sirkBound C Dmin h ‖v‖ m := by
  obtain ⟨Dom, A, X, hext, hX, hball, -⟩ := diagKR_sirk_crouzeix_domain γ hγ
  exact ⟨Dom, A, X, hext, hX, hball,
    fun j _ _ _ _ _ _ hs flow hflow v hv => sirk_scheme_bound hs (hball j) flow hflow v hv⟩

/-! ## 5. Quantum gravity: the `R + αR²` mode Hamiltonian -/

/-- **The end-to-end SIRK bound for the gauge-fixed `R + αR²` quantum-gravity
mode Hamiltonian (§12.4, QG).**  The fiber symbol is two-signed, so no positivity
is available and the scheme runs at a non-real shift; the Crouzeix domain is the
disc of radius `|Im γ|⁻¹`, which is the formal counterpart of the numerics'
sensitivity to how far the shift is taken from the real axis. -/
theorem qgR2_sirk_flow_error_bound (a b : ℕ → ℝ) (M alpha : ℝ) (Rc : ℕ → ℝ)
    {γ : ℂ} (hγ : γ.im ≠ 0) :
    ∃ (Dom : Submodule ℂ L2Nat) (A : Dom →ₗ[ℂ] L2Nat) (X : L2Nat →L[ℂ] L2Nat),
      IsSelfAdjointExtension (qgR2ModeHamiltonian a b M alpha Rc) A ∧
      IsShiftInvertC A γ X ∧ ‖X‖ ≤ |γ.im|⁻¹ ∧
      numRange X ⊆ Metric.closedBall (0 : ℂ) |γ.im|⁻¹ ∧
      ∀ (m : ℕ) (V : EuclideanSpace ℂ (Fin m) →L[ℂ] L2Nat)
        (s : RationalScheme L2Nat (EuclideanSpace ℂ (Fin m))) (C Dmin h : ℝ),
        IsSirkScheme X V (Metric.closedBall (0 : ℂ) |γ.im|⁻¹) C Dmin h m s →
        ∀ (flow : L2Nat →L[ℂ] L2Nat), flow = s.psiX →
        ∀ v : L2Nat, V (V.adjoint v) = v →
          ‖flow v - sirkApprox V s.psiB v‖ ≤ sirkBound C Dmin h ‖v‖ m := by
  obtain ⟨Dom, A, X, hext, hX, hnorm, hball, -⟩ := qgR2_sirk_crouzeix_domain a b M alpha Rc hγ
  exact ⟨Dom, A, X, hext, hX, hnorm, hball,
    fun _ _ _ _ _ _ hs flow hflow v hv => sirk_scheme_bound hs hball flow hflow v hv⟩

/-- **Convergence of the QG reduced flows**, the indefinite counterpart of
`ym_sirk_flow_error_tendsto_zero`. -/
theorem qgR2_sirk_flow_error_tendsto_zero (a b : ℕ → ℝ) (M alpha : ℝ) (Rc : ℕ → ℝ)
    {γ : ℂ} (hγ : γ.im ≠ 0) :
    ∃ (Dom : Submodule ℂ L2Nat) (A : Dom →ₗ[ℂ] L2Nat) (X : L2Nat →L[ℂ] L2Nat),
      IsSelfAdjointExtension (qgR2ModeHamiltonian a b M alpha Rc) A ∧
      IsShiftInvertC A γ X ∧ numRange X ⊆ Metric.closedBall (0 : ℂ) |γ.im|⁻¹ ∧
      ∀ (V : ∀ m : ℕ, EuclideanSpace ℂ (Fin m) →L[ℂ] L2Nat)
        (s : ∀ m : ℕ, RationalScheme L2Nat (EuclideanSpace ℂ (Fin m))) (C Dmin h : ℝ),
        0 < h →
        (∀ m, IsSirkScheme X (V m) (Metric.closedBall (0 : ℂ) |γ.im|⁻¹) C Dmin h m (s m)) →
        ∀ (flow : L2Nat →L[ℂ] L2Nat), (∀ m, flow = (s m).psiX) →
        ∀ v : L2Nat, (∀ m, V m ((V m).adjoint v) = v) →
          Tendsto (fun m => ‖flow v - sirkApprox (V m) (s m).psiB v‖) atTop (𝓝 0) := by
  obtain ⟨Dom, A, X, hext, hX, -, hball, -⟩ := qgR2_sirk_crouzeix_domain a b M alpha Rc hγ
  exact ⟨Dom, A, X, hext, hX, hball,
    fun V s _ _ _ hh hs flow hflow v hv => sirk_scheme_tendsto hh hball V s hs flow hflow v hv⟩

/-! ## 6. Non-vacuity: the scheme hypotheses are satisfiable -/

/-- **`IsSirkScheme` is not vacuous.**  The trivial rational approximant
`r = X` (numerator `X`, denominator `1`) with the compression as reduced
propagator satisfies every field, for any isometric embedding whose range is
invariant under the generator and for any Crouzeix domain, with the constants
`C = Dmin = 1` and any deformation rate `h`. -/
theorem isSirkScheme_trivial (X : E →L[ℂ] E) (V : G →L[ℂ] E)
    (hViso : ∀ x : G, ‖V x‖ = ‖x‖) (hinvX : ∀ x : G, ∃ y : G, X (V x) = V y)
    (S : Set ℂ) (h : ℝ) (m : ℕ) :
    IsSirkScheme X V S 1 1 h m
      { qX := ContinuousLinearMap.id ℂ E, qXinv := ContinuousLinearMap.id ℂ E,
        qBinv := ContinuousLinearMap.id ℂ G, p := Polynomial.X,
        psiX := X, psiB := compress V X } := by
  have hVV : V.adjoint.comp V = ContinuousLinearMap.id ℂ G :=
    adjoint_comp_self_of_isometry V hViso
  have hcid : compress V (ContinuousLinearMap.id ℂ E) = ContinuousLinearMap.id ℂ G := by
    ext x; simpa using congrArg (fun f : G →L[ℂ] G => f x) hVV
  refine ⟨hViso, hinvX, fun x => ⟨x, rfl⟩, by ext x; simp, ?_, ?_, ?_⟩
  · rw [hcid]; ext x; simp
  · intro _
    have hXid : (Polynomial.aeval X (Polynomial.X : Polynomial ℂ) : E →L[ℂ] E).comp
        (ContinuousLinearMap.id ℂ E) = X := by ext x; simp
    rw [hXid, sub_self, norm_zero]
    positivity
  · intro _
    have hBid : (Polynomial.aeval (compress V X) (Polynomial.X : Polynomial ℂ) : G →L[ℂ] G).comp
        (ContinuousLinearMap.id ℂ G) = compress V X := by ext x; simp
    rw [hBid, sub_self, norm_zero]
    positivity

end BookProof.ChapterSirkPerSystemFlowBound
