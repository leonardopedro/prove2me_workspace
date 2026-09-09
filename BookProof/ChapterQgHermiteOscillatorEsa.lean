import Mathlib
import BookProof.ChapterQgHermiteFriedrichs
import BookProof.ChapterHermiteProductBasis
import BookProof.ChapterStoneBridge
import BookProof.ChapterKatoRellichRelative

/-!
# Essential self-adjointness on the Gauss–polynomial core: the harmonic (conformal-mode)
potential

`BookProof.ChapterQgHermiteFriedrichs` realizes the one-particle Hamiltonian `−Δ + W` on
the Gauss–polynomial (Hermite) core of `L²(ℝᵈ)` and produces a canonical *semibounded*
self-adjoint (Friedrichs) extension of it.  That is existence, not uniqueness:
`CONSOLIDATED_PLAN.md` §10.6.1 target 4 asks for **essential** self-adjointness on the
core, which is what forces the extension to be the only one.

This module proves the uniqueness statement for the potential the conformal-mode sector
contributes — the **harmonic (parabolic) potential** `W(x) = ‖x‖²/4` — in every dimension:

> `−Δ + ‖x‖²/4` is essentially self-adjoint on the Gauss–polynomial core of `L²(ℝᵈ)`.

Two ingredients:

* a general criterion, `essentiallySelfAdjointOn_of_eigenbasis`: *a linear map on a
  subspace `D` which has an orthonormal Hilbert basis of eigenvectors, with real
  eigenvalues, all lying in `D`, has trivial deficiency at every non-real point, hence is
  essentially self-adjoint on `D`*.  (The proof is the one-line computation
  `(λ − z)⟪e, w⟫ = 0`, plus completeness of the basis.)
* the identification of `−Δ + ‖x‖²/4` with the **number operator plus `d/2`**:
  on the polynomial side `kinPoly p + harmPoly * p = ∑ⱼ a†ⱼaⱼ p + (d/2) p`
  (`kinPoly_add_harmPoly`), and `a†ᵢaᵢ` acts on the product Hermite polynomial `He_α` by
  the multiplier `αᵢ` (`crePoly_annPoly_hermiteMv`).  The product Hermite functions of
  `BookProof.ChapterHermiteProductBasis` are therefore eigenvectors of the Hamiltonian
  with eigenvalues `|α| + d/2` (`hamCore_hermiteMvLp`), and they are an orthonormal basis
  lying inside the core.

The conclusion `harmonicCore_essentiallySelfAdjoint` is unconditional — no finite-speed or
unique-continuation hypothesis — and `harmonicCore_stone_flow` reads off what it buys: a
self-adjoint realization of the Hamiltonian together with the unitary group it generates,
obtained from essential self-adjointness rather than from a choice of extension.

A Kato–Rellich step widens the class: `harmonic_add_bounded_essentiallySelfAdjoint` shows
that `−Δ + ‖x‖²/4 + B` is still essentially self-adjoint on the core for *any* continuous
bounded real `B`, since multiplication by `B` is symmetric on the core with
`‖Bψ‖ ≤ M‖ψ‖` (`potCore_symmetricOn`, `norm_potLp_le`) — relative bound `0`.

**Honest boundary.**  The potential here is a parabola plus a bounded function, not the
exponentially growing scalaron potential.  For the *potential term* alone the exponential
case is settled in `BookProof.ChapterScalaronHermiteEsa`
(`potCore_essentiallySelfAdjoint`, `scalaronPot_essentiallySelfAdjoint`); §10.6.1 target 4
for the *sum* `−Δ + V` with `V(φ) = (M⁴/16α)(1 − e^{−√(2/3)φ/M})²` is *not* proved here and
remains open, as does target 2 (which needs restating) and target 3.
-/

namespace BookProof.QgHermiteOscillator

open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

/-! ## A general criterion: an orthonormal eigenbasis inside the domain -/

section Criterion

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  {ι : Type*} {D : Submodule ℂ F}

/-- A vector orthogonal to every element of a Hilbert basis vanishes. -/
theorem eq_zero_of_inner_basis_eq_zero (b : HilbertBasis ι ℂ F) {w : F}
    (h : ∀ i, (inner ℂ (b i) w : ℂ) = 0) : w = 0 := by
  have hrep : b.repr w = 0 := by
    ext i
    rw [b.repr_apply_apply]
    simpa using h i
  have := congrArg b.repr.symm hrep
  simpa using this

/-- **The eigenbasis criterion for trivial deficiency.**  If `T` has an orthonormal basis
of eigenvectors with *real* eigenvalues, all of them inside the domain, then no non-real
`z` supports a deficiency vector. -/
theorem deficiencyTrivialAt_of_eigenbasis (T : D →ₗ[ℂ] F) (b : HilbertBasis ι ℂ F)
    (lam : ι → ℝ) (hmem : ∀ i, (b i : F) ∈ D)
    (heig : ∀ i, T ⟨b i, hmem i⟩ = ((lam i : ℝ) : ℂ) • (b i : F))
    {z : ℂ} (hz : z.im ≠ 0) : DeficiencyTrivialAt D T z := by
  intro w hw
  refine eq_zero_of_inner_basis_eq_zero b fun i => ?_
  have key := hw ⟨b i, hmem i⟩
  rw [heig i, inner_smul_left] at key
  have hconj : (starRingEnd ℂ) ((lam i : ℝ) : ℂ) = ((lam i : ℝ) : ℂ) := Complex.conj_ofReal _
  rw [hconj] at key
  have hne : ((lam i : ℝ) : ℂ) - z ≠ 0 := by
    intro h
    apply hz
    have := congrArg Complex.im h
    simpa [sub_eq_zero] using this.symm
  have : (((lam i : ℝ) : ℂ) - z) * (inner ℂ (b i) w : ℂ) = 0 := by
    rw [sub_mul]
    simpa using sub_eq_zero.mpr key
  exact (mul_eq_zero.mp this).resolve_left hne

/-- **The eigenbasis criterion for essential self-adjointness.** -/
theorem essentiallySelfAdjointOn_of_eigenbasis (T : D →ₗ[ℂ] F) (b : HilbertBasis ι ℂ F)
    (lam : ι → ℝ) (hmem : ∀ i, (b i : F) ∈ D)
    (heig : ∀ i, T ⟨b i, hmem i⟩ = ((lam i : ℝ) : ℂ) • (b i : F)) :
    EssentiallySelfAdjointOn D T :=
  ⟨deficiencyTrivialAt_of_eigenbasis T b lam hmem heig (by simp),
    deficiencyTrivialAt_of_eigenbasis T b lam hmem heig (by simp)⟩

end Criterion

variable {d : ℕ}

/-! ## The harmonic potential -/

/-- The harmonic (conformal-mode) potential `‖x‖²/4`, the one for which the
Gauss–polynomial core is the eigenbasis. -/
def harmW (x : Vd d) : ℝ := ‖x‖ ^ 2 / 4

theorem continuous_harmW : Continuous (harmW (d := d)) := by
  unfold harmW
  fun_prop

theorem expBounded_harmW : ExpBounded (harmW (d := d)) := by
  refine ⟨1, 1, zero_le_one, fun x => ?_⟩
  have h := Real.pow_div_factorial_le_exp ‖x‖ (norm_nonneg x) 2
  have hfac : ((Nat.factorial 2 : ℕ) : ℝ) = 2 := by norm_num
  rw [hfac] at h
  have hpos : (0 : ℝ) ≤ harmW x := by
    unfold harmW; positivity
  rw [abs_of_nonneg hpos, one_mul, one_mul]
  unfold harmW
  nlinarith [sq_nonneg ‖x‖]

/-- The harmonic potential, as a polynomial in the coordinates. -/
def harmPoly : MvPolynomial (Fin d) ℂ := ∑ j : Fin d, C (1 / 4 : ℂ) * X j ^ 2

theorem eval_harmPoly (x : Vd d) :
    MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (harmPoly (d := d)) = ((harmW x : ℝ) : ℂ) := by
  have hnorm : ‖x‖ ^ 2 = ∑ i, (x i) ^ 2 := norm_sq_eq_sum x
  unfold harmPoly harmW
  rw [map_sum, hnorm]
  push_cast
  rw [Finset.sum_div]
  refine Finset.sum_congr rfl fun j _ => ?_
  simp
  ring

/-- Multiplication by the harmonic potential is multiplication by `harmPoly` on the
polynomial side. -/
theorem potLp_harmW (p : MvPolynomial (Fin d) ℂ) :
    potLp harmW continuous_harmW expBounded_harmW p = pgLp (harmPoly * p) := by
  unfold potLp pgLp
  refine MemLp.toLp_congr _ _ ?_
  filter_upwards with x
  simp only [pgFun, map_mul, eval_harmPoly]
  ring

/-! ## The Hamiltonian is the number operator plus `d/2` -/

/-- The pointwise (one-coordinate) identity: `−Dⱼ² + xⱼ²/4 = a†ⱼaⱼ + 1/2`. -/
theorem coreD_sq_add_harm (j : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    -coreD j (coreD j p) + C (1 / 4 : ℂ) * (X j ^ 2 * p)
      = crePoly j (annPoly j p) + C (1 / 2 : ℂ) * p := by
  have hC2 : (C (1 / 2 : ℂ) : MvPolynomial (Fin d) ℂ) * 2 = 1 := by
    have h2 : ((2 : MvPolynomial (Fin d) ℂ)) = C (2 : ℂ) :=
      (MvPolynomial.ext _ _ (congrFun rfl)).symm
    rw [h2, ← C_mul]
    norm_num
  have h14 : (C (1 / 4 : ℂ) : MvPolynomial (Fin d) ℂ) = C (1 / 2 : ℂ) * C (1 / 2 : ℂ) := by
    rw [← C_mul]; norm_num
  simp only [coreD, map_sub, pderiv_mul, pderiv_C, pderiv_X_self, crePoly_apply, annPoly_apply,
    h14]
  linear_combination (X j * pderiv j p) * hC2

/-- **`−Δ + ‖x‖²/4` is the number operator plus `d/2`**, on the polynomial side. -/
theorem kinPoly_add_harmPoly (p : MvPolynomial (Fin d) ℂ) :
    kinPoly p + harmPoly * p
      = (∑ j : Fin d, crePoly j (annPoly j p)) + C ((d : ℂ) / 2) * p := by
  have hsum : kinPoly p + harmPoly * p
      = ∑ j : Fin d, (-coreD j (coreD j p) + C (1 / 4 : ℂ) * (X j ^ 2 * p)) := by
    simp only [kinPoly, harmPoly, Finset.sum_mul, Finset.sum_add_distrib,
      Finset.sum_neg_distrib]
    congr 1
    refine Finset.sum_congr rfl fun j _ => ?_
    ring
  rw [hsum]
  simp only [coreD_sq_add_harm]
  rw [Finset.sum_add_distrib]
  congr 1
  rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
  have : ((d : MvPolynomial (Fin d) ℂ)) = C (d : ℂ) := by
    simp
  rw [this, ← mul_assoc, ← C_mul]
  congr 2
  ring

/-! ## The Hermite functions are eigenvectors -/

theorem sub_add_single_cancel {i : Fin d} {a : Fin d →₀ ℕ} (h : 1 ≤ a i) :
    (a - Finsupp.single i 1) + Finsupp.single i 1 = a := by
  classical
  ext j
  by_cases hj : j = i
  · subst hj
    simp only [Finsupp.add_apply, Finsupp.tsub_apply, Finsupp.single_eq_same]
    omega
  · simp [hj]

/-- **`a†ᵢaᵢ He_α = αᵢ He_α`** — the number operator is diagonal in the Hermite basis. -/
theorem crePoly_annPoly_hermiteMv (i : Fin d) (a : Fin d →₀ ℕ) :
    crePoly i (annPoly i (hermiteMv a)) = ((a i : ℂ)) • hermiteMv a := by
  rw [annPoly_apply, pderiv_hermiteMv, map_smul, crePoly_hermiteMv]
  rcases Nat.eq_zero_or_pos (a i) with h0 | hpos
  · rw [h0]
    simp
  · rw [sub_add_single_cancel hpos]

/-- The total degree of a multi-index — the eigenvalue of the number operator. -/
def mvDeg (a : Fin d →₀ ℕ) : ℕ := ∑ i : Fin d, a i

/-- **The eigenvalue equation on the polynomial side**:
`(−Δ + ‖x‖²/4) He_α = (|α| + d/2) He_α`. -/
theorem kinPoly_add_harmPoly_hermiteMv (a : Fin d →₀ ℕ) :
    kinPoly (hermiteMv a) + harmPoly * hermiteMv a
      = (((mvDeg a : ℂ) + (d : ℂ) / 2)) • hermiteMv a := by
  rw [kinPoly_add_harmPoly]
  simp only [crePoly_annPoly_hermiteMv]
  rw [← Finset.sum_smul]
  have hdeg : (∑ i : Fin d, ((a i : ℂ))) = (mvDeg a : ℂ) := by
    unfold mvDeg
    push_cast
    rfl
  rw [hdeg, add_smul]
  congr 1
  exact (MvPolynomial.smul_eq_C_mul _ _).symm

/-! ## The Hamiltonian on the core, and its essential self-adjointness -/

/-- The harmonic Hamiltonian on the Gauss–polynomial core. -/
def harmCore : (polyGaussCore (d := d)) →ₗ[ℂ] L2d d :=
  hamCore harmW continuous_harmW expBounded_harmW

theorem harmCore_pgLp (p : MvPolynomial (Fin d) ℂ) :
    harmCore ⟨pgLp p, pgLp_mem_core p⟩ = pgLp (kinPoly p + harmPoly * p) := by
  unfold harmCore
  rw [hamCore_pgLp]
  unfold hamPoly
  rw [potLp_harmW]
  exact (map_add (pgMap (d := d)) (kinPoly p) (harmPoly * p)).symm

/-- **The product Hermite functions are eigenvectors of `−Δ + ‖x‖²/4`**, with eigenvalue
`|α| + d/2`. -/
theorem harmCore_hermiteMvLp (a : Fin d →₀ ℕ) :
    harmCore ⟨hermiteMvLp a, hermiteMvLp_mem_core a⟩
      = (((mvDeg a : ℝ) + (d : ℝ) / 2 : ℝ) : ℂ) • (hermiteMvLp a : L2d d) := by
  have hsm : (hermiteMvLp (d := d) a) = ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • pgLp (hermiteMv a) := rfl
  have hmem : (((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • pgLp (hermiteMv a)) ∈ polyGaussCore (d := d) := by
    rw [← hsm]
    exact hermiteMvLp_mem_core a
  have hstep : harmCore ⟨((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • pgLp (hermiteMv a), hmem⟩
      = ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • harmCore ⟨pgLp (hermiteMv a), pgLp_mem_core _⟩ := by
    rw [← map_smul]
    congr 1
  have hcast : ((((mvDeg a : ℝ) + (d : ℝ) / 2 : ℝ)) : ℂ) = ((mvDeg a : ℂ) + (d : ℂ) / 2) := by
    push_cast
    ring
  simp only [hsm]
  rw [hstep, harmCore_pgLp, kinPoly_add_harmPoly_hermiteMv,
    ← HermiteProductCore.pgMap_apply, map_smul, HermiteProductCore.pgMap_apply, hcast,
    smul_comm]

/-- **The harmonic Hamiltonian is essentially self-adjoint on the Gauss–polynomial
(Hermite) core of `L²(ℝᵈ)`** — unconditionally, in every dimension. -/
theorem harmonicCore_essentiallySelfAdjoint :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) harmCore := by
  refine essentiallySelfAdjointOn_of_eigenbasis harmCore hermiteMvBasis
    (fun a => (mvDeg a : ℝ) + (d : ℝ) / 2) (fun a => by
      rw [hermiteMvBasis_apply]; exact hermiteMvLp_mem_core a) fun a => ?_
  have := harmCore_hermiteMvLp (d := d) a
  simpa using this

/-- The core is dense, so this is a genuine essential-self-adjointness statement. -/
theorem harmonicCore_dense : Dense ((polyGaussCore (d := d) : Submodule ℂ (L2d d)) : Set (L2d d)) :=
  polyGaussCore_dense

/-- **Symmetry** of the harmonic Hamiltonian on the core (a special case of
`hamCore_symmetricOn`). -/
theorem harmonicCore_symmetricOn : SymmetricOn (polyGaussCore (d := d)) harmCore :=
  hamCore_symmetricOn harmW continuous_harmW expBounded_harmW

/-- **The harmonic Hamiltonian is nonnegative on the core** (a special case of
`hamCore_quadForm_nonneg`); together with essential self-adjointness this says the
semibounded realization of `BookProof.QgHermiteFriedrichs` is a self-adjoint extension of
an operator whose deficiency spaces vanish. -/
theorem harmonicCore_quadForm_nonneg (x : polyGaussCore (d := d)) : 0 ≤ quadForm harmCore x :=
  hamCore_quadForm_nonneg harmW continuous_harmW expBounded_harmW
    (fun x => by unfold harmW; positivity) x

/-- **The Stone flow of the harmonic Hamiltonian.**  Essential self-adjointness on the
dense core produces a self-adjoint realization together with the unitary group it
generates — the continuum counterpart, on the Gauss–polynomial core, of the mode-level
flows of the quantum-gravity chapters. -/
theorem harmonicCore_stone_flow :
    ∃ (T : UnboundedSelfAdjoint (L2d d)) (U : ℝ → (L2d d →L[ℂ] L2d d)),
      IsSelfAdjointExtension (harmCore (d := d)) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa harmCore harmonicCore_dense harmonicCore_symmetricOn
    harmonicCore_essentiallySelfAdjoint

/-! ## Bounded perturbations: `−Δ + ‖x‖²/4 + B` -/

/-- Multiplication by the potential, as a linear map out of the polynomials. -/
def potPolyMap (W : Vd d → ℝ) (hWc : Continuous W) (hWb : ExpBounded W) :
    MvPolynomial (Fin d) ℂ →ₗ[ℂ] L2d d where
  toFun := potLp W hWc hWb
  map_add' := potLp_add W hWc hWb
  map_smul' c p := potLp_smul W hWc hWb c p

/-- Multiplication by the potential, as an operator on the Gauss–polynomial core. -/
def potCore (W : Vd d → ℝ) (hWc : Continuous W) (hWb : ExpBounded W) :
    (polyGaussCore (d := d)) →ₗ[ℂ] L2d d :=
  (potPolyMap W hWc hWb).comp (coreEquiv (d := d)).symm.toLinearMap

theorem potCore_pgLp (W : Vd d → ℝ) (hWc : Continuous W) (hWb : ExpBounded W)
    (p : MvPolynomial (Fin d) ℂ) :
    potCore W hWc hWb ⟨pgLp p, pgLp_mem_core p⟩ = potLp W hWc hWb p := by
  simp only [potCore, LinearMap.comp_apply, LinearEquiv.coe_coe, coreEquiv_symm_pgLp]
  rfl

/-- Multiplication by a real potential is symmetric on the core. -/
theorem potCore_symmetricOn (W : Vd d → ℝ) (hWc : Continuous W) (hWb : ExpBounded W) :
    SymmetricOn (polyGaussCore (d := d)) (potCore W hWc hWb) := by
  intro x y
  obtain ⟨p, hp⟩ := x.2
  obtain ⟨q, hq⟩ := y.2
  have hx : x = ⟨pgLp p, pgLp_mem_core p⟩ := Subtype.ext hp.symm
  have hy : y = ⟨pgLp q, pgLp_mem_core q⟩ := Subtype.ext hq.symm
  rw [hx, hy, potCore_pgLp, potCore_pgLp]
  exact inner_potLp_symm W hWc hWb p q

/-- Splitting the potential splits the Hamiltonian. -/
theorem hamCore_add_potential (V W : Vd d → ℝ) (hVc : Continuous V) (hVb : ExpBounded V)
    (hWc : Continuous W) (hWb : ExpBounded W)
    (hsc : Continuous fun x => V x + W x) (hsb : ExpBounded fun x => V x + W x) :
    hamCore (fun x => V x + W x) hsc hsb = hamCore V hVc hVb + potCore W hWc hWb := by
  refine LinearMap.ext fun x => ?_
  obtain ⟨p, hp⟩ := x.2
  have hx : x = ⟨pgLp p, pgLp_mem_core p⟩ := Subtype.ext hp.symm
  have hsplit : potLp (fun x => V x + W x) hsc hsb p
      = potLp V hVc hVb p + potLp W hWc hWb p := by
    unfold potLp
    rw [← MemLp.toLp_add (memLp_mul_pgFun_of_expBounded hVc hVb p)
      (memLp_mul_pgFun_of_expBounded hWc hWb p)]
    refine MemLp.toLp_congr _ _ ?_
    filter_upwards with y
    simp only [Pi.add_apply]
    push_cast
    ring
  rw [hx, hamCore_pgLp, LinearMap.add_apply, hamCore_pgLp, potCore_pgLp]
  unfold hamPoly
  rw [hsplit, add_assoc]

/-- A potential with a uniform bound is exponentially bounded. -/
theorem expBounded_of_bounded {B : Vd d → ℝ} {M : ℝ} (hM : ∀ x, |B x| ≤ M) : ExpBounded B :=
  ⟨M, 0, le_rfl, fun x => by simpa using hM x⟩

/-- **The `L²` bound for a bounded multiplier**: `‖Bψ‖ ≤ M‖ψ‖` on the core. -/
theorem norm_potLp_le {B : Vd d → ℝ} {M : ℝ} (hBc : Continuous B) (hBb : ExpBounded B)
    (hM : ∀ x, |B x| ≤ M) (p : MvPolynomial (Fin d) ℂ) :
    ‖potLp B hBc hBb p‖ ≤ M * ‖pgLp p‖ := by
  have hM0 : 0 ≤ M := le_trans (abs_nonneg _) (hM 0)
  have hle : ‖potLp B hBc hBb p‖ ≤ ‖((M : ℝ) : ℂ) • pgLp p‖ := by
    refine Lp.norm_le_norm_of_ae_le ?_
    filter_upwards [potLp_coeFn B hBc hBb p, Lp.coeFn_smul ((M : ℝ) : ℂ) (pgLp p),
      pgLp_coeFn p] with x hx hy hz
    rw [hx, hy, Pi.smul_apply, hz]
    simp only [norm_mul, norm_smul, Complex.norm_real, Real.norm_eq_abs]
    exact mul_le_mul_of_nonneg_right ((hM x).trans (le_abs_self M)) (norm_nonneg _)
  refine hle.trans ?_
  rw [norm_smul, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg hM0]

/-- **Essential self-adjointness of `−Δ + ‖x‖²/4 + B`** for an arbitrary continuous
*bounded* real perturbation `B`: a bounded symmetric perturbation of an essentially
self-adjoint operator is essentially self-adjoint (Kato–Rellich with relative bound `0`).
This widens the class of potentials for which the Gauss–polynomial core is known to be a
core beyond the pure parabola. -/
theorem harmonic_add_bounded_essentiallySelfAdjoint {B : Vd d → ℝ} {M : ℝ}
    (hBc : Continuous B) (hM : ∀ x, |B x| ≤ M)
    (hsc : Continuous fun x => harmW x + B x) (hsb : ExpBounded fun x => harmW x + B x) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d))
      (hamCore (fun x => harmW x + B x) hsc hsb) := by
  have hBb : ExpBounded B := expBounded_of_bounded hM
  have hM0 : 0 ≤ M := le_trans (abs_nonneg _) (hM 0)
  rw [hamCore_add_potential harmW B continuous_harmW expBounded_harmW hBc hBb hsc hsb]
  refine BookProof.KatoRellich.essentiallySelfAdjointOn_add_relBounded _ _
    harmonicCore_symmetricOn harmonicCore_essentiallySelfAdjoint
    (potCore_symmetricOn B hBc hBb) le_rfl one_pos hM0 fun x => ?_
  obtain ⟨p, hp⟩ := x.2
  have hx : x = ⟨pgLp p, pgLp_mem_core p⟩ := Subtype.ext hp.symm
  rw [hx, potCore_pgLp]
  simpa using norm_potLp_le (d := d) hBc hBb hM p

end

end BookProof.QgHermiteOscillator
