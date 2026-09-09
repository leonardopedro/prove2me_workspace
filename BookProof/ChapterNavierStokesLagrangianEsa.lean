import Mathlib
import BookProof.ChapterNavierStokesFullEsa

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

/-- The viscous term is positive as well (`ν ≥ 0`). -/
theorem viscous_inner (v : L.D) :
    (inner ℂ (v : F) (L.viscous v : F) : ℂ)
      = ((L.nu * ∑ i : Fin 3, ‖(L.Q i v : F)‖ ^ 2 : ℝ) : ℂ) := by
  simp only [viscous, LinearMap.smul_apply, LinearMap.sum_apply, Submodule.coe_smul,
    Submodule.coe_sum, inner_smul_right, inner_sum, Complex.ofReal_mul, Complex.ofReal_sum]
  congr 1
  exact Finset.sum_congr rfl fun i _ => inner_comp_self (L.Q_symm i) v

theorem kinetic_nonneg (v : L.D) : 0 ≤ (inner ℂ (v : F) (L.kinetic v : F) : ℂ).re := by
  rw [L.kinetic_inner v, Complex.ofReal_re]
  have : (0 : ℝ) ≤ ∑ i : Fin 3, ‖(L.P i v : F)‖ ^ 2 :=
    Finset.sum_nonneg fun i _ => sq_nonneg _
  linarith

theorem viscous_nonneg (v : L.D) : 0 ≤ (inner ℂ (v : F) (L.viscous v : F) : ℂ).re := by
  rw [L.viscous_inner v, Complex.ofReal_re]
  have h : (0 : ℝ) ≤ ∑ i : Fin 3, ‖(L.Q i v : F)‖ ^ 2 :=
    Finset.sum_nonneg fun i _ => sq_nonneg _
  exact mul_nonneg L.nu_nonneg h

/-! ### Criteria for essential self-adjointness -/

/-- **Essential self-adjointness of the transformed Hamiltonian from a complete
unitary flow** (Nelson's criterion). -/
theorem hasZeroDeficiencyOn_of_completeUnitaryFlow (U : ℝ → F → F)
    (hnorm : ∀ (t : ℝ) (v : F), ‖U t v‖ = ‖v‖) (hU0 : ∀ v : F, U 0 v = v)
    (hUD : ∀ (t : ℝ) (v : L.D), U t (v : F) ∈ L.D)
    (hderiv : ∀ (v : L.D) (t : ℝ),
      HasDerivAt (fun s => U s (v : F)) (Complex.I • (L.hFull ⟨U t (v : F), hUD t v⟩ : F)) t) :
    HasZeroDeficiencyOn L.D L.hFull :=
  _root_.BookProof.NavierStokesFlow.hasZeroDeficiencyOn_of_completeUnitaryFlow
    L.D L.hFull U L.dense hnorm hU0 hUD hderiv

/-- **Essential self-adjointness of the transformed Hamiltonian when it is the
restriction of a bounded symmetric operator.** -/
theorem hasZeroDeficiencyOn_of_boundedRealization (A : F →L[ℂ] F)
    (hsym : (A : F →ₗ[ℂ] F).IsSymmetric) (hHA : ∀ x : L.D, (L.hFull x : F) = A (x : F)) :
    HasZeroDeficiencyOn L.D L.hFull :=
  FullEsa.hasZeroDeficiencyOn_of_boundedRealization L.hFull A hsym L.dense hHA

/-- **Essential self-adjointness of the transformed Hamiltonian from a total
family of its own eigenvectors.**  Unlike the bounded criterion this covers
unbounded operators, and unlike the criterion below the eigenvectors need not be
eigenvectors of the individual constituents. -/
theorem hasZeroDeficiencyOn_of_total_eigenvectors {I : Type*} (e : I → L.D) (lam : I → ℝ)
    (heig : ∀ a, L.hFull (e a) = ((lam a : ℝ) : ℂ) • e a)
    (htotal : ∀ w : F, (∀ a, (inner ℂ ((e a : F)) w : ℂ) = 0) → w = 0) :
    HasZeroDeficiencyOn L.D L.hFull :=
  _root_.BookProof.NavierStokesFlow.hasZeroDeficiencyOn_of_total_eigenvectors
    L.D L.hFull e lam heig htotal

/-- The eigenvalue of the transformed Hamiltonian on a common eigenvector of its
constituents: `½∑pᵢ² + ν∑qᵢ² + ∑fᵢdᵢ + c`. -/
noncomputable def eigenvalue (p q dr : Fin 3 → ℝ) (c : ℝ) : ℝ :=
  (1 / 2) * (∑ i : Fin 3, p i ^ 2) + L.nu * (∑ i : Fin 3, q i ^ 2)
    + (∑ i : Fin 3, L.force i * dr i) + c

/-- A common eigenvector of the constituents is an eigenvector of the
transformed Hamiltonian, with the eigenvalue above. -/
theorem hFull_eigenvector {v : L.D} {p q dr : Fin 3 → ℝ} {c : ℝ}
    (hP : ∀ i, L.P i v = ((p i : ℝ) : ℂ) • v) (hQ : ∀ i, L.Q i v = ((q i : ℝ) : ℂ) • v)
    (hD : ∀ i, L.drive i v = ((dr i : ℝ) : ℂ) • v)
    (hC : L.constraintOp v = ((c : ℝ) : ℂ) • v) :
    L.hFull v = ((L.eigenvalue p q dr c : ℝ) : ℂ) • v := by
  have hPP : ∀ i, (L.P i).comp (L.P i) v = ((p i ^ 2 : ℝ) : ℂ) • v := by
    intro i
    simp only [LinearMap.comp_apply, map_smul, hP i, smul_smul]
    norm_num [pow_two]
  have hQQ : ∀ i, (L.Q i).comp (L.Q i) v = ((q i ^ 2 : ℝ) : ℂ) • v := by
    intro i
    simp only [LinearMap.comp_apply, map_smul, hQ i, smul_smul]
    norm_num [pow_two]
  simp only [hFull, kinetic, viscous, drift, LinearMap.add_apply, LinearMap.smul_apply,
    LinearMap.sum_apply, hPP, hQQ, hD, hC, smul_smul, ← Finset.sum_smul, ← add_smul,
    eigenvalue]
  push_cast
  ring_nf

/-- **The headline criterion.**  If the constituents of the transformed
Navier–Stokes operator have a *total* family of common eigenvectors with real
eigenvalues inside the domain — which is exactly the Lagrangian momentum
representation the change of variables is designed to produce — then the full
transformed Hamiltonian is **essentially self-adjoint** on that domain.  No
boundedness is required: the eigenvalues may be arbitrary reals. -/
theorem hasZeroDeficiencyOn_of_commonEigenvectors {I : Type*} (e : I → L.D)
    (p q dr : Fin 3 → I → ℝ) (c : I → ℝ)
    (hP : ∀ i a, L.P i (e a) = ((p i a : ℝ) : ℂ) • e a)
    (hQ : ∀ i a, L.Q i (e a) = ((q i a : ℝ) : ℂ) • e a)
    (hD : ∀ i a, L.drive i (e a) = ((dr i a : ℝ) : ℂ) • e a)
    (hC : ∀ a, L.constraintOp (e a) = ((c a : ℝ) : ℂ) • e a)
    (htotal : ∀ w : F, (∀ a, (inner ℂ ((e a : F)) w : ℂ) = 0) → w = 0) :
    HasZeroDeficiencyOn L.D L.hFull :=
  L.hasZeroDeficiencyOn_of_total_eigenvectors e
    (fun a => L.eigenvalue (fun i => p i a) (fun i => q i a) (fun i => dr i a) (c a))
    (fun a => L.hFull_eigenvector (fun i => hP i a) (fun i => hQ i a) (fun i => hD i a) (hC a))
    htotal

end LagrangianFullData

end Abstract

/-! ## The change of variables transfers essential self-adjointness -/

section ChangeOfVariables

variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]

/-- **Vanishing adjoint deficiency is invariant under a unitary change of
variables.**  If `W` is a unitary map carrying the domain `D` onto the domain
`D'` and intertwining `H` with `H'`, then essential self-adjointness of `H'` —
the operator *after* the change of variables — gives essential self-adjointness
of `H`.  This is what makes the Lagrangian route legitimate: it is enough to
prove the property for the transformed operator. -/
theorem hasZeroDeficiencyOn_of_linearIsometryEquiv (W : F ≃ₗᵢ[ℂ] G) {D : Submodule ℂ F}
    {D' : Submodule ℂ G} {H : D →ₗ[ℂ] D} {H' : D' →ₗ[ℂ] D'}
    (hmap : ∀ x : D, W (x : F) ∈ D') (hsurj : ∀ y : D', ∃ x : D, W (x : F) = (y : G))
    (hint : ∀ x : D, (H' ⟨W (x : F), hmap x⟩ : G) = W ((H x : F)))
    (h : HasZeroDeficiencyOn D' H') : HasZeroDeficiencyOn D H := by
  have key : ∀ (c : ℂ), (∀ w' : G, (∀ y : D', (inner ℂ (H' y : G) w' : ℂ)
      = inner ℂ (y : G) (c • w')) → w' = 0) →
      ∀ w : F, (∀ v : D, (inner ℂ (H v : F) w : ℂ) = inner ℂ (v : F) (c • w)) → w = 0 := by
    intro c hc w hw
    have hW : W w = 0 := by
      refine hc (W w) fun y => ?_
      obtain ⟨x, hx⟩ := hsurj y
      have hHy : (H' y : G) = W ((H x : F)) := by
        have hxy : (⟨W (x : F), hmap x⟩ : D') = y := Subtype.ext hx
        rw [← hxy, hint x]
      rw [hHy, ← hx, W.inner_map_map, hw x, inner_smul_right, inner_smul_right,
        W.inner_map_map]
    have := congrArg W.symm hW
    simpa using this
  refine ⟨key Complex.I h.1, fun w hw => ?_⟩
  refine key (-Complex.I) (fun w' hw' => h.2 w' fun y => ?_) w ?_
  · simpa using hw' y
  · intro v
    simpa using hw v

/-- The converse transport: essential self-adjointness of the operator *before*
the change of variables gives it for the transformed operator. -/
theorem hasZeroDeficiencyOn_map_of_linearIsometryEquiv (W : F ≃ₗᵢ[ℂ] G) {D : Submodule ℂ F}
    {D' : Submodule ℂ G} {H : D →ₗ[ℂ] D} {H' : D' →ₗ[ℂ] D'}
    (hmap : ∀ x : D, W (x : F) ∈ D')
    (hint : ∀ x : D, (H' ⟨W (x : F), hmap x⟩ : G) = W ((H x : F)))
    (h : HasZeroDeficiencyOn D H) : HasZeroDeficiencyOn D' H' := by
  have key : ∀ (c : ℂ), (∀ w : F, (∀ v : D, (inner ℂ (H v : F) w : ℂ)
      = inner ℂ (v : F) (c • w)) → w = 0) →
      ∀ w' : G, (∀ y : D', (inner ℂ (H' y : G) w' : ℂ) = inner ℂ (y : G) (c • w')) → w' = 0 := by
    intro c hc w' hw'
    have hW : W.symm w' = 0 := by
      refine hc (W.symm w') fun v => ?_
      have hleft : (inner ℂ (H v : F) (W.symm w') : ℂ) = inner ℂ (W ((H v : F))) w' := by
        rw [← W.inner_map_map ((H v : F)) (W.symm w')]
        simp
      have hright : (inner ℂ (v : F) (c • W.symm w') : ℂ) = inner ℂ (W (v : F)) (c • w') := by
        rw [inner_smul_right, inner_smul_right, ← W.inner_map_map (v : F) (W.symm w')]
        simp
      rw [hleft, hright, ← hint v]
      exact hw' ⟨W (v : F), hmap v⟩
    simpa using congrArg W hW
  refine ⟨key Complex.I h.1, fun w' hw' => ?_⟩
  refine key (-Complex.I) (fun w hw => h.2 w fun v => ?_) w' ?_
  · simpa using hw v
  · intro y
    simpa using hw' y

/-- **Essential self-adjointness is a property of the operator, not of the
variables it is written in.**  Under a unitary change of variables carrying one
domain onto the other and intertwining the two operators, the Eulerian operator
is essentially self-adjoint if and only if the transformed one is. -/
theorem hasZeroDeficiencyOn_iff_of_linearIsometryEquiv (W : F ≃ₗᵢ[ℂ] G) {D : Submodule ℂ F}
    {D' : Submodule ℂ G} {H : D →ₗ[ℂ] D} {H' : D' →ₗ[ℂ] D'}
    (hmap : ∀ x : D, W (x : F) ∈ D') (hsurj : ∀ y : D', ∃ x : D, W (x : F) = (y : G))
    (hint : ∀ x : D, (H' ⟨W (x : F), hmap x⟩ : G) = W ((H x : F))) :
    HasZeroDeficiencyOn D H ↔ HasZeroDeficiencyOn D' H' :=
  ⟨hasZeroDeficiencyOn_map_of_linearIsometryEquiv W hmap hint,
    hasZeroDeficiencyOn_of_linearIsometryEquiv W hmap hsurj hint⟩

/-- **Essential self-adjointness of the full Navier–Stokes Hamiltonian, obtained
after the Lagrangian change of variables.**  Let `d` be untruncated Eulerian
Navier–Stokes data and `L` the transformed (Lagrangian) data, related by a
unitary change of variables `W` carrying the Eulerian domain onto the Lagrangian
one and the Eulerian Hamiltonian into the transformed Hamiltonian
`ĥ_full = ½∑Pᵢ² + ν∑Qᵢ² + ∑fᵢDᵢ + C`.  If the transformed operator is
essentially self-adjoint, so is the Eulerian one. -/
theorem NSFullData.hasZeroDeficiencyOn_of_lagrangian (d : FullEsa.NSFullData F)
    (L : LagrangianFullData G) (W : F ≃ₗᵢ[ℂ] G) (hmap : ∀ x : d.D, W (x : F) ∈ L.D)
    (hsurj : ∀ y : L.D, ∃ x : d.D, W (x : F) = (y : G))
    (hint : ∀ x : d.D, (L.hFull ⟨W (x : F), hmap x⟩ : G) = W ((d.hamiltonian x : F)))
    (hL : HasZeroDeficiencyOn L.D L.hFull) :
    HasZeroDeficiencyOn d.D d.hamiltonian :=
  hasZeroDeficiencyOn_of_linearIsometryEquiv W hmap hsurj hint hL

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

theorem latticeLagCLM_isSelfAdjoint (v : Fin 3 → LinfZ) (w : LinfZ) (fr : Fin 3 → ℝ) (nu : ℝ) :
    IsSelfAdjoint (latticeLagCLM v w fr nu) := by
  have hmom : IsSelfAdjoint (momentum * momentum) := by
    change star (momentum * momentum) = momentum * momentum
    rw [star_mul, momentum_isSelfAdjoint.star_eq]
  have hsum : IsSelfAdjoint (∑ _i : Fin 3, momentum * momentum) := by
    change star _ = _
    rw [star_sum]
    exact Finset.sum_congr rfl fun i _ => hmom.star_eq
  have hreal : ∀ (r : ℝ) (A : L2Z →L[ℂ] L2Z), IsSelfAdjoint A →
      IsSelfAdjoint (((r : ℝ) : ℂ) • A) := by
    intro r A hA
    change star _ = _
    rw [star_smul, hA.star_eq]
    congr 1
    exact Complex.conj_ofReal r
  have hdrift : IsSelfAdjoint (∑ i : Fin 3, ((fr i : ℝ) : ℂ) • velocityOp (v i)) := by
    change star _ = _
    rw [star_sum]
    exact Finset.sum_congr rfl fun i _ =>
      (hreal (fr i) _ (velocityOp_isSelfAdjoint (v i))).star_eq
  exact (((hreal _ _ hsum).add (hreal _ _ hsum)).add hdrift).add (velocityOp_isSelfAdjoint w)

theorem latticeLagCLM_isSymmetric (v : Fin 3 → LinfZ) (w : LinfZ) (fr : Fin 3 → ℝ) (nu : ℝ) :
    ((latticeLagCLM v w fr nu : L2Z →L[ℂ] L2Z) : L2Z →ₗ[ℂ] L2Z).IsSymmetric :=
  ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.1 (latticeLagCLM_isSelfAdjoint v w fr nu)

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

theorem latticeLagData_hFull_apply (v : Fin 3 → LinfZ) (w : LinfZ) (fr : Fin 3 → ℝ) {nu : ℝ}
    (hnu : 0 ≤ nu) (x : (latticeLagData v w fr hnu).D) :
    ((latticeLagData v w fr hnu).hFull x : L2Z) = latticeLagCLM v w fr nu (x : L2Z) := by
  simp only [LagrangianFullData.hFull, LagrangianFullData.kinetic, LagrangianFullData.viscous,
    LagrangianFullData.drift, latticeLagData, latticeLagCLM, LinearMap.add_apply,
    LinearMap.smul_apply, LinearMap.sum_apply, LinearMap.comp_apply, Submodule.coe_add,
    Submodule.coe_smul, Submodule.coe_sum, restrictCLM_apply, ContinuousLinearMap.add_apply,
    ContinuousLinearMap.smul_apply, ContinuousLinearMap.sum_apply, ContinuousLinearMap.mul_apply]

/-- **The full transformed Navier–Stokes Hamiltonian of the lattice realization
is essentially self-adjoint** on the proper dense domain of finitely supported
modes of `ℓ²(ℤ)`.  This is an untruncated, infinite-dimensional statement: the
kinetic term is the discrete Laplacian `½∑Pᵢ²`, all four terms of the
transformed operator are present, and the domain is not the whole space
(`finiteModes_ne_top`). -/
theorem latticeLag_hasZeroDeficiencyOn (v : Fin 3 → LinfZ) (w : LinfZ) (fr : Fin 3 → ℝ)
    {nu : ℝ} (hnu : 0 ≤ nu) :
    HasZeroDeficiencyOn (latticeLagData v w fr hnu).D (latticeLagData v w fr hnu).hFull :=
  (latticeLagData v w fr hnu).hasZeroDeficiencyOn_of_boundedRealization
    (latticeLagCLM v w fr nu) (latticeLagCLM_isSymmetric v w fr nu)
    (latticeLagData_hFull_apply v w fr hnu)

/-- The zero field of `ℓ^∞(ℤ)`, used to exhibit the purely kinetic realization. -/
noncomputable def zeroField : LinfZ := 0

/-- **The lattice realization is not degenerate**: already the kinetic term
alone — the discrete Laplacian `½∑Pᵢ²` — is a nonzero operator, so the essential
self-adjointness statement above is not about the zero operator. -/
theorem latticeLag_hFull_ne_zero :
    (latticeLagData (fun _ => zeroField) zeroField (fun _ => 0) (le_refl (0 : ℝ))).hFull ≠ 0 := by
  intro hzero
  set L := latticeLagData (fun _ => zeroField) zeroField (fun _ => 0) (le_refl (0 : ℝ)) with hL
  have hmem : (lp.single 2 (0 : ℤ) (1 : ℂ) : L2Z) ∈ L.D := single_mem_finiteModes 0 1
  have h := congrArg (fun T : L.D →ₗ[ℂ] L.D => ((T ⟨_, hmem⟩ : L.D) : L2Z)) hzero
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

/-- The untruncated transformed Navier–Stokes data on `ℓ²(ℕ)` with **diagonal**
constituents: the symbols are arbitrary real sequences, in particular they may
be unbounded. -/
noncomputable def diagLagData (p q dr : Fin 3 → ℕ → ℝ) (c : ℕ → ℝ) (fr : Fin 3 → ℝ) {nu : ℝ}
    (hnu : 0 ≤ nu) : LagrangianFullData L2N where
  D := lpFiniteModes ℕ
  P i := diagOp (p i)
  Q i := diagOp (q i)
  drive i := diagOp (dr i)
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
noncomputable def diagLagSymbol (p q dr : Fin 3 → ℕ → ℝ) (c : ℕ → ℝ) (fr : Fin 3 → ℝ)
    (nu : ℝ) : ℕ → ℝ :=
  fun n => (1 / 2) * (∑ i : Fin 3, p i n * p i n) + nu * (∑ i : Fin 3, q i n * q i n)
    + (∑ i : Fin 3, fr i * dr i n) + c n

theorem diagLagData_hFull (p q dr : Fin 3 → ℕ → ℝ) (c : ℕ → ℝ) (fr : Fin 3 → ℝ) {nu : ℝ}
    (hnu : 0 ≤ nu) :
    (diagLagData p q dr c fr hnu).hFull = diagOp (diagLagSymbol p q dr c fr nu) := by
  simp only [LagrangianFullData.hFull, LagrangianFullData.kinetic, LagrangianFullData.viscous,
    LagrangianFullData.drift, diagLagData, diagOp_comp, diagOp_sum, diagOp_real_smul, diagOp_add]
  refine congrArg diagOp ?_
  funext n
  simp only [diagLagSymbol]

/-- **The full transformed Navier–Stokes Hamiltonian of the diagonal realization
is essentially self-adjoint** on the finite-mode domain of `ℓ²(ℕ)`, for
*arbitrary* — in particular unbounded — real symbols. -/
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
    diagLagUnbounded.hFull = diagOp (fun n => (1 / 2) * (n : ℝ) ^ 2) := by
  unfold diagLagUnbounded
  rw [diagLagData_hFull]
  congr 1
  funext n
  simp only [diagLagSymbol, Fin.sum_univ_three]
  norm_num [Fin.ext_iff]
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
    HasZeroDeficiencyOn diagLagUnbounded.D diagLagUnbounded.hFull :=
  diagLag_hasZeroDeficiencyOn _ _ _ _ _ _

end Diagonal

/-! ## Sharpness: the transformed shape alone does not give ESA -/

section Sharpness

open LpNat JacobiDeficiency FullEsa

/-- Transformed Navier–Stokes data on `ℓ²(ℕ)` whose only nonzero term is the
first-order **drift**, realized by the tridiagonal (limit-circle) operator of
`BookProof.ChapterNavierStokesDeficiency`. -/
noncomputable def jacobiLagData : LagrangianFullData L2N where
  D := lpFiniteModes ℕ
  P _ := 0
  Q _ := 0
  drive i := if i = 0 then jacobiOp else 0
  force i := if i = 0 then 1 else 0
  constraintOp := 0
  nu := 0
  dense := lpFiniteModes_dense
  P_symm _ := IsSymmetricDom.zero
  Q_symm _ := IsSymmetricDom.zero
  drive_symm i := by
    by_cases hi : i = 0
    · rw [hi, if_pos rfl]
      exact fun x y => jacobiOp_symmetric x y
    · rw [if_neg hi]
      exact IsSymmetricDom.zero
  constraint_symm := IsSymmetricDom.zero
  nu_nonneg := le_refl 0

theorem jacobiLagData_hFull : jacobiLagData.hFull = jacobiOp := by
  have hP : ∀ i : Fin 3, jacobiLagData.P i = 0 := fun _ => rfl
  have hQ : ∀ i : Fin 3, jacobiLagData.Q i = 0 := fun _ => rfl
  have hC : jacobiLagData.constraintOp = 0 := rfl
  have hd0 : jacobiLagData.drive 0 = jacobiOp := by
    change (if (0 : Fin 3) = 0 then jacobiOp else 0) = jacobiOp
    rw [if_pos rfl]
  have hd1 : jacobiLagData.drive 1 = 0 := by
    change (if (1 : Fin 3) = 0 then jacobiOp else 0) = 0
    rw [if_neg (by decide)]
  have hd2 : jacobiLagData.drive 2 = 0 := by
    change (if (2 : Fin 3) = 0 then jacobiOp else 0) = 0
    rw [if_neg (by decide)]
  have hf0 : jacobiLagData.force 0 = 1 := by
    change (if (0 : Fin 3) = 0 then (1 : ℝ) else 0) = 1
    rw [if_pos rfl]
  have hf1 : jacobiLagData.force 1 = 0 := by
    change (if (1 : Fin 3) = 0 then (1 : ℝ) else 0) = 0
    rw [if_neg (by decide)]
  have hf2 : jacobiLagData.force 2 = 0 := by
    change (if (2 : Fin 3) = 0 then (1 : ℝ) else 0) = 0
    rw [if_neg (by decide)]
  have hkin : jacobiLagData.kinetic = 0 := by
    simp [LagrangianFullData.kinetic, hP]
  have hvis : jacobiLagData.viscous = 0 := by
    simp [LagrangianFullData.viscous, hQ]
  have hdrift : jacobiLagData.drift = jacobiOp := by
    simp [LagrangianFullData.drift, Fin.sum_univ_three, hd0, hd1, hd2, hf0, hf1, hf2]
  simp [LagrangianFullData.hFull, hkin, hvis, hdrift, hC]

/-- **Sharpness.**  There is untruncated transformed (Lagrangian) Navier–Stokes
data — a dense domain, symmetric parcel momenta, viscous gradients, drift
generators and constraint, viscosity `ν = 0` — whose transformed Hamiltonian is
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
