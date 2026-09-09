import Mathlib
import BookProof.ChapterContinuityUnitaryInfinite

/-!
# The unbounded layer: a self-adjoint operator on `ℓ²(ℤ)` and the group it generates

Source: the *Boundary* paragraphs of proof plan appendix §E
(`Book/ProofPlans.lean`) and the `ConditionalUnitary` chapter — everything the
book formalizes about the dynamics-based unitary is carried by *bounded*
operators (matrices on the cyclic lattice in
`BookProof.ChapterContinuityUnitary`, bounded operators on `ℓ²(ℤ)` in
`BookProof.ChapterContinuityUnitaryInfinite`, a bounded self-adjoint generator on
`L²(μ)` in `BookProof.ChapterBornMeasure`).  The remaining open layer is
*unboundedness*.

This module makes that layer precise rather than rhetorical.  For a real
"multiplier" `f : ℤ → ℝ` — the lattice position field `f k = k` being the case of
interest — it builds the multiplication operator on its **natural domain**

  `D(f) = {ψ ∈ ℓ²(ℤ) : f · ψ ∈ ℓ²(ℤ)}`

(a submodule, `mulDomain`), proves that this domain is **dense**
(`mulDomain_dense`, via the finitely supported vectors), that the operator is
**symmetric** on it (`mulOp_symmetric`), and that for the position field it is
genuinely **unbounded** (`position_unbounded`): no constant `C` satisfies
`‖x̂ψ‖ ≤ C‖ψ‖` on the domain.  So the object here is not a bounded operator in
disguise; it is the first honest instance of the unbounded layer, and
`position_not_boundedOperator` records that it is not the restriction of any
bounded operator either.

The module then goes past symmetry in the two directions that matter for the
book's claim.

* **Self-adjointness.**  `adjointDomain_eq_mulDomain` shows the adjoint domain is
  *exactly* `D(f)` — nothing larger — and `adjoint_eq_mulOp` shows the adjoint
  acts by multiplication there.  So the maximal multiplication operator, position
  included, is a genuine self-adjoint observable, not merely a symmetric one.
* **The unitary group.**  `phaseUnitary f t` is the pointwise phase
  `ψ k ↦ exp(i t f k) ψ k`, a `LinearIsometryEquiv` of `ℓ²(ℤ)`
  (`phaseUnitary_zero`, `phaseUnitary_add` give the one-parameter group law),
  strongly continuous at `0` for *every* state (`tendsto_phaseUnitary`), whose
  generator is the unbounded operator: for `ψ ∈ D(f)` the difference quotient
  converges in `ℓ²(ℤ)` to `i·f·ψ` (`tendsto_slope_phaseUnitary`), which is
  Stone's relation `dU/dt|₀ = iA` for an unbounded self-adjoint `A`.

What therefore remains genuinely open is *not* "symmetric ⟹ self-adjoint ⟹ a
unitary group" — that implication is discharged here for multiplication
operators — but the same package for unbounded operators that are not
multiplication operators in the ambient basis (a continuum Laplacian, say), i.e.
Stone's theorem in full generality.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped ENNReal InnerProductSpace

namespace BookProof.ChapterUnboundedPosition

open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

/-! ## The natural domain of a multiplication operator -/

/-- The **natural domain** `D(f) = {ψ ∈ ℓ²(ℤ) : f·ψ ∈ ℓ²(ℤ)}` of multiplication
by a real field `f`, as a submodule of `ℓ²(ℤ)`. -/
def mulDomain (f : ℤ → ℝ) : Submodule ℂ L2Z where
  carrier := {psi : L2Z | Memℓp (fun k => (f k : ℂ) * (psi : ℤ → ℂ) k) 2}
  zero_mem' := by
    simp only [Set.mem_setOf_eq, lp.coeFn_zero, Pi.zero_apply, mul_zero]
    exact zero_memℓp
  add_mem' := by
    intro a b ha hb
    have heq : (fun k => (f k : ℂ) * ((a + b : L2Z) : ℤ → ℂ) k)
        = (fun k => (f k : ℂ) * (a : ℤ → ℂ) k) + fun k => (f k : ℂ) * (b : ℤ → ℂ) k := by
      funext k
      simp [mul_add]
    change Memℓp _ 2
    rw [heq]
    exact ha.add hb
  smul_mem' := by
    intro c a ha
    have heq : (fun k => (f k : ℂ) * ((c • a : L2Z) : ℤ → ℂ) k)
        = c • fun k => (f k : ℂ) * (a : ℤ → ℂ) k := by
      funext k
      simp [mul_left_comm]
    change Memℓp _ 2
    rw [heq]
    exact ha.const_smul c

theorem mem_mulDomain_iff (f : ℤ → ℝ) (psi : L2Z) :
    psi ∈ mulDomain f ↔ Memℓp (fun k => (f k : ℂ) * (psi : ℤ → ℂ) k) 2 := Iff.rfl

/-- Multiplication by `f`, on its natural domain. -/
noncomputable def mulOp (f : ℤ → ℝ) : mulDomain f →ₗ[ℂ] L2Z where
  toFun psi := ⟨fun k => (f k : ℂ) * ((psi : L2Z) : ℤ → ℂ) k, psi.2⟩
  map_add' a b := by ext k; simp [mul_add]
  map_smul' c a := by
    ext k
    simp only [lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply, Submodule.coe_smul]
    ring

@[simp] theorem mulOp_apply (f : ℤ → ℝ) (psi : mulDomain f) (k : ℤ) :
    ((mulOp f psi : L2Z) : ℤ → ℂ) k = (f k : ℂ) * ((psi : L2Z) : ℤ → ℂ) k := rfl

/-- **The operator is symmetric on its domain.** -/
theorem mulOp_symmetric (f : ℤ → ℝ) (psi phi : mulDomain f) :
    ⟪mulOp f psi, (phi : L2Z)⟫_ℂ = ⟪(psi : L2Z), mulOp f phi⟫_ℂ := by
  rw [lp.inner_eq_tsum, lp.inner_eq_tsum]
  refine tsum_congr fun k => ?_
  simp only [mulOp_apply, RCLike.inner_apply, map_mul, Complex.conj_ofReal]
  ring

/-! ## The domain is dense -/

/-- Every basis vector lies in every natural domain. -/
theorem single_mem_mulDomain (f : ℤ → ℝ) (n : ℤ) (c : ℂ) :
    lp.single 2 n c ∈ mulDomain f := by
  refine memℓp_gen (summable_of_ne_finset_zero (s := {n}) ?_)
  intro j hj
  have hjn : j ≠ n := by simpa using hj
  simp [lp.single_apply, hjn]

/-- Each finite truncation of a vector lies in the domain. -/
theorem sum_single_mem_mulDomain (f : ℤ → ℝ) (psi : L2Z) (s : Finset ℤ) :
    (∑ i ∈ s, lp.single 2 i ((psi : ℤ → ℂ) i)) ∈ mulDomain f :=
  Submodule.sum_mem _ fun i _ => single_mem_mulDomain f i _

/-- **The natural domain is dense in `ℓ²(ℤ)`** — the operator is densely
defined, as an unbounded operator must be for its adjoint to exist. -/
theorem mulDomain_dense (f : ℤ → ℝ) : Dense ((mulDomain f : Submodule ℂ L2Z) : Set L2Z) := by
  intro psi
  refine mem_closure_of_tendsto (lp.hasSum_single (by simp) psi) ?_
  filter_upwards with s using sum_single_mem_mulDomain f psi s

/-! ## The position field really is unbounded -/

/-- The lattice **position field** `x̂ : k ↦ k`. -/
def positionField : ℤ → ℝ := fun k => (k : ℝ)

theorem mulOp_single (f : ℤ → ℝ) (n : ℤ) (c : ℂ) :
    mulOp f ⟨lp.single 2 n c, single_mem_mulDomain f n c⟩ = lp.single 2 n ((f n : ℂ) * c) := by
  ext k
  by_cases hk : k = n
  · subst hk
    simp [lp.single_apply]
  · simp [lp.single_apply, hk]

/-- **The position operator is unbounded**: there is no constant `C` with
`‖x̂ψ‖ ≤ C‖ψ‖` on the domain.  The basis vectors `e_n` are unit vectors with
`‖x̂ e_n‖ = |n|`. -/
theorem position_unbounded :
    ¬ ∃ C : ℝ, ∀ psi : mulDomain positionField,
      ‖mulOp positionField psi‖ ≤ C * ‖(psi : L2Z)‖ := by
  rintro ⟨C, hC⟩
  obtain ⟨n, hn⟩ := exists_nat_gt C
  have hmem := single_mem_mulDomain positionField (n : ℤ) (1 : ℂ)
  have h := hC ⟨lp.single 2 (n : ℤ) (1 : ℂ), hmem⟩
  rw [mulOp_single positionField (n : ℤ) (1 : ℂ)] at h
  rw [lp.norm_single (by norm_num), lp.norm_single (by norm_num)] at h
  simp only [positionField, mul_one, norm_one] at h
  simp only [Complex.norm_real, Real.norm_eq_abs] at h
  rw [abs_of_nonneg (by positivity)] at h
  push_cast at h
  linarith

/-! ## The adjoint: the maximal multiplication operator is self-adjoint -/

theorem inner_single_left (phi : L2Z) (k : ℤ) (c : ℂ) :
    ⟪(lp.single 2 k c : L2Z), phi⟫_ℂ = (starRingEnd ℂ) c * (phi : ℤ → ℂ) k := by
  rw [lp.inner_eq_tsum, tsum_eq_single k (by intro j hj; simp [lp.single_apply, hj])]
  simp [lp.single_apply, RCLike.inner_apply, mul_comm]

/-- **The adjoint acts by multiplication, on no larger a domain.**  If `φ` is paired
with some `η ∈ ℓ²(ℤ)` against the whole domain, then `η = f·φ` pointwise — so
`f·φ` is square-summable and `φ` already lies in the natural domain. -/
theorem mulOp_adjoint_apply (f : ℤ → ℝ) {phi eta : L2Z}
    (h : ∀ psi : mulDomain f, ⟪mulOp f psi, phi⟫_ℂ = ⟪(psi : L2Z), eta⟫_ℂ) :
    (∀ k, (f k : ℂ) * (phi : ℤ → ℂ) k = (eta : ℤ → ℂ) k) ∧ phi ∈ mulDomain f := by
  have hpt : ∀ k, (f k : ℂ) * (phi : ℤ → ℂ) k = (eta : ℤ → ℂ) k := by
    intro k
    have hk := h ⟨lp.single 2 k (1 : ℂ), single_mem_mulDomain f k 1⟩
    rw [mulOp_single f k (1 : ℂ), inner_single_left, inner_single_left] at hk
    simpa [Complex.conj_ofReal] using hk
  refine ⟨hpt, ?_⟩
  change Memℓp _ 2
  have hfun : (fun k => (f k : ℂ) * (phi : ℤ → ℂ) k) = (eta : ℤ → ℂ) := funext hpt
  rw [hfun]
  exact lp.memℓp eta

/-- The domain of the adjoint of multiplication by `f`. -/
def adjointDomain (f : ℤ → ℝ) : Set L2Z :=
  {phi | ∃ eta : L2Z, ∀ psi : mulDomain f, ⟪mulOp f psi, phi⟫_ℂ = ⟪(psi : L2Z), eta⟫_ℂ}

/-- **The maximal multiplication operator is self-adjoint**: the adjoint domain is
exactly the natural domain.  In particular the lattice position operator — densely
defined, symmetric and unbounded — is a *self-adjoint* observable, not merely a
symmetric one. -/
theorem adjointDomain_eq_mulDomain (f : ℤ → ℝ) :
    adjointDomain f = ((mulDomain f : Submodule ℂ L2Z) : Set L2Z) := by
  ext phi
  constructor
  · rintro ⟨eta, h⟩
    exact (mulOp_adjoint_apply f h).2
  · intro hphi
    exact ⟨mulOp f ⟨phi, hphi⟩, fun psi => mulOp_symmetric f psi ⟨phi, hphi⟩⟩

/-- ... and on that domain the adjoint *is* the operator: any `η` implementing the
adjoint pairing equals `f·φ`. -/
theorem adjoint_eq_mulOp (f : ℤ → ℝ) {phi eta : L2Z} (hphi : phi ∈ mulDomain f)
    (h : ∀ psi : mulDomain f, ⟪mulOp f psi, phi⟫_ℂ = ⟪(psi : L2Z), eta⟫_ℂ) :
    eta = mulOp f ⟨phi, hphi⟩ := by
  refine lp.ext (funext fun k => ?_)
  exact ((mulOp_adjoint_apply f h).1 k).symm

/-- The position operator is not the restriction of any bounded operator on
`ℓ²(ℤ)`: a bounded operator would supply exactly the constant that
`position_unbounded` forbids. -/
theorem position_not_boundedOperator :
    ¬ ∃ T : L2Z →L[ℂ] L2Z, ∀ psi : mulDomain positionField,
      mulOp positionField psi = T (psi : L2Z) := by
  rintro ⟨T, hT⟩
  refine position_unbounded ⟨‖T‖, fun psi => ?_⟩
  rw [hT psi]
  exact T.le_opNorm _

/-! ## The unitary group generated by the multiplication operator -/

/-- The phase `e^{i t f k}` of the group generated by multiplication by `f`. -/
noncomputable def phase (f : ℤ → ℝ) (t : ℝ) (k : ℤ) : ℂ :=
  Complex.exp (Complex.I * ((t * f k : ℝ) : ℂ))

theorem norm_phase (f : ℤ → ℝ) (t : ℝ) (k : ℤ) : ‖phase f t k‖ = 1 :=
  Complex.norm_exp_I_mul_ofReal _

theorem continuous_phase (f : ℤ → ℝ) (k : ℤ) : Continuous fun t : ℝ => phase f t k := by
  unfold phase
  fun_prop

theorem memℓp_phase (f : ℤ → ℝ) (t : ℝ) (psi : L2Z) :
    Memℓp (fun k => phase f t k * (psi : ℤ → ℂ) k) 2 := by
  refine BookProof.ChapterContinuityUnitaryInfinite.memℓp_two_of_summable ?_
  have h : ∀ k : ℤ, ‖phase f t k * (psi : ℤ → ℂ) k‖ ^ 2 = ‖(psi : ℤ → ℂ) k‖ ^ 2 := by
    intro k
    rw [norm_mul, norm_phase, one_mul]
  simpa only [h] using BookProof.ChapterContinuityUnitaryInfinite.summable_normSq psi

/-- Multiplication by the phase `e^{i t f}`, as a linear map. -/
noncomputable def phaseLin (f : ℤ → ℝ) (t : ℝ) : L2Z →ₗ[ℂ] L2Z where
  toFun psi := ⟨fun k => phase f t k * (psi : ℤ → ℂ) k, memℓp_phase f t psi⟩
  map_add' a b := by ext k; simp [mul_add]
  map_smul' c a := by
    ext k
    simp only [lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply]
    ring

@[simp] theorem phaseLin_apply (f : ℤ → ℝ) (t : ℝ) (psi : L2Z) (k : ℤ) :
    ((phaseLin f t psi : L2Z) : ℤ → ℂ) k = phase f t k * (psi : ℤ → ℂ) k := rfl

theorem phaseLin_add (f : ℤ → ℝ) (s t : ℝ) (psi : L2Z) :
    phaseLin f s (phaseLin f t psi) = phaseLin f (s + t) psi := by
  ext k
  simp only [phaseLin_apply, phase, ← mul_assoc, ← Complex.exp_add]
  congr 2
  push_cast
  ring

theorem phaseLin_zero (f : ℤ → ℝ) (psi : L2Z) : phaseLin f 0 psi = psi := by
  ext k
  simp [phase]

theorem phaseLin_norm (f : ℤ → ℝ) (t : ℝ) (psi : L2Z) : ‖phaseLin f t psi‖ = ‖psi‖ := by
  have key : ‖phaseLin f t psi‖ ^ 2 = ‖psi‖ ^ 2 := by
    rw [BookProof.ChapterContinuityUnitaryInfinite.norm_sq_eq_tsum,
      BookProof.ChapterContinuityUnitaryInfinite.norm_sq_eq_tsum]
    refine tsum_congr fun k => ?_
    rw [phaseLin_apply, norm_mul, norm_phase, one_mul]
  have hpow : ‖phaseLin f t psi‖ ^ ((2 : ℕ) : ℝ) = ‖psi‖ ^ ((2 : ℕ) : ℝ) := by
    simpa only [Real.rpow_natCast] using key
  exact Real.rpow_left_injOn (x := ((2 : ℕ) : ℝ)) (by norm_num)
    (norm_nonneg _) (norm_nonneg _) hpow

/-- **The unitary group `U t = e^{i t f}` generated by multiplication by `f`.**
Every `U t` is a unitary of `ℓ²(ℤ)` — for the position field this is the group
generated by an *unbounded* self-adjoint observable. -/
noncomputable def phaseUnitary (f : ℤ → ℝ) (t : ℝ) : L2Z ≃ₗᵢ[ℂ] L2Z where
  toLinearEquiv :=
    { phaseLin f t with
      invFun := phaseLin f (-t)
      left_inv := fun psi => by
        change phaseLin f (-t) (phaseLin f t psi) = psi
        rw [phaseLin_add, neg_add_cancel, phaseLin_zero]
      right_inv := fun psi => by
        change phaseLin f t (phaseLin f (-t) psi) = psi
        rw [phaseLin_add, add_neg_cancel, phaseLin_zero] }
  norm_map' := phaseLin_norm f t

@[simp] theorem phaseUnitary_apply (f : ℤ → ℝ) (t : ℝ) (psi : L2Z) :
    phaseUnitary f t psi = phaseLin f t psi := rfl

theorem phaseUnitary_zero (f : ℤ → ℝ) (psi : L2Z) : phaseUnitary f 0 psi = psi :=
  phaseLin_zero f psi

/-- The one-parameter group law. -/
theorem phaseUnitary_add (f : ℤ → ℝ) (s t : ℝ) (psi : L2Z) :
    phaseUnitary f (s + t) psi = phaseUnitary f s (phaseUnitary f t psi) :=
  (phaseLin_add f s t psi).symm

/-- **Strong continuity at `0`.**  Although the generator is unbounded, the group
is strongly continuous: `U t ψ → ψ` in `ℓ²(ℤ)` as `t → 0`, for *every* state — no
domain hypothesis. -/
theorem tendsto_phaseUnitary (f : ℤ → ℝ) (psi : L2Z) :
    Filter.Tendsto (fun t : ℝ => phaseUnitary f t psi) (nhds 0) (nhds psi) := by
  rw [tendsto_iff_norm_sub_tendsto_zero]
  have hsq : ∀ t : ℝ, ‖phaseUnitary f t psi - psi‖ ^ 2
      = ∑' k : ℤ, ‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ^ 2 := by
    intro t
    rw [BookProof.ChapterContinuityUnitaryInfinite.norm_sq_eq_tsum]
    refine tsum_congr fun k => ?_
    congr 1
    simp [sub_mul]
  have hbound : Summable fun k : ℤ => 4 * ‖(psi : ℤ → ℂ) k‖ ^ 2 :=
    (BookProof.ChapterContinuityUnitaryInfinite.summable_normSq psi).mul_left 4
  have hpt : ∀ k : ℤ, Filter.Tendsto
      (fun t : ℝ => ‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ^ 2) (nhds 0) (nhds 0) := by
    intro k
    have hc : Continuous fun t : ℝ => ‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ^ 2 :=
      (((continuous_phase f k).sub continuous_const).mul continuous_const).norm.pow 2
    simpa [phase] using hc.tendsto 0
  have hdom : ∀ t : ℝ, ∀ k : ℤ,
      ‖‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ^ 2‖ ≤ 4 * ‖(psi : ℤ → ℂ) k‖ ^ 2 := by
    intro t k
    have h1 : ‖phase f t k - 1‖ ≤ 2 := by
      calc ‖phase f t k - 1‖ ≤ ‖phase f t k‖ + ‖(1 : ℂ)‖ := norm_sub_le _ _
        _ = 2 := by rw [norm_phase]; norm_num
    have h2 : ‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ≤ 2 * ‖(psi : ℤ → ℂ) k‖ := by
      rw [norm_mul]
      exact mul_le_mul_of_nonneg_right h1 (norm_nonneg _)
    rw [Real.norm_eq_abs, abs_of_nonneg (by positivity)]
    nlinarith [norm_nonneg ((phase f t k - 1) * (psi : ℤ → ℂ) k), norm_nonneg ((psi : ℤ → ℂ) k)]
  have htsum := tendsto_tsum_of_dominated_convergence hbound hpt
    (Filter.Eventually.of_forall hdom)
  rw [tsum_zero] at htsum
  have hsqrt : Filter.Tendsto
      (fun t : ℝ => Real.sqrt (∑' k : ℤ, ‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ^ 2))
      (nhds 0) (nhds 0) := by
    simpa using (Real.continuous_sqrt.tendsto 0).comp htsum
  refine hsqrt.congr fun t => ?_
  rw [← hsq t, Real.sqrt_sq (norm_nonneg _)]

/-- The phase has the expected derivative in `t`. -/
theorem hasDerivAt_phase (f : ℤ → ℝ) (k : ℤ) :
    HasDerivAt (fun t : ℝ => phase f t k) (Complex.I * f k) 0 := by
  have h1 : HasDerivAt (fun t : ℝ => Complex.I * ((t * f k : ℝ) : ℂ)) (Complex.I * f k) 0 := by
    have h0 : HasDerivAt (fun t : ℝ => ((t * f k : ℝ) : ℂ)) ((f k : ℂ)) 0 := by
      simpa using ((hasDerivAt_id (0 : ℝ)).mul_const (f k)).ofReal_comp
    simpa [mul_comm] using h0.const_mul Complex.I
  simpa [phase] using h1.cexp

theorem tendsto_slope_phase (f : ℤ → ℝ) (k : ℤ) :
    Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (phase f t k - 1)) (nhdsWithin 0 {0}ᶜ)
      (nhds (Complex.I * f k)) := by
  have h := hasDerivAt_iff_tendsto_slope.1 (hasDerivAt_phase f k)
  refine h.congr fun t => ?_
  simp [slope, vsub_eq_sub, phase]

/-- **The multiplication operator is the generator of its phase group.**  For a
state in the natural domain the difference quotient of `U t ψ` converges *in
`ℓ²(ℤ)`* to `i·f·ψ` — Stone's relation `dU/dt|₀ = iA`, here for an unbounded
self-adjoint `A`. -/
theorem tendsto_slope_phaseUnitary (f : ℤ → ℝ) (psi : mulDomain f) :
    Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (phaseUnitary f t (psi : L2Z) - (psi : L2Z)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • mulOp f psi)) := by
  rw [tendsto_iff_norm_sub_tendsto_zero]
  set g : ℤ → ℂ := fun k => (psi : L2Z) k with hg
  have hsq : ∀ t : ℝ,
      ‖(t⁻¹ : ℝ) • (phaseUnitary f t (psi : L2Z) - (psi : L2Z)) - Complex.I • mulOp f psi‖ ^ 2
        = ∑' k : ℤ, ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k‖ ^ 2 := by
    intro t
    rw [BookProof.ChapterContinuityUnitaryInfinite.norm_sq_eq_tsum]
    refine tsum_congr fun k => ?_
    congr 1
    simp only [lp.coeFn_sub, lp.coeFn_smul, Pi.sub_apply, Pi.smul_apply, smul_eq_mul,
      phaseUnitary_apply, phaseLin_apply, mulOp_apply, Complex.real_smul, hg]
    ring
  have hfpsi : Summable fun k : ℤ => ‖(f k : ℂ) * g k‖ ^ 2 := by
    simpa [hg] using
      BookProof.ChapterContinuityUnitaryInfinite.summable_normSq (mulOp f psi)
  have hbound : Summable fun k : ℤ => 4 * ‖(f k : ℂ) * g k‖ ^ 2 := hfpsi.mul_left 4
  have hpt : ∀ k : ℤ, Filter.Tendsto
      (fun t : ℝ => ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k‖ ^ 2)
      (nhdsWithin 0 {0}ᶜ) (nhds 0) := by
    intro k
    have h1 := (tendsto_slope_phase f k).mul_const (g k)
    have h2 : Filter.Tendsto
        (fun t : ℝ => ((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k)
        (nhdsWithin 0 {0}ᶜ) (nhds 0) := by
      have := h1.sub_const (Complex.I * (f k : ℂ) * g k)
      simpa [mul_assoc] using this
    simpa using (h2.norm.pow 2)
  have hdom : ∀ t : ℝ, ∀ k : ℤ,
      ‖‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k‖ ^ 2‖
        ≤ 4 * ‖(f k : ℂ) * g k‖ ^ 2 := by
    intro t k
    have hph : ‖((t⁻¹ : ℝ) • (phase f t k - 1))‖ ≤ |f k| := by
      rcases eq_or_ne t 0 with rfl | ht
      · simp
      · have hbase : ‖phase f t k - 1‖ ≤ |t * f k| := by
          simpa [phase, Real.norm_eq_abs] using
            (Real.norm_exp_I_mul_ofReal_sub_one_le (x := t * f k))
        rw [norm_smul, Real.norm_eq_abs, abs_inv]
        calc |t|⁻¹ * ‖phase f t k - 1‖ ≤ |t|⁻¹ * |t * f k| :=
              mul_le_mul_of_nonneg_left hbase (by positivity)
          _ = |f k| := by
              rw [abs_mul, ← mul_assoc, inv_mul_cancel₀ (abs_ne_zero.2 ht), one_mul]
    have h1 : ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k‖
        ≤ 2 * ‖(f k : ℂ) * g k‖ := by
      have e1 : ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k‖ ≤ |f k| * ‖g k‖ := by
        rw [norm_mul]
        exact mul_le_mul_of_nonneg_right hph (norm_nonneg _)
      have e2 : ‖Complex.I * (f k : ℂ) * g k‖ = |f k| * ‖g k‖ := by
        simp [Complex.norm_real, Real.norm_eq_abs, mul_assoc]
      have e3 : ‖(f k : ℂ) * g k‖ = |f k| * ‖g k‖ := by
        simp [Complex.norm_real, Real.norm_eq_abs]
      calc ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k‖
          ≤ ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k‖ + ‖Complex.I * (f k : ℂ) * g k‖ :=
            norm_sub_le _ _
        _ ≤ |f k| * ‖g k‖ + |f k| * ‖g k‖ := by rw [e2]; linarith
        _ = 2 * ‖(f k : ℂ) * g k‖ := by rw [e3]; ring
    rw [Real.norm_eq_abs, abs_of_nonneg (by positivity)]
    nlinarith [norm_nonneg (((t⁻¹ : ℝ) • (phase f t k - 1)) * g k -
      Complex.I * (f k : ℂ) * g k), norm_nonneg ((f k : ℂ) * g k)]
  have htsum := tendsto_tsum_of_dominated_convergence hbound hpt
    (Filter.Eventually.of_forall hdom)
  rw [tsum_zero] at htsum
  have hsqrt : Filter.Tendsto
      (fun t : ℝ => Real.sqrt (∑' k : ℤ,
        ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k‖ ^ 2))
      (nhdsWithin 0 {0}ᶜ) (nhds 0) := by
    simpa using (Real.continuous_sqrt.tendsto 0).comp htsum
  refine hsqrt.congr fun t => ?_
  rw [← hsq t, Real.sqrt_sq (norm_nonneg _)]

end BookProof.ChapterUnboundedPosition
