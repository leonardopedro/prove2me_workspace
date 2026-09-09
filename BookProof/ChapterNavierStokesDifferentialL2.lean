import Mathlib
import BookProof.ChapterHermiteProductBasis
import BookProof.ChapterNavierStokesCanonicalVector
import BookProof.ChapterNavierStokesLagrangianEsa

/-!
# The differential realization of the Navier–Stokes quadratic symbol on `L²(du₁du₂du₃)`

`BookProof.ChapterNavierStokesThreeComponent` proves that the coupled three-component
fiber Hamiltonian `H = ∑ᵢ ½(πᵢVᵢ + Vᵢπᵢ)`, `Vᵢ(u) = ∑ₖ A_{ik}u_k + c_i`, is essentially
self-adjoint on the finite-mode core of `ℓ²(Vel)`, `Vel = Fin 3 → ℕ`, and
`BookProof.ChapterNavierStokesCanonicalVector` shows that this sequence-space matrix *is*
the Weyl-ordered expression in the abstract ladder operators of that space.  What both
modules record as the honest open step is the **differential realization**: the operator
written with `πᵢ = −i ∂/∂uᵢ` and `uᵢ` a genuine multiplication operator, on the Hermite
core of `L²(du₁du₂du₃)`.  This module takes that step.

## The setting

The Hilbert space is `L²(ℝ³)` and the dense domain is the Gauss–polynomial (product
Hermite) core `polyGaussCore` of `BookProof.ChapterHermiteProductCore`: the functions
`p(u)·e^{-‖u‖²/4}` with `p` a polynomial.  Since `pgMap` is injective, the core carries the
polynomial coordinates `coreEquiv`, and an operator on the core is given by a polynomial
operator (`coreOp`).  Two such operators are the physical ones:

* `posOp i` — multiplication by the coordinate `uᵢ` (`pgFun_mulXPoly`);
* `momOp i` — the differential operator `πᵢ = −i ∂/∂uᵢ`.  That it *is* the derivative is
  `momOp_apply_eq_differential`: the value of `momOp i` at `p·e^{-‖u‖²/4}` is, pointwise,
  `−i` times the honest derivative `deriv (fun t => f (u with uᵢ := t)) uᵢ` of the function
  along the `i`-th coordinate (Mathlib's `deriv`, `hasDerivAt_pgFun_sec`).

`comm_momOp_posOp` is the canonical commutation relation `[πᵢ, u_k] = −i δ_{ik}` for these
genuinely differential operators.

## The Hamiltonian and the transport

`nsDiffH A c = ∑ᵢ ½(πᵢ Vᵢ + Vᵢ πᵢ)` with `Vᵢ` the multiplication operator by the affine
field `∑ₖ A_{ik}u_k + c_i` is the Weyl quantization of the Navier–Stokes quadratic symbol
`A_i(u) = u_j u_{i,j} − ν u_{i,jj}` at one Eulerian fiber (linear part the velocity
gradient, constant part `−ν` times the velocity Laplacian).

The **unitary transport** is `velUnitary : ℓ²(Vel) ≃ₗᵢ L²(ℝ³)`, the Hilbert-basis
isomorphism given by the product Hermite functions
(`BookProof.ChapterHermiteProductBasis`).  It carries the finite-mode core onto the
Gauss–polynomial core (`map_finiteModes`) and the abstract ladder operators onto the
differential ones (`intertwine_ann`, `intertwine_cre`), hence the abstract canonical
Hamiltonian onto the differential one (`conj_canH`).  The conclusions:

* `nsDiffH_essentiallySelfAdjointOn_core` — the **differentially written** Navier–Stokes
  quadratic symbol is essentially self-adjoint on the Hermite core of `L²(ℝ³)`, for every
  real velocity gradient and every constant part;
* `nsQuadraticDiffH_essentiallySelfAdjointOn_core` — the same with the coefficients spelled
  out as `(ν, u_{i,j}, u_{i,jj})`;
* `nsDiffH_not_bounded`, `polyGaussCore_dense_L2` — the operator is genuinely unbounded and
  the domain is dense, so the statement is not a bounded-operator artefact.

## Honest boundary

Nothing here claims global regularity of the *classical* Navier–Stokes PDE (Contention D5,
the deliberate scope cut): the theorem is about the Hilbert-space operator at one Eulerian
fiber, where the derivative fields `u_{i,j}`, `u_{i,jj}` are independent canonical
coordinates.
-/

namespace BookProof.NavierStokesFlow.DifferentialL2

open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LpNat BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.CanonicalVector
open BookProof.NavierStokesFlow.LagrangianEsa

noncomputable section

/-! ## Differentiating along one coordinate -/

variable {d : ℕ}

/-- The line through `x` in the `i`-th coordinate direction. -/
def sec (i : Fin d) (x : Vd d) (t : ℝ) : Vd d :=
  (WithLp.toLp 2 (Function.update (WithLp.ofLp x) i t) : Vd d)

theorem sec_apply (i : Fin d) (x : Vd d) (t : ℝ) (j : Fin d) :
    (sec i x t) j = if j = i then t else x j := by
  simp [sec, Function.update_apply]

@[simp] theorem sec_self (i : Fin d) (x : Vd d) : sec i x (x i) = x := by simp [sec]

theorem norm_sq_sec (i : Fin d) (x : Vd d) (t : ℝ) :
    ‖sec i x t‖ ^ 2 = (∑ j ∈ Finset.univ.erase i, (x j) ^ 2) + t ^ 2 := by
  classical
  rw [norm_sq_eq_sum, ← Finset.add_sum_erase _ _ (Finset.mem_univ i), sec_apply]
  simp only []
  rw [add_comm]
  congr 1
  exact Finset.sum_congr rfl fun j hj => by rw [sec_apply, if_neg (Finset.ne_of_mem_erase hj)]

theorem hasDerivAt_gaussD_sec (i : Fin d) (x : Vd d) (t : ℝ) :
    HasDerivAt (fun s : ℝ => gaussD (sec i x s)) (-(t / 2) * gaussD (sec i x t)) t := by
  classical
  set S := ∑ j ∈ Finset.univ.erase i, (x j) ^ 2 with hS
  have hfun : (fun s : ℝ => gaussD (sec i x s)) = fun s : ℝ => Real.exp (-(S + s ^ 2) / 4) := by
    funext s
    rw [gaussD, norm_sq_sec]
  rw [hfun]
  have h1 : HasDerivAt (fun s : ℝ => -(S + s ^ 2) / 4) (-(2 * t) / 4) t := by
    have h : HasDerivAt (fun s : ℝ => -(S + s ^ 2) / 4) (-(0 + 2 * t) / 4) t := by
      have h0 : HasDerivAt (fun s : ℝ => S + s ^ 2) (0 + 2 * t) t := by
        simpa using ((hasDerivAt_pow 2 t).const_add S)
      exact h0.neg.div_const 4
    simpa using h
  have h2 := (Real.hasDerivAt_exp (-(S + t ^ 2) / 4)).comp t h1
  convert h2 using 1
  rw [gaussD, norm_sq_sec]
  ring

/-- The derivative of a polynomial along one coordinate is the partial derivative. -/
theorem hasDerivAt_eval_update (i : Fin d) (p : MvPolynomial (Fin d) ℂ) (x : Fin d → ℂ) (t : ℂ) :
    HasDerivAt (fun s : ℂ => MvPolynomial.eval (Function.update x i s) p)
      (MvPolynomial.eval (Function.update x i t) (pderiv i p)) t := by
  classical
  induction p using MvPolynomial.induction_on with
  | C a => simpa using (hasDerivAt_const t (a : ℂ))
  | add p q hp hq => simpa [map_add] using hp.add hq
  | mul_X p j hp =>
      by_cases hj : j = i
      · subst hj
        have hX : HasDerivAt (fun s : ℂ => MvPolynomial.eval (Function.update x j s) (X j))
            1 t := by simpa using hasDerivAt_id t
        have h := hp.mul hX
        have hpd : pderiv j (p * X j) = X j * pderiv j p + p := by
          rw [Derivation.leibniz]
          simp [smul_eq_mul]
          ring
        rw [hpd]
        simp only [map_add, map_mul, MvPolynomial.eval_X, Function.update_self] at h ⊢
        convert h using 1
        ring
      · have hX : HasDerivAt (fun s : ℂ => MvPolynomial.eval (Function.update x i s) (X j))
            0 t := by
          simp only [MvPolynomial.eval_X, Function.update_apply, hj]
          exact hasDerivAt_const _ _
        have h := hp.mul hX
        have hpd : pderiv i (p * X j) = X j * pderiv i p := by
          rw [Derivation.leibniz]
          simp [Ne.symm hj]
        rw [hpd]
        simp only [map_mul, MvPolynomial.eval_X] at h ⊢
        convert h using 1
        ring

theorem hasDerivAt_evalSec (i : Fin d) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    HasDerivAt (fun t : ℝ => MvPolynomial.eval (fun j => (((sec i x t) j : ℝ) : ℂ)) p)
      (MvPolynomial.eval (fun j => ((x j : ℝ) : ℂ)) (pderiv i p)) (x i) := by
  classical
  have hupd : ∀ t : ℝ, (fun j => (((sec i x t) j : ℝ) : ℂ))
      = Function.update (fun j => ((x j : ℝ) : ℂ)) i ((t : ℝ) : ℂ) := by
    intro t
    funext j
    rw [sec_apply, Function.update_apply]
    by_cases hj : j = i <;> simp [hj]
  have hbase := hasDerivAt_eval_update i p (fun j => ((x j : ℝ) : ℂ)) (((x i : ℝ)) : ℂ)
  have h := hbase.comp_ofReal (z := x i)
  have heq : (fun y : ℝ => MvPolynomial.eval
        (Function.update (fun j => ((x j : ℝ) : ℂ)) i ((y : ℝ) : ℂ)) p)
      = fun t : ℝ => MvPolynomial.eval (fun j => (((sec i x t) j : ℝ) : ℂ)) p := by
    funext t; rw [hupd t]
  rw [heq] at h
  have hfun : Function.update (fun j => ((x j : ℝ) : ℂ)) i (((x i : ℝ)) : ℂ)
      = fun j => ((x j : ℝ) : ℂ) := by
    funext j
    rw [Function.update_apply]
    by_cases hj : j = i <;> simp [hj]
  rwa [hfun] at h

/-- **The coordinate derivative of a Gauss–polynomial**:
`∂ᵢ(p·e^{-‖u‖²/4}) = (∂ᵢp − (uᵢ/2)p)·e^{-‖u‖²/4}`.  This is the analytic fact that turns
the polynomial operators of `BookProof.ChapterHermiteProductBasis` into genuine
differential operators. -/
theorem hasDerivAt_pgFun_sec (i : Fin d) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    HasDerivAt (fun t : ℝ => pgFun p (sec i x t))
      (pgFun (pderiv i p - (1/2 : ℂ) • (X i * p)) x) (x i) := by
  have hg : HasDerivAt (fun t : ℝ => ((gaussD (sec i x t) : ℝ) : ℂ))
      (((-(x i / 2) * gaussD x : ℝ)) : ℂ) (x i) := by
    have h := (hasDerivAt_gaussD_sec i x (x i)).ofReal_comp
    simpa using h
  have hp := hasDerivAt_evalSec i p x
  have h := hp.mul hg
  have hfun : (fun t : ℝ => pgFun p (sec i x t))
      = (fun t : ℝ => MvPolynomial.eval (fun j => (((sec i x t) j : ℝ) : ℂ)) p)
        * (fun t : ℝ => ((gaussD (sec i x t) : ℝ) : ℂ)) := by
    funext t; simp [pgFun]
  rw [hfun]
  convert h using 1
  rw [sec_self]
  simp only [pgFun, map_sub, MvPolynomial.smul_eval, map_mul, MvPolynomial.eval_X]
  push_cast
  ring

/-! ## The polynomial coordinates of the core -/

/-- The Gauss–polynomial core, coordinatized by polynomials. -/
def coreEquiv : MvPolynomial (Fin d) ℂ ≃ₗ[ℂ] (polyGaussCore (d := d)) :=
  LinearEquiv.ofInjective (pgMap (d := d)) (pgMap_injective (d := d))

theorem coreEquiv_coe (p : MvPolynomial (Fin d) ℂ) :
    ((coreEquiv p : polyGaussCore (d := d)) : L2d d) = pgLp p := rfl

/-- An operator on the core, given by an operator on the polynomial coordinates. -/
def coreOp (T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ) :
    (polyGaussCore (d := d)) →ₗ[ℂ] (polyGaussCore (d := d)) :=
  (coreEquiv (d := d)).toLinearMap ∘ₗ T ∘ₗ (coreEquiv (d := d)).symm.toLinearMap

theorem coreOp_coreEquiv (T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ)
    (p : MvPolynomial (Fin d) ℂ) : coreOp T (coreEquiv p) = coreEquiv (T p) := by
  simp [coreOp]

theorem coreOp_coe (T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ)
    (p : MvPolynomial (Fin d) ℂ) :
    ((coreOp T (coreEquiv p) : polyGaussCore (d := d)) : L2d d) = pgLp (T p) := by
  rw [coreOp_coreEquiv, coreEquiv_coe]

/-! ## The canonical pair: multiplication by `uᵢ` and `−i ∂/∂uᵢ` -/

/-- Multiplication by the coordinate, on polynomials. -/
def mulXPoly (i : Fin d) : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ where
  toFun p := X i * p
  map_add' p q := by rw [mul_add]
  map_smul' c p := by simp

/-- The momentum `−i ∂/∂uᵢ`, on polynomial coordinates. -/
def momPoly (i : Fin d) : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ where
  toFun p := C (-Complex.I) * (pderiv i p - C (1/2 : ℂ) * (X i * p))
  map_add' p q := by simp only [map_add, mul_add]; ring
  map_smul' c p := by
    simp only [RingHom.id_apply, MvPolynomial.smul_eq_C_mul, MvPolynomial.pderiv_C_mul]; ring

@[simp] theorem mulXPoly_apply (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    mulXPoly i p = X i * p := rfl

@[simp] theorem momPoly_apply (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    momPoly i p = C (-Complex.I) * (pderiv i p - C (1/2 : ℂ) * (X i * p)) := rfl

/-- **The position operator** `uᵢ` on the Hermite core of `L²(ℝᵈ)`. -/
def posOp (i : Fin d) : (polyGaussCore (d := d)) →ₗ[ℂ] (polyGaussCore (d := d)) :=
  coreOp (mulXPoly i)

/-- **The momentum operator** `πᵢ = −i ∂/∂uᵢ` on the Hermite core of `L²(ℝᵈ)`. -/
def momOp (i : Fin d) : (polyGaussCore (d := d)) →ₗ[ℂ] (polyGaussCore (d := d)) :=
  coreOp (momPoly i)

/-- **The position operator is multiplication by the coordinate**, pointwise. -/
theorem posOp_apply_eq_mul (i : Fin d) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    pgFun (mulXPoly i p) x = ((x i : ℝ) : ℂ) * pgFun p x := by
  simp [pgFun, mulXPoly]
  ring

/-- **The momentum operator is the derivative**: at every point, the value of `momOp i` on
`f = p·e^{-‖u‖²/4}` is `−i` times the honest derivative of `f` along the `i`-th
coordinate. -/
theorem momOp_apply_eq_differential (i : Fin d) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    pgFun (momPoly i p) x
      = -Complex.I * deriv (fun t : ℝ => pgFun p (sec i x t)) (x i) := by
  rw [(hasDerivAt_pgFun_sec i p x).deriv]
  simp only [momPoly, pgFun, LinearMap.coe_mk, AddHom.coe_mk, map_mul, map_sub,
    MvPolynomial.eval_C, MvPolynomial.eval_X, MvPolynomial.smul_eval]
  ring

/-- The `L²` element `momOp i f` is the class of the differential expression. -/
theorem momOp_coe_eq_differential (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    ((momOp i (coreEquiv p) : polyGaussCore (d := d)) : L2d d)
      = pgLp (momPoly i p) := coreOp_coe _ p

/-- **The canonical commutation relation** `[πᵢ, u_k] = −i δ_{ik}` for the differential
operators. -/
theorem comm_momPoly_mulXPoly (i k : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    momPoly i (mulXPoly k p) - mulXPoly k (momPoly i p)
      = C (if i = k then -Complex.I else 0) * p := by
  classical
  have hpd : pderiv i (X k * p) = (if i = k then (1 : MvPolynomial (Fin d) ℂ) else 0) * p
      + X k * pderiv i p := by
    rw [Derivation.leibniz]
    by_cases hik : i = k
    · subst hik
      rw [if_pos rfl, pderiv_X_self]
      simp only [smul_eq_mul, mul_one, one_mul]
      ring
    · rw [pderiv_X_of_ne (Ne.symm hik), if_neg hik]
      simp [smul_eq_mul]
  simp only [momPoly_apply, mulXPoly_apply, hpd]
  by_cases hik : i = k
  · subst hik
    rw [if_pos rfl, if_pos rfl]
    ring
  · rw [if_neg hik, if_neg hik]
    simp only [map_zero, zero_mul]
    ring

set_option maxHeartbeats 1000000 in
-- The core-level commutator unfolds a composite of three linear equivalences, which is
-- elaboration-heavy; the default heartbeat budget is not enough.
theorem comm_momOp_posOp (i k : Fin d) :
    (momOp i).comp (posOp k) - (posOp k).comp (momOp i)
      = (if i = k then -Complex.I else 0) • LinearMap.id := by
  refine LinearMap.ext fun y => ?_
  obtain ⟨p, rfl⟩ := (coreEquiv (d := d)).surjective y
  simp only [LinearMap.sub_apply, LinearMap.comp_apply, posOp, momOp, coreOp_coreEquiv,
    LinearMap.smul_apply, LinearMap.id_apply]
  rw [← map_sub, comm_momPoly_mulXPoly, ← MvPolynomial.smul_eq_C_mul, map_smul]

/-! ## The unitary transport from the three-mode sequence space

The product Hermite functions indexed by `Vel = Fin 3 → ℕ` form a Hilbert basis of
`L²(ℝ³)`, so the sequence space `ℓ²(Vel)` of
`BookProof.ChapterNavierStokesThreeComponent` is unitarily `L²(du₁du₂du₃)`. -/

/-- A three-mode index, read as a finitely supported multi-index. -/
def velIdx : Vel ≃ (Fin 3 →₀ ℕ) := Finsupp.equivFunOnFinite.symm

@[simp] theorem velIdx_apply (b : Vel) (i : Fin 3) : velIdx b i = b i := rfl

theorem velIdx_raise (i : Fin 3) (b : Vel) :
    velIdx (raise i b) = velIdx b + Finsupp.single i 1 := by
  ext j
  by_cases hj : j = i
  · subst hj; simp
  · simp [raise_of_ne hj, Ne.symm hj]

theorem velIdx_lower (i : Fin 3) (b : Vel) :
    velIdx (lower i b) = velIdx b - Finsupp.single i 1 := by
  ext j
  by_cases hj : j = i
  · subst hj; simp [Finsupp.tsub_apply]
  · simp [lower_of_ne hj, Finsupp.tsub_apply, Ne.symm hj]

/-- The product Hermite function attached to a three-mode index. -/
def hermiteVel (b : Vel) : L2d 3 := hermiteMvLp (velIdx b)

theorem orthonormal_hermiteVel : Orthonormal ℂ hermiteVel :=
  orthonormal_hermiteMvLp.comp velIdx velIdx.injective

theorem range_hermiteVel : Set.range hermiteVel = Set.range (hermiteMvLp (d := 3)) :=
  velIdx.surjective.range_comp _

/-- **The three-mode product Hermite basis of `L²(ℝ³)`.** -/
def velBasis : HilbertBasis Vel ℂ (L2d 3) :=
  HilbertBasis.mk orthonormal_hermiteVel
    (by
      rw [range_hermiteVel, span_hermiteMvLp]
      have hd := polyGaussCore_dense (d := 3)
      rw [Submodule.dense_iff_topologicalClosure_eq_top] at hd
      rw [hd])

@[simp] theorem velBasis_apply (b : Vel) : velBasis b = hermiteVel b := by
  rw [velBasis, HilbertBasis.coe_mk]

/-- **The unitary transport** `ℓ²(Vel) ≃ L²(du₁du₂du₃)` given by the product Hermite
basis. -/
def velUnitary : L2I Vel ≃ₗᵢ[ℂ] L2d 3 := velBasis.repr.symm

@[simp] theorem velUnitary_single (b : Vel) :
    velUnitary (lp.single 2 b (1 : ℂ)) = hermiteVel b := by
  rw [velUnitary, velBasis.repr_symm_single, velBasis_apply]

/-! ### The finite-mode core is spanned by its basis states -/

theorem coreState_coe (b : Vel) :
    ((coreState b : lpFiniteModes Vel) : L2I Vel) = lp.single 2 b (1 : ℂ) := rfl

/-- The finite-mode core of `ℓ²(Vel)` is the algebraic span of the basis states. -/
theorem lpFiniteModes_eq_span :
    lpFiniteModes Vel
      = Submodule.span ℂ (Set.range fun b : Vel => (lp.single 2 b (1 : ℂ) : L2I Vel)) := by
  classical
  refine le_antisymm (fun f hf => ?_) ?_
  · have hfin : (Function.support ((f : Vel → ℂ))).Finite := hf
    have hsum : f = ∑ b ∈ hfin.toFinset, ((f : Vel → ℂ) b) • (lp.single 2 b (1 : ℂ)) := by
      refine lp.ext (funext fun j => ?_)
      rw [lp.coeFn_sum]
      simp only [Finset.sum_apply, lp.coeFn_smul, Pi.smul_apply, lp.single_apply,
        Pi.single_apply, smul_eq_mul, mul_ite, mul_one, mul_zero]
      rw [Finset.sum_ite_eq hfin.toFinset j (fun b => (f : Vel → ℂ) b)]
      by_cases hj : j ∈ hfin.toFinset
      · rw [if_pos hj]
      · rw [if_neg hj]
        have : j ∉ Function.support ((f : Vel → ℂ)) := by
          simpa [Set.Finite.mem_toFinset] using hj
        simpa [Function.mem_support] using this
    rw [hsum]
    exact Submodule.sum_mem _ fun b _ =>
      Submodule.smul_mem _ _ (Submodule.subset_span ⟨b, rfl⟩)
  · rw [Submodule.span_le]
    rintro _ ⟨b, rfl⟩
    exact lpSingle_mem_lpFiniteModes b 1

/-- The basis states span the finite-mode core as a module in its own right. -/
theorem span_coreState :
    Submodule.span ℂ (Set.range coreState) = (⊤ : Submodule ℂ (lpFiniteModes Vel)) := by
  refine Submodule.map_injective_of_injective
    (Submodule.injective_subtype (lpFiniteModes Vel)) ?_
  rw [Submodule.map_span, Submodule.map_top, Submodule.range_subtype, ← Set.range_comp]
  exact lpFiniteModes_eq_span.symm

/-- Two linear maps out of the finite-mode core agree as soon as they agree on the basis
states. -/
theorem core_ext {M : Type*} [AddCommGroup M] [Module ℂ M]
    {F G : lpFiniteModes Vel →ₗ[ℂ] M} (h : ∀ b, F (coreState b) = G (coreState b)) : F = G := by
  refine LinearMap.ext fun x => ?_
  have hx : x ∈ Submodule.span ℂ (Set.range coreState) := by rw [span_coreState]; trivial
  induction hx using Submodule.span_induction with
  | mem y hy => obtain ⟨b, rfl⟩ := hy; exact h b
  | zero => simp
  | add y z _ _ hy hz => rw [map_add, map_add, hy, hz]
  | smul a y _ hy => rw [map_smul, map_smul, hy]

/-! ### The ladder action on the basis states -/

theorem crd_coreState (b g : Vel) : crd (coreState b) g = if g = b then 1 else 0 := by
  simp [crd, coreState, lp.single_apply, Pi.single_apply]

/-- `a_i e_β = √βᵢ e_{β−eᵢ}`. -/
theorem ann_coreState (i : Fin 3) (b : Vel) :
    ann i (coreState b) = ((Real.sqrt ((b i : ℝ)) : ℝ) : ℂ) • coreState (lower i b) := by
  refine crd_injective (funext fun g => ?_)
  rw [crd_ann, crd_smul]
  simp only [aFun, crd_coreState, Pi.smul_apply, smul_eq_mul]
  by_cases hg : raise i g = b
  · have hbi : b i = g i + 1 := by rw [← hg, raise_self]
    have hlow : lower i b = g := by rw [← hg, lower_raise]
    rw [if_pos hg, hlow, if_pos rfl, hbi]
    push_cast
    ring
  · rw [if_neg hg, mul_zero]
    by_cases hg2 : g = lower i b
    · have hb0 : b i = 0 := by
        by_contra hne
        exact hg (by rw [hg2, raise_lower i (Nat.one_le_iff_ne_zero.mpr hne)])
      rw [hb0]
      simp
    · rw [if_neg hg2, mul_zero]

/-- `a_i† e_β = √(βᵢ+1) e_{β+eᵢ}`. -/
theorem cre_coreState (i : Fin 3) (b : Vel) :
    cre i (coreState b) = ((Real.sqrt ((b i : ℝ) + 1) : ℝ) : ℂ) • coreState (raise i b) := by
  refine crd_injective (funext fun g => ?_)
  rw [crd_cre, crd_smul]
  simp only [cFun, crd_coreState, Pi.smul_apply, smul_eq_mul]
  by_cases hg : g = raise i b
  · have hlow : lower i g = b := by rw [hg, lower_raise]
    have hgi : (g i : ℝ) = (b i : ℝ) + 1 := by rw [hg, raise_self]; push_cast; ring
    rw [hlow, if_pos rfl, if_pos hg, hgi]
  · rw [if_neg hg, mul_zero]
    by_cases hg2 : lower i g = b
    · have hgi : g i = 0 := by
        by_contra hne
        exact hg (by rw [← hg2, raise_lower i (Nat.one_le_iff_ne_zero.mpr hne)])
      rw [hgi]
      simp
    · rw [if_neg hg2, mul_zero]

/-! ### The transport of the core, and of the ladder operators -/

theorem hermiteVel_mem_core (b : Vel) : hermiteVel b ∈ polyGaussCore (d := 3) :=
  hermiteMvLp_mem_core (velIdx b)

theorem pgLp_smul (c : ℂ) (p : MvPolynomial (Fin d) ℂ) : pgLp (c • p) = c • pgLp p :=
  map_smul (pgMap (d := d)) c p

theorem velUnitary_mem_core (x : lpFiniteModes Vel) :
    velUnitary ((x : L2I Vel)) ∈ polyGaussCore (d := 3) := by
  have hspan : (⊤ : Submodule ℂ (lpFiniteModes Vel))
      ≤ (polyGaussCore (d := 3)).comap
        (velUnitary.toLinearEquiv.toLinearMap ∘ₗ (lpFiniteModes Vel).subtype) := by
    rw [← span_coreState, Submodule.span_le]
    rintro _ ⟨b, rfl⟩
    change velUnitary ((coreState b : L2I Vel)) ∈ polyGaussCore (d := 3)
    rw [coreState_coe, velUnitary_single]
    exact hermiteVel_mem_core b
  exact hspan Submodule.mem_top

/-- **The transport of the finite-mode core into the Gauss–polynomial core.** -/
def embedCore : lpFiniteModes Vel →ₗ[ℂ] (polyGaussCore (d := 3)) :=
  LinearMap.codRestrict _ (velUnitary.toLinearEquiv.toLinearMap ∘ₗ (lpFiniteModes Vel).subtype)
    velUnitary_mem_core

@[simp] theorem embedCore_coe (x : lpFiniteModes Vel) :
    ((embedCore x : polyGaussCore (d := 3)) : L2d 3) = velUnitary ((x : L2I Vel)) := rfl

theorem embedCore_coreState (b : Vel) :
    embedCore (coreState b)
      = coreEquiv (((hermiteMvNorm (velIdx b) : ℝ) : ℂ)⁻¹ • hermiteMv (velIdx b)) := by
  refine Subtype.ext ?_
  rw [coreEquiv_coe, embedCore_coe, coreState_coe, velUnitary_single, hermiteVel, hermiteMvLp,
    pgLp_smul]

/-- **The annihilation operator on the Hermite core of `L²(ℝ³)`**: `∂ᵢ + uᵢ/2`. -/
def annOp (i : Fin 3) : (polyGaussCore (d := 3)) →ₗ[ℂ] (polyGaussCore (d := 3)) :=
  coreOp (annPoly i)

/-- **The creation operator on the Hermite core of `L²(ℝ³)`**: `uᵢ/2 − ∂ᵢ`. -/
def creOp (i : Fin 3) : (polyGaussCore (d := 3)) →ₗ[ℂ] (polyGaussCore (d := 3)) :=
  coreOp (crePoly i)

/-- The transport carries the abstract annihilation operator to the differential one. -/
theorem intertwine_ann (i : Fin 3) : (annOp i).comp embedCore = embedCore.comp (ann i) := by
  refine core_ext fun b => ?_
  refine Subtype.ext ?_
  simp only [LinearMap.comp_apply, annOp]
  have hR : ((embedCore (ann i (coreState b)) : polyGaussCore (d := 3)) : L2d 3)
      = ((Real.sqrt ((b i : ℝ)) : ℝ) : ℂ) • hermiteMvLp (velIdx b - Finsupp.single i 1) := by
    rw [ann_coreState, map_smul, Submodule.coe_smul, embedCore_coe, coreState_coe,
      velUnitary_single, hermiteVel, velIdx_lower]
  rw [hR, embedCore_coreState, coreOp_coe, map_smul, pgLp_smul, annPoly_hermiteMvLp,
    velIdx_apply]

/-- The transport carries the abstract creation operator to the differential one. -/
theorem intertwine_cre (i : Fin 3) : (creOp i).comp embedCore = embedCore.comp (cre i) := by
  refine core_ext fun b => ?_
  refine Subtype.ext ?_
  simp only [LinearMap.comp_apply, creOp]
  have hR : ((embedCore (cre i (coreState b)) : polyGaussCore (d := 3)) : L2d 3)
      = ((Real.sqrt ((b i : ℝ) + 1) : ℝ) : ℂ) • hermiteMvLp (velIdx b + Finsupp.single i 1) := by
    rw [cre_coreState, map_smul, Submodule.coe_smul, embedCore_coe, coreState_coe,
      velUnitary_single, hermiteVel, velIdx_raise]
  rw [hR, embedCore_coreState, coreOp_coe, map_smul, pgLp_smul, crePoly_hermiteMvLp,
    velIdx_apply]

/-! ### The algebra of intertwined operators -/

/-- `T'` is the transport of `T`: the two agree through `embedCore`. -/
def Intertwined (T : lpFiniteModes Vel →ₗ[ℂ] lpFiniteModes Vel)
    (T' : (polyGaussCore (d := 3)) →ₗ[ℂ] (polyGaussCore (d := 3))) : Prop :=
  ∀ x, T' (embedCore x) = embedCore (T x)

theorem Intertwined.add {T S T' S'} (hT : Intertwined T T') (hS : Intertwined S S') :
    Intertwined (T + S) (T' + S') := fun x => by
  simp only [LinearMap.add_apply, hT x, hS x, map_add]

theorem Intertwined.sub {T S T' S'} (hT : Intertwined T T') (hS : Intertwined S S') :
    Intertwined (T - S) (T' - S') := fun x => by
  simp only [LinearMap.sub_apply, hT x, hS x, map_sub]

theorem Intertwined.smul {T T'} (c : ℂ) (hT : Intertwined T T') :
    Intertwined (c • T) (c • T') := fun x => by
  simp only [LinearMap.smul_apply, hT x, map_smul]

theorem Intertwined.comp {T S T' S'} (hT : Intertwined T T') (hS : Intertwined S S') :
    Intertwined (T.comp S) (T'.comp S') := fun x => by
  simp only [LinearMap.comp_apply, hS x, hT (S x)]

theorem Intertwined.id : Intertwined LinearMap.id LinearMap.id := fun _ => rfl

theorem Intertwined.sum {ι : Type*} (s : Finset ι)
    {T : ι → lpFiniteModes Vel →ₗ[ℂ] lpFiniteModes Vel}
    {T' : ι → (polyGaussCore (d := 3)) →ₗ[ℂ] (polyGaussCore (d := 3))}
    (h : ∀ i ∈ s, Intertwined (T i) (T' i)) :
    Intertwined (∑ i ∈ s, T i) (∑ i ∈ s, T' i) := fun x => by
  simp only [LinearMap.sum_apply]
  rw [map_sum]
  exact Finset.sum_congr rfl fun i hi => h i hi x

theorem intertwined_ann (i : Fin 3) : Intertwined (ann i) (annOp i) := fun x =>
  congrFun (congrArg (fun F : lpFiniteModes Vel →ₗ[ℂ] (polyGaussCore (d := 3)) => ⇑F)
    (intertwine_ann i)) x

theorem intertwined_cre (i : Fin 3) : Intertwined (cre i) (creOp i) := fun x =>
  congrFun (congrArg (fun F : lpFiniteModes Vel →ₗ[ℂ] (polyGaussCore (d := 3)) => ⇑F)
    (intertwine_cre i)) x

/-! ### Position and momentum as ladder combinations -/

theorem posOp_eq_ladder (i : Fin 3) : posOp i = annOp i + creOp i := by
  refine LinearMap.ext fun y => ?_
  obtain ⟨p, rfl⟩ := (coreEquiv (d := 3)).surjective y
  simp only [posOp, annOp, creOp, coreOp_coreEquiv, LinearMap.add_apply, ← map_add]
  congr 1
  simp only [mulXPoly_apply, annPoly_apply, crePoly_apply]
  ring

set_option maxHeartbeats 1000000 in
-- Unfolding the core coordinates through three linear equivalences is elaboration-heavy.
theorem momOp_eq_ladder (i : Fin 3) :
    momOp i = (Complex.I / 2) • (creOp i - annOp i) := by
  refine LinearMap.ext fun y => ?_
  obtain ⟨p, rfl⟩ := (coreEquiv (d := 3)).surjective y
  simp only [momOp, annOp, creOp, coreOp_coreEquiv, LinearMap.smul_apply, LinearMap.sub_apply,
    ← map_sub, ← map_smul]
  congr 1
  have hI : (C (Complex.I / 2) : MvPolynomial (Fin 3) ℂ) = C Complex.I * C (1 / 2 : ℂ) := by
    rw [← map_mul]
    congr 1
    ring
  have h2 : (C (1 / 2 : ℂ) : MvPolynomial (Fin 3) ℂ) * 2 = 1 := by
    rw [← map_ofNat C 2, ← map_mul]
    norm_num
  simp only [momPoly_apply, annPoly_apply, crePoly_apply, MvPolynomial.smul_eq_C_mul, map_neg,
    hI]
  linear_combination (C Complex.I * (pderiv i) p) * h2

/-! ### The transported canonical pair -/

theorem sqrtTwo_ne_zero : ((Real.sqrt 2 : ℝ) : ℂ) ≠ 0 := by
  simp

theorem sqrtTwo_mul_self : ((Real.sqrt 2 : ℝ) : ℂ) * ((Real.sqrt 2 : ℝ) : ℂ) = 2 := by
  rw [← Complex.ofReal_mul, Real.mul_self_sqrt (by norm_num : (0 : ℝ) ≤ 2)]
  norm_num

set_option maxHeartbeats 4000000 in
-- The transport arguments unfold operators on a submodule of `L²(ℝ³)` through several
-- linear equivalences, so the default heartbeat budget is not enough.
/-- The transport carries the mode coordinate `uᵢ = (aᵢ + aᵢ†)/√2` to `(1/√2)` times
multiplication by the coordinate. -/
theorem intertwined_pos (i : Fin 3) :
    Intertwined (pos i) (((1 / Real.sqrt 2 : ℝ) : ℂ) • posOp i) := by
  rw [posOp_eq_ladder, add_comm (annOp i) (creOp i)]
  exact ((intertwined_cre i).add (intertwined_ann i)).smul _

set_option maxHeartbeats 4000000 in
-- The transport arguments unfold operators on a submodule of `L²(ℝ³)` through several
-- linear equivalences, so the default heartbeat budget is not enough.
/-- The transport carries the mode momentum `πᵢ = i(aᵢ† − aᵢ)/√2` to `√2` times the
differential operator `−i ∂/∂uᵢ`. -/
theorem intertwined_mom (i : Fin 3) :
    Intertwined (mom i) (((Real.sqrt 2 : ℝ) : ℂ) • momOp i) := by
  have hs : ((Real.sqrt 2 : ℝ) : ℂ) • momOp i
      = (Complex.I * ((1 / Real.sqrt 2 : ℝ) : ℂ)) • (creOp i - annOp i) := by
    rw [momOp_eq_ladder, smul_smul]
    congr 1
    have hne := sqrtTwo_ne_zero
    have hsq : ((Real.sqrt 2 : ℝ) : ℂ) ^ 2 = 2 := by rw [sq]; exact sqrtTwo_mul_self
    push_cast
    field_simp
    linear_combination hsq
  rw [hs]
  exact ((intertwined_cre i).sub (intertwined_ann i)).smul _

/-! ### The differentially written Navier–Stokes quadratic symbol -/

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

/-- **The affine fiber field as a multiplication operator** on the Hermite core of
`L²(ℝ³)`: `Vᵢ(u) = ∑ₖ A_{ik} uₖ + cᵢ`. -/
def fieldOp (i : Fin 3) : (polyGaussCore (d := 3)) →ₗ[ℂ] (polyGaussCore (d := 3)) :=
  (∑ k, ((A i k : ℝ) : ℂ) • posOp k) + (((c i : ℝ) : ℂ) • LinearMap.id)

/-- **The differentially written Weyl-ordered Hamiltonian**
`∑ᵢ ½(πᵢ Vᵢ + Vᵢ πᵢ)` on the Hermite core of `L²(du₁du₂du₃)`, with `πᵢ = −i ∂/∂uᵢ`
and `Vᵢ` multiplication by the affine field. -/
def nsDiffH : (polyGaussCore (d := 3)) →ₗ[ℂ] (polyGaussCore (d := 3)) :=
  ∑ i, ((1 : ℂ) / 2) • ((momOp i).comp (fieldOp A c i) + (fieldOp A c i).comp (momOp i))

set_option maxHeartbeats 4000000 in
-- The transport arguments unfold operators on a submodule of `L²(ℝ³)` through several
-- linear equivalences, so the default heartbeat budget is not enough.
theorem intertwined_fieldV (i : Fin 3) :
    Intertwined (fieldV A c i)
      (((1 / Real.sqrt 2 : ℝ) : ℂ) • fieldOp A (fun j => Real.sqrt 2 * c j) i) := by
  have hsum : Intertwined (∑ k, ((A i k : ℝ) : ℂ) • pos k)
      (∑ k, ((A i k : ℝ) : ℂ) • (((1 / Real.sqrt 2 : ℝ) : ℂ) • posOp k)) :=
    Intertwined.sum _ fun k _ => (intertwined_pos k).smul _
  have hid : Intertwined (((c i : ℝ) : ℂ) • LinearMap.id)
      (((c i : ℝ) : ℂ) • LinearMap.id) := Intertwined.id.smul _
  have heq : ((1 / Real.sqrt 2 : ℝ) : ℂ) • fieldOp A (fun j => Real.sqrt 2 * c j) i
      = (∑ k, ((A i k : ℝ) : ℂ) • (((1 / Real.sqrt 2 : ℝ) : ℂ) • posOp k))
        + ((c i : ℝ) : ℂ) • LinearMap.id := by
    rw [fieldOp, smul_add, Finset.smul_sum]
    congr 1
    · exact Finset.sum_congr rfl fun k _ => smul_comm _ _ _
    · rw [smul_smul]
      congr 1
      have hne := sqrtTwo_ne_zero
      push_cast
      field_simp
  rw [heq]
  exact hsum.add hid

set_option maxHeartbeats 4000000 in
-- The transport arguments unfold operators on a submodule of `L²(ℝ³)` through several
-- linear equivalences, so the default heartbeat budget is not enough.
/-- **The transport carries the canonical Hamiltonian to the differential one.** -/
theorem intertwined_canH :
    Intertwined (canH A c) (nsDiffH A (fun j => Real.sqrt 2 * c j)) := by
  have hscal : ((Real.sqrt 2 : ℝ) : ℂ) * ((1 / Real.sqrt 2 : ℝ) : ℂ) = 1 := by
    have hne := sqrtTwo_ne_zero
    push_cast
    field_simp
  have hterm : ∀ i : Fin 3,
      Intertwined (((1 : ℂ) / 2) • ((mom i).comp (fieldV A c i) + (fieldV A c i).comp (mom i)))
        (((1 : ℂ) / 2) • ((momOp i).comp (fieldOp A (fun j => Real.sqrt 2 * c j) i)
          + (fieldOp A (fun j => Real.sqrt 2 * c j) i).comp (momOp i))) := by
    intro i
    have hm := intertwined_mom i
    have hf := intertwined_fieldV A c i
    have h := ((hm.comp hf).add (hf.comp hm)).smul ((1 : ℂ) / 2)
    have heq : (((Real.sqrt 2 : ℝ) : ℂ) • momOp i).comp
          (((1 / Real.sqrt 2 : ℝ) : ℂ) • fieldOp A (fun j => Real.sqrt 2 * c j) i)
        + (((1 / Real.sqrt 2 : ℝ) : ℂ) • fieldOp A (fun j => Real.sqrt 2 * c j) i).comp
          (((Real.sqrt 2 : ℝ) : ℂ) • momOp i)
        = (momOp i).comp (fieldOp A (fun j => Real.sqrt 2 * c j) i)
          + (fieldOp A (fun j => Real.sqrt 2 * c j) i).comp (momOp i) := by
      rw [LinearMap.smul_comp, LinearMap.comp_smul, LinearMap.smul_comp, LinearMap.comp_smul,
        smul_smul, smul_smul, hscal, mul_comm (((1 / Real.sqrt 2 : ℝ) : ℂ))
          (((Real.sqrt 2 : ℝ) : ℂ)), hscal, one_smul, one_smul]
    rw [← heq]
    exact h
  exact Intertwined.sum Finset.univ fun i _ => hterm i

/-! ## Essential self-adjointness of the differentially written operator -/

theorem sqrtTwo_real_ne_zero : Real.sqrt 2 ≠ 0 :=
  ne_of_gt (Real.sqrt_pos.mpr (by norm_num))

/-- **The Navier–Stokes quadratic symbol, written with genuine derivatives and genuine
multiplication operators on `L²(du₁du₂du₃)`, is essentially self-adjoint on the Hermite
core** — for every real velocity gradient `A` and every real constant part `c`. -/
theorem nsDiffH_essentiallySelfAdjointOn_core :
    EssentiallySelfAdjointOn (polyGaussCore (d := 3))
      ((polyGaussCore (d := 3)).subtype.comp (nsDiffH A c)) := by
  rw [essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn]
  have hc : (fun j => Real.sqrt 2 * (c j / Real.sqrt 2)) = c := by
    funext j
    field_simp
  have hint : ∀ x : lpFiniteModes Vel,
      ((nsDiffH A c ⟨velUnitary ((x : L2I Vel)), velUnitary_mem_core x⟩ :
            polyGaussCore (d := 3)) : L2d 3)
        = velUnitary (((canH A (fun j => c j / Real.sqrt 2) x : lpFiniteModes Vel) : L2I Vel)) := by
    intro x
    have h := intertwined_canH A (fun j => c j / Real.sqrt 2) x
    rw [hc] at h
    have hx : (⟨velUnitary ((x : L2I Vel)), velUnitary_mem_core x⟩ : polyGaussCore (d := 3))
        = embedCore x := rfl
    rw [hx, h, embedCore_coe]
  refine hasZeroDeficiencyOn_map_of_linearIsometryEquiv velUnitary velUnitary_mem_core hint ?_
  exact (essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn _ _).1
    (canH_essentiallySelfAdjointOn_core A (fun j => c j / Real.sqrt 2))

/-- **The differentially written operator is unbounded**: essential self-adjointness above
is not a boundedness phenomenon. -/
theorem nsDiffH_not_bounded (hA : A 0 0 ≠ 0) (K : ℝ) :
    ∃ f : polyGaussCore (d := 3), ‖(f : L2d 3)‖ = 1
      ∧ K < ‖((nsDiffH A c f : polyGaussCore (d := 3)) : L2d 3)‖ := by
  have hc : (fun j => Real.sqrt 2 * (c j / Real.sqrt 2)) = c := by
    funext j
    field_simp
  obtain ⟨x, hx1, hx2⟩ := canH_not_bounded A (fun j => c j / Real.sqrt 2) hA K
  refine ⟨embedCore x, ?_, ?_⟩
  · rw [embedCore_coe, velUnitary.norm_map, hx1]
  · have h := intertwined_canH A (fun j => c j / Real.sqrt 2) x
    rw [hc] at h
    rw [h, embedCore_coe, velUnitary.norm_map]
    exact hx2

/-- The Hermite core is dense in `L²(ℝ³)`, so the operator above is densely defined. -/
theorem nsDiffH_domain_dense :
    Dense ((polyGaussCore (d := 3) : Submodule ℂ (L2d 3)) : Set (L2d 3)) :=
  polyGaussCore_dense

/-! ## The Navier–Stokes reading of the coefficients -/

/-- **The quantized Navier–Stokes quadratic symbol on `L²(du₁du₂du₃)`**,
`∑ᵢ ½(πᵢ Aᵢ + Aᵢ πᵢ)` with `Aᵢ(u) = ∑ⱼ (grad i j) uⱼ − ν (lap i)`, `πᵢ = −i ∂/∂uᵢ`. -/
def nsQuadraticDiffH (nu : ℝ) (grad : Matrix (Fin 3) (Fin 3) ℝ) (lap : Fin 3 → ℝ) :
    (polyGaussCore (d := 3)) →ₗ[ℂ] (polyGaussCore (d := 3)) :=
  nsDiffH grad (fun i => -(nu * lap i))

/-- **The differentially written quantized Navier–Stokes quadratic symbol is essentially
self-adjoint on the Hermite core of `L²(du₁du₂du₃)`**, for every viscosity, every velocity
gradient and every velocity Laplacian at the fiber. -/
theorem nsQuadraticDiffH_essentiallySelfAdjointOn_core
    (nu : ℝ) (grad : Matrix (Fin 3) (Fin 3) ℝ) (lap : Fin 3 → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 3))
      ((polyGaussCore (d := 3)).subtype.comp (nsQuadraticDiffH nu grad lap)) :=
  nsDiffH_essentiallySelfAdjointOn_core grad _

end

end BookProof.NavierStokesFlow.DifferentialL2
