import Mathlib
import BookProof.ChapterNavierStokesFlow

/-!
# The second coordinate `y`, the field `u_i(y)` and its two gauge generators

Source: `book.tex`, chapter *"Free field parametrization in Classical Statistical
Field Theory and Navier–Stokes equations"* (~4133–4216) together with the
constraint taxonomy of *"Gauge transformations, constrained systems and
conditioned probability"* (~2222–2323).

`BookProof.ChapterNavierStokesEulerian` states the Eulerian constraints with the
velocity field written as `u_i(X) = u_i + u_{i,j}(X_j − x_j)`, i.e. with the
Taylor expansion centred at the space coordinate itself.  This module carries
out the refinement in which the expansion uses a **second coordinate** `y`:

* the degrees of freedom are the space coordinate `x_j`, the auxiliary
  coordinate `y_j`, the velocity modes `u_i`, the first-derivative modes
  `u_{i,j}` and the second-derivative (Laplacian) modes `u_{i,jj}`
  (`NSVar`);
* the field that appears in the Hamiltonian is
  `u_i(y) = u_i + u_{i,j} y_j` (`uField`);
* the gauge generator associated with `x` is the **standard momentum**
  `π^j = ∂/∂x_j` (`genX`);
* the gauge generator associated with `y` is the one **involving the derivative
  modes of `u_i`**,
  `G_j = ∂/∂y_j − u_{i,j} ∂/∂u_i` (`genY`):
  it translates `y` while compensating with the corresponding first-order change
  of the velocity modes, which is exactly the statement that `u_{i,j}` is the
  `y`-derivative of `u_i(y)`;
* the initial state has `y = 0`, so the field collapses to its point value there
  (`setYZero_uField`, `uFieldOp_apply_of_y_zero`) and the Hamiltonian built from
  `u_i(y)` acts as the ordinary Navier–Stokes Hamiltonian built from `u_i`
  (`setYZero_nsSymbol`, `hamiltonianOp_apply_of_y_zero`).

Both generators annihilate `u_i(y)` (`genX_uField`, `genY_uField`) and the
Hamiltonian symbol (`genX_nsSymbol`, `genY_nsSymbol`), and they form an abelian
(hence first-class) algebra (`genX_genX_commute`, `genX_genY_commute`,
`genY_genY_commute`).  The `y`-generator is sharp: changing the coefficient of
`y_j` in the field away from `u_{i,j}` destroys the invariance
(`genY_uField_perturbed_ne_zero`).

The realization is the polynomial one used throughout the Navier–Stokes
modules: the canonical variables are the generators `X v` of
`MvPolynomial NSVar ℂ` and the conjugate momenta are the partial derivatives
`MvPolynomial.pderiv v`, so that `[∂_v, X_w · ] = δ_{vw}` is the CCR
(`BookProof.NavierStokesFlow.ccr_field`).  A second, operator-theoretic section
reuses `fieldTaylor` to state the `y = 0` collapse and the reduction of the
Hamiltonian on the initial state for arbitrary operators on a complex vector
space.

Everything here is `sorry`-free and `axiom`-free.
-/

namespace BookProof.NavierStokesGaugeY

open MvPolynomial BookProof.NavierStokesFlow

/-! ## The canonical variables: two coordinates, the velocity and its derivatives -/

/-- The canonical coordinates of the construction: the space coordinate `x_j`,
the **second coordinate** `y_j` in which the velocity field is expanded, the
velocity modes `u_i`, the first-derivative modes `u_{i,j}` and the
second-derivative modes `u_{i,jj}`. -/
inductive NSVar
  | x : Fin 3 → NSVar
  | y : Fin 3 → NSVar
  | u : Fin 3 → NSVar
  | uD : Fin 3 → Fin 3 → NSVar
  | uL : Fin 3 → NSVar
deriving DecidableEq

/-- The algebra of polynomials in the canonical variables; the conjugate momenta
act on it as the partial derivatives `pderiv`. -/
abbrev NSAlg := MvPolynomial NSVar ℂ

/-! ### Two elementary facts about the momenta -/

/-- Partial derivatives commute: `∂_a ∂_b = ∂_b ∂_a`. -/
theorem pderiv_swap (a b : NSVar) (p : NSAlg) :
    pderiv a (pderiv b p) = pderiv b (pderiv a p) := by
  induction p using MvPolynomial.induction_on with
  | C c => simp
  | add p q hp hq => simp [hp, hq]
  | mul_X p n hp =>
      simp only [pderiv_mul, pderiv_X, Pi.single_apply, map_add, map_zero,
        Derivation.map_one_eq_zero, apply_ite (⇑(pderiv a)), apply_ite (⇑(pderiv b)), hp]
      split_ifs <;> ring

/-- The derivative modes are constants for the momentum conjugate to `u`. -/
theorem pderiv_u_mul_uD (m i j : Fin 3) (q : NSAlg) :
    pderiv (NSVar.u m) (X (NSVar.uD i j) * q) = X (NSVar.uD i j) * pderiv (NSVar.u m) q := by
  rw [pderiv_mul, pderiv_X_of_ne (by simp)]; ring

/-- The derivative modes are constants for the momentum conjugate to `y`. -/
theorem pderiv_y_mul_uD (m i j : Fin 3) (q : NSAlg) :
    pderiv (NSVar.y m) (X (NSVar.uD i j) * q) = X (NSVar.uD i j) * pderiv (NSVar.y m) q := by
  rw [pderiv_mul, pderiv_X_of_ne (by simp)]; ring

/-- The derivative modes are constants for the momentum conjugate to `x`. -/
theorem pderiv_x_mul_uD (m i j : Fin 3) (q : NSAlg) :
    pderiv (NSVar.x m) (X (NSVar.uD i j) * q) = X (NSVar.uD i j) * pderiv (NSVar.x m) q := by
  rw [pderiv_mul, pderiv_X_of_ne (by simp)]; ring

/-! ## The field in the second coordinate -/

/-- **The field appearing in the Hamiltonian**, expanded in the second
coordinate `y`: `u_i(y) = u_i + u_{i,j} y_j`. -/
noncomputable def uField (i : Fin 3) : NSAlg :=
  X (NSVar.u i) + ∑ j : Fin 3, X (NSVar.uD i j) * X (NSVar.y j)

/-- *The derivative modes are the `y`-derivatives of the field*:
`u_{i,j} = ∂u_i(y)/∂y_j`.  This is the constraint that the `y`-gauge generator
below implements. -/
theorem uField_pderiv_y (i j : Fin 3) :
    pderiv (NSVar.y j) (uField i) = X (NSVar.uD i j) := by
  simp [uField, pderiv_X, Pi.single_apply, Finset.sum_ite_eq', apply_ite]

/-- The field is the point value plus a term linear in `y`; in particular it has
no `x`-dependence. -/
theorem uField_pderiv_x (i j : Fin 3) : pderiv (NSVar.x j) (uField i) = 0 := by
  simp [uField, pderiv_X]

/-! ## The two gauge generators -/

/-- **The gauge generator for `x`: the standard momentum** `π^j = ∂/∂x_j`. -/
noncomputable def genX (j : Fin 3) : Module.End ℂ NSAlg :=
  (pderiv (NSVar.x j)).toLinearMap

/-- **The gauge generator for `y`: the one involving the derivative modes of
`u_i`**, `G_j = ∂/∂y_j − u_{i,j} ∂/∂u_i`.  It translates the second coordinate
and simultaneously shifts the velocity modes by the corresponding
first derivatives, which is what makes `u_i(y)` gauge invariant. -/
noncomputable def genY (j : Fin 3) : Module.End ℂ NSAlg :=
  (pderiv (NSVar.y j)).toLinearMap
    - ∑ i : Fin 3, (LinearMap.mulLeft ℂ (X (NSVar.uD i j) : NSAlg)) ∘ₗ
        (pderiv (NSVar.u i)).toLinearMap

@[simp] theorem genX_apply (j : Fin 3) (p : NSAlg) : genX j p = pderiv (NSVar.x j) p := rfl

theorem genY_apply (j : Fin 3) (p : NSAlg) :
    genY j p = pderiv (NSVar.y j) p - ∑ i : Fin 3, X (NSVar.uD i j) * pderiv (NSVar.u i) p := by
  simp [genY]

/-- Both generators are first-order differential operators: `G_j` obeys the
Leibniz rule, so it generates a one-parameter group of algebra automorphisms —
a genuine gauge transformation. -/
theorem genY_leibniz (j : Fin 3) (p q : NSAlg) :
    genY j (p * q) = genY j p * q + p * genY j q := by
  have key : ∑ i : Fin 3, X (NSVar.uD i j) * pderiv (NSVar.u i) (p * q)
      = (∑ i : Fin 3, X (NSVar.uD i j) * pderiv (NSVar.u i) p) * q
        + p * ∑ i : Fin 3, X (NSVar.uD i j) * pderiv (NSVar.u i) q := by
    rw [Finset.sum_mul, Finset.mul_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [pderiv_mul]; ring
  rw [genY_apply, genY_apply, genY_apply, key, pderiv_mul]
  ring

/-- The `x`-generator obeys the Leibniz rule as well. -/
theorem genX_leibniz (j : Fin 3) (p q : NSAlg) :
    genX j (p * q) = genX j p * q + p * genX j q := by
  rw [genX_apply, genX_apply, genX_apply, pderiv_mul]

/-! ### The generators as momenta: the canonical commutation relations -/

/-- **The `x`-generator is the standard momentum**: `[π^j, x_k · ] = δ^j_k`. -/
theorem genX_ccr_x (j k : Fin 3) (p : NSAlg) :
    genX j (X (NSVar.x k) * p) - X (NSVar.x k) * genX j p
      = if NSVar.x j = NSVar.x k then p else 0 :=
  ccr_field _ _ p

/-- The `x`-momentum ignores the second coordinate: `[π^j, y_k · ] = 0`. -/
theorem genX_ccr_y (j k : Fin 3) (p : NSAlg) :
    genX j (X (NSVar.y k) * p) - X (NSVar.y k) * genX j p = 0 := by
  rw [genX_apply, genX_apply, pderiv_mul, pderiv_X_of_ne (by simp)]; ring

/-- **The `y`-generator is the momentum conjugate to the second coordinate**:
`[G_j, y_k · ] = δ_{jk}`. -/
theorem genY_ccr_y (j k : Fin 3) (p : NSAlg) :
    genY j (X (NSVar.y k) * p) - X (NSVar.y k) * genY j p = if j = k then p else 0 := by
  have hsum : ∑ i : Fin 3, X (NSVar.uD i j) * pderiv (NSVar.u i) (X (NSVar.y k) * p)
      = X (NSVar.y k) * ∑ i : Fin 3, X (NSVar.uD i j) * pderiv (NSVar.u i) p := by
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [pderiv_mul, pderiv_X_of_ne (by simp)]; ring
  rw [genY_apply, genY_apply, hsum, pderiv_mul, pderiv_X, Pi.single_apply]
  simp only [NSVar.y.injEq]
  by_cases h : j = k
  · subst h; simp; ring
  · rw [if_neg (fun hh : k = j => h hh.symm), if_neg h]; ring

/-- **The `y`-generator involves the derivative modes of `u_i`**: translating `y`
shifts each velocity mode by its first derivative,
`[G_j, u_i · ] = −u_{i,j}`. -/
theorem genY_shifts_velocity (i j : Fin 3) (p : NSAlg) :
    genY j (X (NSVar.u i) * p) - X (NSVar.u i) * genY j p = -(X (NSVar.uD i j) * p) := by
  have expand : ∀ m : Fin 3, X (NSVar.uD m j) * pderiv (NSVar.u m) (X (NSVar.u i) * p)
      = (if m = i then X (NSVar.uD m j) * p else 0)
        + X (NSVar.u i) * (X (NSVar.uD m j) * pderiv (NSVar.u m) p) := by
    intro m
    rw [pderiv_mul, pderiv_X, Pi.single_apply]
    simp only [NSVar.u.injEq]
    by_cases h : m = i
    · subst h; simp; ring
    · rw [if_neg (fun hh : i = m => h hh.symm), if_neg h]; ring
  have hsum : ∑ m : Fin 3, X (NSVar.uD m j) * pderiv (NSVar.u m) (X (NSVar.u i) * p)
      = X (NSVar.uD i j) * p
        + X (NSVar.u i) * ∑ m : Fin 3, X (NSVar.uD m j) * pderiv (NSVar.u m) p := by
    rw [Finset.sum_congr rfl fun m _ => expand m, Finset.sum_add_distrib,
      Finset.sum_ite_eq' Finset.univ i (fun m => X (NSVar.uD m j) * p),
      if_pos (Finset.mem_univ i), Finset.mul_sum]
  rw [genY_apply, genY_apply, hsum, pderiv_mul, pderiv_X_of_ne (by simp)]
  ring

/-- The derivative modes themselves are gauge invariant. -/
@[simp] theorem genY_X_uD (i j k : Fin 3) : genY k (X (NSVar.uD i j)) = 0 := by
  simp [genY_apply]

/-- The second-derivative modes are gauge invariant. -/
@[simp] theorem genY_X_uL (i k : Fin 3) : genY k (X (NSVar.uL i)) = 0 := by
  simp [genY_apply]

/-! ### The gauge invariance of the field -/

/-- **Headline.** The field appearing in the Hamiltonian is annihilated by the
`y`-gauge generator: `(∂/∂y_j − u_{k,j} ∂/∂u_k) (u_i + u_{i,l} y_l) = 0`.  The
shift of the second coordinate is exactly compensated by the shift of the
velocity modes by their first derivatives. -/
theorem genY_uField (i j : Fin 3) : genY j (uField i) = 0 := by
  simp [genY_apply, uField, pderiv_X, Pi.single_apply, Finset.sum_ite_eq', apply_ite]

/-- The field is annihilated by the `x`-gauge generator (the standard momentum):
the expansion in the second coordinate carries no `x`-dependence. -/
theorem genX_uField (i j : Fin 3) : genX j (uField i) = 0 := uField_pderiv_x i j

/-- **Sharpness of the `y`-generator.**  If the coefficient of `y_j` in the field
is changed by a non-zero constant `c`, gauge invariance fails: `G_j` returns `c`.
So `u_{i,j}` is the *only* admissible coefficient, which is the content of the
constraint `u_{i,j} = ∂_j u_i`. -/
theorem genY_uField_perturbed (i j : Fin 3) (c : ℂ) :
    genY j (uField i + C c * X (NSVar.y j)) = C c := by
  have h := genY_uField i j
  have h2 : genY j (C c * X (NSVar.y j)) = C c := by
    simp [genY_apply, pderiv_X]
  rw [map_add, h, h2, zero_add]

/-- The perturbed field is not gauge invariant for `c ≠ 0`. -/
theorem genY_uField_perturbed_ne_zero (i j : Fin 3) (c : ℂ) (hc : c ≠ 0) :
    genY j (uField i + C c * X (NSVar.y j)) ≠ 0 := by
  rw [genY_uField_perturbed]
  simpa using hc

/-! ### The gauge algebra is abelian (first class) -/

/-- Expansion of a double application of the `y`-generator. -/
theorem genY_genY_expand (j k : Fin 3) (p : NSAlg) :
    genY j (genY k p) =
      pderiv (NSVar.y j) (pderiv (NSVar.y k) p)
      - ∑ i : Fin 3, X (NSVar.uD i j) * pderiv (NSVar.y k) (pderiv (NSVar.u i) p)
      - ∑ i : Fin 3, X (NSVar.uD i k) * pderiv (NSVar.y j) (pderiv (NSVar.u i) p)
      + ∑ i : Fin 3, ∑ m : Fin 3,
          X (NSVar.uD i j) * X (NSVar.uD m k) * pderiv (NSVar.u i) (pderiv (NSVar.u m) p) := by
  simp only [genY_apply, map_sub, map_sum, pderiv_u_mul_uD, pderiv_y_mul_uD,
    Finset.sum_sub_distrib, pderiv_swap (NSVar.u _) (NSVar.y _)]
  rw [Finset.sum_comm]
  ring_nf

/-- **The `y`-gauge generators commute**: the gauge algebra of the second
coordinate is abelian, hence first class. -/
theorem genY_genY_commute (j k : Fin 3) : ⁅genY j, genY k⁆ = 0 := by
  refine LinearMap.ext fun p => ?_
  have hsum : ∑ i : Fin 3, ∑ m : Fin 3,
        X (NSVar.uD i j) * X (NSVar.uD m k) * pderiv (NSVar.u i) (pderiv (NSVar.u m) p)
      = ∑ i : Fin 3, ∑ m : Fin 3,
        X (NSVar.uD i k) * X (NSVar.uD m j) * pderiv (NSVar.u i) (pderiv (NSVar.u m) p) := by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun m _ => ?_
    rw [pderiv_swap (NSVar.u m) (NSVar.u i)]
    ring
  simp only [Ring.lie_def, LinearMap.sub_apply, Module.End.mul_apply, LinearMap.zero_apply,
    genY_genY_expand, pderiv_swap (NSVar.y j) (NSVar.y k), hsum]
  ring

/-- **The `x`- and `y`-gauge generators commute.** -/
theorem genX_genY_commute (j k : Fin 3) : ⁅genX j, genY k⁆ = 0 := by
  refine LinearMap.ext fun p => ?_
  simp only [Ring.lie_def, LinearMap.sub_apply, Module.End.mul_apply, LinearMap.zero_apply,
    genX_apply, genY_apply, map_sub, map_sum, pderiv_x_mul_uD,
    pderiv_swap (NSVar.x j) (NSVar.u _), pderiv_swap (NSVar.x j) (NSVar.y k)]
  ring

/-- **The `x`-gauge generators commute** with each other. -/
theorem genX_genX_commute (j k : Fin 3) : ⁅genX j, genX k⁆ = 0 := by
  refine LinearMap.ext fun p => ?_
  simp only [Ring.lie_def, LinearMap.sub_apply, Module.End.mul_apply, LinearMap.zero_apply,
    genX_apply, pderiv_swap (NSVar.x j) (NSVar.x k)]
  ring

/-! ## The Hamiltonian symbol built from the field `u_i(y)` -/

/-- The Navier–Stokes symbol `A_i = u_j(y) u_{i,j} − ν u_{i,jj}` with the field
written in the second coordinate: this is the operator that appears in
`H(x) = π^i A_i + h.c.` (`book.tex` ~4184–4189). -/
noncomputable def nsSymbol (nu : ℂ) (i : Fin 3) : NSAlg :=
  (∑ j : Fin 3, uField j * X (NSVar.uD i j)) - C nu * X (NSVar.uL i)

/-- The same symbol with the point values `u_j` in place of the fields `u_j(y)`:
the ordinary Navier–Stokes expression. -/
noncomputable def nsSymbolPoint (nu : ℂ) (i : Fin 3) : NSAlg :=
  (∑ j : Fin 3, X (NSVar.u j) * X (NSVar.uD i j)) - C nu * X (NSVar.uL i)

/-- **The Hamiltonian symbol is invariant under the `y`-gauge generator.** -/
theorem genY_nsSymbol (nu : ℂ) (i j : Fin 3) : genY j (nsSymbol nu i) = 0 := by
  have hC : genY j (C nu) = 0 := by simp [genY_apply]
  simp only [nsSymbol, map_sub, map_sum, genY_leibniz, genY_uField, genY_X_uD, genY_X_uL, hC,
    zero_mul, mul_zero, add_zero, Finset.sum_const_zero, sub_self]

/-- **The Hamiltonian symbol is invariant under the `x`-gauge generator** (the
standard momentum). -/
theorem genX_nsSymbol (nu : ℂ) (i j : Fin 3) : genX j (nsSymbol nu i) = 0 := by
  have hC : genX j (C nu) = 0 := by simp
  have huD : ∀ k : Fin 3, genX j (X (NSVar.uD i k)) = 0 := by
    intro k; simp
  have huL : genX j (X (NSVar.uL i)) = 0 := by simp
  simp only [nsSymbol, map_sub, map_sum, genX_leibniz, genX_uField, huD, huL, hC,
    zero_mul, mul_zero, add_zero, Finset.sum_const_zero, sub_self]

/-! ## The initial state: `y` evaluates to `0` -/

/-- Evaluation of the second coordinate at the initial value `y = 0`, as an
algebra map: all other canonical variables are left untouched. -/
noncomputable def setYZero : NSAlg →ₐ[ℂ] NSAlg :=
  aeval fun v => match v with
    | NSVar.y _ => 0
    | v => X v

@[simp] theorem setYZero_X_y (j : Fin 3) : setYZero (X (NSVar.y j)) = 0 := by simp [setYZero]

@[simp] theorem setYZero_X_u (i : Fin 3) : setYZero (X (NSVar.u i)) = X (NSVar.u i) := by
  simp [setYZero]

@[simp] theorem setYZero_X_uD (i j : Fin 3) :
    setYZero (X (NSVar.uD i j)) = X (NSVar.uD i j) := by simp [setYZero]

@[simp] theorem setYZero_X_uL (i : Fin 3) : setYZero (X (NSVar.uL i)) = X (NSVar.uL i) := by
  simp [setYZero]

/-- **Headline.** *In the initial state the second coordinate evaluates to zero*,
and there the field collapses to its point value: `u_i(0) = u_i`. -/
theorem setYZero_uField (i : Fin 3) : setYZero (uField i) = X (NSVar.u i) := by
  simp [uField]

/-- **Headline.** *On the initial state the Hamiltonian symbol built from the
fields `u_j(y)` is the ordinary Navier–Stokes symbol* `u_j u_{i,j} − ν u_{i,jj}`:
the second coordinate is invisible in the initial data, and only the gauge
structure remembers it. -/
theorem setYZero_nsSymbol (nu : ℂ) (i : Fin 3) :
    setYZero (nsSymbol nu i) = nsSymbolPoint nu i := by
  simp [nsSymbol, nsSymbolPoint, setYZero_uField]

/-! ## The operator form: `y = 0` as an eigenvalue condition on the initial state -/

section Operators

variable {E : Type*} [AddCommGroup E] [Module ℂ E]

/-- The operator-valued field in the second coordinate,
`u_i(Y) = u_i + u_{i,j} Y_j`: the `fieldTaylor` of
`BookProof.ChapterNavierStokesFlow` with the *second coordinate operators* `Y`
expanded around `y = 0`. -/
noncomputable def uFieldOp (u : Fin 3 → E →ₗ[ℂ] E) (uD : Fin 3 → Fin 3 → E →ₗ[ℂ] E)
    (Y : Fin 3 → E →ₗ[ℂ] E) (i : Fin 3) : E →ₗ[ℂ] E :=
  fieldTaylor (u i) (uD i) Y 0

/-- **The field collapses on the initial state**: if the second coordinate
evaluates to `0` on `v` (i.e. `v` is an eigenvector of every `Y_j` with
eigenvalue `0`), then `u_i(Y) v = u_i v`. -/
theorem uFieldOp_apply_of_y_zero (u : Fin 3 → E →ₗ[ℂ] E) (uD : Fin 3 → Fin 3 → E →ₗ[ℂ] E)
    (Y : Fin 3 → E →ₗ[ℂ] E) (v : E) (hv : ∀ j, Y j v = 0) (i : Fin 3) :
    uFieldOp u uD Y i v = u i v :=
  field_evaluates_to_value (u i) (uD i) Y 0 v (by simpa using hv)

/-- The `y = 0` condition is preserved by any operator commuting with the second
coordinate. -/
theorem y_zero_of_commute (Y : Fin 3 → E →ₗ[ℂ] E) (T : E →ₗ[ℂ] E)
    (hT : ∀ j, Y j ∘ₗ T = T ∘ₗ Y j) (v : E) (hv : ∀ j, Y j v = 0) (j : Fin 3) :
    Y j (T v) = 0 := by
  have := congrArg (fun L : E →ₗ[ℂ] E => L v) (hT j)
  simpa [hv j] using this

/-- The Navier–Stokes operator `A_i = ∑_j u_j(Y) u_{i,j} − ν u_{i,jj}` built from
the fields in the second coordinate. -/
noncomputable def advectionOp (nu : ℂ) (u : Fin 3 → E →ₗ[ℂ] E)
    (uD : Fin 3 → Fin 3 → E →ₗ[ℂ] E) (uL : Fin 3 → E →ₗ[ℂ] E) (Y : Fin 3 → E →ₗ[ℂ] E)
    (i : Fin 3) : E →ₗ[ℂ] E :=
  (∑ j : Fin 3, uFieldOp u uD Y j ∘ₗ uD i j) - nu • uL i

/-- The Navier–Stokes operator built from the point values,
`A_i = ∑_j u_j u_{i,j} − ν u_{i,jj}`. -/
noncomputable def advectionPoint (nu : ℂ) (u : Fin 3 → E →ₗ[ℂ] E)
    (uD : Fin 3 → Fin 3 → E →ₗ[ℂ] E) (uL : Fin 3 → E →ₗ[ℂ] E) (i : Fin 3) : E →ₗ[ℂ] E :=
  (∑ j : Fin 3, u j ∘ₗ uD i j) - nu • uL i

/-- On the initial state (`y = 0`) the operator built from the fields `u_j(Y)`
agrees with the one built from the point values. -/
theorem advectionOp_apply_of_y_zero (nu : ℂ) (u : Fin 3 → E →ₗ[ℂ] E)
    (uD : Fin 3 → Fin 3 → E →ₗ[ℂ] E) (uL : Fin 3 → E →ₗ[ℂ] E) (Y : Fin 3 → E →ₗ[ℂ] E)
    (hcomm : ∀ i j k, Y k ∘ₗ uD i j = uD i j ∘ₗ Y k) (v : E) (hv : ∀ j, Y j v = 0)
    (i : Fin 3) :
    advectionOp nu u uD uL Y i v = advectionPoint nu u uD uL i v := by
  simp only [advectionOp, advectionPoint, LinearMap.sub_apply, LinearMap.sum_apply,
    LinearMap.comp_apply]
  congr 1
  refine Finset.sum_congr rfl fun j _ => ?_
  exact uFieldOp_apply_of_y_zero u uD Y (uD i j v)
    (fun k => y_zero_of_commute Y (uD i j) (fun k => hcomm i j k) v hv k) j

/-- The truncated Navier–Stokes Hamiltonian `H = ∑_i (π^i A_i + A_i π^i)` with
the fields expanded in the second coordinate. -/
noncomputable def hamiltonianOp (nu : ℂ) (mom : Fin 3 → E →ₗ[ℂ] E) (u : Fin 3 → E →ₗ[ℂ] E)
    (uD : Fin 3 → Fin 3 → E →ₗ[ℂ] E) (uL : Fin 3 → E →ₗ[ℂ] E) (Y : Fin 3 → E →ₗ[ℂ] E) :
    E →ₗ[ℂ] E :=
  ∑ i : Fin 3, (mom i ∘ₗ advectionOp nu u uD uL Y i + advectionOp nu u uD uL Y i ∘ₗ mom i)

/-- The same Hamiltonian with the point values of the fields. -/
noncomputable def hamiltonianPoint (nu : ℂ) (mom : Fin 3 → E →ₗ[ℂ] E) (u : Fin 3 → E →ₗ[ℂ] E)
    (uD : Fin 3 → Fin 3 → E →ₗ[ℂ] E) (uL : Fin 3 → E →ₗ[ℂ] E) : E →ₗ[ℂ] E :=
  ∑ i : Fin 3, (mom i ∘ₗ advectionPoint nu u uD uL i + advectionPoint nu u uD uL i ∘ₗ mom i)

/-- **Headline.** *On the initial state, where the second coordinate evaluates to
zero, the Hamiltonian built from the fields `u_i(y)` acts as the ordinary
Navier–Stokes Hamiltonian built from the point values.*  The second coordinate is
therefore a pure gauge addition: it carries the constraint
`u_{i,j} = ∂ u_i/∂ y_j` without changing the dynamics of the initial data. -/
theorem hamiltonianOp_apply_of_y_zero (nu : ℂ) (mom : Fin 3 → E →ₗ[ℂ] E)
    (u : Fin 3 → E →ₗ[ℂ] E) (uD : Fin 3 → Fin 3 → E →ₗ[ℂ] E) (uL : Fin 3 → E →ₗ[ℂ] E)
    (Y : Fin 3 → E →ₗ[ℂ] E) (hcomm : ∀ i j k, Y k ∘ₗ uD i j = uD i j ∘ₗ Y k)
    (hmom : ∀ i k, Y k ∘ₗ mom i = mom i ∘ₗ Y k) (v : E) (hv : ∀ j, Y j v = 0) :
    hamiltonianOp nu mom u uD uL Y v = hamiltonianPoint nu mom u uD uL v := by
  simp only [hamiltonianOp, hamiltonianPoint, LinearMap.sum_apply, LinearMap.add_apply,
    LinearMap.comp_apply]
  refine Finset.sum_congr rfl fun i _ => ?_
  have h1 : advectionOp nu u uD uL Y i v = advectionPoint nu u uD uL i v :=
    advectionOp_apply_of_y_zero nu u uD uL Y hcomm v hv i
  have h2 : advectionOp nu u uD uL Y i (mom i v) = advectionPoint nu u uD uL i (mom i v) :=
    advectionOp_apply_of_y_zero nu u uD uL Y hcomm (mom i v)
      (fun k => y_zero_of_commute Y (mom i) (fun k => hmom i k) v hv k) i
  rw [h1, h2]

end Operators

end BookProof.NavierStokesGaugeY
