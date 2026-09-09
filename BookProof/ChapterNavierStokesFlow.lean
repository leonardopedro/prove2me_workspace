import Mathlib
import BookProof.ChapterGhostField
import BookProof.ChapterFreeFieldConstraint
import BookProof.ChapterContinuityUnitary
import BookProof.ChapterU

/-!
# Chapter "Free field parametrization … Navier–Stokes": the truncated
Navier–Stokes Hamiltonian generates a **complete flow**

Source: `book.tex`, chapter *"Free field parametrization in Classical Statistical
Field Theory and Navier–Stokes equations"*, §*"Free field parametrization in
Navier–Stokes equations"* (`book.tex` ~4133–4216).  The correspondence between
the book's text and the theorems proved here is:

* ~4151–4173, degrees of freedom, derivatives treated as fields:
  `fieldTaylor`, `field_evaluates_to_value`;
* ~4163–4170, the canonical commutation relations of the modes: `ccr_field`,
  `derivativeField_momentum`, `secondDerivativeField_momentum`;
* ~4184–4189, the Navier–Stokes Hamiltonian: `nsHamiltonian`,
  `nsHamiltonian_hermitian`;
* ~4199, "polynomial of low degree in the fields":
  `nsHamiltonian_isPolynomial` (words of length ≤ 3);
* ~4191–4197, the divergence constraint and its resolution:
  `nsDivergenceConstraint_resolution`, `nsBrst_nilpotent`;
* ~4199–4208, self-adjointness: `nsHamiltonian_hasZeroDeficiency`,
  `nsHamiltonian_hasZeroDeficiencyOn` (**truncation only**) and the conditional
  `ns_esa_of_farisLavine`, `ns_esa_of_farisLavine_dense`;
* ~4210–4216, existence and uniqueness of the solution: `nsFlow_group`,
  `nsFlow_groupOnEvolved`, `nsFlow_noBlowup` (**truncation only**); the
  differential form — the evolution equation `ψ̇ = i H_N ψ` and the unique
  solvability of its Cauchy problem — is in the companion module
  `BookProof.ChapterNavierStokesCauchy`.

## What is proved

Let `H_N` be the Navier–Stokes Hamiltonian **restricted to a finite truncation**
(finitely many field modes `u_k`, `u_{k,j}`, `u_{k,jj}`, each realized by a
Hermitian matrix on a finite-dimensional state space, the modes commuting with
one another as multiplication operators do).  Then

* `nsHamiltonian_hermitian` — `H_Nᴴ = H_N`;
* `nsHamiltonian_isPolynomial` — every term of `H_N` is a word of length at most
  three in the generators `u_k`, `π_i` (the "low degree in the fields"
  hypothesis of `book.tex` ~4199);
* `nsFlow_zero`, `nsFlow_group`, `nsFlow_unitary` — `U(t) = e^{i t H_N}` is a
  one-parameter **unitary group**, defined for *every* real time: the flow of the
  truncation is complete;
* `nsFlow_norm_preserving`, `nsFlow_noBlowup` — the flow preserves the `ℓ²` mass
  and every coefficient of the evolved state stays bounded by the initial mass,
  uniformly in `t`: **no finite-time singularity on the truncation**;
* `nsHamiltonian_hasZeroDeficiency` — the truncated Hamiltonian has vanishing
  deficiency: `H_N ψ = ± i ψ` forces `ψ = 0`.

Alongside the truncation the file records the algebraic core of the surrounding
construction: the derivatives-as-fields Taylor operator (`Part A`), the
Lagrangian change of variables and the volume-preservation constraint
(`Part B`), the BRST ghost charge (`Part E`), and the Faris–Lavine framing of
the continuum essential-self-adjointness question (`Part G`).

## What is *not* claimed

The essential self-adjointness of the **untruncated continuum** operator
`H = ∫ a†(πⁱ(u_j u_{i,j} − ν u_{i,jj}) + h.c.) a`, and with it global existence
and uniqueness for the Navier–Stokes equations, is **not** claimed anywhere in
this file.  The project's own ODE chapter is the standing warning: for `ẋ = x²`
the Hamiltonian `x²p̂ − i x̂` is a polynomial of degree 3 whose classical flow
`x₀/(1 − t x₀)` is incomplete, so a low-degree polynomial Hamiltonian need *not*
be essentially self-adjoint.  Accordingly:

* the degree bound `nsHamiltonian_isPolynomial` is recorded as a **symmetry**
  statement (a well-defined polynomial operator), never as self-adjointness;
* `HasZeroDeficiency` is the deficiency-index-`(0,0)` condition *for the operator
  itself*; on a finite-dimensional space (where the operator is bounded and
  everywhere defined) this is exactly essential self-adjointness, and it is
  proved for the truncation.  For an unbounded operator the deficiency spaces
  are those of the *adjoint*, so the finite statement does not transfer;
* `ns_esa_of_farisLavine` and its densely-defined form
  `ns_esa_of_farisLavine_dense` are **conditional**: the Faris–Lavine commutator
  criterion (Faris–Lavine 1974, Corollary 1.1; Reed–Simon Vol. II Theorem X.28)
  enters as a *named hypothesis*, never as an `axiom`, exactly as Crouzeix's
  inequality does in `BookProof.ChapterH4`.  Verifying its two analytic
  inequalities for the continuum operator is a research target, not a result of
  this file.  The hypothesis is carried in its honest form: symmetry of the
  operator is part of it, since without symmetry the criterion is contradictory
  and the conditional theorem would be vacuous
  (`farisLavine_without_symmetry_forces_trivial`), while with symmetry it is
  satisfiable (`farisLavine_holds_of_everywhereDefined`) — indeed automatic for
  everywhere-defined operators, which is precisely why the analytic content sits
  in the dense-domain predicate `HasZeroDeficiencyOn`.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

namespace BookProof.NavierStokesFlow

/-! ## Part A — The field, its derivatives as fields, and the momentum constraint -/

section FieldWithDerivatives

variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]

/-- **A.2** The operator-valued field of `book.tex` ~4151–4173,
`φ(X) = φ + φ_i · (X_i − x_i)`: a point value `φ` together with first-order
Taylor coefficients `φ_i`, which are the *derivative fields* `u_{k,j}` of the
truncation and are independent canonical degrees of freedom. -/
def fieldTaylor (phi : E →ₗ[ℂ] E) (phiD : ι → E →ₗ[ℂ] E) (X : ι → E →ₗ[ℂ] E)
    (x : ι → ℂ) : E →ₗ[ℂ] E :=
  phi + ∑ i, (phiD i) ∘ₗ (X i - x i • LinearMap.id)

/-- **A.2 (headline)** On an eigenstate of the position operators the
operator-valued field **collapses to its point value**: the first-order Taylor
correction annihilates the state, so `φ(X)|v⟩ = φ|v⟩`. -/
theorem field_evaluates_to_value (phi : E →ₗ[ℂ] E) (phiD : ι → E →ₗ[ℂ] E)
    (X : ι → E →ₗ[ℂ] E) (x : ι → ℂ) (v : E) (hv : ∀ i, X i v = x i • v) :
    fieldTaylor phi phiD X x v = phi v := by
  simp [fieldTaylor, LinearMap.sum_apply, hv]

end FieldWithDerivatives

/-- **A.1 (non-vacuity of A.2)** The hypothesis of `field_evaluates_to_value`
is met by the **position representation**: the position operators are the
diagonal multiplication operators `X_i = diag(x_i)`, whose eigenstates are the
coordinate states `|k⟩` with eigenvalues `x_i(k)`.  On such a state the
operator-valued field of `book.tex` ~4151–4173 collapses to its point value, so
the collapse statement is not about an empty situation. -/
theorem field_evaluates_to_value_diagonal {m : ℕ} (xs : Fin 3 → Fin m → ℂ) (k : Fin m)
    (phi : (Fin m → ℂ) →ₗ[ℂ] (Fin m → ℂ)) (phiD : Fin 3 → (Fin m → ℂ) →ₗ[ℂ] (Fin m → ℂ)) :
    fieldTaylor phi phiD (fun i => Matrix.mulVecLin (Matrix.diagonal (xs i)))
        (fun i => xs i k) (Pi.single k 1)
      = phi (Pi.single k 1) := by
  refine field_evaluates_to_value _ _ _ _ _ fun i => ?_
  funext j
  by_cases h : j = k <;> simp [Matrix.mulVec_diagonal, h]

/-- **A.3 (core)** The canonical commutation relation of the Bargmann–Fock model
in the form used for the field modes: with `a_b := ∂/∂X_b` and `a†_b := X_b·(·)`,
`[∂_a, X_b] = δ_{ab}` on polynomials in *any* family of modes. -/
theorem ccr_field {σ : Type*} [DecidableEq σ] (a b : σ) (p : MvPolynomial σ ℂ) :
    (MvPolynomial.pderiv a) (MvPolynomial.X b * p)
      - MvPolynomial.X b * (MvPolynomial.pderiv a) p = (if a = b then p else 0) := by
  split_ifs with h <;> simp_all [MvPolynomial.pderiv_X]

/-- **A.3** *The derivatives are fields with their own momenta*
(`book.tex` ~4169): `[u_{j,k}, π^{mn}] = i·δ^n_j·δ^m_k`, here in the
`∂/∂X`-realization of the momentum, on polynomials in the nine derivative modes
`u_{j,k}`. -/
theorem derivativeField_momentum (j k m n : Fin 3) (p : MvPolynomial (Fin 3 × Fin 3) ℂ) :
    (MvPolynomial.pderiv (m, n)) (MvPolynomial.X (j, k) * p)
      - MvPolynomial.X (j, k) * (MvPolynomial.pderiv (m, n)) p
      = (if m = j ∧ n = k then p else 0) := by
  rw [ccr_field]
  simp [Prod.ext_iff]

/-- **A.3** The second-derivative family of `book.tex` ~4170:
`[u_{i,jk}, π^{lmn}] = i·δ^l_i·δ^m_j·δ^n_k`. -/
theorem secondDerivativeField_momentum (i j k l m n : Fin 3)
    (p : MvPolynomial (Fin 3 × Fin 3 × Fin 3) ℂ) :
    (MvPolynomial.pderiv (l, m, n)) (MvPolynomial.X (i, j, k) * p)
      - MvPolynomial.X (i, j, k) * (MvPolynomial.pderiv (l, m, n)) p
      = (if l = i ∧ m = j ∧ n = k then p else 0) := by
  rw [ccr_field]
  simp [Prod.ext_iff]

/-- **A.4** The momentum constraint is a *first-class* invariant of the
dynamics: if the constraint `D` commutes with the Hamiltonian `H`, then
`⁅⁅D, A⁆, H⁆ = −⁅D, ⁅H, A⁆⁆` for every operator `A`, and the `D`-invariant
operators are closed under the Hamiltonian bracket.  (The general identity is
`BookProof.FreeFieldConstraint.constraint_commutation_identity`; this is its
Navier–Stokes instance on matrices.) -/
theorem momentumConstraint_preserved {n : ℕ} (D H A : Matrix (Fin n) (Fin n) ℂ)
    (hDH : BookProof.FreeFieldConstraint.bracket D H = 0)
    (hDA : BookProof.FreeFieldConstraint.bracket D A = 0) :
    BookProof.FreeFieldConstraint.bracket D (BookProof.FreeFieldConstraint.bracket H A) = 0 :=
  BookProof.FreeFieldConstraint.constraint_preserved_under_bracket D H A hDH hDA

/-! ## Part B — The Lagrangian change of variables and volume preservation -/

/-- **B.1** *The parcel velocity is the canonical momentum.*  If the trajectory
`t ↦ X t` is an integral curve of the Eulerian velocity field `u`, then its
derivative — the momentum conjugate to the trajectory — is `u` evaluated at the
parcel position: `Ẋ_i(t) = u_i(X(t))`. -/
theorem lagrangian_velocity {d : ℕ} (X : ℝ → Fin d → ℝ) (u : (Fin d → ℝ) → Fin d → ℝ)
    (h : ∀ t i, HasDerivAt (fun s => X s i) (u (X t) i) t) (t : ℝ) (i : Fin d) :
    deriv (fun s => X s i) t = u (X t) i :=
  (h t i).deriv

/-- **B.2** *Incompressibility is volume preservation in parcel space.*  A
Lagrangian map with unit Jacobian determinant `det(∂X_i/∂ξ_j) = 1` preserves the
volume of every set — the 0-order constraint of the transformed Hamiltonian. -/
theorem volume_preservation_constraint {d : ℕ} (f : (Fin d → ℝ) →ₗ[ℝ] (Fin d → ℝ))
    (hdet : LinearMap.det f = 1) (s : Set (Fin d → ℝ)) :
    MeasureTheory.volume (f '' s) = MeasureTheory.volume s := by
  rw [MeasureTheory.Measure.addHaar_image_linearMap, hdet]
  simp

/-- **B.2 (linearization)** The infinitesimal form of the determinant constraint
is the divergence-free condition: the derivative of `t ↦ det(1 + t·A)` at `t = 0`
is `tr A`, so `det(∂X/∂ξ) = 1` to first order is exactly `∇·u = 0`. -/
theorem det_one_add_smul_hasDerivAt (A : Matrix (Fin 3) (Fin 3) ℝ) :
    HasDerivAt (fun t : ℝ => (1 + t • A).det) A.trace 0 := by
  have h : ∀ t : ℝ, (1 + t • A).det
      = 1 + t * A.trace
        + t ^ 2 * (A 0 0 * A 1 1 - A 0 1 * A 1 0 + A 0 0 * A 2 2 - A 0 2 * A 2 0
            + A 1 1 * A 2 2 - A 1 2 * A 2 1)
        + t ^ 3 * A.det := by
    intro t
    simp [Matrix.det_fin_three, Matrix.trace_fin_three]
    ring
  simp only [h]
  have h1 : HasDerivAt
      (fun t : ℝ => 1 + t * A.trace
        + t ^ 2 * (A 0 0 * A 1 1 - A 0 1 * A 1 0 + A 0 0 * A 2 2 - A 0 2 * A 2 0
            + A 1 1 * A 2 2 - A 1 2 * A 2 1)
        + t ^ 3 * A.det)
      (0 + 1 * A.trace + ((2 : ℕ) * 0 ^ ((2 : ℕ) - 1)) * (A 0 0 * A 1 1 - A 0 1 * A 1 0
          + A 0 0 * A 2 2 - A 0 2 * A 2 0 + A 1 1 * A 2 2 - A 1 2 * A 2 1)
        + ((3 : ℕ) * 0 ^ ((3 : ℕ) - 1)) * A.det) 0 :=
    (((hasDerivAt_const (0 : ℝ) (1 : ℝ)).add ((hasDerivAt_id (0 : ℝ)).mul_const A.trace)).add
        ((hasDerivAt_pow 2 (0 : ℝ)).mul_const _)).add ((hasDerivAt_pow 3 (0 : ℝ)).mul_const A.det)
  simpa using h1

/-- The data of the **Lagrangian (parcel) form** of the transformed
Navier–Stokes operator: the parcel momenta `P` (whose squares are the advective
Laplacian `−½Δ_X`), the viscous gradients `Q`, the drift generators `D` with the
external force `f`, the viscosity `nu ≥ 0`, and the 0-order volume-preservation
constraint `C`. -/
structure LagrangianNS (n : ℕ) where
  /-- Parcel momenta: the advection term is `½ ∑ P_i²`. -/
  P : Fin 3 → Matrix (Fin n) (Fin n) ℂ
  /-- Viscous gradient operators: the viscosity term is `nu ∑ Q_i²`. -/
  Q : Fin 3 → Matrix (Fin n) (Fin n) ℂ
  /-- Drift generators of the external force (a first-order term). -/
  D : Fin 3 → Matrix (Fin n) (Fin n) ℂ
  /-- The external force. -/
  f : Fin 3 → ℝ
  /-- The kinematic viscosity. -/
  nu : ℝ
  /-- The 0-order volume-preservation (pressure/ghost) constraint. -/
  C : Matrix (Fin n) (Fin n) ℂ
  P_herm : ∀ i, (P i)ᴴ = P i
  Q_herm : ∀ i, (Q i)ᴴ = Q i
  D_herm : ∀ i, (D i)ᴴ = D i
  C_herm : Cᴴ = C
  nu_nonneg : 0 ≤ nu

namespace LagrangianNS

variable {n : ℕ} (L : LagrangianNS n)

/-- The advective (kinetic) term `−½Δ_X = ½ ∑ P_i²`: a **positive** second-order
operator after the Lagrangian change of variables. -/
noncomputable def kinetic : Matrix (Fin n) (Fin n) ℂ := ((1 : ℝ) / 2) • ∑ i, L.P i * L.P i

/-- The viscous term `nu ∑ Q_i²`, second order. -/
noncomputable def viscous : Matrix (Fin n) (Fin n) ℂ := L.nu • ∑ i, L.Q i * L.Q i

/-- The force drift `∑ f_i D_i`, first order. -/
noncomputable def drift : Matrix (Fin n) (Fin n) ℂ := ∑ i, L.f i • L.D i

/-- The full transformed operator `ĥ_full = −½Δ_X − νΔ_{ξ,X} − i f·∇_X + Ĥ_c`. -/
noncomputable def hFull : Matrix (Fin n) (Fin n) ℂ := L.kinetic + L.viscous + L.drift + L.C

/-- **B.3** *The four-term decomposition* of the transformed operator: second
order (advection) + second order (viscosity) + first order (force drift) +
zeroth order (volume-preservation constraint). -/
theorem transformed_hamiltonian_decomposition :
    L.hFull = L.kinetic + L.viscous + L.drift + L.C := rfl

/-- A sum of squares of Hermitian matrices is positive semidefinite. -/
theorem sum_sq_posSemidef {m : ℕ} {R : Fin 3 → Matrix (Fin m) (Fin m) ℂ}
    (hR : ∀ i, (R i)ᴴ = R i) : (∑ i, R i * R i).PosSemidef := by
  refine Finset.sum_induction _ _ (fun a b ha hb => ha.add hb) Matrix.PosSemidef.zero ?_
  intro i _
  have h := Matrix.posSemidef_conjTranspose_mul_self (R i)
  rwa [hR i] at h

/-- **B.3** The advection term is a *positive* second-order operator — the
structural gain of the Lagrangian change of variables. -/
theorem kinetic_posSemidef : L.kinetic.PosSemidef :=
  (sum_sq_posSemidef L.P_herm).smul (by norm_num)

/-- **B.3** The viscous term is positive semidefinite (for `nu ≥ 0`). -/
theorem viscous_posSemidef : L.viscous.PosSemidef :=
  (sum_sq_posSemidef L.Q_herm).smul L.nu_nonneg

/-- **B.3** The transformed operator is Hermitian. -/
theorem transformed_hamiltonian_hermitian : (L.hFull)ᴴ = L.hFull := by
  have hk : (L.kinetic)ᴴ = L.kinetic := (kinetic_posSemidef L).isHermitian
  have hv : (L.viscous)ᴴ = L.viscous := (viscous_posSemidef L).isHermitian
  have hd : (L.drift)ᴴ = L.drift := by
    simp only [drift, Matrix.conjTranspose_sum, Matrix.conjTranspose_smul, L.D_herm,
      star_trivial]
  simp only [hFull, Matrix.conjTranspose_add, hk, hv, hd, L.C_herm]

end LagrangianNS

/-! ## Part C — The finite truncation is a finite Hermitian matrix -/

/-- The data of a **finite truncation** of the Navier–Stokes system: the fifteen
field modes `u_k` (`k = 0,1,2`), `u_{k,j}` (indices `3 … 11`) and `u_{k,jj}`
(indices `12, 13, 14`) of `book.tex` ~4151–4173, realized as Hermitian matrices
on a finite-dimensional state space, together with the three momenta `π_i` and
the viscosity `nu`.  The field modes commute with one another, as multiplication
operators of a common set of coordinates do. -/
structure NSTruncation (n : ℕ) where
  /-- The fifteen field modes. -/
  u : Fin 15 → Matrix (Fin n) (Fin n) ℂ
  /-- The three momenta `π_i`. -/
  mom : Fin 3 → Matrix (Fin n) (Fin n) ℂ
  /-- The kinematic viscosity. -/
  nu : ℝ
  u_herm : ∀ k, (u k)ᴴ = u k
  mom_herm : ∀ i, (mom i)ᴴ = mom i
  u_comm : ∀ k l, u k * u l = u l * u k

/-- **Non-vacuity of the truncation hypotheses.**  Diagonal (multiplication)
field modes with real entries — the finite shadow of the multiplication
operators `u_k(x)` — are Hermitian and commute with one another, so together
with any Hermitian momenta they form a truncation. -/
def nsTruncationOfDiagonal {n : ℕ} (a : Fin 15 → Fin n → ℝ)
    (p : Fin 3 → Matrix (Fin n) (Fin n) ℂ) (hp : ∀ i, (p i)ᴴ = p i) (nu : ℝ) :
    NSTruncation n where
  u k := Matrix.diagonal fun x => (a k x : ℂ)
  mom := p
  nu := nu
  u_herm k := by simp [Matrix.diagonal_conjTranspose]
  mom_herm := hp
  u_comm k l := by
    rw [Matrix.diagonal_mul_diagonal, Matrix.diagonal_mul_diagonal]
    simp [mul_comm]

/-- The index of the velocity mode `u_j`. -/
def nsVelIdx (j : Fin 3) : Fin 15 := ⟨j.val, by omega⟩

/-- The index of the first-derivative mode `u_{i,j}`. -/
def nsGradIdx (i j : Fin 3) : Fin 15 := ⟨3 + 3 * i.val + j.val, by omega⟩

/-- The index of the second-derivative mode `u_{i,jj}`. -/
def nsLapIdx (i : Fin 3) : Fin 15 := ⟨12 + i.val, by omega⟩

variable {n : ℕ} (d : NSTruncation n)

/-- The velocity mode `u_j`. -/
def nsVelocity (j : Fin 3) : Matrix (Fin n) (Fin n) ℂ := d.u (nsVelIdx j)

/-- The derivative mode `u_{i,j}`. -/
def nsGradVelocity (i j : Fin 3) : Matrix (Fin n) (Fin n) ℂ := d.u (nsGradIdx i j)

/-- The second-derivative mode `u_{i,jj}`. -/
def nsLapVelocity (i : Fin 3) : Matrix (Fin n) (Fin n) ℂ := d.u (nsLapIdx i)

/-- **C.2** The Navier–Stokes term `A_i = ∑_j u_j u_{i,j} − ν u_{i,jj}`
(`book.tex` ~4184–4189): advection minus viscosity. -/
noncomputable def nsAdvection (i : Fin 3) : Matrix (Fin n) (Fin n) ℂ :=
  (∑ j : Fin 3, nsVelocity d j * nsGradVelocity d i j) - (d.nu : ℂ) • nsLapVelocity d i

/-- **C.2** The truncated Navier–Stokes Hamiltonian
`H_N = ∑_i (π_i A_i + A_i π_i)`, the Weyl-symmetrized (anticommutator) form. -/
noncomputable def nsHamiltonian : Matrix (Fin n) (Fin n) ℂ :=
  ∑ i : Fin 3, (d.mom i * nsAdvection d i + nsAdvection d i * d.mom i)

/-- `A_i` is Hermitian: the field modes are Hermitian and commute, and `ν` is
real. -/
theorem nsAdvection_hermitian (i : Fin 3) : (nsAdvection d i)ᴴ = nsAdvection d i := by
  simp only [nsAdvection, Matrix.conjTranspose_sub, Matrix.conjTranspose_smul,
    Matrix.conjTranspose_sum, Matrix.conjTranspose_mul, nsVelocity, nsGradVelocity,
    nsLapVelocity, d.u_herm, Complex.star_def, Complex.conj_ofReal]
  congr 1
  exact Finset.sum_congr rfl fun j _ => d.u_comm _ _

/-- **C.3 (headline)** *The truncated Navier–Stokes Hamiltonian is Hermitian.*
The anticommutator `π_i A_i + A_i π_i` of two Hermitian matrices is Hermitian —
this is what makes `e^{i t H_N}` unitary. -/
theorem nsHamiltonian_hermitian : (nsHamiltonian d)ᴴ = nsHamiltonian d := by
  simp only [nsHamiltonian, Matrix.conjTranspose_sum, Matrix.conjTranspose_add,
    Matrix.conjTranspose_mul, nsAdvection_hermitian, d.mom_herm]
  exact Finset.sum_congr rfl fun i _ => add_comm _ _

/-- **The truncated Hamiltonian is not trivially zero.**  With all fifteen modes
equal to the unit multiplication operator, zero viscosity and unit momenta on a
one-dimensional state space, `H_N = 18`, which is nonzero: the statements above
are not about a degenerate operator. -/
theorem nsHamiltonian_ne_zero_example :
    nsHamiltonian (nsTruncationOfDiagonal (n := 1) (fun _ _ => 1) (fun _ => 1)
      (fun _ => Matrix.conjTranspose_one) 0) ≠ 0 := by
  intro h
  have h00 := congrFun (congrFun h 0) 0
  simp [nsHamiltonian, nsAdvection, nsVelocity, nsGradVelocity, nsLapVelocity,
    nsTruncationOfDiagonal, Matrix.ofNat_apply] at h00

/-- The generators of the truncated algebra: `inl k` is the field mode `u_k`,
`inr i` the momentum `π_i`. -/
def nsGen : Fin 15 ⊕ Fin 3 → Matrix (Fin n) (Fin n) ℂ := Sum.elim d.u d.mom

/-- The index set of the terms of `H_N`: an advection term `(i, j, b)` (with `b`
recording which side the momentum sits on) or a viscous term `(i, b)`. -/
abbrev NSWordIndex := (Fin 3 × Fin 3 × Bool) ⊕ (Fin 3 × Bool)

/-- The word (ordered list of generators) of each term of `H_N`. -/
def nsWord : NSWordIndex → List (Fin 15 ⊕ Fin 3)
  | .inl (i, j, false) => [.inr i, .inl (nsVelIdx j), .inl (nsGradIdx i j)]
  | .inl (i, j, true) => [.inl (nsVelIdx j), .inl (nsGradIdx i j), .inr i]
  | .inr (i, false) => [.inr i, .inl (nsLapIdx i)]
  | .inr (i, true) => [.inl (nsLapIdx i), .inr i]

/-- The scalar coefficient of each term of `H_N`. -/
def nsCoeff (nu : ℝ) : NSWordIndex → ℂ
  | .inl _ => 1
  | .inr _ => -(nu : ℂ)

/-- **C.4** Every term of `H_N` is a word of length **at most three** in the
generators. -/
theorem nsWord_length_le_three (a : NSWordIndex) : (nsWord a).length ≤ 3 := by
  rcases a with ⟨i, j, b⟩ | ⟨i, b⟩ <;> cases b <;> simp [nsWord]

/-- **C.4 (headline)** *`H_N` is a polynomial of degree ≤ 3 in the ladder/field
generators* (`book.tex` ~4199, "polynomial of low degree in the fields"): it is
a finite linear combination of words `nsWord a`, each of length at most three by
`nsWord_length_le_three`.

**Role: symmetry, not self-adjointness.**  The degree bound says `H_N` is a
well-defined polynomial operator; self-adjointness of the truncation comes from
`nsHamiltonian_hermitian` (finite matrices), not from the degree bound. -/
theorem nsHamiltonian_isPolynomial :
    nsHamiltonian d = ∑ a : NSWordIndex, nsCoeff d.nu a • ((nsWord a).map (nsGen d)).prod := by
  simp only [Fintype.sum_sum_type, Fintype.sum_prod_type, Fintype.sum_bool, nsWord, nsCoeff,
    nsGen, List.map_cons, List.map_nil, List.prod_cons, List.prod_nil, Sum.elim_inl,
    Sum.elim_inr, one_smul, mul_one, nsHamiltonian, nsAdvection, nsVelocity, nsGradVelocity,
    nsLapVelocity]
  simp only [mul_add, add_mul, Finset.mul_sum, Finset.sum_mul, Finset.sum_add_distrib,
    sub_eq_add_neg, mul_neg, neg_mul, Matrix.mul_smul, Matrix.smul_mul, neg_smul, mul_assoc]
  abel

/-! ## Part D — Complete flow on the truncation (no singularities) -/

/-- **D.1** The flow of the truncated Navier–Stokes Hamiltonian,
`U(t) = e^{i t H_N}`. -/
noncomputable def nsFlowUnitary (t : ℝ) : Matrix (Fin n) (Fin n) ℂ :=
  NormedSpace.exp (((t : ℂ) * Complex.I) • nsHamiltonian d)

/-- **D.2 (headline)** Every `U(t)` is **unitary**. -/
theorem nsFlow_unitary (t : ℝ) : (nsFlowUnitary d t)ᴴ * nsFlowUnitary d t = 1 :=
  BookProof.ChapterContinuityUnitary.exp_smul_I_unitary _ (nsHamiltonian_hermitian d) t

/-- **D.4** `U(0) = 1`. -/
theorem nsFlow_zero : nsFlowUnitary d 0 = 1 := by
  simp [nsFlowUnitary, NormedSpace.exp_zero]

/-- **D.3 (headline)** *The flow is complete*: `U` is a one-parameter group,
`U(s + t) = U(s) U(t)`, defined for **every** real time — there is no finite time
horizon beyond which the truncated evolution ceases to exist. -/
theorem nsFlow_group (s t : ℝ) :
    nsFlowUnitary d (s + t) = nsFlowUnitary d s * nsFlowUnitary d t := by
  have hcomm : Commute (((s : ℂ) * Complex.I) • nsHamiltonian d)
      (((t : ℂ) * Complex.I) • nsHamiltonian d) := by
    simp [Commute, SemiconjBy, smul_smul, mul_comm]
  have hsum : (((s + t : ℝ) : ℂ) * Complex.I) • nsHamiltonian d
      = ((s : ℂ) * Complex.I) • nsHamiltonian d
        + ((t : ℂ) * Complex.I) • nsHamiltonian d := by
    rw [← add_smul]
    push_cast
    ring_nf
  rw [nsFlowUnitary, hsum, Matrix.exp_add_of_commute _ _ hcomm]
  rfl

/-- **D.5** The flow is **norm preserving**: `‖ψ(t)‖ = ‖ψ(0)‖`. -/
theorem nsFlow_norm_preserving (t : ℝ) (psi : Fin n → ℂ) :
    ∑ a, ‖(nsFlowUnitary d t *ᵥ psi) a‖ ^ 2 = ∑ a, ‖psi a‖ ^ 2 :=
  BookProof.ChapterContinuityUnitary.unitary_preserves_normSq _ (nsFlow_unitary d t) psi

/-- **D.6 (headline)** *No finite-time singularity on the truncation*: at every
time `t` — however large — each coefficient of the evolved state is bounded by
the (conserved) initial mass. -/
theorem nsFlow_noBlowup (t : ℝ) (psi : Fin n → ℂ) (k : Fin n) :
    ‖(nsFlowUnitary d t *ᵥ psi) k‖ ^ 2 ≤ ∑ a, ‖psi a‖ ^ 2 := by
  rw [← nsFlow_norm_preserving d t psi]
  exact Finset.single_le_sum (f := fun a => ‖(nsFlowUnitary d t *ᵥ psi) a‖ ^ 2)
    (fun a _ => by positivity) (Finset.mem_univ k)

/-- **D.7** The complete-flow statement on states: evolving by `t₂` and then by
`t₁` is evolving by `t₁ + t₂`. -/
theorem nsFlow_groupOnEvolved (t₁ t₂ : ℝ) (psi : Fin n → ℂ) :
    nsFlowUnitary d t₁ *ᵥ (nsFlowUnitary d t₂ *ᵥ psi) = nsFlowUnitary d (t₁ + t₂) *ᵥ psi := by
  rw [nsFlow_group, Matrix.mulVec_mulVec]

/-! ## Part E — The divergence constraint and the BRST charge -/

/-- The divergence field `u_{j,j}` of the truncation. -/
noncomputable def nsDivergence : Matrix (Fin n) (Fin n) ℂ := ∑ j : Fin 3, nsGradVelocity d j j

/-- **E.1** The truncated **BRST charge** `Ω = u_{j,j} ⊗ ψ†` on the tensor
product of the bosonic state space with the two-dimensional ghost factor. -/
noncomputable def nsBrstCharge : Matrix (Fin n × Fin 2) (Fin n × Fin 2) ℂ :=
  nsDivergence d ⊗ₖ BookProof.GhostField.psiDag

/-- **E.1 (headline)** *The BRST charge is nilpotent*, `Ω² = 0` — the
first-class property that makes the BRST cohomology of the divergence constraint
well defined.  It reduces to the nilpotency `ψ†² = 0` of the ghost creation
operator. -/
theorem nsBrst_nilpotent : nsBrstCharge d * nsBrstCharge d = 0 := by
  rw [nsBrstCharge, ← Matrix.mul_kronecker_mul, BookProof.GhostField.psiDag_sq,
    Matrix.kronecker_zero]

/-- **E.3** The adjoint of the BRST charge is `u_{j,j} ⊗ ψ`: the charge itself is
*not* Hermitian (the ghost factor is a creation operator), which is why the
physical space is `ker Ω / im Ω` rather than an eigenspace of `Ω`. -/
theorem nsBrst_adjoint : (nsBrstCharge d)ᴴ = nsDivergence d ⊗ₖ BookProof.GhostField.psi := by
  have hD : (nsDivergence d)ᴴ = nsDivergence d := by
    simp only [nsDivergence, Matrix.conjTranspose_sum, nsGradVelocity, d.u_herm]
  have hp : (BookProof.GhostField.psiDag)ᴴ = BookProof.GhostField.psi := by
    rw [BookProof.GhostField.psiDag_eq_conjTranspose, Matrix.conjTranspose_conjTranspose]
  rw [nsBrstCharge, Matrix.conjTranspose_kronecker, hD, hp]

/-- **E.2** *The divergence constraint is resolved by the book's substitution*
(`book.tex` ~4191–4197): setting `u_{3,3} = −(u_{1,1} + u_{2,2})` solves
`∂_j u_j = u_{1,1} + u_{2,2} + u_{3,3} = 0`. -/
theorem nsDivergenceConstraint_resolution (u11 u22 u33 : ℝ) (h : u33 = -(u11 + u22)) :
    u11 + u22 + u33 = 0 := by
  rw [h]; ring

/-- The operator form of the same resolution. -/
theorem nsDivergenceConstraint_resolution_matrix (U11 U22 U33 : Matrix (Fin n) (Fin n) ℂ)
    (h : U33 = -(U11 + U22)) : U11 + U22 + U33 = 0 := by
  rw [h]; abel

/-! ## Part G — Deficiency, second quantization, and the Faris–Lavine criterion -/

section Deficiency

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- **Vanishing deficiency** for an operator on a complex inner-product space:
`H ψ = ± i ψ` forces `ψ = 0`, i.e. the deficiency indices are `(0, 0)`.

*Scope.* On a finite-dimensional space (a bounded, everywhere-defined operator)
this is exactly essential self-adjointness.  For an unbounded operator the
deficiency spaces are those of the **adjoint** on its own domain, so this
predicate is the finite/bounded shadow of the analytic notion. -/
def HasZeroDeficiency (H : F →ₗ[ℂ] F) : Prop :=
  (∀ v : F, H v = Complex.I • v → v = 0) ∧ (∀ v : F, H v = -(Complex.I • v) → v = 0)

/-- A symmetric operator has vanishing deficiency in the above sense: the
expectation `⟪v, Hv⟫` is real, while `⟪v, ± i v⟫` is purely imaginary. -/
theorem symmetric_hasZeroDeficiency (H : F →ₗ[ℂ] F) (hsym : H.IsSymmetric) :
    HasZeroDeficiency H := by
  constructor
  · intro v hv
    have h := hsym v v
    rw [hv, inner_smul_left, inner_smul_right] at h
    have h2 : (2 * Complex.I) * (inner ℂ v v : ℂ) = 0 := by
      simp only [Complex.conj_I] at h
      linear_combination -h
    exact inner_self_eq_zero.mp ((mul_eq_zero.mp h2).resolve_left (by simp [Complex.I_ne_zero]))
  · intro v hv
    have h := hsym v v
    rw [hv, inner_neg_left, inner_neg_right, inner_smul_left, inner_smul_right] at h
    have h2 : (2 * Complex.I) * (inner ℂ v v : ℂ) = 0 := by
      simp only [Complex.conj_I] at h
      linear_combination h
    exact inner_self_eq_zero.mp ((mul_eq_zero.mp h2).resolve_left (by simp [Complex.I_ne_zero]))

/-- **G.4** *The Faris–Lavine criterion, as a conditional theorem.*

`farisLavine` is the **named external input** (Faris & Lavine 1974, Corollary
1.1; Reed & Simon Vol. II, Theorem X.28 — Sears' theorem in the
quadratic-growth case): an operator relatively bounded by a comparison operator
`N`, with a form-commutator bound `|⟪ψ, [H, N] ψ⟫| ≤ c₂ |⟪ψ, N ψ⟫|`, is
essentially self-adjoint.  It enters as a hypothesis, **never as an `axiom`**,
exactly as Crouzeix's inequality does in `BookProof.ChapterH4`.

Given the criterion and the two Faris–Lavine inequalities for the pair `(H, N)`
— `H` the transformed (Lagrangian) Navier–Stokes operator of Part B, `N` the
outer number operator of `G.3` — the operator has vanishing deficiency.  Neither
inequality is proved here for the continuum operator: that is the research
target recorded in the module docstring. -/
theorem ns_esa_of_farisLavine (H N : F →ₗ[ℂ] F) (c₁ c₂ : ℝ) (hsym : H.IsSymmetric)
    (farisLavine : ∀ (H' N' : F →ₗ[ℂ] F) (a b : ℝ), H'.IsSymmetric →
      (∀ v : F, ‖H' v‖ ≤ a * ‖N' v‖) →
      (∀ v : F, ‖(inner ℂ v (H' (N' v) - N' (H' v)) : ℂ)‖ ≤ b * ‖(inner ℂ v (N' v) : ℂ)‖) →
      HasZeroDeficiency H')
    (hHbound : ∀ v : F, ‖H v‖ ≤ c₁ * ‖N v‖)
    (hCommutator : ∀ v : F,
      ‖(inner ℂ v (H (N v) - N (H v)) : ℂ)‖ ≤ c₂ * ‖(inner ℂ v (N v) : ℂ)‖) :
    HasZeroDeficiency H :=
  farisLavine H N c₁ c₂ hsym hHbound hCommutator

/-- *Why the symmetry hypothesis of `ns_esa_of_farisLavine` cannot be dropped.*
Without it the quantified criterion is **contradictory** on every nontrivial
space: `H' = i·1` and `N' = 1` satisfy both inequalities with `a = b = 1` while
`H' v = i v` for every `v`, so the criterion would force `v = 0`.  A conditional
theorem resting on that hypothesis would be vacuous, which is why the symmetry
of `H'` — part of the actual Faris–Lavine statement — is carried explicitly. -/
theorem farisLavine_without_symmetry_forces_trivial
    (crit : ∀ (H' N' : F →ₗ[ℂ] F) (a b : ℝ),
      (∀ v : F, ‖H' v‖ ≤ a * ‖N' v‖) →
      (∀ v : F, ‖(inner ℂ v (H' (N' v) - N' (H' v)) : ℂ)‖ ≤ b * ‖(inner ℂ v (N' v) : ℂ)‖) →
      HasZeroDeficiency H') (v : F) : v = 0 :=
  (crit (Complex.I • LinearMap.id) LinearMap.id 1 1 (fun v => by simp [norm_smul])
    (fun v => by simp)).1 v (by simp)

/-- *The criterion assumed by `ns_esa_of_farisLavine` is satisfiable* — hence
that theorem is **not vacuous**.  For operators defined on the whole space the
criterion is in fact automatic: symmetry alone already gives vanishing
deficiency (`symmetric_hasZeroDeficiency`), and neither Faris–Lavine inequality
is used.  The analytic content of Faris–Lavine therefore lives entirely in the
*densely defined, unbounded* setting — the predicate `HasZeroDeficiencyOn`
below, where the deficiency spaces are those of the **adjoint** and symmetry no
longer suffices.  This file proves the everywhere-defined case only. -/
theorem farisLavine_holds_of_everywhereDefined :
    ∀ (H' N' : F →ₗ[ℂ] F) (a b : ℝ), H'.IsSymmetric →
      (∀ v : F, ‖H' v‖ ≤ a * ‖N' v‖) →
      (∀ v : F, ‖(inner ℂ v (H' (N' v) - N' (H' v)) : ℂ)‖ ≤ b * ‖(inner ℂ v (N' v) : ℂ)‖) →
      HasZeroDeficiency H' :=
  fun H' _ _ _ hsym _ _ => symmetric_hasZeroDeficiency H' hsym

/-! ### Deficiency of the adjoint on a dense domain

`HasZeroDeficiency` above is the deficiency condition *for the operator itself*,
which is the right notion exactly when the operator is everywhere defined.  The
analytic notion — the one Faris–Lavine is about — asks the deficiency spaces of
the **adjoint** of an operator given on a dense domain `D` to vanish: no `w` may
satisfy `⟪H v, w⟫ = ⟪v, ± i w⟫` for all `v ∈ D` unless `w = 0`.  For `D = ⊤` the
two notions agree (`hasZeroDeficiencyOn_top_of_symmetric`); for a proper dense
domain the second is strictly stronger, and it is *not* claimed here for the
continuum Navier–Stokes operator. -/

/-- Vanishing deficiency of the **adjoint** of an operator `H` defined on the
domain `D`: if `w` satisfies `⟪H v, w⟫ = ⟪v, ± i w⟫` for every `v ∈ D` — that
is, if `w` lies in a deficiency space of `H∗` — then `w = 0`. -/
def HasZeroDeficiencyOn (D : Submodule ℂ F) (H : D →ₗ[ℂ] D) : Prop :=
  (∀ w : F, (∀ v : D, (inner ℂ (H v : F) w : ℂ) = inner ℂ (v : F) (Complex.I • w)) → w = 0) ∧
    (∀ w : F, (∀ v : D, (inner ℂ (H v : F) w : ℂ) = inner ℂ (v : F) (-(Complex.I • w))) → w = 0)

/-- An everywhere-defined operator, viewed as an operator on the domain `⊤`. -/
noncomputable def restrictToTop (H : F →ₗ[ℂ] F) :
    (⊤ : Submodule ℂ F) →ₗ[ℂ] (⊤ : Submodule ℂ F) :=
  LinearMap.codRestrict ⊤ (H.comp (⊤ : Submodule ℂ F).subtype) fun _ => trivial

@[simp] theorem restrictToTop_apply (H : F →ₗ[ℂ] F) (v : (⊤ : Submodule ℂ F)) :
    (restrictToTop H v : F) = H (v : F) := rfl

/-- On the **full** domain a symmetric operator already has vanishing adjoint
deficiency: testing the defining identity against `w` itself makes `⟪H w, w⟫`
both real (by symmetry) and purely imaginary, so `w = 0`.  This is the
everywhere-defined case of essential self-adjointness — and, for a proper dense
domain, exactly the step that fails without an analytic criterion such as
Faris–Lavine. -/
theorem hasZeroDeficiencyOn_top_of_symmetric (H : F →ₗ[ℂ] F) (hsym : H.IsSymmetric) :
    HasZeroDeficiencyOn (⊤ : Submodule ℂ F) (restrictToTop H) := by
  constructor
  · intro w hw
    have h := hw ⟨w, trivial⟩
    simp only [restrictToTop_apply, inner_smul_right] at h
    have hs : (inner ℂ (H w) w : ℂ) = inner ℂ w (H w) := hsym w w
    have hc : (inner ℂ w (H w) : ℂ) = starRingEnd ℂ (inner ℂ (H w) w) :=
      (inner_conj_symm _ _).symm
    have h2 : (2 * Complex.I) * (inner ℂ w w : ℂ) = 0 := by
      have hcc : starRingEnd ℂ (inner ℂ w w : ℂ) = inner ℂ w w := inner_self_conj _
      rw [h] at hs hc
      rw [hc] at hs
      simp only [map_mul, Complex.conj_I, hcc] at hs
      linear_combination hs
    exact inner_self_eq_zero.mp ((mul_eq_zero.mp h2).resolve_left (by simp [Complex.I_ne_zero]))
  · intro w hw
    have h := hw ⟨w, trivial⟩
    simp only [restrictToTop_apply, inner_neg_right, inner_smul_right] at h
    have hs : (inner ℂ (H w) w : ℂ) = inner ℂ w (H w) := hsym w w
    have hc : (inner ℂ w (H w) : ℂ) = starRingEnd ℂ (inner ℂ (H w) w) :=
      (inner_conj_symm _ _).symm
    have h2 : (2 * Complex.I) * (inner ℂ w w : ℂ) = 0 := by
      have hcc : starRingEnd ℂ (inner ℂ w w : ℂ) = inner ℂ w w := inner_self_conj _
      rw [h] at hs hc
      rw [hc] at hs
      simp only [map_neg, map_mul, Complex.conj_I, hcc] at hs
      linear_combination -hs
    exact inner_self_eq_zero.mp ((mul_eq_zero.mp h2).resolve_left (by simp [Complex.I_ne_zero]))

/-- **G.4 (dense form)** *The Faris–Lavine criterion for a densely defined
operator, as a conditional theorem.*  This is the statement the continuum
Navier–Stokes question actually needs: `H` and the comparison operator `N` live
on a dense domain `D` (the finite-particle vectors), `H` is symmetric there, `H`
is relatively bounded by `N`, and the form commutator `[H, N]` is dominated by
`N`; the conclusion is that the **adjoint** has no deficiency, i.e. `H` is
essentially self-adjoint.

As in the everywhere-defined version the criterion itself is a **named
hypothesis** (Faris & Lavine 1974, Corollary 1.1; Reed & Simon Vol. II, Theorem
X.28), never an `axiom`, and the two analytic inequalities are *not* verified
here for the continuum operator: that is the research target recorded in the
module docstring.  The criterion is consistent — it holds whenever the domain is
the whole space, by `hasZeroDeficiencyOn_top_of_symmetric`. -/
theorem ns_esa_of_farisLavine_dense (D : Submodule ℂ F) (H N : D →ₗ[ℂ] D) (c₁ c₂ : ℝ)
    (farisLavine : ∀ (D' : Submodule ℂ F) (H' N' : D' →ₗ[ℂ] D') (a b : ℝ),
      Dense (D' : Set F) →
      (∀ x y : D', (inner ℂ (H' x : F) (y : F) : ℂ) = inner ℂ (x : F) (H' y : F)) →
      (∀ v : D', ‖(H' v : F)‖ ≤ a * ‖(N' v : F)‖) →
      (∀ v : D', ‖(inner ℂ (v : F) ((H' (N' v) : F) - (N' (H' v) : F)) : ℂ)‖
        ≤ b * ‖(inner ℂ (v : F) (N' v : F) : ℂ)‖) →
      HasZeroDeficiencyOn D' H')
    (hdense : Dense (D : Set F))
    (hsym : ∀ x y : D, (inner ℂ (H x : F) (y : F) : ℂ) = inner ℂ (x : F) (H y : F))
    (hHbound : ∀ v : D, ‖(H v : F)‖ ≤ c₁ * ‖(N v : F)‖)
    (hCommutator : ∀ v : D, ‖(inner ℂ (v : F) ((H (N v) : F) - (N (H v) : F)) : ℂ)‖
      ≤ c₂ * ‖(inner ℂ (v : F) (N v : F) : ℂ)‖) :
    HasZeroDeficiencyOn D H :=
  farisLavine D H N c₁ c₂ hdense hsym hHbound hCommutator

end Deficiency

/-- **G (truncation)** *The truncated Navier–Stokes Hamiltonian has vanishing
deficiency*: `H_N ψ = ± i ψ` forces `ψ = 0`.  On the finite-dimensional
truncation this **is** essential self-adjointness — the honest, provable core of
`book.tex` ~4199–4208.  Nothing is claimed here about the continuum operator. -/
theorem nsHamiltonian_hasZeroDeficiency :
    HasZeroDeficiency (Matrix.toEuclideanLin (nsHamiltonian d)) :=
  symmetric_hasZeroDeficiency _
    (Matrix.isHermitian_iff_isSymmetric.mp (nsHamiltonian_hermitian d))

/-- **G (truncation, adjoint form)** The same statement for the deficiency
spaces of the **adjoint**: no state `w` satisfies `⟪H_N v, w⟫ = ⟪v, ± i w⟫` for
all `v` except `w = 0`.  On the truncation the domain is the whole space, so
this is again essential self-adjointness; for a proper dense domain — the
continuum case — the corresponding statement is *not* proved here. -/
theorem nsHamiltonian_hasZeroDeficiencyOn :
    HasZeroDeficiencyOn (⊤ : Submodule ℂ (EuclideanSpace ℂ (Fin n)))
      (restrictToTop (Matrix.toEuclideanLin (nsHamiltonian d))) :=
  hasZeroDeficiencyOn_top_of_symmetric _
    (Matrix.isHermitian_iff_isSymmetric.mp (nsHamiltonian_hermitian d))

/-- **G.1** *The Navier–Stokes Hilbert space is a Fock space over a Fock space.*
The algebraic content is the exponential law `Sym(M × N) ≅ Sym M ⊗ Sym N`
(`BookProof.ChapterU.prodEquiv`): the tensor product of two Fock spaces is again
a Fock space, so the outer (trajectory-indexed) quantization of `nsSecondQuant`
below stays inside the same category and no infinite-dimensional tensor product
is needed. -/
noncomputable def nsFockOfFock (R M N : Type*) [CommRing R] [AddCommGroup M] [Module R M]
    [AddCommGroup N] [Module R N] :
    SymmetricAlgebra R (M × N) ≃ₐ[R] (SymmetricAlgebra R M ⊗[R] SymmetricAlgebra R N) :=
  BookProof.ChapterU.prodEquiv R M N

/-- **G.1/G.2** The second-quantized ("Fock of a Fock") form of an operator: with
outer ladder operators `A_k` and single-particle kernel `h`,
`Ĥ = ∑_{k,l} h_{kl} A†_k A_l`. -/
noncomputable def nsSecondQuant {m : ℕ} (A : Fin m → Matrix (Fin n) (Fin n) ℂ)
    (h : Matrix (Fin m) (Fin m) ℂ) : Matrix (Fin n) (Fin n) ℂ :=
  ∑ k : Fin m, ∑ l : Fin m, h k l • ((A k)ᴴ * A l)

/-- The outer generators: `inl k` is the creation operator `A†_k`, `inr l` the
annihilation operator `A_l`. -/
def nsOuterGen {m : ℕ} (A : Fin m → Matrix (Fin n) (Fin n) ℂ) :
    Fin m ⊕ Fin m → Matrix (Fin n) (Fin n) ℂ :=
  Sum.elim (fun k => (A k)ᴴ) A

/-- **G.2 (headline)** *The second-quantized operator is at most **quadratic** in
the outer ladder operators*: it is a finite linear combination of the words
`[A†_k, A_l]`, each of length `2`.  This is the Fock-of-Fock shadow of the
degree bound `nsHamiltonian_isPolynomial`, and it is the structure the
quadratic-growth hypothesis of Faris–Lavine/Sears needs. -/
theorem ns_outer_degree_le_two {m : ℕ} (A : Fin m → Matrix (Fin n) (Fin n) ℂ)
    (h : Matrix (Fin m) (Fin m) ℂ) :
    nsSecondQuant A h
        = ∑ a : Fin m × Fin m,
            h a.1 a.2 • (([Sum.inl a.1, Sum.inr a.2].map (nsOuterGen A)).prod)
      ∧ ∀ a : Fin m × Fin m, ([Sum.inl a.1, Sum.inr a.2] : List (Fin m ⊕ Fin m)).length ≤ 2 := by
  refine ⟨?_, fun a => by simp⟩
  simp [nsSecondQuant, nsOuterGen, Fintype.sum_prod_type]

/-- **G.3** The **comparison operator** of the outer Fock layer: the number
operator `N = ∑_k A†_k A_k`, the second-quantized `∫ 𝒩X A†[X] A[X]`. -/
noncomputable def nsNumberOp {m : ℕ} (A : Fin m → Matrix (Fin n) (Fin n) ℂ) :
    Matrix (Fin n) (Fin n) ℂ := ∑ k : Fin m, (A k)ᴴ * A k

/-- **G.3** The comparison operator is the second quantization of the identity
kernel. -/
theorem nsNumberOp_eq_secondQuant {m : ℕ} (A : Fin m → Matrix (Fin n) (Fin n) ℂ) :
    nsNumberOp A = nsSecondQuant A 1 := by
  simp [nsNumberOp, nsSecondQuant, Matrix.one_apply]

/-- **G.3** The comparison operator is positive semidefinite — the positivity the
Faris–Lavine relative bound is measured against. -/
theorem nsNumberOp_posSemidef {m : ℕ} (A : Fin m → Matrix (Fin n) (Fin n) ℂ) :
    (nsNumberOp A).PosSemidef := by
  refine Finset.sum_induction _ _ (fun a b ha hb => ha.add hb) Matrix.PosSemidef.zero ?_
  intro k _
  exact Matrix.posSemidef_conjTranspose_mul_self (A k)

end BookProof.NavierStokesFlow
