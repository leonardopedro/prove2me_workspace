-- Generated from ChapterNavierStokesDifferentialL2.lean — solution of BookProof.NavierStokesFlow.DifferentialL2.mulXPoly_apply
import Mathlib
import Definitions.Def_ChapterNavierStokesDifferentialL2
open BookProof.NavierStokesFlow.DifferentialL2




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LpNat BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.CanonicalVector
open BookProof.NavierStokesFlow.LagrangianEsa

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
 :=
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
    refine HasDerivAt.congr_deriv h2 ?_
    rw [gaussD, norm_sq_sec, hS]
    ring
  
  /-- The derivative of a polynomial along one coordinate is the partial derivative. -/
  theorem hasDerivAt_eval_update (i : Fin d) (p : MvPolynomial (Fin d) ℂ) (x : Fin d → ℂ) (t : ℂ) :
      HasDerivAt (fun s : ℂ => MvPolynomial.eval (Function.update x i s) p)
        (MvPolynomial.eval (Function.update x i t) (pderiv i p)) t := by
    classical
    induction p using MvPolynomial.induction_on with
    | C a => simpa using (hasDerivAt_const t (a : ℂ))
    | add p q hp hq =>
        simp only [map_add]
        exact hp.add hq
    | mul_X p j hp =>
        by_cases hj : j = i
        · subst hj
          have hX : HasDerivAt (fun s : ℂ => MvPolynomial.eval (Function.update x j s) (X j))
              1 t := by
            simp only [MvPolynomial.eval_X, Function.update_self]
            exact hasDerivAt_id t
          have h := hp.mul hX
          have hpd : pderiv j (p * X j) = X j * pderiv j p + p := by
            rw [Derivation.leibniz]
            simp [smul_eq_mul]
            ring
          rw [hpd]
          simp only [map_add, map_mul, MvPolynomial.eval_X, Function.update_self] at h ⊢
          convert h using 1
          all_goals first | rfl | ring
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
          all_goals first | rfl | ring
  
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
    all_goals first
      | rfl
      | (rw [sec_self]; simp only [pgFun, map_sub, MvPolynomial.smul_eval, map_mul,
          MvPolynomial.eval_X]; push_cast; ring)
  
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
