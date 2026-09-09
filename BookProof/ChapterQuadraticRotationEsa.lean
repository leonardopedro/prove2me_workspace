import Mathlib
import BookProof.ChapterHyperbolicQuadraticEsa

/-!
# General (non-diagonal) quadratic Hamiltonians of arbitrary signature

`BookProof.ChapterHyperbolicQuadraticEsa` proves that the *diagonal* quadratic operator

`H_c = ∑ᵢ cᵢ (−∂ᵢ² + xᵢ²/4)`,  `c : Fin d → ℝ` arbitrary (hyperbolic signatures included),

is essentially self-adjoint on the Gauss–polynomial (product Hermite) core of `L²(ℝᵈ)`.
This module removes the diagonality restriction: for an **arbitrary real symmetric matrix**
`A` the operator

`H_A = ∑_{k,l} A_{kl} (π_k π_l + x_k x_l / 4)`,  `π_k = −i ∂/∂x_k`,

— the general quadratic Hamiltonian whose kinetic and potential forms share the matrix
`A`, of arbitrary signature — is symmetric and essentially self-adjoint on the same core.
With `A = diag(c)` this is the diagonal theorem; with `A` a rotated Minkowski form it is
`□ + V` written in rotated coordinates, where neither the kinetic form nor the potential
is diagonal.

## The route

An orthogonal change of coordinates.  The Gaussian `e^{−‖x‖²/4}` is rotation invariant, so
composition with an orthogonal matrix `O` maps the Gauss–polynomial core onto itself; on
the polynomial coordinates it is the substitution `rotPoly O`, an algebra automorphism.
The canonical pair transforms contravariantly with the *same* matrix
(`rotPoly_mulXPoly`, `rotPoly_momPoly`), so the diagonal operator `H_c` is carried onto
`H_A` with `A = O diag(c) Oᵀ` (`quadPolyMat_rotPoly`).  The rotated product Hermite
functions are therefore an orthonormal family of joint eigenvectors of `H_A` spanning the
core (`orthonormal_rotHermiteLp`, `span_rotHermiteLp`, `quadOpMat_rotHermiteLp`), and the
diagonal instruments of `BookProof.ChapterHyperbolicQuadraticEsa`
(`symmetricOn_of_diagonal`, `deficiencyTrivialAt_of_diagonal`) finish the argument.
The spectral theorem for real symmetric matrices supplies `O` and `c` for an arbitrary
symmetric `A`.

## What is proved

* `rotPoly`, `pderiv_rotPoly`, `rotPoly_mulXPoly`, `rotPoly_momPoly` — the orthogonal
  substitution on polynomial coordinates and its action on the canonical pair;
* `rotIso`, `gaussInt_rotPoly`, `inner_pgLp_rotPoly` — the rotation as a
  measure-preserving linear isometry of `ℝᵈ`, and the resulting unitarity on the core;
* `quadPolyMat`, `quadPolyMat_rotPoly` — the general quadratic operator and the
  conjugation identity `H_{O diag(c) Oᵀ} ∘ R = R ∘ H_c`;
* `rotHermiteLp`, `orthonormal_rotHermiteLp`, `span_rotHermiteLp` — the rotated product
  Hermite functions are an orthonormal family whose span is the core;
* `quadOpMat_rotConj_symmetric`, `quadOpMat_rotConj_essentiallySelfAdjoint` — the headline
  for `A = O diag(c) Oᵀ`;
* `quadOpMat_symmetric`, `quadOpMat_essentiallySelfAdjoint` — **the headline**: for every
  real symmetric matrix `A`, `H_A` is symmetric and essentially self-adjoint on the
  Gauss–polynomial core of `L²(ℝᵈ)`;
* `quadOpMat_not_bounded`, `polyGaussCore_dense_L2` — non-vacuity: the operator is
  genuinely unbounded whenever `A ≠ 0`, and its domain is dense.

## Honest boundary

The potential is quadratic and its matrix is *the same* as the matrix of the kinetic form:
that matched pair is what a single rotation diagonalizes.  A general Faris–Lavine
potential bounded above by a quadratic remains out of reach by this argument, exactly as
recorded in `BookProof.ChapterHyperbolicQuadraticEsa`.
-/

namespace BookProof.QuadraticRotation

open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

variable {d : ℕ}

/-! ## 1. The orthogonal substitution on polynomial coordinates -/

/-- The substitution `Xᵢ ↦ ∑ⱼ Oⱼᵢ Xⱼ`: on functions this is `p ↦ p ∘ Oᵀ`. -/
def rotPoly (O : Matrix (Fin d) (Fin d) ℝ) :
    MvPolynomial (Fin d) ℂ →ₐ[ℂ] MvPolynomial (Fin d) ℂ :=
  aeval (fun i => ∑ j, C ((O j i : ℝ) : ℂ) * X j)

theorem rotPoly_X (O : Matrix (Fin d) (Fin d) ℝ) (i : Fin d) :
    rotPoly O (X i) = ∑ j, C ((O j i : ℝ) : ℂ) * X j := by
  simp [rotPoly]

theorem rotPoly_C (O : Matrix (Fin d) (Fin d) ℝ) (z : ℂ) : rotPoly O (C z) = C z := by
  simp [rotPoly]

/-- **The chain rule** for the substitution: `∂_k (p ∘ Oᵀ) = ∑ᵢ O_{ki} (∂ᵢp) ∘ Oᵀ`. -/
theorem pderiv_rotPoly (O : Matrix (Fin d) (Fin d) ℝ) (k : Fin d)
    (p : MvPolynomial (Fin d) ℂ) :
    pderiv k (rotPoly O p) = ∑ i, C ((O k i : ℝ) : ℂ) * rotPoly O (pderiv i p) := by
  induction p using MvPolynomial.induction_on with
  | C a => simp
  | add p q hp hq => simp [hp, hq, Finset.sum_add_distrib, mul_add]
  | mul_X p i hp =>
      have hd : pderiv k (rotPoly O (X i)) = C ((O k i : ℝ) : ℂ) := by
        rw [rotPoly_X, map_sum]
        simp [Pi.single_apply]
      have hr : ∀ m : Fin d, pderiv m (p * X i)
          = pderiv m p * X i + (if m = i then p else 0) := by
        intro m
        rw [Derivation.leibniz, pderiv_X]
        by_cases h : m = i <;> simp [h, Pi.single_apply, smul_eq_mul, mul_comm, add_comm]
      have hRHS : ∑ m, C ((O k m : ℝ) : ℂ) * rotPoly O (pderiv m (p * X i))
          = (∑ m, C ((O k m : ℝ) : ℂ) * rotPoly O (pderiv m p)) * rotPoly O (X i)
            + C ((O k i : ℝ) : ℂ) * rotPoly O p := by
        have hsplit : ∀ m : Fin d, C ((O k m : ℝ) : ℂ) * rotPoly O (pderiv m (p * X i))
            = C ((O k m : ℝ) : ℂ) * rotPoly O (pderiv m p) * rotPoly O (X i)
              + (if m = i then C ((O k m : ℝ) : ℂ) * rotPoly O p else 0) := by
          intro m
          rw [hr m, map_add, map_mul, mul_add]
          by_cases h : m = i <;> simp [h, mul_assoc]
        rw [Finset.sum_congr rfl fun m _ => hsplit m, Finset.sum_add_distrib, Finset.sum_mul]
        congr 1
        simp
      rw [map_mul, Derivation.leibniz, hd, hp, hRHS]
      simp only [smul_eq_mul]
      ring

/-- The substitutions by `O` and by `Oᵀ` are mutually inverse. -/
theorem rotPoly_rotPoly_transpose {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1)
    (p : MvPolynomial (Fin d) ℂ) : rotPoly O (rotPoly Oᵀ p) = p := by
  have hOO : O * Oᵀ = 1 := mul_eq_one_comm.mp hO
  have hgen : ∀ i : Fin d, rotPoly O (rotPoly Oᵀ (X i)) = X i := by
    intro i
    rw [rotPoly_X, map_sum]
    have hstep : ∀ j : Fin d, rotPoly O (C ((Oᵀ j i : ℝ) : ℂ) * X j)
        = ∑ k, C (((O i j * O k j : ℝ)) : ℂ) * X k := by
      intro j
      rw [map_mul, rotPoly_C, rotPoly_X, Finset.mul_sum]
      refine Finset.sum_congr rfl fun k _ => ?_
      rw [← mul_assoc, ← map_mul]
      norm_num [Matrix.transpose_apply]
    rw [Finset.sum_congr rfl fun j _ => hstep j, Finset.sum_comm]
    have hk : ∀ k : Fin d, ∑ j, C (((O i j * O k j : ℝ)) : ℂ) * X k
        = (if i = k then (1 : MvPolynomial (Fin d) ℂ) else 0) * X k := by
      intro k
      rw [← Finset.sum_mul]
      congr 1
      have h1 := congrFun (congrFun hOO i) k
      have h2 : ∑ j, O i j * O k j = if i = k then (1 : ℝ) else 0 := by
        simpa [Matrix.mul_apply, Matrix.one_apply, Matrix.transpose_apply] using h1
      rw [← map_sum,
        show (∑ j, ((O i j * O k j : ℝ) : ℂ)) = ((∑ j, O i j * O k j : ℝ) : ℂ) by
          push_cast; ring,
        h2]
      by_cases h : i = k <;> simp [h]
    rw [Finset.sum_congr rfl fun k _ => hk k]
    simp
  have hcomp := MvPolynomial.algHom_ext (f := (rotPoly O).comp (rotPoly Oᵀ))
    (g := AlgHom.id ℂ (MvPolynomial (Fin d) ℂ)) (by intro i; simpa using hgen i)
  exact congrArg (fun f => f p) hcomp

theorem rotPoly_surjective {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1) :
    Function.Surjective (rotPoly O) := fun p =>
  ⟨rotPoly Oᵀ p, rotPoly_rotPoly_transpose hO p⟩

/-! ## 2. The canonical pair transforms with the same matrix -/

theorem rotPoly_mulXPoly (O : Matrix (Fin d) (Fin d) ℝ) (i : Fin d)
    (p : MvPolynomial (Fin d) ℂ) :
    rotPoly O (mulXPoly i p) = ∑ k, ((O k i : ℝ) : ℂ) • mulXPoly k (rotPoly O p) := by
  simp only [mulXPoly_apply, map_mul, rotPoly_X, Finset.sum_mul]
  exact Finset.sum_congr rfl fun k _ => by rw [MvPolynomial.smul_eq_C_mul, mul_assoc]

/-- `∂ᵢ` pulled back: `R(∂ᵢ p) = ∑ₖ O_{ki} ∂ₖ (R p)`, by the chain rule and `OᵀO = 1`. -/
theorem rotPoly_pderiv {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1) (i : Fin d)
    (p : MvPolynomial (Fin d) ℂ) :
    rotPoly O (pderiv i p) = ∑ k, ((O k i : ℝ) : ℂ) • pderiv k (rotPoly O p) := by
  have hexp : ∀ k : Fin d, ((O k i : ℝ) : ℂ) • pderiv k (rotPoly O p)
      = ∑ m, ((O k i * O k m : ℝ) : ℂ) • rotPoly O (pderiv m p) := by
    intro k
    rw [pderiv_rotPoly, Finset.smul_sum]
    refine Finset.sum_congr rfl fun m _ => ?_
    rw [MvPolynomial.smul_eq_C_mul, MvPolynomial.smul_eq_C_mul, ← mul_assoc, ← map_mul]
    push_cast
    ring_nf
  rw [Finset.sum_congr rfl fun k _ => hexp k, Finset.sum_comm]
  have hm : ∀ m : Fin d, ∑ k, ((O k i * O k m : ℝ) : ℂ) • rotPoly O (pderiv m p)
      = (if i = m then (1 : ℂ) else 0) • rotPoly O (pderiv m p) := by
    intro m
    rw [← Finset.sum_smul]
    congr 1
    have h1 := congrFun (congrFun hO i) m
    have h2 : ∑ k, O k i * O k m = if i = m then (1 : ℝ) else 0 := by
      simpa [Matrix.mul_apply, Matrix.one_apply, Matrix.transpose_apply] using h1
    rw [show (∑ k, ((O k i * O k m : ℝ) : ℂ)) = ((∑ k, O k i * O k m : ℝ) : ℂ) by
        push_cast; ring, h2]
    by_cases h : i = m <;> simp [h]
  rw [Finset.sum_congr rfl fun m _ => hm m]
  simp

theorem rotPoly_momPoly {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1) (i : Fin d)
    (p : MvPolynomial (Fin d) ℂ) :
    rotPoly O (momPoly i p) = ∑ k, ((O k i : ℝ) : ℂ) • momPoly k (rotPoly O p) := by
  have hX : rotPoly O (X i * p) = ∑ k, ((O k i : ℝ) : ℂ) • (X k * rotPoly O p) := by
    simpa using rotPoly_mulXPoly O i p
  rw [momPoly_apply, map_mul, rotPoly_C, map_sub, map_mul, rotPoly_C, rotPoly_pderiv hO, hX,
    Finset.mul_sum, ← Finset.sum_sub_distrib, Finset.mul_sum]
  refine Finset.sum_congr rfl fun k _ => ?_
  simp only [momPoly_apply, MvPolynomial.smul_eq_C_mul]
  ring

/-! ## 3. The general quadratic operator and the conjugation identity -/

/-- The general quadratic Hamiltonian `∑_{k,l} A_{kl}(π_k π_l + x_k x_l/4)` in polynomial
coordinates. -/
def quadPolyMat (A : Matrix (Fin d) (Fin d) ℝ) :
    MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ :=
  ∑ k, ∑ l, ((A k l : ℝ) : ℂ) •
    ((momPoly k).comp (momPoly l) + (1/4 : ℂ) • ((mulXPoly k).comp (mulXPoly l)))

theorem quadPolyMat_apply (A : Matrix (Fin d) (Fin d) ℝ) (p : MvPolynomial (Fin d) ℂ) :
    quadPolyMat A p = ∑ k, ∑ l, ((A k l : ℝ) : ℂ) •
      (momPoly k (momPoly l p) + (1/4 : ℂ) • (X k * (X l * p))) := by
  simp [quadPolyMat, LinearMap.sum_apply]

/-- The diagonal-weight operator, in the form used below. -/
theorem quadPoly_apply' (c : Fin d → ℝ) (p : MvPolynomial (Fin d) ℂ) :
    quadPoly c p = ∑ i, ((c i : ℝ) : ℂ) •
      (momPoly i (momPoly i p) + (1/4 : ℂ) • (X i * (X i * p))) := by
  simp [quadPoly, oscPoly, LinearMap.sum_apply]

/-- **The diagonal case is the operator of `BookProof.ChapterHyperbolicQuadraticEsa`**, so
the theorems below genuinely extend the diagonal ones. -/
theorem quadPolyMat_diagonal (c : Fin d → ℝ) :
    quadPolyMat (Matrix.diagonal c) = quadPoly c := by
  refine LinearMap.ext fun p => ?_
  rw [quadPolyMat_apply, quadPoly_apply']
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [Finset.sum_eq_single k (fun l _ hl => by simp [Ne.symm hl]) (by simp)]
  simp

/-- `O diag(c) Oᵀ`, written entrywise. -/
def rotConj (O : Matrix (Fin d) (Fin d) ℝ) (c : Fin d → ℝ) : Matrix (Fin d) (Fin d) ℝ :=
  fun k l => ∑ i, O k i * c i * O l i

theorem rotConj_eq (O : Matrix (Fin d) (Fin d) ℝ) (c : Fin d → ℝ) :
    rotConj O c = O * Matrix.diagonal c * Oᵀ := by
  ext k l
  simp only [rotConj, Matrix.mul_apply, Matrix.transpose_apply, Matrix.diagonal_apply]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Finset.sum_eq_single j (fun i _ hi => by simp [hi]) (by simp)]
  simp

/-- **The conjugation identity**: the rotation carries the diagonal Hamiltonian `H_c` onto
the general one `H_{O diag(c) Oᵀ}`. -/
theorem quadPolyMat_rotPoly {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1)
    (c : Fin d → ℝ) (p : MvPolynomial (Fin d) ℂ) :
    quadPolyMat (rotConj O c) (rotPoly O p) = rotPoly O (quadPoly c p) := by
  have hmom : ∀ i : Fin d, rotPoly O (momPoly i (momPoly i p))
      = ∑ k, ∑ l, ((O k i * O l i : ℝ) : ℂ) • momPoly k (momPoly l (rotPoly O p)) := by
    intro i
    rw [rotPoly_momPoly hO i (momPoly i p), rotPoly_momPoly hO i p]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [map_sum, Finset.smul_sum]
    refine Finset.sum_congr rfl fun l _ => ?_
    rw [map_smul, smul_smul]
    congr 1
    push_cast
    ring
  have hx : ∀ i : Fin d, rotPoly O (X i * (X i * p))
      = ∑ k, ∑ l, ((O k i * O l i : ℝ) : ℂ) • (X k * (X l * rotPoly O p)) := by
    intro i
    have h1 := rotPoly_mulXPoly O i (X i * p)
    have h2 := rotPoly_mulXPoly O i p
    simp only [mulXPoly_apply] at h1 h2
    rw [h1, h2]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [Finset.mul_sum, Finset.smul_sum]
    refine Finset.sum_congr rfl fun l _ => ?_
    rw [mul_smul_comm, smul_smul]
    congr 1
    push_cast
    ring
  have hboth : ∀ i : Fin d, rotPoly O (((c i : ℝ) : ℂ) •
      (momPoly i (momPoly i p) + (1/4 : ℂ) • (X i * (X i * p))))
      = ∑ k, ∑ l, ((O k i * c i * O l i : ℝ) : ℂ) •
          (momPoly k (momPoly l (rotPoly O p))
            + (1/4 : ℂ) • (X k * (X l * rotPoly O p))) := by
    intro i
    have hquarter : (1/4 : ℂ) •
        (∑ k, ∑ l, ((O k i * O l i : ℝ) : ℂ) • (X k * (X l * rotPoly O p)))
        = ∑ k, ∑ l, ((O k i * O l i : ℝ) : ℂ) •
            ((1/4 : ℂ) • (X k * (X l * rotPoly O p))) := by
      simp only [Finset.smul_sum]
      exact Finset.sum_congr rfl fun k _ =>
        Finset.sum_congr rfl fun l _ => smul_comm _ _ _
    have hcomb :
        (∑ k, ∑ l, ((O k i * O l i : ℝ) : ℂ) • momPoly k (momPoly l (rotPoly O p)))
          + (∑ k, ∑ l, ((O k i * O l i : ℝ) : ℂ) •
              ((1/4 : ℂ) • (X k * (X l * rotPoly O p))))
        = ∑ k, ∑ l, ((O k i * O l i : ℝ) : ℂ) •
            (momPoly k (momPoly l (rotPoly O p))
              + (1/4 : ℂ) • (X k * (X l * rotPoly O p))) := by
      rw [← Finset.sum_add_distrib]
      refine Finset.sum_congr rfl fun k _ => ?_
      rw [← Finset.sum_add_distrib]
      exact Finset.sum_congr rfl fun l _ => (smul_add _ _ _).symm
    rw [map_smul, map_add, map_smul, hmom i, hx i, hquarter, hcomb, Finset.smul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [Finset.smul_sum]
    refine Finset.sum_congr rfl fun l _ => ?_
    rw [smul_smul]
    congr 1
    push_cast
    ring
  have hswap : ∀ f : Fin d → Fin d → Fin d → MvPolynomial (Fin d) ℂ,
      ∑ i, ∑ k, ∑ l, f i k l = ∑ k, ∑ l, ∑ i, f i k l := by
    intro f
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun k _ => Finset.sum_comm
  rw [quadPoly_apply', map_sum, Finset.sum_congr rfl fun i _ => hboth i, hswap,
    quadPolyMat_apply]
  refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
  rw [← Finset.sum_smul]
  congr 1
  rw [rotConj]
  push_cast
  ring

/-! ## 4. The rotation as a measure-preserving isometry of `ℝᵈ` -/

/-- The linear map `x ↦ Oᵀx` of `ℝᵈ`. -/
def rotLin (O : Matrix (Fin d) (Fin d) ℝ) : Vd d →ₗ[ℝ] Vd d where
  toFun x := (WithLp.toLp 2 (fun i => ∑ j, O j i * x j))
  map_add' x y := by ext i; simp [Finset.sum_add_distrib, mul_add]
  map_smul' t x := by
    ext i
    change ∑ j, O j i * (t * x j) = t * ∑ j, O j i * x j
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun j _ => by ring

@[simp] theorem rotLin_apply (O : Matrix (Fin d) (Fin d) ℝ) (x : Vd d) (i : Fin d) :
    rotLin O x i = ∑ j, O j i * x j := rfl

theorem rot_dot {O : Matrix (Fin d) (Fin d) ℝ} (hOO : O * Oᵀ = 1) (a b : Fin d → ℝ) :
    ∑ k, (∑ j, O j k * a j) * (∑ l, O l k * b l) = ∑ j, a j * b j := by
  have hstep : ∀ k : Fin d, (∑ j, O j k * a j) * (∑ l, O l k * b l)
      = ∑ j, ∑ l, (O j k * O l k) * (a j * b l) := by
    intro k
    rw [Finset.sum_mul_sum]
    exact Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun l _ => by ring
  rw [Finset.sum_congr rfl fun k _ => hstep k, Finset.sum_comm]
  have hj : ∀ j : Fin d, ∑ k, ∑ l, (O j k * O l k) * (a j * b l) = a j * b j := by
    intro j
    rw [Finset.sum_comm]
    have h2 : ∀ l : Fin d, ∑ k, (O j k * O l k) * (a j * b l)
        = (if j = l then (1 : ℝ) else 0) * (a j * b l) := by
      intro l
      rw [← Finset.sum_mul]
      congr 1
      simpa [Matrix.mul_apply, Matrix.one_apply] using congrFun (congrFun hOO j) l
    rw [Finset.sum_congr rfl fun l _ => h2 l]
    simp
  rw [Finset.sum_congr rfl fun j _ => hj j]

theorem rotLin_inner {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1) (x y : Vd d) :
    inner ℝ (rotLin O x) (rotLin O y) = inner ℝ x y := by
  have hOO : O * Oᵀ = 1 := mul_eq_one_comm.mp hO
  simp only [PiLp.inner_apply, RCLike.inner_apply, conj_trivial, rotLin_apply]
  simpa [mul_comm] using rot_dot hOO (fun j => y j) (fun j => x j)

/-- The orthogonal matrix as a linear isometry equivalence of `ℝᵈ`. -/
def rotIso {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1) : Vd d ≃ₗᵢ[ℝ] Vd d :=
  ((rotLin O).isometryOfInner (rotLin_inner hO)).toLinearIsometryEquiv rfl

@[simp] theorem rotIso_apply {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1) (x : Vd d) :
    (rotIso hO x : Vd d) = rotLin O x := rfl

theorem integral_comp_rotIso {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1)
    (g : Vd d → ℂ) : ∫ x : Vd d, g (rotIso hO x) = ∫ y : Vd d, g y :=
  (rotIso hO).measurePreserving.integral_comp
    ((rotIso hO).toHomeomorph.measurableEmbedding) g

/-- Evaluating the substituted polynomial is evaluating at the rotated point. -/
theorem eval_rotPoly {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1)
    (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (rotPoly O p)
      = MvPolynomial.eval (fun i => (((rotIso hO x) i : ℝ) : ℂ)) p := by
  induction p using MvPolynomial.induction_on with
  | C a => simp [rotPoly]
  | add p q hp hq => simp [hp, hq]
  | mul_X p i hp =>
      rw [map_mul, map_mul, rotPoly_X, hp]
      simp [Complex.ofReal_sum]

theorem pgFun_rotPoly {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1)
    (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    pgFun (rotPoly O p) x = pgFun p (rotIso hO x) := by
  rw [pgFun, pgFun, eval_rotPoly hO]
  congr 2
  rw [gaussD, gaussD, (rotIso hO).norm_map x]

/-- **The Gaussian integral is rotation invariant.** -/
theorem gaussInt_rotPoly {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1)
    (r : MvPolynomial (Fin d) ℂ) : gaussInt (rotPoly O r) = gaussInt r := by
  rw [gaussInt, gaussInt]
  have hpt : ∀ x : Vd d,
      MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (rotPoly O r) * (gaussWD x : ℂ)
        = (fun y : Vd d => MvPolynomial.eval (fun i => ((y i : ℝ) : ℂ)) r * (gaussWD y : ℂ))
            (rotIso hO x) := by
    intro x
    rw [eval_rotPoly hO]
    congr 2
    rw [gaussWD, gaussWD, (rotIso hO).norm_map x]
  rw [integral_congr_ae (Filter.Eventually.of_forall hpt)]
  exact integral_comp_rotIso hO
    (fun y : Vd d => MvPolynomial.eval (fun i => ((y i : ℝ) : ℂ)) r * (gaussWD y : ℂ))

/-- **The substitution is unitary on the core.** -/
theorem inner_pgLp_rotPoly {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1)
    (p q : MvPolynomial (Fin d) ℂ) :
    (inner ℂ (pgLp (rotPoly O p)) (pgLp (rotPoly O q)) : ℂ)
      = (inner ℂ (pgLp p) (pgLp q) : ℂ) := by
  have hL : (inner ℂ (pgLp (rotPoly O p)) (pgLp (rotPoly O q)) : ℂ)
      = ∫ x : Vd d, (starRingEnd ℂ) (pgFun (rotPoly O p) x) * pgFun (rotPoly O q) x := by
    rw [inner_pgLp]
    refine integral_congr_ae ?_
    filter_upwards [pgLp_coeFn (rotPoly O q)] with x hx
    rw [hx]
  have hR : (inner ℂ (pgLp p) (pgLp q) : ℂ)
      = ∫ x : Vd d, (starRingEnd ℂ) (pgFun p x) * pgFun q x := by
    rw [inner_pgLp]
    refine integral_congr_ae ?_
    filter_upwards [pgLp_coeFn q] with x hx
    rw [hx]
  have hpt : ∀ x : Vd d, (starRingEnd ℂ) (pgFun (rotPoly O p) x) * pgFun (rotPoly O q) x
      = (fun y : Vd d => (starRingEnd ℂ) (pgFun p y) * pgFun q y) (rotIso hO x) := by
    intro x
    rw [pgFun_rotPoly hO, pgFun_rotPoly hO]
  rw [hL, hR, integral_congr_ae (Filter.Eventually.of_forall hpt)]
  exact integral_comp_rotIso hO
    (fun y : Vd d => (starRingEnd ℂ) (pgFun p y) * pgFun q y)

/-! ## 5. The rotated product Hermite basis -/

/-- The rotated product Hermite functions `ψ_α ∘ Oᵀ`. -/
def rotHermiteLp (O : Matrix (Fin d) (Fin d) ℝ) (a : Fin d →₀ ℕ) : L2d d :=
  ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • pgLp (rotPoly O (hermiteMv a))

theorem inner_rotHermiteLp {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1)
    (a b : Fin d →₀ ℕ) :
    (inner ℂ (rotHermiteLp O a) (rotHermiteLp O b) : ℂ)
      = (inner ℂ (hermiteMvLp (d := d) a) (hermiteMvLp (d := d) b) : ℂ) := by
  rw [rotHermiteLp, rotHermiteLp, hermiteMvLp, hermiteMvLp, inner_smul_left, inner_smul_right,
    inner_smul_left, inner_smul_right, inner_pgLp_rotPoly hO]

theorem orthonormal_rotHermiteLp {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1) :
    Orthonormal ℂ (rotHermiteLp (d := d) O) := by
  rw [orthonormal_iff_ite]
  intro a b
  rw [inner_rotHermiteLp hO]
  exact orthonormal_iff_ite.mp orthonormal_hermiteMvLp a b

theorem rotHermiteLp_mem_core (O : Matrix (Fin d) (Fin d) ℝ) (a : Fin d →₀ ℕ) :
    rotHermiteLp O a ∈ polyGaussCore (d := d) :=
  Submodule.smul_mem _ _ (pgLp_mem_core _)

theorem span_rotHermiteLp {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1) :
    Submodule.span ℂ (Set.range (rotHermiteLp (d := d) O)) = polyGaussCore (d := d) := by
  have hbase : Submodule.span ℂ
      (Set.range fun a : Fin d →₀ ℕ => pgLp (rotPoly O (hermiteMv a)))
      = polyGaussCore (d := d) := by
    have hrange : (Set.range fun a : Fin d →₀ ℕ => pgLp (rotPoly O (hermiteMv a)))
        = ((pgMap (d := d)).comp (rotPoly O).toLinearMap) ''
            (Set.range (hermiteMv (d := d))) := by
      rw [← Set.range_comp]
      rfl
    rw [hrange, ← Submodule.map_span, span_hermiteMv, Submodule.map_top, polyGaussCore]
    apply le_antisymm
    · rintro _ ⟨p, rfl⟩
      exact ⟨rotPoly O p, rfl⟩
    · rintro _ ⟨p, rfl⟩
      obtain ⟨q, hq⟩ := rotPoly_surjective hO p
      exact ⟨q, by simp [hq]⟩
  rw [← hbase]
  refine le_antisymm ?_ ?_
  · rw [Submodule.span_le]
    rintro _ ⟨a, rfl⟩
    exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨a, rfl⟩)
  · rw [Submodule.span_le]
    rintro _ ⟨a, rfl⟩
    change pgLp (rotPoly O (hermiteMv a))
      ∈ Submodule.span ℂ (Set.range (rotHermiteLp (d := d) O))
    have h : pgLp (rotPoly O (hermiteMv a))
        = ((hermiteMvNorm a : ℝ) : ℂ) • rotHermiteLp O a := by
      rw [rotHermiteLp, smul_smul, mul_inv_cancel₀ (hermiteMvNorm_ne_zero a), one_smul]
    rw [h]
    exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨a, rfl⟩)

/-- A vector orthogonal to the whole core vanishes: the core is dense. -/
theorem eq_zero_of_inner_core (w : L2d d)
    (h : ∀ u ∈ polyGaussCore (d := d), (inner ℂ u w : ℂ) = 0) : w = 0 := by
  have hclosed : IsClosed {u : L2d d | (inner ℂ u w : ℂ) = 0} := by
    have hcont : Continuous fun u : L2d d => (inner ℂ u w : ℂ) := by fun_prop
    exact isClosed_eq hcont continuous_const
  have hsub : (Set.univ : Set (L2d d)) ⊆ {u : L2d d | (inner ℂ u w : ℂ) = 0} := by
    rw [← (polyGaussCore_dense (d := d)).closure_eq]
    exact hclosed.closure_subset_iff.mpr h
  exact inner_self_eq_zero.mp (hsub (Set.mem_univ w))

theorem rotHermiteLp_total {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1) (w : L2d d)
    (h : ∀ a, (inner ℂ (rotHermiteLp (d := d) O a) w : ℂ) = 0) : w = 0 := by
  refine eq_zero_of_inner_core w fun u hu => ?_
  rw [← span_rotHermiteLp hO] at hu
  induction hu using Submodule.span_induction with
  | mem z hz => obtain ⟨a, rfl⟩ := hz; exact h a
  | zero => simp
  | add z z' _ _ ihz ihz' => rw [inner_add_left, ihz, ihz']; ring
  | smul r z _ ih => rw [inner_smul_left, ih]; ring

/-! ## 6. The Hamiltonian on the core, and essential self-adjointness -/

/-- **The general quadratic Hamiltonian on the Gauss–polynomial core of `L²(ℝᵈ)`.** -/
def quadOpMat (A : Matrix (Fin d) (Fin d) ℝ) : (polyGaussCore (d := d)) →ₗ[ℂ] L2d d :=
  (polyGaussCore (d := d)).subtype ∘ₗ coreOp (quadPolyMat A)

/-- **The diagonal action** of `H_A` on the rotated Hermite functions. -/
theorem quadOpMat_rotHermiteLp {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1)
    (c : Fin d → ℝ) (a : Fin d →₀ ℕ) (h : rotHermiteLp O a ∈ polyGaussCore (d := d)) :
    quadOpMat (rotConj O c) ⟨rotHermiteLp O a, h⟩
      = ((quadSymbol c a : ℝ) : ℂ) • rotHermiteLp O a := by
  have hcoe : (⟨rotHermiteLp O a, h⟩ : polyGaussCore (d := d))
      = coreEquiv (((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • rotPoly O (hermiteMv a)) := by
    apply Subtype.ext
    rw [coreEquiv_coe, pgLp_smul]
    rfl
  rw [hcoe]
  simp only [quadOpMat, LinearMap.comp_apply, Submodule.subtype_apply]
  rw [coreOp_coe, map_smul, quadPolyMat_rotPoly hO, quadPoly_hermiteMv, map_smul,
    smul_comm, pgLp_smul, pgLp_smul]
  rfl

theorem quadOpMat_rotConj_symmetric {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1)
    (c : Fin d → ℝ) : SymmetricOn (polyGaussCore (d := d)) (quadOpMat (rotConj O c)) :=
  symmetricOn_of_diagonal (rotHermiteLp O) (orthonormal_rotHermiteLp hO) (quadSymbol c)
    (span_rotHermiteLp hO) (quadOpMat (rotConj O c))
    (fun a h => quadOpMat_rotHermiteLp hO c a h)

theorem quadOpMat_rotConj_deficiencyTrivialAt {O : Matrix (Fin d) (Fin d) ℝ}
    (hO : Oᵀ * O = 1) (c : Fin d → ℝ) {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (polyGaussCore (d := d)) (quadOpMat (rotConj O c)) z :=
  deficiencyTrivialAt_of_diagonal (rotHermiteLp O) (quadSymbol c) (rotHermiteLp_total hO)
    (quadOpMat (rotConj O c)) (rotHermiteLp_mem_core O)
    (fun a h => quadOpMat_rotHermiteLp hO c a h) hz

theorem quadOpMat_rotConj_essentiallySelfAdjoint {O : Matrix (Fin d) (Fin d) ℝ}
    (hO : Oᵀ * O = 1) (c : Fin d → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (quadOpMat (rotConj O c)) :=
  ⟨quadOpMat_rotConj_deficiencyTrivialAt hO c (by simp),
    quadOpMat_rotConj_deficiencyTrivialAt hO c (by simp)⟩

/-- Every real symmetric matrix is `O diag(λ) Oᵀ` for an orthogonal `O`, **with `λ` the
eigenvalues of `A`**: the spectral theorem for real symmetric matrices.  Naming the
weights matters downstream, where a sign condition on them is imposed. -/
theorem exists_rotConj_eigenvalues {A : Matrix (Fin d) (Fin d) ℝ} (hA : A.IsHermitian) :
    ∃ O : Matrix (Fin d) (Fin d) ℝ, Oᵀ * O = 1 ∧ A = rotConj O hA.eigenvalues := by
  classical
  refine ⟨(hA.eigenvectorUnitary : Matrix (Fin d) (Fin d) ℝ), ?_, ?_⟩
  · have hu := hA.eigenvectorUnitary.2
    rw [Unitary.mem_iff] at hu
    simpa [Matrix.star_eq_conjTranspose, Matrix.conjTranspose] using hu.1
  · have hspec := hA.spectral_theorem
    rw [Unitary.conjStarAlgAut_apply] at hspec
    have hd : (Matrix.diagonal (RCLike.ofReal ∘ hA.eigenvalues) : Matrix (Fin d) (Fin d) ℝ)
        = Matrix.diagonal hA.eigenvalues := by congr 1
    have hst : star (hA.eigenvectorUnitary : Matrix (Fin d) (Fin d) ℝ)
        = (hA.eigenvectorUnitary : Matrix (Fin d) (Fin d) ℝ)ᵀ := by
      simp [Matrix.star_eq_conjTranspose, Matrix.conjTranspose]
      rfl
    rw [rotConj_eq, ← hd, ← hst]
    exact hspec

/-- Every real symmetric matrix is `O diag(c) Oᵀ` for an orthogonal `O`: the spectral
theorem for real symmetric matrices. -/
theorem exists_rotConj {A : Matrix (Fin d) (Fin d) ℝ} (hA : A.IsHermitian) :
    ∃ (O : Matrix (Fin d) (Fin d) ℝ) (c : Fin d → ℝ), Oᵀ * O = 1 ∧ A = rotConj O c := by
  obtain ⟨O, hO, hAO⟩ := exists_rotConj_eigenvalues hA
  exact ⟨O, hA.eigenvalues, hO, hAO⟩

/-- **The headline (symmetry).**  For every real symmetric matrix `A` the operator
`H_A = ∑_{k,l} A_{kl}(π_k π_l + x_k x_l/4)` is symmetric on the Gauss–polynomial core. -/
theorem quadOpMat_symmetric {A : Matrix (Fin d) (Fin d) ℝ} (hA : A.IsHermitian) :
    SymmetricOn (polyGaussCore (d := d)) (quadOpMat A) := by
  obtain ⟨O, c, hO, rfl⟩ := exists_rotConj hA
  exact quadOpMat_rotConj_symmetric hO c

/-- **The headline.**  For every real symmetric matrix `A` — no sign condition, so the
signature of the quadratic form may be arbitrary — the operator
`H_A = ∑_{k,l} A_{kl}(π_k π_l + x_k x_l/4)` with `π_k = −i∂/∂x_k` is essentially
self-adjoint on the Gauss–polynomial (product Hermite) core of `L²(ℝᵈ)`. -/
theorem quadOpMat_essentiallySelfAdjoint {A : Matrix (Fin d) (Fin d) ℝ} (hA : A.IsHermitian) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (quadOpMat A) := by
  obtain ⟨O, c, hO, rfl⟩ := exists_rotConj hA
  exact quadOpMat_rotConj_essentiallySelfAdjoint hO c

/-- On the core, the diagonal matrix gives back the diagonal Hamiltonian `H_c`. -/
theorem quadOpMat_diagonal (c : Fin d → ℝ) :
    quadOpMat (Matrix.diagonal c) = quadOp c := by
  rw [quadOpMat, quadOp, quadPolyMat_diagonal]

/-- **The rotated wave operator.**  For every orthogonal `O`, the Minkowski quadratic form
conjugated by `O` — the wave operator `□ + V`, `V(t,x) = (t² − ‖x‖²)/4`, written in rotated
coordinates, where neither the kinetic form nor the potential is diagonal — is essentially
self-adjoint on the Gauss–polynomial core. -/
theorem wave_rotated_essentiallySelfAdjoint {n : ℕ}
    {O : Matrix (Fin (1 + n)) (Fin (1 + n)) ℝ} (hO : Oᵀ * O = 1) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 1 + n))
      (quadOpMat (rotConj O (minkowskiCoeff n))) :=
  quadOpMat_rotConj_essentiallySelfAdjoint hO (minkowskiCoeff n)

/-! ## 7. Non-vacuity -/

/-- The core is dense, so the statement above is a genuine essential self-adjointness
statement. -/
theorem polyGaussCore_dense_L2 :
    Dense ((polyGaussCore (d := d) : Submodule ℂ (L2d d)) : Set (L2d d)) :=
  polyGaussCore_dense

theorem quadOpMat_rotConj_not_bounded {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1)
    (c : Fin d → ℝ) {i : Fin d} (hci : c i ≠ 0) :
    ¬ ∃ K : ℝ, ∀ f : polyGaussCore (d := d),
        ‖quadOpMat (rotConj O c) f‖ ≤ K * ‖(f : L2d d)‖ := by
  classical
  rintro ⟨K, hK⟩
  obtain ⟨n, hn⟩ := exists_nat_gt ((K + |∑ j, c j * (1/2)|) / |c i|)
  set a : Fin d →₀ ℕ := Finsupp.single i n with ha
  have hnorm : ‖rotHermiteLp (d := d) O a‖ = 1 := (orthonormal_rotHermiteLp hO).norm_eq_one a
  have h := hK ⟨rotHermiteLp O a, rotHermiteLp_mem_core O a⟩
  rw [quadOpMat_rotHermiteLp hO c a (rotHermiteLp_mem_core O a), norm_smul] at h
  simp only [hnorm, mul_one, Complex.norm_real, Real.norm_eq_abs] at h
  have hci' : 0 < |c i| := abs_pos.mpr hci
  have hlow : |c i| * (n : ℝ) - |∑ j, c j * (1/2)| ≤ |quadSymbol c a| := by
    have htri : |c i * (n : ℝ)|
        ≤ |c i * (n : ℝ) + ∑ j, c j * (1/2)| + |∑ j, c j * (1/2)| := by
      have h1 : |c i * (n : ℝ) + ∑ j, c j * (1/2)| + |-(∑ j, c j * (1/2))|
          ≥ |c i * (n : ℝ) + ∑ j, c j * (1/2) + -(∑ j, c j * (1/2))| := abs_add_le _ _
      simpa using h1
    have habs : |c i * (n : ℝ)| = |c i| * (n : ℝ) := by
      rw [abs_mul, Nat.abs_cast]
    rw [ha, quadSymbol_single]
    linarith [htri, habs.symm.le, habs.le]
  have hbig : K < |c i| * (n : ℝ) - |∑ j, c j * (1/2)| := by
    have hmul : (K + |∑ j, c j * (1/2)|) < |c i| * (n : ℝ) := by
      rw [div_lt_iff₀ hci'] at hn
      linarith [hn]
    linarith
  linarith [h, hlow, hbig]

/-- **The operator is genuinely unbounded** whenever `A ≠ 0`. -/
theorem quadOpMat_not_bounded {A : Matrix (Fin d) (Fin d) ℝ} (hA : A.IsHermitian)
    (hA0 : A ≠ 0) :
    ¬ ∃ K : ℝ, ∀ f : polyGaussCore (d := d), ‖quadOpMat A f‖ ≤ K * ‖(f : L2d d)‖ := by
  obtain ⟨O, c, hO, hAeq⟩ := exists_rotConj hA
  have hc : ∃ i, c i ≠ 0 := by
    by_contra hcon
    push_neg at hcon
    exact hA0 (by
      rw [hAeq]
      ext k l
      simp [rotConj, hcon])
  obtain ⟨i, hci⟩ := hc
  rw [hAeq]
  exact quadOpMat_rotConj_not_bounded hO c hci

end

end BookProof.QuadraticRotation
