import Mathlib


/-!
# The dynamics-based unitary on the infinite lattice `ℓ²(ℤ)`

Source: the manuscript's field-theoretic thread (`QFM.tex`) and the
`ConditionalUnitary` chapter's *"A Less Arbitrary Construction"* section
(`Book/ConditionalUnitary.lean`); proof plan appendix §E
(`Book/ProofPlans.lean`).

`BookProof.ChapterContinuityUnitary` builds the dynamics-based unitary on the
*finite* cyclic lattice `ZMod N`, where every operator is a matrix and the
exponential is a matrix exponential.  Its docstring records the
infinite-dimensional analytic realization as the book's standing open layer.
This module closes that layer in the **bounded** case: the same construction is
carried out on the genuine infinite-dimensional Hilbert space
`ℓ²(ℤ) = lp (fun _ : ℤ => ℂ) 2`, with

* the lattice translations `(S_m f) k = f (k + m)` as *unitaries*
  (`shiftEquiv`), rather than permutation matrices;
* the symmetric-difference momentum `p = -(i/2)(S₁ - S₋₁)` as a **bounded
  self-adjoint operator** (`momentum_isSelfAdjoint`);
* a bounded velocity field `v ∈ ℓ^∞(ℤ)` acting as a bounded self-adjoint
  multiplication operator (`velocityOp_isSelfAdjoint`);
* the Weyl-symmetrized generator `H = ½ (p·v + v·p)`, again bounded and
  self-adjoint (`continuityHamiltonian_isSelfAdjoint`);
* the one-parameter unitary group `U t = exp (i t H)`
  (`continuityUnitary_unitary`, `continuityUnitary_zero`,
  `continuityUnitary_add`), built with the Banach-algebra exponential of
  `ℓ²(ℤ) →L[ℂ] ℓ²(ℤ)`;
* the Born recovery `P(B) = ∑_{z ∈ B} |Ψ_t z|²`, now a **countably** additive
  probability law: `bornRecover_tsum_univ` gives total mass `1` and `bornPMF`
  packages it as a `PMF ℤ`, with the capstone `condProb_of_continuity_infinite`.

The only structural change from the finite chapter is that self-adjointness is
proved through the inner product (`ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric`)
instead of through conjugate transposition of matrices, and that the total mass
is a `tsum` instead of a finite sum.  Unboundedness (the position/momentum
operators of the continuum) remains outside the statement: everything here is a
bounded operator on `ℓ²(ℤ)`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped ENNReal InnerProductSpace

namespace BookProof.ChapterContinuityUnitaryInfinite

/-! ## The lattice Hilbert space and the `ℓ^∞` velocity fields -/

/-- The infinite lattice Hilbert space `ℓ²(ℤ)`. -/
noncomputable abbrev L2Z := lp (fun _ :import Mathlib

/-!
# The dynamics-based unitary on the infinite lattice `ℓ²(ℤ)`

Source: the manuscript's field-theoretic thread (`QFM.tex`) and the
`ConditionalUnitary` chapter's *"A Less Arbitrary Construction"* section
(`Book/ConditionalUnitary.lean`); proof plan appendix §E
(`Book/ProofPlans.lean`).

`BookProof.ChapterContinuityUnitary` builds the dynamics-based unitary on the
*finite* cyclic lattice `ZMod N`, where every operator is a matrix and the
exponential is a matrix exponential.  Its docstring records the
infinite-dimensional analytic realization as the book's standing open layer.
This module closes that layer in the **bounded** case: the same construction is
carried out on the genuine infinite-dimensional Hilbert space
`ℓ²(ℤ) = lp (fun _ : ℤ => ℂ) 2`, with

* the lattice translations `(S_m f) k = f (k + m)` as *unitaries*
  (`shiftEquiv`), rather than permutation matrices;
* the symmetric-difference momentum `p = -(i/2)(S₁ - S₋₁)` as a **bounded
  self-adjoint operator** (`momentum_isSelfAdjoint`);
* a bounded velocity field `v ∈ ℓ^∞(ℤ)` acting as a bounded self-adjoint
  multiplication operator (`velocityOp_isSelfAdjoint`);
* the Weyl-symmetrized generator `H = ½ (p·v + v·p)`, again bounded and
  self-adjoint (`continuityHamiltonian_isSelfAdjoint`);
* the one-parameter unitary group `U t = exp (i t H)`
  (`continuityUnitary_unitary`, `continuityUnitary_zero`,
  `continuityUnitary_add`), built with the Banach-algebra exponential of
  `ℓ²(ℤ) →L[ℂ] ℓ²(ℤ)`;
* the Born recovery `P(B) = ∑_{z ∈ B} |Ψ_t z|²`, now a **countably** additive
  probability law: `bornRecover_tsum_univ` gives total mass `1` and `bornPMF`
  packages it as a `PMF ℤ`, with the capstone `condProb_of_continuity_infinite`.

The only structural change from the finite chapter is that self-adjointness is
proved through the inner product (`ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric`)
instead of through conjugate transposition of matrices, and that the total mass
is a `tsum` instead of a finite sum.  Unboundedness (the position/momentum
operators of the continuum) remains outside the statement: everything here is a
bounded operator on `ℓ²(ℤ)`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped ENNReal InnerProductSpace

namespace BookProof.ChapterContinuityUnitaryInfinite

/-! ## The lattice Hilbert space and the `ℓ^∞` velocity fields -/

/-- The infinite lattice Hilbert space `ℓ²(ℤ)`. -/
noncomputable abbrev L2Z := lp (fun _ : ℤ => ℂ) 2

/-- Bounded velocity fields on the lattice: `ℓ^∞(ℤ)`. -/
abbrev LinfZ := lp (fun _ : ℤ => ℝ) ∞

theorem summable_normSq (f : L2Z) : Summable fun k : ℤ => ‖(f : ℤ → ℂ) k‖ ^ 2 := by
  have hsum := (lp.memℓp f).summable (p := 2) (by norm_num)
  simpa [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num, Real.rpow_natCast] using hsum

/-- Parseval on `ℓ²(ℤ)`: the squared norm is the sum of the squared moduli. -/
theorem norm_sq_eq_tsum (f : L2Z) : ‖f‖ ^ 2 = ∑' k : ℤ, ‖(f : ℤ → ℂ) k‖ ^ 2 := by
  have h := lp.norm_rpow_eq_tsum (p := 2) (by norm_num) f
  rw [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num] at h
  simpa only [Real.rpow_natCast] using h

theorem memℓp_two_of_summable {g : ℤ → ℂ} (h : Summable fun k => ‖g k‖ ^ 2) : Memℓp g 2 := by
  apply memℓp_gen
  simpa [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num, Real.rpow_natCast] using h

/-! ## The lattice translations are unitaries -/

theorem memℓp_shift (f : L2Z) (m : ℤ) : Memℓp (fun k : ℤ => (f : ℤ → ℂ) (k + m)) 2 := by
  apply memℓp_gen
  exact ((Equiv.addRight m).summable_iff).2 ((lp.memℓp f).summable (p := 2) (by norm_num))

/-- The lattice translation `(S_m f) k = f (k + m)`, as a linear map. -/
noncomputable def shiftLin (m : ℤ) : L2Z →ₗ[ℂ] L2Z where
  toFun f := ⟨fun k => (f : ℤ → ℂ) (k + m), memℓp_shift f m⟩
  map_add' f g := by
    ext k
    rfl
  map_smul' c fimport Mathlib

/-!
# The dynamics-based unitary on the infinite lattice `ℓ²(ℤ)`

Source: the manuscript's field-theoretic thread (`QFM.tex`) and the
`ConditionalUnitary` chapter's *"A Less Arbitrary Construction"* section
(`Book/ConditionalUnitary.lean`); proof plan appendix §E
(`Book/ProofPlans.lean`).

`BookProof.ChapterContinuityUnitary` builds the dynamics-based unitary on the
*finite* cyclic lattice `ZMod N`, where every operator is a matrix and the
exponential is a matrix exponential.  Its docstring records the
infinite-dimensional analytic realization as the book's standing open layer.
This module closes that layer in the **bounded** case: the same construction is
carried out on the genuine infinite-dimensional Hilbert space
`ℓ²(ℤ) = lp (fun _ : ℤ => ℂ) 2`, with

* the lattice translations `(S_m f) k = f (k + m)` as *unitaries*
  (`shiftEquiv`), rather than permutation matrices;
* the symmetric-difference momentum `p = -(i/2)(S₁ - S₋₁)` as a **bounded
  self-adjoint operator** (`momentum_isSelfAdjoint`);
* a bounded velocity field `v ∈ ℓ^∞(ℤ)` acting as a bounded self-adjoint
  multiplication operator (`velocityOp_isSelfAdjoint`);
* the Weyl-symmetrized generator `H = ½ (p·v + v·p)`, again bounded and
  self-adjoint (`continuityHamiltonian_isSelfAdjoint`);
* the one-parameter unitary group `U t = exp (i t H)`
  (`continuityUnitary_unitary`, `continuityUnitary_zero`,
  `continuityUnitary_add`), built with the Banach-algebra exponential of
  `ℓ²(ℤ) →L[ℂ] ℓ²(ℤ)`;
* the Born recovery `P(B) = ∑_{z ∈ B} |Ψ_t z|²`, now a **countably** additive
  probability law: `bornRecover_tsum_univ` gives total mass `1` and `bornPMF`
  packages it as a `PMF ℤ`, with the capstone `condProb_of_continuity_infinite`.

The only structural change from the finite chapter is that self-adjointness is
proved through the inner product (`ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric`)
instead of through conjugate transposition of matrices, and that the total mass
is a `tsum` instead of a finite sum.  Unboundedness (the position/momentum
operators of the continuum) remains outside the statement: everything here is a
bounded operator on `ℓ²(ℤ)`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped ENNReal InnerProductSpace

namespace BookProof.ChapterContinuityUnitaryInfinite

/-! ## The lattice Hilbert space and the `ℓ^∞` velocity fields -/

/-- The infinite lattice Hilbert space `ℓ²(ℤ)`. -/
noncomputable abbrev L2Z := lp (fun _ : ℤ => ℂ) 2

/-- Bounded velocity fields on the lattice: `ℓ^∞(ℤ)`. -/
abbrev LinfZ := lp (fun _ : ℤ => ℝ) ∞

theorem summable_normSq (f : L2Z) : Summable fun k : ℤ => ‖(f : ℤ → ℂ) k‖ ^ 2 := by
  have hsum := (lp.memℓp f).summable (p := 2) (by norm_num)
  simpa [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num, Real.rpow_natCast] using hsum

/-- Parseval on `ℓ²(ℤ)`: the squared norm is the sum of the squared moduli. -/
theorem norm_sq_eq_tsum (f : L2Z) : ‖f‖ ^ 2 = ∑' k : ℤ, ‖(f : ℤ → ℂ) k‖ ^ 2 := by
  have h := lp.norm_rpow_eq_tsum (p := 2) (by norm_num) f
  rw [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num] at h
  simpa only [Real.rpow_natCast] using h

theorem memℓp_two_of_summable {g : ℤ → ℂ} (h : Summable fun k => ‖g k‖ ^ 2) : Memℓp g 2 := by
  apply memℓp_gen
  simpa [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num, Real.rpow_natCast] using h

/-! ## The lattice translations are unitaries -/

theorem memℓp_shift (f : L2Z) (m : ℤ) : Memℓp (fun k : ℤ => (f : ℤ → ℂ) (k + m)) 2 := by
  apply memℓp_gen
  exact ((Equiv.addRight m).summable_iff).2 ((lp.memℓp f).summable (p := 2) (by norm_num))

/-- The lattice translation `(S_m f) k = f (k + m)`, as a linear map. -/
noncomputable def shiftLin (m : ℤ) : L2Z →ₗ[ℂ] L2Z where
  toFun f := ⟨fun k => (f : ℤ → ℂ) (k + m), memℓp_shift f m⟩
  map_add' f g := by
    ext k
    rfl
  map_smul' c f := by ext k; simp

@[simp] theorem shiftLin_apply (m : ℤ) (f : L2Z) (k : ℤ) :
    ((shiftLin m f : L2Z) : ℤ → ℂ) k = (f : ℤ → ℂ) (k + m) := rfl

theorem shiftLin_norm (m : ℤ) (f : L2Z) : ‖shiftLin m f‖ = ‖f‖ := by
  have key : ‖shiftLin m f‖ ^ 2 = ‖f‖ ^ 2 := by
    rw [norm_sq_eq_tsum, norm_sq_eq_tsum]
    exact (Equiv.addRight m).tsum_eq fun k => ‖(f : ℤ → ℂ) k‖ ^ 2
  have hpow : ‖shiftLin m f‖ ^ ((2 : ℕ) : ℝ) = ‖f‖ ^ ((2 : ℕ) : ℝ) := by
    simpa only [Real.rpow_natCast] using key
  exact Real.rpow_left_injOn (x := ((2 : ℕ) : ℝ)) (by norm_num)
    (norm_nonneg _) (norm_nonneg _) hpow

/-- **The lattice translation is a unitary of `ℓ²(ℤ)`.** -/
noncomputable def shiftEquiv (m : ℤ) : L2Z ≃ₗᵢ[ℂ] L2Z where
  toLinearEquiv :=
    { shiftLin m with
      invFun := shiftLin (-m)
      left_inv := fun f => by ext k; simp
      right_inv := fun f => by ext k; simp }
  norm_map' := shiftLin_norm m

/-- The lattice translation as a bounded operator. -/
noncomputable def shiftOp (m : ℤ) : L2Z →L[ℂ] L2Z :=
  (shiftEquiv m).toLinearIsometry.toC [hg] at h
  exact h

/-! ## The momentum operator -/

/-- The **symmetric-difference momentum** on the infinite lattice:
`(p f) k = -(i/2) (f (k+1) - f (k-1))`. -/
noncomputable def momentum : L2Z →L[ℂ] L2Z :=
  (-Complex.I / 2) • (shiftOptOx.momentum_isSymmetric

/-! ## The velocity (multiplice_norm (by simp) v k

theorem memℓp_mul (v : LinfZ) (f : L2Z) :
    Memℓp (fun k : ℤ => ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k) 2 := by
  refine memℓp_two_of_summable (Summable.of_nonneg_of_le (fun k => by positivity) (fun k => ?_)
    ((summable_normSq f).mul_left (‖v‖ ^ 2)))
  have hnorm : ‖((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k‖ = |(v : ℤ → ℝ) k| * ‖(f : ℤ → ℂ) k‖ := by
    simp [Complex.norm_real]
  rw [hnorm, mul_pow]
  have h1 : |(v : ℤ → ℝ) k| ^ 2 ≤ ‖v‖ ^ 2 := by
    nlinarith [abs_nonneg ((v : ℤ → ℝ) k), velocity_bound v k]
  nlinarith [sq_nonneg ‖(f : ℤ → ℂ) k‖]

/-- Multiplication by a bounded real velocity field, as a linear map. -/
noncomputable def velocityLin (v : LinfZ) : L2Z →ₗ[ℂ] L2Z where
  toFun f := ⟨fun k => ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k, memℓp_mul v f⟩
  map_add' f g := by
    ext k
    show ((v : ℤ → ℝ) k : ℂ) * ((f + g : L2Z) : ℤ → ℂ) k
        = ((v : ℤ → ℝ) k : ℂ) *lp2  LZ oe, velocityOp_apply, RCLike.inner_apply, map_mul,
    ²nttyUnitary.continuityHamiltonian_hermitian`. -/
theorem continuityHamiltonian_isSelfAdjoint (v : LinfZ) :
    IsSelfAdjoint (continuityHamiltonian v) :=
  ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.2 (continuityHamiltonian_isSymmetric v)

/-! ## The one-parameter unitary group -/

/-- `exp (i t A)` is unitary for a bounded self-adjoint `A` on a Hilbert space —
the operator-algebra counterpart of `ChapterContinuityUnitary.exp_smul_I_unitary`. -/
theorem exp_smul_I_unitary {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
    [CompleteSpace E] (A : E →L[ℂ] E) (hA : IsSelfAdjoint A) (t : ℝ) :
    star (NormedSpace.exp (((t : ℂ) * Complex.I) • A)) *
        NormedSpace.exp (((t : ℂ) * Complex.I) • A) = 1 ∧
      NormedSpace.exp (((t : ℂ) * Complex.I) • A) *
        star (NormedSpace.exp (((t : ℂ) * Complex.I) • A)) = 1 := by
  let +nondep : NormedAlgebra ℚ (E →L[ℂ] E) := .restrictScalars ℚ ℂ _
  set B : E →L[ℂ] E := ((t : ℂ) * Complex.I) • A with hB
  have hstar : star B = -B := by
    rw [hB, star_smul, hA.star_eq]
    simp [RCLike.star_def, ← neg_smul]
  have hexp : star (NormedSpace.exp B) = NormedSpace.exp (-B) := by
    rw [NormedSpace.star_exp, hstar]
  refine ⟨?_, ?_⟩
  · rw [hexp, ← No`U t = exp (i t H)`
for the continuity generator `H` of the bounded velocity field `v`. -/
noncomputable def continuityUnitary (v : LinfZ) (t : ℝ) : L2Z →L[ℂ] L2Z :=
  NormedSpace.exp (((t : ℂ) * Complex.I) • continuityHamiltonian v)

/-- **`U t` is unitary.** -/
theorem continuityUnitary_unitary (v : LinfZ) (t : ℝ) :
    star (continuityUnitary v t) * continuityUnitary v t =  ((s : ℂ) * Complex.I) • continuityHamiltonian v
        + ((t : ℂ) * Complex.I) • continuityHamiltonian v := by
    rw [← add_smul]
    push_cast
    ring_nf
  rw [continuityUnitary, hsum, NormedSpace.exp_add_of_commute hcomm]
  rfl

/-- A unitary preserves the norm — hence the total `ℓ²` mass. -/
theorem norm_of_unitary {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
    [CompleteSpace E] (U : E →L[ℂ] E) (hU : star U * U = 1) (x : E) : ‖U x‖ = ‖x‖ := by
  have hinner : ⟪U x, U x⟫_ℂ = ⟪x, x⟫_ℂ := by
    rw [← ContinuousLinearMap.adjoint_inner_left]
    rw [← ContinuousLinearMap.star_eq_adjoint]
    rw [show (star U) (U x) = ((star U) * U) x from rfl, hU]
    rfl
  have h := congrArg Complex.re# t ) nfnRveity

/-- The evolved state has the same `ℓ²` mass as the initial state. -/
theorem norm_evolvedState (v : LinfZ) (t : ℝ) (psi : L2Z) :
    ‖evolvedState v t psi‖ = ‖psi‖ :=
  norm_of_unitary _ (continuityUnitary_unitary v t).1 psi

/-- **Born recovery: the total mass is `1`.**  On the infinite lattice this is a
countable sum, and unitarity of `U t` makes it exactly `1` for a normalized
initial state. -/
theorem bornRecover_tsum_univ (v : LinfZ) (t : ℝ) (psi : L2Z) (hpsi : ‖psi‖ = 1) :
    ∑' z : ℤ, ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2 = 1 := by
  rw [← norm_sq_eq_tsum, norm_evolvedState, hpsi, one_pow]

theorem summable_bornWeight (v : LinfZ) (t : ℝ) (psi : L2Z) :
    Summable fun z : ℤ => ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2 :=
  summable_normSq _

/-- The Born weights of the evolved state, as a probability distribution on the
infinite lattice `ℤ`. -/
noncomputable def bornPMF (v : LinfZ) (t : ℝ) (psi : L2Z) (hpsi : ‖psi‖ = 1) : PMF ℤ :=
  ⟨fun z => ENNReal.ofReal (‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2), by
    have hns : ∀ z : ℤ, 0 ≤ ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2 := fun _ => by positivity
    have htsum : ∑' z : ℤ, ENNReal.ofReal (‖((evolvedStat ENNReal.summable.hasSum⟩

@[simp] theorem bor