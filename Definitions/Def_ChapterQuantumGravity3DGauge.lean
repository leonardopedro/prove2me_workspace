import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterQuantumGravityDensitized
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsFriedrichs
import Mathlib


/-!
# The concrete 3D gauge-fixed gravity Hamiltonian on the Gauss–polynomial core of `L²(ℝ⁸⁴)`

`CONSOLIDATED_PLAN.md` §10.6.2 item 4 (and `PLAN_LEAN_SPECIALIST_QG_FLOW.md` **Part F**,
items F.1–F.5 and F.8) asks for the *concrete* field-space realization of the manuscript's
3D gauge-fixed gravity Hamiltonian: densitized, Weyl-ordered, written with genuine
multiplication and differentiation operators on a dense core of `L²(ℝ⁸⁴)` — the gravity
analogue of `BookProof/ChapterYangMillsHermite.lean`, whose polynomial-level machinery
(`mulOp`, `momOp`, `weylProd`, `CoreRep`) is reused verbatim here.

The ghost sector (`ℤ₂¹⁹`), the BRST charge and its nilpotency (F.6, F.7) are the companion
module `BookProof/ChapterQuantumGravityBrstCharge.lean`.

## The coordinates of `ℝ⁸⁴`

`84 = 4 + 16 + 64`: the four spacetime coordinates `x^μ`, the sixteen tetrad fields
`e_μ^a`, and the sixty-four independent derivative coordinates `∂_μ e_ν^a`
(`idxX`, `idxE`, `idxDE`, with the injectivity and disjointness lemmas that make them a
genuine coordinate system).

**Non-ADM note (book.tex ~8226–8244).**  The three-dimensional reduction of record fixes
the globally defined time-like vector `v^μ = δ^μ_0`; it is **not** the ADM formalism
(the constraints differ; ADM is only weakly hyperbolic).  Diffeomorphisms conserve
`v^μ = δ^μ_0`, so the BRST ghosts of the reduction are **constant in the timepiece**,
and the charge keeps the same functional form as the 4D one — see
`BookProof/ChapterQuantumGravityBrstCharge.lean` and `Book/Starobinsky.lean`
(gauge-fixing fermion `{G, i b_j A_0^j}`).  The coordinate set `ℝ⁸⁴` above is the full
4D field content carried on the reduced phase space, **not** an ADM spatial-metric
truncation.

## What is proved

**F.1 — the singular density and its absorption.**  `qg3DDensity` is the manuscript's
Hamiltonian density `(1/(16 e))𝒮² − (1/(24 e))𝒫²` with its `1/e = 1/det e_i^a`
degeneracy; `qg3DDensity_singular` records that the coefficient really diverges as the
tetrad degenerates, and `qg3DDensity_densitized` that in the densitized variables
`S̃ = 𝒮/y`, `P̃ = 𝒫/y` (`y = √e`, Part A of the QG plan) the density becomes the
**constant-coefficient** expression `(1/16)S̃² − (1/24)P̃²` — the two-signed signature
`qgKappa` that the operator below carries.

**F.3, F.4 — the canonical structure.**  `qgCoord`/`qgMom` are the coordinate and momentum
operators on the core; `ccr_poly` is the full canonical commutation relation
`[x_j, π_k] = i δ_{jk}` at polynomial level (both the diagonal and, what the gravity CCR
`[e_μ^a, π^ν_b] = i δ^ν_μ δ^a_b` needs, the *vanishing* of the off-diagonal brackets), and
`qgCCR`/`qgCCR_tetrad` are its transports to the core.  `qgWeylProd` is the Weyl ordering
`½(PQ + QP)` of the non-commuting cross terms, symmetric on the core
(`qgWeylProd_symmetricOn`), and `commute_mom_mom` records that the momenta commute among
themselves, so no ordering ambiguity arises in the kinetic term.

**F.2, F.5 — the Hamiltonian.**  `signedOp` is the *two-signed* sum of squares
`½ Σ_j κ_j π_j² + ½ Σ_A V_A²` — the gravity analogue of `weylOp`, which the hyperbolic
signature `(1/16, −1/24)` of the densitized kinetic term forces: `signedOp_symmetricOn`
(symmetric for every real signature), `signedOp_quadForm` (the quadratic form is the
signed sum of squares `½ Σ κ_j ‖π_j x‖² + ½ Σ ‖V_A x‖²`) and `signedOp_quadForm_nonneg`
(positive exactly when the signature is nonnegative).  `qg3DHamiltonian` is the physical
instance with `qgKappa` and the torsion-type potential `torsionPoly`, `qg3D_symmetricOn`
and `qg3D_quadForm` its symmetry and quadratic form.

**F.8 — Friedrichs and Hashimoto, for the elliptic sector.**
`qg3DEllipticHamiltonian` is the same operator with the conformal direction removed
(`qgKappaElliptic ≥ 0`); `qg3DElliptic_friedrichs_extension` and
`qg3DElliptic_hashimoto_selects` instantiate the project's Friedrichs-extension and
shift-invert selection theorems on it.

## Honest boundary

The physical signature is **hyperbolic**: `qgKappa` is negative in the conformal direction
(`qgKappa_conformal_neg`), so `signedOp_quadForm_nonneg` does *not* apply to
`qg3DHamiltonian` and no Friedrichs extension is claimed for it — that is exactly the
two-signed residue recorded in `CONSOLIDATED_PLAN.md` §10.3 (`qgSymbol_indefinite` of
`ChapterQuantumGravityDensitized` is the symbol-level form of the same fact).  What is
claimed for the full two-signed operator is that it is a well-defined **symmetric**
operator on the dense Gauss–polynomial core with the stated quadratic form; the selection
of a y ShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

/-! ## F.1 — the singular Hamiltonian density and the densitized form -/

/-- The manuscript's 3D gravity Hamiltonian density,
`ℋ = (1/(16 e)) 𝒮² − (1/(24 e)) 𝒫²`, with the tetrad determinant `e = det e_i^a` in the
denominator: it is *not* defined where the tetrad degenerates. -/
def qg3DDensity (e s p : ℝ) : ℝ := 1 / (16 * e) * s ^ 2 - 1 / (24 * e) * p ^ 2

/-- **The singularity is real**: the coefficient of the kinetic terms diverges as the
tetrad determinant degenerates. -/
theorem qg3DDensity_singular dconsity_densitized (e s p : ℝ) (he : 0 < e) :
    qg3DDensity e s p = 1 / 16 * (s / densY e) ^ 2 - 1 / 24 * (p / densY e) ^ 2 := by
  rw [qg3DDensity, k4 := ⟨4 + 4 * mu.val + a.val, by omega⟩

/-- The coordinate index of the independent derivative coordinate `∂_μ e_ν^a`. -/
def idxDE (mu nu a : Fin 4) : Fin ed gravity Hamiltonian on the Gauss–polynomial core of `L²(ℝ⁸⁴)`

`CONSOLIDATED_PLAN.md` §10.6.2 item 4 (and `PLAN_LEAN_SPECIALIST_QG_FLOW.md` **Part F**,
items F.1–F.5 and F.8) asks for the *concrete* field-space realization of the manuscript's
3D gauge-fixed gravity Hamiltonian: densitized, Weyl-ordered, written with genuine
multiplication and differentiation operators on a dense core of `L²(ℝ⁸⁴)` — the gravity
analogue of `BookProof/ChapterYangMillsHermite.lean`, whose polynomial-level machinery
(`mulOp`, `momOp`, `weylProd`, `CoreRep`) is reused verbatim here.

The ghost sector (`ℤ₂¹⁹`), the BRST charge and its nilpotency (F.6, F.7) are the companion
module `BookProof/ChapterQuantumGravityBrstCharge.lean`.

## The coordinates of `ℝ⁸⁴`

`84 = 4 + 16 + 64`: the four spacetime coordinates `x^μ`, the sixteen tetrad fields
`e_μ^a`, and the sixty-four independent derivative coordinates `∂_μ e_ν^a`
(`idxX`, `idxE`, `idxDE`, with the injectivity and disjointness lemmas that make them a
genuine coordinate system).

**Non-ADM note (book.tex ~8226–8244).**  The three-dimensional reduction of record fixes
the globally defined time-like vector `v^μ = δ^μ_0`; it is **not** the ADM formalism
(the constraints differ; ADM is only weakly hyperbolic).  Diffeomorphisms conserve
`v^μ = δ^μ_0`, so the BRST ghosts of the reduction are **constant in the timepiece**,
and the charge keeps the same functional form as the 4D one — see
`BookProof/ChapterQuantumGravityBrstCharge.lean` and `Book/Starobinsky.lean`
(gauge-fixing fermion `{G, i b_j A_0^j}`).  The coordinate set `ℝ⁸⁴` above is the full
4D field content carried on the reduced phase space, **not** an ADM spatial-metric
truncation.

## What is proved

**F.1 — the singular density and its absorption.**  `qg3DDensity` is the manuscript's
Hamiltonian density `(1/(16 e))𝒮² − (1/(24 e))𝒫²` with its `1/e = 1/det e_i^a`
degeneracy; `qg3DDensity_singular` records that the coefficient really diverges as the
tetrad degenerates, and `qg3DDensity_densitized` that in the densitized variables
`S̃ = 𝒮/y`, `P̃ = 𝒫/y` (`y = √e`, Part A of the QG plan) the density becomes the
**constant-coefficient** expression `(1/16)S̃² − (1/24)P̃²` — the two-signed signature
`qgKappa` that the operator below carries.

**F.3, F.4 — the canonical structure.**  `qgCoord`/`qgMom` are the coordinate and momentum
operators on the core; `ccr_poly` is the full canonical commutation relation
`[x_j, π_k] = i δ_{jk}` at polynomial level (both the diagonal and, what the gravity CCR
`[e_μ^a, π^ν_b] = i δ^ν_μ δ^a_b` needs, the *vanishing* of the off-diagonal brackets), and
`qgCCR`/`qgCCR_tetrad` are its transports to the core.  `qgWeylProd` is the Weyl ordering
`½(PQ + QP)` of the non-commuting cross terms, symmetric on the core
(`qgWeylProd_symmetricOn`), and `commute_mom_mom` records that the momenta commute among
themselves, so no ordering ambiguity arises in the kinetic term.

**F.2, F.5 — the Hamiltonian.**  `signedOp` is the *two-signed* sum of squares
`½ Σ_j κ_j π_j² + ½ Σ_A V_A²` — the gravity analogue of `weylOp`, which the hyperbolic
signature `(1/16, −1/24)` of the densitized kinetic term forces: `signedOp_symmetricOn`
(symmetric for every real signature), `signedOp_quadForm` (the quadratic form is the
signed sum of squares `½ Σ κ_j ‖π_j x‖² + ½ Σ ‖V_A x‖²`) and `signedOp_quadForm_nonneg`
(positive exactly when the signature is nonnegative).  `qg3DHamiltonian` is the physical
instance with `qgKappa` and the torsion-type potential `torsionPoly`, `qg3D_symmetricOn`
and `qg3D_quadForm` its symmetry and quadratic form.

**F.8 — Friedrichs and Hashimoto, for the elliptic sector.**
`qg3DEllipticHamiltonian` is the same operator with the conformal direction removed
(`qgKappaElliptic ≥ 0`); `qg3DElliptic_friedrichs_extension` and
`qg3DElliptic_hashimoto_selects` instantiate the project's Friedrichs-extension and
shift-invert selection theorems on it.

## Honest boundary

The physical signature is **hyperbolic**: `qgKappa` is negative in the conformal direction
(`qgKappa_conformal_neg`), so `signedOp_quadForm_nonneg` does *not* apply to
`qg3DHamiltonian` and no Friedrichs extension is claimed for it — that is exactly the
two-signed residue recorded in `CONSOLIDATED_PLAN.md` §10.3 (`qgSymbol_indefinite` of
`ChapterQuantumGravityDensitized` is the symbol-level form of the same fact).  What is
claimed for the full two-signed operator is that it is a well-defined **symmetric**
operator on the dense Gauss–polynomial core with the stated quadratic form; the selection
of a self-adjoint extension is claimed only for the elliptic sector.  No mass gap, no
global existence, and no continuum `L²(ℝ⁸⁴)` essential self-adjointness statement is
claimed anywhere.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.QuantumGravity3DGauge

open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

/-! ## F.1 — the singular Hamiltonian density and the densitized form -/

/-- The manuscript's 3D gravity Hamiltonian density,
`ℋ = (1/(16 e)) 𝒮² − (1/(24 e)) 𝒫²`, with the tetrad determinant `e = det e_i^a` in the
denominator: it is *not* defined where the tetrad degenerates. -/
def qg3DDensity (e s p : ℝ) : ℝ := 1 / (16 * e) * s ^ 2 - 1 / (24 * e) * p ^ 2

/-- **The singularity is real**: the coefficient of the kinetic terms diverges as the
tetrad determinant degenerates. -/
theorem qg3DDensity_singular : Tendsto (fun e : ℝ => 1 / e) (𝓝[>] (0 : ℝ)) atTop :=
  tendsto_inv_det_atTop

/-- **The densitized form of the density (F.2).**  In the densitized variables
`S̃ = 𝒮/y`, `P̃ = 𝒫/y` with `y = √e`, the `1/e`-singular density becomes the
constant-coefficient expression `(1/16) S̃² − (1/24) P̃²`: the coefficients are exactly
the two-signed signature `qgKappa` of the field-space operator below. -/
theorem qg3DDensity_densitized (e s p : ℝ) (he : 0 < e) :
    qg3DDensity e s p = 1 / 16 * (s / densY e) ^ 2 - 1 / 24 * (p / densY e) ^ 2 := by
  rw [qg3DDensity, kinetic_absorption e s he, conformal_absorption e p he]

/-! ## The coordinates of `ℝ⁸⁴` -/

/-- The coordinate index of the spacetime coordinate `x^μ`. -/
def idxX (mu : Fin 4) : Fin 84 := ⟨mu.val, by omega⟩

/-- The coordinate index of the tetrad field `e_μ^a`. -/
def idxE (mu a : Fin 4) : Fin 84 := ⟨4 + 4 * mu.val + a.val, by omega⟩

/-- The coordinate index of the independent derivative coordinate `∂_μ e_ν^a`. -/
def idxDE (mu nu a : Fin 4) : Fin 84 := ⟨20 + 16 * mu.val + 4 * nu.val + a.val, by omega⟩

theorem idxX_injective : Function.Injective idxX := by
  intro mu mu' h
  have := congrArg Fin.val h
  simp only [idxX] at this
  exact Fin.ext this

theorem idxE_injep njg Fin.val h
  simp only [idxDE] at h'
  have hmu : mu.val = mu'.val := by omega
  have hnu : nu.v *d_Mvk ap_sub, map_smul, hjk, hkj, hcomm]
  simOomial (Fin d) ℂ) :
    mulOp f (mulOp g p) = mulOp g (mulOp f p) := by
  simp only [mulOp_apply]; ring

/-! ## F.4 — the Weyl ordering -/

/-- **The Weyl ordering** `½(PQ + QP)` of two operators on the core, the ordering
prescription for the non-commuting `π e` cross terms of the gravity Hamiltonian. -/
def qgWeylProd (S T : Module.End ℂ (MvPolynomial (Fin d) ℂ)) :
    Module.End ℂ (MvPolynomial (Fin d) ℂ) := weylProd S T

/-- **The Weyl-ordered product of two symmetric operators is symmetric

section Signed

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

/-- **The two-signed sum of squares** `½ Σ_j κ_j π_j² + ½ Σ_A V_A²` on a domain.  The
gravity analogue of `BookProof.YangMillsFriedrichs.weylOpDom`: the densitized gravity
kinetic term has the *hyperbolic* signature `(1/16, −1/24)`, so the coefficients `κ` are
arbitrary reals rather than all `1`. -/
def signedOpDom {n m : ℕ} (kappa : Fin n → ℝ) (pi : Fin n → D →ₗ[ℂ] D)
    (Bf : Fin m → D →ₗ[ℂ] D) : D →ₗ[ℂ] D :=
  ((1 / 2 : ℝ) : ℂ) •
    ((∑ i, ((kappa i : ℝ) ne* peharescaled momenwhat
turns the polynomial canonical commutation relations into the operator ones. -/
theorem coreRep_commutator {D : Submo :=on m ))Φ (idxE mu a) x)
      = (if mu = nu ∧ a =   epmund the potential -/

/-- The **conformal direction** of the densitized field space: the coordinate `y = √e`.
It is the direction in which the densitized kinetic term carries the opposite sign. -/
def confIndex : Fin 84 := idxX 0

/-- **The hyperbolic signature of the densitized gravity kinetic term**: `1/16` in every
direction except the conformal one, where it is `−1/24` (F.2, from
`qg3DDensity_densostwo-signed** — the field-space form of `qgSymbol_indefinite`: no
choice of ordering makes the densitized gravity kinetic term a positive sum of squares. -/
theorem qgKappa_indefinite : (∃ j, 0 < qgKappa j) ∧ ∃ j, qgKappa j < 0 :=
  ⟨⟨idxE 0 0, qgKappa_spatial_pos (by simpa [confIndex] using (idxX_ne_idxE 0 0 0).symm)⟩,
    ⟨confIndex, qgKappa_conformal_neg⟩⟩

/-- The **elliptic signature**: the same operator with the conformal direction removed —
the sector to which the Friedrichs machinery applies. -/
def qgKappaElliptic (_j : Fin 84) : ℝ := 1 / 16

theorem qgKappaElliptic_nonneg (j : Fin 84) : 0 ≤ qgKappaElliptic j := by
  norm_num [qgKappaElliptic]

/-- The **torsion-type potential** of the densitized fiehe) arP_sub, starP_X, starP_X]
  exact h

/-- The torsion is antisymmetric in its twcOn (Φ : CoreRep 84 D) (m : Fin 64) :
    SymmetricOn D (D.subtype.comp (torsionOps Φ m)) :=
  Φ.symmetricOn_op (mulOp_polySym (realCoeff_torsionPoly _ _ _))

/-! ### F.2, F.5 — the Hamiltonian, its symmetry and its quadratic form -/

/-- **The concrete 3D gauge-fixed gravity Hamiltonian on the Gauss–polynomial core of
`L²(ℝ⁸⁴)`** (F.2): the densiti 8icOn D (qg3DHamiltonian Φ) :=
  signedOp_symmetricOn (qgMom_symmetricOn Φ) (torsionOpsorignedOp_quadForm (qgMom_symmetricOn Φ) (torsionOps_symmetricOn Φ) x

/-! ### F.8 — the elliptic sector: Friedrichs extension and Hashimoto selection -/

/-- **The elliptic sector of the gravity Hamiltonian**: the same field-sp (g j)  Compression R (coreBasis e) k u)
          Filter.atTop (nhds (R u))) ∧
        (∀ (Dom' : Submodule ℂ (L2d 84)) (A' : Dom' →ₗ[ℂ] L2d 84),
          IsShiftInvert A' γ R → Dom' = Dom) := by
  rw [qg3DElliptic_eq_weylOp]
  exact weyl_hashimoto_selects_friedrichs (coreBasis e)
    (qgMomScaled_symmetricOn (coreRepBasis e)) (torsionOps_symmetricOn (coreRepBasis e)) hγ

/-- A concrete enumeration of the monomials of `ℂ[X₀,…,X₈₃]`, so that
`qg3DElliptic_hashimoto_selects` is not vacuous. -/
def qgEnum : ℕ ≃ (Fin 84 →₀ ℕ) :=
  letI : Denumerable (Fin 84 →₀ ℕ) := Denumerable.ofEncodableOfInfinite _
  (Denumerable.eqv (Fin 84 →₀ ℕ)).symm

end Gravity

end

end BookProof.QuantumGravity3DGauge
