import Mathlib
import BookProof.ChapterNavierStokesFlow

/-!
# The **Eulerian** constraints of the derivatives-as-fields construction

Source: `book.tex`, chapter *"Free field parametrization in Classical Statistical
Field Theory and Navier–Stokes equations"* (~4133–4216), together with the
constraint taxonomy of the chapter *"Gauge transformations, constrained systems
and conditioned probability"* (~2222–2323).

`BookProof.ChapterNavierStokesFlow` formalizes the field-with-derivatives
construction (`fieldTaylor`, `field_evaluates_to_value`), the canonical
commutation relations of the derivative modes, the Lagrangian (parcel) side of
the change of variables (`lagrangian_velocity`, `volume_preservation_constraint`)
and the complete flow of the finite truncation.  This module supplies the
**Eulerian** counterpart: the constraints that make `u_{k,j}` and `u_{k,jk}`
legitimate Eulerian canonical variables rather than arbitrary tensors.

Following the book's own taxonomy the constraints split in two kinds:

* **gauge-generator constraints** — the field-to-derivative relations
  `u_{i,j} = ∂_j u_i` (`derivativeField_relates_to_field`),
  `u_{i,jk} = ∂_k u_{i,j}` (`derivativeField_second`) and their Clairaut
  consequence `u_{i,jk} = u_{i,kj}` (`derivativeField_consistency`): they have no
  explicit solution, so they are imposed by declaring a gauge generator
  (`book.tex` ~2286);
* **explicit-solution constraints** — incompressibility `∂_j u_j = 0`
  (`eulerian_divergence_constraint`), which needs no gauge generator because the
  substitution `u_{3,3} = −(u_{1,1} + u_{2,2})` solves it outright
  (`book.tex` ~4194–4197); the BRST charge is then only the elegant packaging of
  that constraint, not a first-class gauge generator.

The partial derivatives are taken in the *directional* form
`dirDeriv f j x = d/dt f(x + t e_j)|_{t=0}`, which is the exact meaning of
"the derivative of the field along the `j`-th coordinate" used by the book, and
which `dirDeriv_eq` identifies with the Fréchet derivative in the direction `e_j`
whenever the field is differentiable.

Nothing here claims anything about the *continuum* Navier–Stokes problem: these
are the algebraic/differential identities that the finite truncation of
`ChapterNavierStokesFlow` is the shadow of.  Everything is `sorry`-free and
`axiom`-free.
-/

namespace BookProof.NavierStokesEulerian

open BookProof.NavierStokesFlow Matrix

/-! ## Directional (partial) derivatives of a Eulerian field -/

/-- The `j`-th coordinate direction of `ℝ³`. -/
def evec (j : Fin 3) : Fin 3 → ℝ := Pi.single j 1

/-- The partial derivative `∂_j f` of a field on `ℝ³`, in directional form. -/
noncomputable def dirDeriv (f : (Fin 3 → ℝ) → ℝ) (j : Fin 3) (x : Fin 3 → ℝ) : ℝ :=
  deriv (fun t : ℝ => f (x + t • evec j)) 0

/-- For a differentiable field the directional derivative is the Fréchet
derivative evaluated on the coordinate direction. -/
theorem dirDeriv_eq {f : (Fin 3 → ℝ) → ℝ} {L : (Fin 3 → ℝ) →L[ℝ] ℝ} {x : Fin 3 → ℝ}
    (hf : HasFDerivAt f L x) (j : Fin 3) : dirDeriv f j x = L (evec j) := by
  have h : HasDerivAt (fun t : ℝ => x + t • evec j) (evec j) 0 := by
    simpa using ((hasDerivAt_id (0 : ℝ)).smul_const (evec j)).const_add x
  have hf' : HasFDerivAt f L (x + (0 : ℝ) • evec j) := by simpa using hf
  simpa [dirDeriv] using (hf'.comp_hasDerivAt 0 h).deriv

/-- The partial derivatives of the coordinate functions: `∂_j x_k = δ_{kj}`. -/
theorem dirDeriv_coord (k j : Fin 3) (x : Fin 3 → ℝ) :
    dirDeriv (fun y => y k) j x = if k = j then 1 else 0 := by
  have hf : HasFDerivAt (fun y : Fin 3 → ℝ => y k) (ContinuousLinearMap.proj k) x :=
    (ContinuousLinearMap.proj k : (Fin 3 → ℝ) →L[ℝ] ℝ).hasFDerivAt
  rw [dirDeriv_eq hf]
  simp [evec, Pi.single_apply]

/-- The second partial derivative in terms of the second Fréchet derivative. -/
theorem dirDeriv_dirDeriv (f : (Fin 3 → ℝ) → ℝ) (hf : ContDiff ℝ 2 f) (j k : Fin 3)
    (x : Fin 3 → ℝ) :
    dirDeriv (dirDeriv f j) k x = fderiv ℝ (fderiv ℝ f) x (evec k) (evec j) := by
  have hd : Differentiable ℝ (fderiv ℝ f) :=
    (hf.fderiv_right (m := 1) (by norm_num)).differentiable (by norm_num)
  have hfd : dirDeriv f j = fun y => fderiv ℝ f y (evec j) := funext fun y =>
    dirDeriv_eq (hf.differentiable (by norm_num) y).hasFDerivAt j
  have hg : HasFDerivAt (fun y => fderiv ℝ f y (evec j))
      ((ContinuousLinearMap.apply ℝ ℝ (evec j)).comp (fderiv ℝ (fderiv ℝ f) x)) x :=
    (ContinuousLinearMap.apply ℝ ℝ (evec j)).hasFDerivAt.comp x (hd x).hasFDerivAt
  rw [hfd]
  simpa using dirDeriv_eq hg k

/-! ## A.5 — the Eulerian constraints -/

/-- **A.5** *The Eulerian velocity field collapses to its point value.*  The
operator-valued velocity `u_i(X) = u_i + u_{i,j}·(X_j − x_j)` of `book.tex`
~4151–4173 is the Eulerian instance of `fieldTaylor`: on an eigenstate of the
position operators the first-order Taylor correction annihilates the state, so
the field is its point value `u_i`. -/
theorem u_evaluates_to_value {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]
    (u : Fin 3 → E →ₗ[ℂ] E) (uD : Fin 3 → ι → E →ₗ[ℂ] E) (X : ι → E →ₗ[ℂ] E) (x : ι → ℂ)
    (v : E) (hv : ∀ i, X i v = x i • v) (i : Fin 3) :
    fieldTaylor (u i) (uD i) X x v = u i v :=
  field_evaluates_to_value (u i) (uD i) X x v hv

/-- **A.5** *The momentum constraint for the Eulerian velocity modes*
(`book.tex` ~4163–4170, the zeroth-order member of the CCR family):
`[u_j, π^k] = i·δ^k_j`, in the `∂/∂u`-realization of the momentum, on
polynomials in the three velocity modes. -/
theorem eulerian_momentum_constraint (j k : Fin 3) (p : MvPolynomial (Fin 3) ℂ) :
    (MvPolynomial.pderiv k) (MvPolynomial.X j * p)
      - MvPolynomial.X j * (MvPolynomial.pderiv k) p = (if k = j then p else 0) :=
  ccr_field k j p

/-- **A.5** *The momenta dual to the derivative modes.*  Each first-derivative
mode `u_{i,j}` is a canonical variable with its own conjugate momentum `π^{ij}`,
and the pairing is the Kronecker delta `π^{ij}(u_{k,l}) = δ^i_k δ^j_l`: the
momenta separate the derivative modes, which is what makes them independent
canonical degrees of freedom (`book.tex` ~4163–4170). -/
theorem eulerian_momentum_dual (i j k l : Fin 3) :
    (MvPolynomial.pderiv (i, j)) (MvPolynomial.X (k, l) : MvPolynomial (Fin 3 × Fin 3) ℂ)
      = if i = k ∧ j = l then 1 else 0 := by
  rw [MvPolynomial.pderiv_X]
  simp [Prod.ext_iff, Pi.single_apply, eq_comm]

/-- **A.5 (gauge-generator constraint)** *The first-derivative modes are the
partial derivatives of the velocity field*: `u_{i,j} = ∂_j u_i`.  This is the
relation that makes `u_{i,j}` a derivative field rather than an arbitrary
tensor; it has no explicit solution, so on the book's taxonomy it is imposed by
a gauge generator. -/
theorem derivativeField_relates_to_field (u : (Fin 3 → ℝ) → Fin 3 → ℝ)
    (uD : Fin 3 → Fin 3 → (Fin 3 → ℝ) → ℝ) (L : Fin 3 → (Fin 3 → ℝ) → ((Fin 3 → ℝ) →L[ℝ] ℝ))
    (hu : ∀ i x, HasFDerivAt (fun y => u y i) (L i x) x)
    (huD : ∀ i j x, uD i j x = L i x (evec j)) (i j : Fin 3) (x : Fin 3 → ℝ) :
    uD i j x = dirDeriv (fun y => u y i) j x := by
  rw [huD, dirDeriv_eq (hu i x)]

/-- **A.5 (gauge-generator constraint)** *The second-derivative modes are the
partial derivatives of the first-derivative modes*: `u_{i,jk} = ∂_k u_{i,j}` —
the same relation one level up, so that `u_{i,jk} = ∂_k ∂_j u_i`. -/
theorem derivativeField_second (uD : Fin 3 → Fin 3 → (Fin 3 → ℝ) → ℝ)
    (uDD : Fin 3 → Fin 3 → Fin 3 → (Fin 3 → ℝ) → ℝ)
    (M : Fin 3 → Fin 3 → (Fin 3 → ℝ) → ((Fin 3 → ℝ) →L[ℝ] ℝ))
    (huD : ∀ i j x, HasFDerivAt (uD i j) (M i j x) x)
    (huDD : ∀ i j k x, uDD i j k x = M i j x (evec k)) (i j k : Fin 3) (x : Fin 3 → ℝ) :
    uDD i j k x = dirDeriv (uD i j) k x := by
  rw [huDD, dirDeriv_eq (huD i j x)]

/-- **A.5 (Clairaut consistency)** *Mixed partials commute*, so the derivative
modes are integrable: `u_{i,jk} = u_{i,kj}`.  This is the consequence of
`derivativeField_second` taken in the two orders, and it is the identity that
reduces the eighteen second-derivative modes of the truncation to the six
symmetric ones. -/
theorem derivativeField_consistency (u : (Fin 3 → ℝ) → Fin 3 → ℝ)
    (hu : ∀ i, ContDiff ℝ 2 (fun y => u y i)) (i j k : Fin 3) (x : Fin 3 → ℝ) :
    dirDeriv (dirDeriv (fun y => u y i) j) k x
      = dirDeriv (dirDeriv (fun y => u y i) k) j x := by
  rw [dirDeriv_dirDeriv _ (hu i), dirDeriv_dirDeriv _ (hu i)]
  exact ((hu i).contDiffAt.isSymmSndFDerivAt (by simp)) _ _

/-- **A.5 (explicit-solution constraint)** *Incompressibility in Eulerian
variables.*  The divergence `∂_j u_j = u_{1,1} + u_{2,2} + u_{3,3}` vanishes as
soon as the third diagonal derivative mode is given by the book's explicit
substitution `u_{3,3} = −(u_{1,1} + u_{2,2})` (`book.tex` ~4194–4197): the
constraint is imposed by initial data satisfying it, and needs no gauge
generator. -/
theorem eulerian_divergence_constraint (u : (Fin 3 → ℝ) → Fin 3 → ℝ) (x : Fin 3 → ℝ)
    (h : dirDeriv (fun y => u y 2) 2 x
      = -(dirDeriv (fun y => u y 0) 0 x + dirDeriv (fun y => u y 1) 1 x)) :
    ∑ j : Fin 3, dirDeriv (fun y => u y j) j x = 0 := by
  rw [Fin.sum_univ_three, h]
  ring

/-- The cyclic shear field `u_i(x) = x_{i+1}`. -/
def cyclicShear (y : Fin 3 → ℝ) (i : Fin 3) : ℝ := y (i + 1)

/-- **A.5 (non-vacuity of the divergence constraint)** The constraint
`∂_j u_j = 0` is satisfied by a genuinely non-constant field: the cyclic shear
`u_i(x) = x_{i+1}` is divergence free, so the constrained space of Eulerian
fields is not empty. -/
theorem cyclicShear_divergence_free (x : Fin 3 → ℝ) :
    ∑ j : Fin 3, dirDeriv (fun y => cyclicShear y j) j x = 0 := by
  have h : ∀ j : Fin 3, dirDeriv (fun y => cyclicShear y j) j x = 0 := by
    intro j
    have hj : j + 1 ≠ j := by revert j; decide
    rw [show (fun y => cyclicShear y j) = (fun y : Fin 3 → ℝ => y (j + 1)) from rfl,
      dirDeriv_coord, if_neg hj]
  simp [h]

/-! ## E.3 — the BRST charge is not Hermitian -/

open BookProof.NavierStokesFlow in
/-- **E.3** *The BRST charge is not Hermitian* whenever the divergence field is
non-zero: `Ω = u_{j,j} ⊗ ψ†` has adjoint `u_{j,j} ⊗ ψ` (`nsBrst_adjoint`), and
the ghost creation and annihilation operators differ.  So the physical space is
the cohomology `ker Ω / im Ω`, not an eigenspace of a Hermitian `Ω`. -/
theorem nsBrst_not_hermitian {n : ℕ} (d : NSTruncation n) (h : nsDivergence d ≠ 0) :
    (nsBrstCharge d)ᴴ ≠ nsBrstCharge d := by
  intro hEq
  apply h
  ext a b
  have := congrFun (congrFun hEq (a, 0)) (b, 1)
  rw [nsBrst_adjoint] at this
  simpa [nsBrstCharge, Matrix.kroneckerMap_apply, BookProof.GhostField.psi,
    BookProof.GhostField.psiDag] using this.symm

open BookProof.NavierStokesFlow in
/-- **E.3 (the Hermitian packaging)** The symmetrization `Ω + Ω†` *is* Hermitian;
it is the observable built from the BRST charge. -/
theorem nsBrst_symmetrization_hermitian {n : ℕ} (d : NSTruncation n) :
    (nsBrstCharge d + (nsBrstCharge d)ᴴ)ᴴ = nsBrstCharge d + (nsBrstCharge d)ᴴ := by
  rw [Matrix.conjTranspose_add, Matrix.conjTranspose_conjTranspose, add_comm]

end BookProof.NavierStokesEulerian
