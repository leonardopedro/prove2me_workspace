import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterYangMillsHermite
import Mathlib


/-!
# The nonlinear Navier–Stokes Koopman generator and the Faris–Lavine criterion

The operator is the Koopman–von Neumann generator of `ChapterNsKoopman`,

```
H_NS = ½ Σ_m (π_m F_m + F_m π_m),      F_m(u) = −ν λ_m u_m + Σ_{j,k} b_{mjk} u_j u_k ,
```

with the **exact quadratic advection** `B(u,u)`: no linearization and no perturbative
splitting.  The coefficients `b_{mjk}` are the momentum-space (convolution) form of
`(u·∇)u` followed by the Leray projection.  The spatial derivative becomes the symbol `i k`, and
the product `u_j ∂_j u_m` becomes the triad convolution `Σ_{p+q=k} i (û_p · q) û_q`
(`NsAdvectionConvolution.fourier_advection_convolution`).  The only properties of the
coefficients used are the two structural identities recorded in `NsSystem`: Leray's energy
identity `Σ_m u_m B_m(u,u) = 0` and the Liouville identity `div_u B = 0`.

## The comparison operator

The Faris–Lavine criterion needs a positive `N` with `𝒟(N) ⊆ 𝒟(H)` and `±i[H,N] ≤ cN`.  The
Leray energy `E = 1 + ‖u‖²` has the right commutator, since `i[H_NS, E] = −2ν Σ λ_m u_m²` and the
advection drops out by Leray's identity (`NsKoopman.commForm_kvn_energy_bound`).  But `E` does not
dominate the first-order operator `H_NS`.  This module takes

```
N_NS := H_NS² + E = H_NS² + 1 + ‖u‖² .
```

It is positive, and its form is `⟪x, N x⟫ = ‖H x‖² + ⟪x, E x⟫ ≥ ‖x‖²`
(`nsSquareComparison_quadForm`).  It dominates `H_NS`: `‖H x‖ ≤ ‖N x‖ + ‖x‖`
(`nsSquareComparison_relBound`).  Its commutation relation with `H_NS` is exact:
`H_NS` commutes with `H_NS²`, so

```
⟪x, i[H_NS, N_NS] x⟫ = ⟪x, i[H_NS, E] x⟫ = ⟪x, (−2ν Σ λ_m u_m²) x⟫
|⟪x, i[H_NS, N_NS] x⟫| ≤ 2νΛ ⟪x, N_NS x⟫
```

(`nsSquareComparison_commForm`, `nsSquareComparison_commForm_bound`).  Here `Λ` bounds the
Stokes eigenvalues `λ_m = |k_m|²`.  All of this holds on the Gauss–polynomial core, for the full
nonlinear operator.

## The conclusion

`nsKoopman_esa_of_squareComparison_esa`: **if `N_NS` is essentially self-adjoint on the core,
then so is the nonlinear Navier–Stokes generator `H_NS`.**  The proof is the core form of
Faris–Lavine, `FarisLavine.essentiallySelfAdjointOn_of_square_comparison`.

## Honest boundary

* The one input that is **not** proved is the essential self-adjointness of `N_NS` itself
  (equivalently, since `N_NS ≥ 1`, density of `(N_NS + 1)` applied to the core).  It is carried
  as an explicit hypothesis.  This is a genuine reduction, not a proof of essential
  self-adjointness of `H_NS`.  The commutator part of Faris–Lavine is fully discharged, and what
  is left is the self-adjointness of the positive operator `N_NS`.
* Why no simpler `N` was used: a comparison operator for a first-order generator must be
  invariant under the classical flow up to a bounded exponential rate, in both time directions.
  For a polynomial `N` built from `u` and `π`, the quadratic advection makes the
  linearized flow stretch the momenta at a rate proportional to `|u|`, which is unbounded.
  So no polynomial in `u`, `π` of the harmonic-oscillator type satisfies `±i[H,N] ≤ cN`.  The
  invariant `H_NS` itself, plus the energy, is the algebraic choice that does.  This argument
  is informal and is not formalized here.
* The constant `2νΛ` depends on the largest Stokes eigenvalue kept.  With **all** Fourier modes
  (no truncation) the commutator `2ν Σ |k|² |û_k|²` is not bounded by any multiple of
  `1 + ‖u‖²`.  This reflects the fact that viscous Navier–Stokes is not well posed backward in
  time, so a unitary (two-sided) Koopman group cannot be expected in infinite dimensions.  The
  statements here are for every finite set of modes, with the exact nonlinearity on those modes.
-/

/-! ## Embedded `BookProof.NsKoopman` core

There is no `Definitions.Def_ChapterNsKoopman` bundle, so the handful of declarations these
bundles consume from `BookProof.ChapterNsKoopman.Part1/Part2` are embedded verbatim here
(they need only Mathlib plus `Def_ChapterYangMillsHermite` / `Def_ChapterHermiteProductCore`,
both already imported).  `Def_ChapterNsLinearKoopmanEsa` imports this bundle in turn.  Only
definitions are embedded — every lemma that lives in the source `ChapterNsKoopman` files and
is referenced from these two bundles does so from a docstring alone. -/

namespace BookProof.NsKoopman

open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite

noncomputable section

variable {d : ℕ}

/-- The advection field `B_i(u,u) = Σ_{j,k} b_{ijk} u_j u_k` of a Galerkin form of the
incompressible Navier–Stokes equation: the exact quadratic term, with the pressure already
eliminated by the Leray projection. -/
def advOf (b : Fin d → Fin d → Fin d → ℝ) (i : Fin d) : MvPolynomial (Fin d) ℂ :=
  ∑ j, ∑ k, ((b i j k : ℝ) : ℂ) • (X j * X k)

/-- **The mainstream incompressible Navier–Stokes system** in the functional form
`u̇ = −νAu + B(u,u)`: `nu` is the viscosity, `lam i = |k_i|²` the Stokes eigenvalues in the
divergence-free Fourier basis, and `bcoef` the structure constants of the exact quadratic
advection.  `leray` and `liouville` are the two structural identities of the incompressible
equation. -/
structure NsSystem (d : ℕ) where
  /-- The kinematic viscosity `ν`. -/
  nu : ℝ
  /-- The Stokes eigenvalues `λ_i = |k_i|²`. -/
  lam : Fin d → ℝ
  /-- The structure constants of the advection `B_i(u,u) = Σ_{j,k} b_{ijk}u_ju_k`. -/
  bcoef : Fin d → Fin d → Fin d → ℝ
  nu_nonneg : 0 ≤ nu
  lam_nonneg : ∀ i, 0 ≤ lam i
  /-- **Leray's energy identity** `⟨u, B(u,u)⟩ = 0`. -/
  leray : ∑ i, X i * advOf bcoef i = (0 : MvPolynomial (Fin d) ℂ)
  /-- **The Liouville identity** `div_u B = 0`. -/
  liouville : ∑ i, pderiv i (advOf bcoef i) = (0 : MvPolynomial (Fin d) ℂ)

variable (S : NsSystem d)

/-- The **drift field** `F_i(u) = −ν λ_i u_i + B_i(u,u)` of the mainstream system. -/
def drift (i : Fin d) : MvPolynomial (Fin d) ℂ :=
  -(((S.nu * S.lam i : ℝ) : ℂ) • X i) + advOf S.bcoef i

/-- The **Navier–Stokes Hamiltonian** `H_NS = ½ Σ_m (π_m F_m + F_m π_m)`: the Weyl-ordered
Koopman–von Neumann generator of the mainstream Navier–Stokes flow. -/
def kvnPoly : Module.End ℂ (MvPolynomial (Fin d) ℂ) :=
  ∑ i, weylProd (momOp i) (mulOp (drift S i))

/-- The **Leray energy** `E(u) = 1 + ‖u‖²`, the comparison observable. -/
def energyPoly (d : ℕ) : MvPolynomial (Fin d) ℂ := 1 + ∑ i, X i * X i

/-- **The comparison operator `N_E`**: multiplication by the Leray energy. -/
def energyOp (d : ℕ) : Module.End ℂ (MvPolynomial (Fin d) ℂ) := mulOp (energyPoly d)

/-- **The Navier–Stokes Hamiltonian on the Gauss–polynomial core of `L²(ℝᵈ)`.** -/
def nsKoopmanOp : (polyGaussCore (d := d)) →ₗ[ℂ] L2d d :=
  (polyGaussCore (d := d)).subtype.comp ((coreRepPoly d).op (kvnPoly S))

/-- **The comparison operator on the Gauss–polynomial core of `L²(ℝᵈ)`.** -/
def nsEnergyOp : (polyGaussCore (d := d)) →ₗ[ℂ] L2d d :=
  (polyGaussCore (d := d)).subtype.comp ((coreRepPoly d).op (energyOp d))

end

end BookProof.NsKoopman

namespace BookProof.NsNonlinearFarisLavine

open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman

noncomputable section

variable {d : ℕ} (S : NsSystem d)

/-- The nonlinear Navier–Stokes generator as a map of the Gauss–polynomial core into itself. -/
def nsKoopmanCore : (polyGaussCore (d := d)) →ₗ[ℂ] (polyGaussCore (d := d)) :=
  (coreRepPoly d).op (kvnPoly S)



/-- **The comparison operator** `N_NS = H_NS² + (1 + ‖u‖²)` on the Gauss–polynomial core. -/
def nsSquareComparison : (polyGaussCore (d := d)) →ₗ[ℂ] L2d d :=
  nsKoopmanOp S ∘ₗ nsKoopmanCore S + nsEnergyOp (d := d)

















end

end BookProof.NsNonlinearFarisLavine
