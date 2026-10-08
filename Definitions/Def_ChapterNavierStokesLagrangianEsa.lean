import Theorems.Thm_BookProof_NavierStokesFlow_JacobiDeficiency_jacobiOp_symmetric

import Theorems.Thm_BookProof_NavierStokesFlow_lpFiniteModes_dense

import Theorems.Thm_BookProof_ChapterContinuityUnitaryInfinite_momentum_isSymmetric

import Theorems.Thm_BookProof_ChapterContinuityUnitaryInfinite_velocityOp_isSymmetric

import Theorems.Thm_BookProof_NavierStokesFlow_finiteModes_dense

import Theorems.Thm_BookProof_NavierStokesFlow_velocityOp_mem_finiteModes


import Definitions.Def_ChapterNavierStokesFullEsa
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Mathlib


/-!
# Essential self-adjointness of the **full** Navier–Stokes Hamiltonian *after the
Lagrangian change of variables*

`BookProof.ChapterNavierStokesFlow` records the Lagrangian (parcel) change of
variables of `PLAN_LEAN_SPECIALIST_NS_FLOW.md` Part B for a **finite
truncation**: with the Eulerian velocity replaced by the parcel trajectory
`X(ξ)` and its canonical momentum `P(ξ) = Ẋ(ξ) = u(X(ξ))`, the Navier–Stokes
operator becomes the four-term expression

`ĥ_full = −½Δ_X − ν Δ_{ξ,X} − i f(X)·∇_X + Ĥ_constraint`
       ` = ½ ∑ᵢ Pᵢ² + ν ∑ᵢ Qᵢ² + ∑ᵢ fᵢ Dᵢ + C`,

whose first two terms are *positive* second-order operators, the third a
first-order drift and the fourth the zeroth-order volume-preservation
constraint.  `BookProof.ChapterNavierStokesFullEsa` removes the truncation from
the *Eulerian* operator.  This module removes the truncation from the
*transformed* one and proves its essential self-adjointness.

## What is proved here

* `LagrangianFullData` — the untruncated transformed data: a dense domain `D` of
  an arbitrary complex inner-product space, three symmetric parcel momenta `Pᵢ`,
  three symmetric viscous gradients `Qᵢ`, three symmetric drift generators `Dᵢ`
  with a real external force, a symmetric constraint operator and a viscosity
  `ν ≥ 0`.  Nothing is finite-dimensional and nothing is bounded.
* `LagrangianFullData.hFull_isSymmetricDom` — the transformed Hamiltonian is
  symmetric on its domain, unconditionally.
* `LagrangianFullData.kinetic_inner`, `kinetic_nonneg`, `viscous_nonneg` — the
  quadratic forms of the two second-order terms are `½∑‖Pᵢv‖²` and `ν∑‖Qᵢv‖²`:
  after the change of variables the advection term is **positive**, which is the
  structural gain the change of variables is made for.
* `LagrangianFullData.hasZeroDeficiencyOn_of_commonEigenvectors` — **the
  headline criterion**: if the constituents of the transformed operator have a
  total family of common eigenvectors with real eigenvalues in the domain — the
  Lagrangian *momentum representation* — then the full transformed Hamiltonian
  is essentially self-adjoint, with the explicit eigenvalue
  `½∑pᵢ² + ν∑qᵢ² + ∑fᵢdᵢ + c`.  Also the flow criterion
  (`hasZeroDeficiencyOn_of_completeUnitaryFlow`) and the bounded-realization
  criterion.
* `hasZeroDeficiencyOn_of_linearIsometryEquiv` and
  `NSFullData.hasZeroDeficiencyOn_of_lagrangian` — **the change of variables
  transfers essential self-adjointness**: vanishing adjoint deficiency is
  invariant under a unitary change of variables, so proving essential
  self-adjointness *after* passing to the Lagrangian variables proves it for the
  Eulerian operator it came from.
* **Two genuinely infinite-dimensional, untruncated instances.**  On `ℓ²(ℤ)`
  the parcel momenta and viscous gradients are the lattice
  (symmetric-difference) momentum — so the kinetic term `½∑Pᵢ²` really is a
  discrete Laplacian — the drift generators and the constraint are
  multiplication by bounded real fields, and the transformed Hamiltonian is
  essentially self-adjoint on the **proper** dense domain of finitely supported
  modes (`latticeLag_hasZeroDeficiencyOn`), and is not the zero operator
  (`latticeLag_hFull_ne_zero`).  On `ℓ²(ℕ)` all the constituents are diagonal
  with arbitrary — in particular unbounded — real symbols, and the transformed
  Hamiltonian is again essentially self-adjoint
  (`diagLag_hasZeroDeficiencyOn`), for a suitable choice genuinely unbounded
  (`diagLag_not_bounded`).
* **Sharpness.**  `exists_lagrangianFullData_not_hasZeroDeficiencyOn`: the
  algebraic shape of the transformed operator is by itself not enough — an
  unbounded first-order *drift* term can already destroy essential
  self-adjointness.  So the criteria above are necessary, not decorative; this
  is the formal counterpart of the `ẋ = x²` warning of the ODE chapter.

## Scope

Essential self-adjointness of the *continuum* transformed Navier–Stokes
generator — and with it global existence for Navier–Stokes — is **not** claimed.
What is proved is: the transformed operator is symmetric and has positive
second-order part in complete generality; it is essentially self-adjoint,
unconditionally, for the two untruncated infinite-dimensional realizations
above; it is essentially self-adjoint under each of three general criteria; and
essential self-adjointness passes back and forth along the change of variables.
By `exists_lagrangianFullData_not_hasZeroDeficiencyOn` no statement about the
abstract transformed data can do better than a criterion of this kind.
-/

namespace BookProof.NavierStokesFlow

namespace LagrangianEsa

open FullEsa

/-! ## The untruncated transformed (Lagrangian) data -/

section Abstract

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- **The untruncated Lagrangian Navier–Stokes data.**  The parcel momenta `Pᵢ`
(= the Eulerian velocities evaluated along the trajectory, `uᵢ(X(ξ)) = Pᵢ(ξ)`),
the viscous gradients `Qᵢ = ∇_ξPᵢ`, the drift generators `Dᵢ` of the external
force, the zeroth-order volume-preservation constraint `C` and the viscosity
`ν ≥ 0` — now as operators on a *dense domain* `D` of an arbitrary complex
inner-product space. -/
structure LagrangianFullData (F : Type*) [NormedAddCommGroup F]
    [InnerProductSpace ℂ F] where
  /-- The dense domain. -/
  D : Submodule ℂ F
  /-- The parcel momenta: the advection term is `½∑Pᵢ²`. -/
  P : Fin 3 → (D →ₗ[ℂ] D)
  /-- The viscous gradients: the viscosity term is `ν∑Qᵢ²`. -/
  Q : Fin 3 → (D →ₗ[ℂ] D)
  /-- The drift generators of the external force (a first-order term). -/
  drive : Fin 3 → (D →ₗ[ℂ] D)
  /-- The external force. -/
  force : Fin 3 → ℝ
  /-- The zeroth-order volume-preservation (pressure/ghost) constraint. -/
  constraintOp : D →ₗ[ℂ] D
  /-- The kinematic viscosity. -/
  nu : ℝ
  dense : Dense (D : Set F)
  P_symm : ∀ i, IsSymmetricDom (P i)
  Q_symm : ∀ i, IsSymmetricDom (Q i)
  drive_symm : ∀ i, IsSymmetricDom (drive i)
  constraint_symm : IsSymmetricDom constraintOp
  nu_nonneg : 0 ≤ nu

namespace LagrangianFullData

variable (L : LagrangianFullData F)

/-- The advective (kinetic) term `−½Δ_X = ½∑Pᵢ²` — a *positive* second-order
operator after the Lagrangian change of variables. -/
noncomputable def kinetic : L.D →ₗ[ℂ] L.D :=
  ((1 / 2 : ℝ) : ℂ) • ∑ i : Fin 3, (L.P i).comp (L.P i)

/-- The viscous term `−νΔ_{ξ,X} = ν∑Qᵢ²`, second order. -/
noncomputable def viscous : L.D →ₗ[ℂ] L.D :=
  ((L.nu : ℝ) : ℂ) • ∑ i : Fin 3, (L.Q i).comp (L.Q i)

/-- The force drift `∑fᵢDᵢ`, first order. -/
noncomputable def drift : L.D →ₗ[ℂ] L.D :=
  ∑ i : Fin 3, ((L.force i : ℝ) : ℂ) • L.drive i

/-- **The full transformed Navier–Stokes Hamiltonian**
`ĥ_full = −½Δ_X − νΔ_{ξ,X} − i f(X)·∇_X + Ĥ_constraint`, on the dense domain
`D`, with no truncation and no boundedness assumption. -/
noncomputable def hFull : L.D →ₗ[ℂ] L.D :=
  L.kinetic + L.viscous + L.drift + L.constraintOp













/-! ### Positivity of the second-order part -/

hapterNavierStokesFlow` records the Lagrangian (parcel) change of
variables of `PLAN_LEAN_SPECIALIST_NS_FLOW.md` Part B for a **finite
truncation**: with the Eulerian velocity replaced by the parcel trajectory
`X(ξ)` and its canonical momentum `P(ξ) = Ẋ(ξ) = u(X(ξ))`, the Navier–Stokes
operator becomes the four-term expression

`ĥ_full = −½Δ_X − ν Δ_{ξ,X} − i f(X)·∇_X + Ĥ_constraint`
       ` = ½ ∑ᵢ Pᵢ² + ν ∑ᵢ Qᵢ² + ∑ᵢ fᵢ Dᵢ + C`,

whose first two terms are *positive* second-order operators, the third a
first-order drift and the fourth the zeroth-order volume-preservation
constraint.  `BookProof.ChapterNavierStokesFullEsa` removes the truncation from
the *Eulerian* operator.  This module removes the truncation from the
*transformed* one and proves its essential self-adjointness.

## What is proved here

* `LagrangianFullData` — the untruncated transformed data: a dense domain `D` of
  an arbitrary complex inner-product space, three symmetric parcel momenta `Pᵢ`,
  three symmetric viscous gradients `Qᵢ`, three symmetric drift generators `Dᵢ`
  with a real external force, a symmetric constraint operator and a viscosity
  `ν ≥ 0`.  Nothing is finite-dimensional and nothing is bounded.
* `LagrangianFullData.hFull_isSymmetricDom` — the transformed Hamiltonian is
  symmetric on its domain, unconditionally.
* `LagrangianFullData.kinetic_inner`, `kinetic_nonneg`, `viscous_nonneg` — the
  quadratic forms of the two second-order terms are `½∑‖Pᵢv‖²` and `ν∑‖Qᵢv‖²`:
  after the change of variables the advection term is **positive**, which is the
  structural gain the change of variables is made for.
* `LagrangianFullData.hasZeroDeficiencyOn_of_commonEigenvectors` — **the
  headline criterion**: if the constituents of the transformed operator have a
  total family of common eigenvectors with real eigenvalues in the domain — the
  Lagrangian *momentum representation* — then the full transformed Hamiltonian
  is essentially self-adjoint, with the explicit eigenvalue
  `½∑pᵢ² + ν∑qᵢ² + ∑fᵢdᵢ + c`.  Also the flow criterion
  (`hasZeroDeficiencyOn_of_completeUnitaryFlow`) and the bounded-realization
  criterion.
* `hasZeroDeficiencyOn_of_linearIsometryEquiv` and
  `NSFullData.hasZeroDeficiencyOn_of_lagrangian` — **the change of variables
  transfers essential self-adjointness**: vanishing adjoint deficiency is
  invariant under a unitary change of variables, so proving essential
  self-adjointness *after* passing to the Lagrangian variables proves it for the
  Eulerian operator it came from.
* **Two genuinely infinite-dimensional, untruncated instances.**  On `ℓ²(ℤ)`
  the parcel momenta and viscous gradients are the lattice
  (symmetric-difference) momentum — so the kinetic term `½∑Pᵢ²` really is a
  discrete Laplacian — the drift generators and the constraint are
  multiplication by bounded real fields, and the transformed Hamiltonian is
  essentially self-adjoint on the **proper** dense domain of finitely supported
  modes (`latticeLag_hasZeroDeficiencyOn`), and is not the zero operator
  (`latticeLag_hFull_ne_zero`).  On `ℓ²(ℕ)` all the constituents are diagonal
  with arbitrary — in particular unbounded — real symbols, and the transformed
  Hamiltonian is again essentially self-adjoint
  (`diagLag_hasZeroDeficiencyOn`), for a suitable choice genuinely unbounded
  (`diagLag_not_bounded`).
* **Sharpness.**  `exists_lagrangianFullData_not_hasZeroDeficiencyOn`: the
  algebraic shape of the transformed operator is by itself not enough — an
  unbounded first-order *drift* term can already destroy essential
  self-adjointness.  So the criteria above are necessary, not decorative; this
  is the formal counterpart of the `ẋ = x²` warning of the ODE chapter.

## Scope

Essential self-adjointness of the *continuum* transformed Navier–Stokes
generator — and with it global existence for Navier–Stokes — is **not** claimed.
What is proved is: the transformed operator is symmetric and has positive
second-order part in complete generality; it is essentially self-adjoint,
unconditionally, for the two untruncated infinite-dimensional realizations
above; it is essentially self-adjoint under each of three general criteria; and
essential self-adjointness passes back and forth along the change of variables.
By `exists_lagrangianFullData_not_hasZeroDeficiencyOn` no statement about the
abstract transformed data can do better than a criterion of this kind.
-/

namespace BookProof.NavierStokesFlow

namespace LagrangianEsa

open FullEsa

/-! ## The untruncated transformed (Lagrangian) data -/

section Abstract

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- **The untruncated Lagrangian Navier–Stokes data.**  The parcel momenta `Pᵢ`
(= the Eulerian velocities evaluated along the trajectory, `uᵢ(X(ξ)) = Pᵢ(ξ)`),
the viscous gradients `Qᵢ = ∇_ξPᵢ`, the drift generators `Dᵢ` of the external
force, the zeroth-order volume-preservation constraint `C` and the viscosity
`ν ≥ 0` — now as operators on a *dense domain* `D` of an arbitrary complex
inner-product space. -/
structure LagrangianFullData (F : Type*) [NormedAddCommGroup F]
    [InnerProductSpace ℂ F] where
  /-- The dense domain. -/
  D : Submodule ℂ F
  /-- The parcel momenta: the advection term is `½∑Pᵢ²`. -/
  P : Fin 3 → (D →ₗ[ℂ] D)
  /-- The viscous gradients: the viscosity term is `ν∑Qᵢ²`. -/
  Q : Fin 3 → (D →ₗ[ℂ] D)
  /-- The drift generators of the external force (a first-order term). -/
  drive : Fin 3 → (D →ₗ[ℂ] D)
  /-- The external force. -/
  force : Fin 3 → ℝ
  /-- The zeroth-order volume-preservation (pressure/ghost) constraint. -/
  constraintOp : D →ₗ[ℂ] D
  /-- The kinematic viscosity. -/
  nu : ℝ
  dense : Dense (D : Set F)
  P_symm : ∀ i, IsSymmetricDom (P i)
  Q_symm : ∀ i, IsSymmetricDom (Q i)
  drive_symm : ∀ i, IsSymmetricDom (drive i)
  constraint_symm : IsSymmetricDom constraintOp
  nu_nonneg : 0 ≤ nu

namespace LagrangianFullData

variable (L : LagrangianFullData F)

/-- The advective (kinetic) term `−½Δ_X = ½∑Pᵢ²` — a *positive* second-order
operator after the Lagrangian change of variables. -/
noncomputable def kinetic : L.D →ₗ[ℂ] L.D :=
  ((1 / 2 : ℝ) : ℂ) • ∑ i : Fin 3, (L.P i).comp (L.P i)

/-- The viscous term `−νΔ_{ξ,X} = ν∑Qᵢ²`, second order. -/
noncomputable def viscous : L.D →ₗ[ℂ] L.D :=
  ((L.nu : ℝ) : ℂ) • ∑ i : Fin 3, (L.Q i).comp (L.Q i)

/-- The force drift `∑fᵢDᵢ`, first order. -/
noncomputable def drift : L.D →ₗ[ℂ] L.D :=
  ∑ i : Fin 3, ((L.force i : ℝ) : ℂ) • L.drive i

/-- **The full transformed Navier–Stokes Hamiltonian**
`ĥ_full = −½Δ_X − νΔ_{ξ,X} − i f(X)·∇_X + Ĥ_constraint`, on the dense domain
`D`, with no truncation and no boundedness assumption. -/
noncomputable def hFull : L.D →ₗ[ℂ] L.D :=
  L.kinetic + L.viscous + L.drift + L.constraintOp

/-- The four-term decomposition: second order (advection) + second order
(viscosity) + first order (force drift) + zeroth order (constraint). -/
theorem hFull_decomposition :
    L.hFull = L.kinetic + L.viscous + L.drift + L.constraintOp := rfl

/-- The square of a symmetric operator is symmetric. -/
theorem isSymmetricDom_sq {D : Submodule ℂ F} {A : D →ₗ[ℂ] D} (hA : IsSymmetricDom A) :
    IsSymmetricDom (A.comp A) :=
  hA.comp_of_commute hA rfl

theorem kinetic_isSymmetricDom : IsSymmetricDom L.kinetic :=
  IsSymmetricDom.real_smul
    (IsSymmetricDom.sum Finset.univ fun i _ => isSymmetricDom_sq (L.P_symm i)) _

theorem viscous_isSymmetricDom : IsSymmetricDom L.viscous :=
  IsSymmetricDom.real_smul
    (IsSymmetricDom.sum Finset.univ fun i _ => isSymmetricDom_sq (L.Q_symm i)) _

theorem drift_isSymmetricDom : IsSymmetricDom L.drift :=
  IsSymmetricDom.sum Finset.univ fun i _ => (L.drive_symm i).real_smul _

/-- **The full transformed Navier–Stokes Hamiltonian is symmetric on its
domain**, unconditionally: each of the four terms is. -/
theorem hFull_isSymmetricDom : IsSymmetricDom L.hFull :=
  ((L.kinetic_isSymmetricDom.add L.viscous_isSymmetricDom).add
      L.drift_isSymmetricDom).add L.constraint_symm

/-! ### Positivity of the second-order part -/

/-- The quadratic form of the square of a symmetric operator is the squared norm
of its value. -/
theorem inner_comp_self {D : Submodule ℂ F} {A : D →ₗ[ℂ] D} (hA : IsSymmetricDom A) (v : D) :
    (inner ℂ (v : F) ((A.comp A) v : F) : ℂ) = ((‖(A v : F)‖ ^ 2 : ℝ) : ℂ) := by
  have h := hA v (A v)
  simp only [LinearMap.comp_apply]
  rw [← h]
  simp

/-- **The advection term of the transformed operator is positive**: its
quadratic form is `½∑‖Pᵢv‖²`.  This is the structural gain of the Lagrangian
change of variables — the Eulerian advection `−u_j∂_ju_i` becomes the positive
second-order Laplacian `−½Δ_X`. -/
theorem kinetic_inner (v : L.D) :
    (inner ℂ (v : F) (L.kinetic v : F) : ℂ)
      = (((1 / 2 : ℝ) * ∑ i : Fin 3, ‖(L.P i v : F)‖ ^ 2 : ℝ) : ℂ) := by
  simp only [kinetic, LinearMap.smul_apply, LinearMap.sum_apply, Submodule.coe_smul,
    Submodule.coe_sum, inner_smul_right, inner_sum, Complex.ofReal_mul, Complex.ofReal_sum]
  congr 1
  exact Finset.sum_congr rfl fun i _ => inner_comp_self (L.P_symm i) v







/-! ### Criteria for essential self-adjointness -/







/-- The eigenvalue of the transformed Hamiltonian on a common eigenvector of its
constituents: `½∑pᵢ² + ν∑qᵢ² + ∑fᵢdᵢ + c`. -/
noncomputable def eigenvalue (p q dr : Fin 3 → ℝ) (c : ℝ) : ℝ :=
  (1 / 2) * (∑ i : Fin 3, p i ^ 2) + L.nu * (∑ i : Fin 3, q i ^ 2)
    + (∑ i : Fin 3, L.force i * dr i) + c





end LagrangianFullData

end Abstract

/-! ## The change of variables transfers essential self-adjointness -/

section ChangeOfVariables

variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]









end ChangeOfVariables

/-! ## An untruncated instance on `ℓ²(ℤ)`: the kinetic term is a discrete
Laplacian -/

section Lattice

open BookProof.ChapterContinuityUnitaryInfinite FullEsa

/-- **The transformed Navier–Stokes Hamiltonian of the lattice realization**, as
a bounded operator on `ℓ²(ℤ)`: the parcel momenta and the viscous gradients are
the symmetric-difference lattice momentum (so `½∑Pᵢ²` is a discrete Laplacian),
the drift generators and the constraint are multiplication by bounded real
fields. -/
noncomputable def latticeLagCLM (v : Fin 3 → LinfZ) (w : LinfZ) (fr : Fin 3 → ℝ) (nu : ℝ) :
    L2Z →L[ℂ] L2Z :=
  ((1 / 2 : ℝ) : ℂ) • (∑ _i : Fin 3, momentum * momentum)
    + ((nu : ℝ) : ℂ) • (∑ _i : Fin 3, momentum * momentum)
    + (∑ i : Fin 3, ((fr i : ℝ) : ℂ) • velocityOp (v i))
    + velocityOp w





/-- **The untruncated transformed Navier–Stokes data on the lattice `ℓ²(ℤ)`**,
on the *proper* dense domain of finitely supported modes. -/
noncomputable def latticeLagData (v : Fin 3 → LinfZ) (w : LinfZ) (fr : Fin 3 → ℝ) {nu : ℝ}
    (hnu : 0 ≤ nu) : LagrangianFullData L2Z where
  D := finiteModes
  P _ := restrictCLM momentum finiteModes fun f => momentum_mem_finiteModes f.2
  Q _ := restrictCLM momentum finiteModes fun f => momentum_mem_finiteModes f.2
  drive i := restrictCLM (velocityOp (v i)) finiteModes fun f => velocityOp_mem_finiteModes _ f.2
  force := fr
  constraintOp := restrictCLM (velocityOp w) finiteModes fun f => velocityOp_mem_finiteModes _ f.2
  nu := nu
  dense := finiteModes_dense
  P_symm _ := by
    intro x y
    simpa using momentum_isSymmetric (x : L2Z) (y : L2Z)
  Q_symm _ := by
    intro x y
    simpa using momentum_isSymmetric (x : L2Z) (y : L2Z)
  drive_symm i := by
    intro x y
    simpa using velocityOp_isSymmetric (v i) (x : L2Z) (y : L2Z)
  constraint_symm := by
    intro x y
    simpa using velocityOp_isSymmetric w (x : L2Z) (y : L2Z)
  nu_nonneg := hnu

apd
Po
  simp only [LinearMap.zero_apply, Submodule.coe_zero] at h
  rw [latticeLagData_hFull_apply] at h
  have hsingle : ((lp.single 2 (0 : ℤ) (1 : ℂ) : L2Z) : ℤ → ℂ) = Pi.single 0 1 := by
    funext k
    simp [lp.single_apply]
  have h0 := congrArg (fun g : L2Z => (g : ℤ → ℂ) 0) h
  simp only [latticeLagCLM, ContinuousLinearMap.add_apply, ContinuousLinearMap.smul_apply,
    ContinuousLinearMap.mul_apply, lp.coeFn_add, lp.coeFn_smul,
    lp.coeFn_zero, Pi.add_apply, Pi.smul_apply, Pi.zero_apply, smul_eq_mul, Fin.sum_univ_three,
    momentum_apply, velocityOp_apply, hsingle, zeroField] at h0
  norm_num [Pi.single_apply, Complex.ext_iff] at h0

end Lattice

/-! ## An **unbounded** untruncated instance on `ℓ²(ℕ)` -/

section Diagonal

open LpNat DiagonalEsa FullEsa

/-- The untruncated transformed Navier–Stokes data on `ℓOp (dr i)
  force := fr
  constraintOp := diagOp c
  nu := nu
  dense := lpFiniteModes_dense
  P_symm i := diagOp_isSymmetricDom (p i)
  Q_symm i := diagOp_isSymmetricDom (q i)
  drive_symm i := diagOp_isSymmetricDom (dr i)
  constraint_symm := diagOp_isSymmetricDom c
  nu_nonneg := hnu

/-- The symbol of the diagonal transformed Hamiltonian:
`½∑pᵢ² + ν∑qᵢ² + ∑fᵢdᵢ + c`. -/
noncomputable def diagLagSymbol (p q dr : Fin 3 → ℕ → ℝ) (c : ℕ → ℝ) (frifm,rbitrary* — in particular unbounded — real symbols. -/
theorem diagLag_hasZeroDeficiencyOn (p q dr : Fin 3 → ℕ → ℝ) (c : ℕ → ℝ) (fr : Fin 3 → ℝ)
    {nu : ℝ} (hnu : 0 ≤ nu) :
    HasZeroDeficiencyOn (diagLagData p q dr c fr hnu).D (diagLagData p q dr c fr hnu).hFull := by
  rw [diagLagData_hFull]
  exact diagOp_hasZeroDeficiencyOn _

/-- A purely kinetic choice of transformed data whose parcel momentum grows
linearly: the transformed Hamiltonian is `½n²`, unbounded. -/
noncomputable def diagLagUnbounded : LagrangianFullData L2N :=
  diagLagData (fun i => if i = 0 then fun n => (n : ℝ) else fun _ => 0) (fun _ _ => 0)
    (fun _ _ => 0) (fun _ => 0) (fun _ => 0) (le_refl (0 : ℝ))

theorem diagLagUnbounded_hFull :
    diagLagUnbounded.hFull = diagOp (fun n => (1 / 2) * (n : ℝ
  ring

/-- **The transformed Hamiltonian can be genuinely unbounded and still
essentially self-adjoint**: essential self-adjointness after the change of
variables is not a boundedness phenomenon. -/
theorem diagLag_not_bounded :
    ¬ ∃ C : ℝ, ∀ f : diagLagUnbounded.D, ‖diagLagUnbounded.hFull f‖ ≤ C * ‖f‖ := by
  rw [diagLagUnbounded_hFull]
  refine diagOp_not_bounded _ fun C => ?_
  refine ⟨⌈|C|⌉₊ + 1, ?_⟩
  have hc : C ≤ |C| := le_abs_self C
  have hn : |C| ≤ (⌈|C|⌉₊ : ℝ) := Nat.le_ceil _
  have h0 : (0 : ℝ) ≤ (⌈|C|⌉₊ : ℝ) := Nat.cast_nonneg _
  set m : ℝ := (⌈|C|⌉₊ : ℝ) with hm
  have habs : |(1 / 2) * (((⌈|C|⌉₊ + 1 : ℕ) : ℝ)) ^ 2| = (1 / 2) * (m + 1) ^ 2 := by
    push_cast
    rw [abs_of_nonneg (by positivity)]
  rw [habs]
  nlinarith

theorem diagLagUnbounded_hasZeroDeficiencyOn :
    HasZeroDeficiencyOn diagLagUnb 0nd constraint, viscosity `ν = 0` — whose transformed Hamiltonian is
**not** essentially self-adjoint: an unbounded first-order drift term already
destroys the property.  So the positive results above cannot be improved to a
statement about the abstract transformed data; an analytic input (a total
eigenbasis / momentum representation, a complete flow, boundedness) is
indispensable.  This is the formal counterpart of the `ẋ = x²` warning of the
ODE chapter.

What the example exploits is that the abstract data imposes no relation between
the first-order drift and the positive second-order part: it allows a drift that
is not relatively bounded by the kinetic term.  Supplying that relation is
exactly the analytic (Kato–Rellich / Faris–Lavine) input the continuum problem
needs, and it is not part of the algebraic structure. -/
theorem exists_lagrangianFullData_not_hasZeroDeficiencyOn :
    ∃ L : LagrangianFullData L2N, ¬ HasZeroDeficiencyOn L.D L.hFull := by
  refine ⟨jacobiLagData, ?_⟩
  rw [jacobiLagData_hFull]
  exact jacobiOp_not_hasZeroDeficiencyOn

end Sharpness

end LagrangianEsa

end BookProof.NavierStokesFlow
