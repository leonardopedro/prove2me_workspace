import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Definitions.Def_ChapterNsLagrangianDetConvolution
import Mathlib


/-!
# Lagrangian Navier–Stokes with the determinant constraint, through Faris–Lavine

The fluid is described in **Lagrangian variables**: the displacement `ξ(a)` of the material point
with reference position `a ∈ 𝕋³` and its material velocity `v(a) = ξ̇(a)`, both Galerkin fields on a
finite set `K` of wave vectors (`BookProof.ChapterNsLagrangianDetConvolution`).  The phase space is
`ℝ^{PIdx K}`, with coordinates `x_{(false, k, i, Re/Im)}` (the displacement coefficients `ξ̂_{k,i}`)
and `x_{(true, k, i, Re/Im)}` (the velocity coefficients `v̂_{k,i}`).

**Incompressibility** is the constraint `det(I + ∇ξ) = 1`.  Its Fourier coefficients are the
momentum-convolution polynomials `volCoef q` of the displacement coordinates, in which every
spatial derivative has become the momentum `i k` (`NsLagrangianDet.det_deformation_eq`).  The
constraint enters the dynamics through the **volume penalty**
`V_κ = (κ/2) Σ_q |(det F − 1)^(q)|²` (bulk modulus `κ`), whose gradient is the Lagrange-multiplier
(pressure / Piola) force and whose zero set is incompressible
(`NsLagrangianDet.det_eq_one_of_volPot_eq_zero`).  The Galerkin equations are

```
ξ̇ = v,          v̇ = −ν |k|² v − ∂V_κ/∂ξ ,
```

(unit mass per real coordinate; the Parseval factor is absorbed in `κ`).  The Koopman–von Neumann
generator of this flow is `H_L = ½ Σ (π F + F π)` (`lagKoopmanOp`), the Weyl-ordered first-order
operator on `L²(ℝ^{PIdx K})`, with the **exact** degree-five constraint force (no linearization of
the determinant).

## What is proved

* `lagFlux_eq` — the **energy identity**: for the Lagrangian energy
  `E = 1 + ½|v|² + V_κ(ξ)`, the derivative along the flow is `F·∇E = −ν Σ |k|² v²`: the constraint
  force does no net work (it is the gradient of the potential part of `E`);
* `lagDiv_eq` — the **Liouville identity** `div F = −ν Σ |k|²` (constant);
* `lagKoopmanOp_symmetricOn` — `H_L` is symmetric on the Gauss–polynomial core;
* `lagComparison_commForm` — with the comparison operator `N_L = H_L² + E`, the exact
  commutation relation `⟪x, i[H_L, N_L] x⟫ = ⟪x, (−ν Σ |k|² v²) x⟫`;
* `lagComparison_commForm_bound` — `|⟪x, i[H_L, N_L] x⟫| ≤ 2νΛ ⟪x, N_L x⟫`;
* `lagComparison_quadForm_ge`, `lagComparison_relBound` — `N_L ≥ 1` and `‖H_L x‖ ≤ ‖N_L x‖ + ‖x‖`;
* **`lagKoopman_esa_of_comparison_esa`** — Faris–Lavine: if `N_L` is essentially self-adjoint on
  the core, then so is the Lagrangian Navier–Stokes generator `H_L`.

## Honest boundary

* As for the Eulerian generator (`NsNonlinearFarisLavine`), the essential self-adjointness of the
  comparison operator `N_L` is an **explicit hypothesis**, not proved.  Everything else in the
  Faris–Lavine criterion is discharged.
* The constraint is imposed by the penalty `V_κ` (a slightly compressible fluid with bulk modulus
  `κ`); the exactly incompressible dynamics is the formal limit `κ → ∞`, which is not taken here.
* The viscous term is `ν Δ_a v` in the reference coordinates (`−ν|k|² v̂_k`), which is the
  Lagrangian viscous term at `F = I`; the exact Lagrangian viscous term (with `F^{−1}`) is not
  polynomial and is not used.
-/

namespace BookProof.NsLagrangianDetFL

open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman BookProof.KoopmanLyapunov BookProof.NsLagrangianDet

noncomputable section

variable {K : Type*} [Fintype K]

/-! ## 1. The phase space and the data -/

/-- Phase-space indices: `(false, j)` the displacement coordinate `j`, `(true, j)` the velocity
coordinate `j`. -/
abbrev PIdx (K : Type*) := Bool × DIdx K

/-- The displacement coordinates inside the phase space. -/
def dispVar (j : DIdx K) : PIdx K := (false, j)



/-- **Lagrangian Navier–Stokes data**: the base wave vectors, the viscosity `ν ≥ 0` and the bulk
modulus `κ ≥ 0` of the incompressibility penalty. -/
structure LagNsData (K : Type*) where
  /-- The base wave vectors `k ∈ ℝ³`. -/
  kvec : K → Fin 3 → ℝ
  /-- The kinematic viscosity `ν`. -/
  nu : ℝ
  /-- The bulk modulus `κ` of the volume penalty. -/
  kappa : ℝ
  nu_nonneg : 0 ≤ nu
  kappa_nonneg : 0 ≤ kappa

variable (S : LagNsData K)

/-- The Stokes eigenvalue `|k|²` of a coordinate. -/
def lam (j : DIdx K) : ℝ := ∑ c, S.kvec j.1 c ^ 2



/-- The volume penalty `V_κ(ξ)` as a function on the phase space. -/
def potP : MvPolynomial (PIdx K) ℂ := rename dispVar (volPot S.kappa S.kvec)

/-- **The Lagrangian Navier–Stokes vector field**: `ξ̇ = v`, `v̇ = −ν|k|² v − ∂V_κ/∂ξ`. -/
def lagDrift : PIdx K → MvPolynomial (PIdx K) ℂ
  | (false, j) => X (true, j)
  | (true, j) => -(((S.nu * lam S j : ℝ) : ℂ) • X (true, j)) - pderiv (false, j) (potP S)

/-- **The Lagrangian energy** `E = 1 + ½|v|² + V_κ(ξ)`. -/
def lagEnergy : MvPolynomial (PIdx K) ℂ :=
  1 + ((1 / 2 : ℝ) : ℂ) • ∑ j : DIdx K, (X (true, j) : MvPolynomial (PIdx K) ℂ) * X (true, j)
    + potP S

/-- The viscous dissipation `−ν Σ |k|² v²`. -/
def lagFlux : MvPolynomial (PIdx K) ℂ :=
  ∑ j : DIdx K,
    ((-(S.nu * lam S j) : ℝ) : ℂ) • ((X (true, j) : MvPolynomial (PIdx K) ℂ) * X (true, j))

/-! ## 2. The energy and Liouville identities -/



















/-! ## 3. Pointwise facts -/











/-! ## 4. Real coefficients -/

/-- Complex conjugation of the coefficients of a phase-space polynomial. -/
def conjQ (p : MvPolynomial (PIdx K) ℂ) : MvPolynomial (PIdx K) ℂ := map (starRingEnd ℂ) p









/-! ## 5. Transport to `L²(ℝᵈ)` and the Faris–Lavine argument -/

/-- The dimension of the Lagrangian phase space. -/
abbrev lagDim (K : Type*) [Fintype K] : ℕ := Fintype.card (PIdx K)

/-- An enumeration of the phase-space coordinates. -/
def lagEquiv : PIdx K ≃ Fin (lagDim K) := Fintype.equivFin _

/-- The Lagrangian vector field in the coordinates `Fin (lagDim K)`. -/
def lagG (i : Fin (lagDim K)) : MvPolynomial (Fin (lagDim K)) ℂ :=
  rename lagEquiv (lagDrift S (lagEquiv.symm i))

/-- The Lagrangian energy in the coordinates `Fin (lagDim K)`. -/
def lagE : MvPolynomial (Fin (lagDim K)) ℂ := rename lagEquiv (lagEnergy S)











/-- **The Lagrangian Navier–Stokes Hamiltonian** `H_L = ½ Σ (π F + F π)` on the Gauss–polynomial
core of `L²(ℝ^{PIdx K})`: the Koopman generator of the Lagrangian flow with the determinant
(incompressibility) constraint in momentum-convolution form. -/
def lagKoopmanOp : (polyGaussCore (d := lagDim K)) →ₗ[ℂ] L2d (lagDim K) := kvnGenOp (lagG S)

/-- **The Faris–Lavine comparison operator** `N_L = H_L² + E`. -/
def lagComparison : (polyGaussCore (d := lagDim K)) →ₗ[ℂ] L2d (lagDim K) :=
  lyapunovComparison (lagG S) (lagE S)



















end

end BookProof.NsLagrangianDetFL
