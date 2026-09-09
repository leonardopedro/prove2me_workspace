import Mathlib
import BookProof.ChapterScalaronWallEsa

/-!
# The deficiency space of `−d²/dx² + V` *is* its space of `L²` classical solutions

`BookProof/ChapterScalaronWallEsa.lean` proves one direction of the classical Weyl
alternative for the one-dimensional Schrödinger operator on the compactly supported smooth
core: every deficiency vector is (a.e.) a classical solution of `W'' = (V − z)W`
(`wallHam_weak_eq` plus the regularity theorem `exists_deriv2_of_weak_eq`), and for `V ≥ 0`
and purely imaginary `z` such a solution must vanish (`ode_solution_eq_zero`), whence
essential self-adjointness.

This module proves the **converse**, which is what `CONSOLIDATED_PLAN.md`'s QG-2 "Case B"
needs: an `L²` classical solution of `W'' = (V − z)W` *is* a deficiency vector.  Together the
two directions turn the deficiency problem into a pure ODE question:

`DeficiencyTrivialAt (ccDomain ℝ) (wallHam V hV) z ↔ the ODE W'' = (V − z)W has no nonzero
L² solution`.

So the failure of essential self-adjointness in the conformal (Case B) direction is not an
assumption to be argued informally: it is *equivalent* to exhibiting one square-integrable
classical solution, and this module supplies the bridge in both directions.

## What is proved

* `integral_conj_deriv2_mul` — integration by parts twice against a compactly supported
  `C²` weight: `∫ conj(φ'')·W = ∫ conj(φ)·W''`, no boundary terms;
* `IsL2Ode` — the predicate "`W` is a square-integrable classical solution of
  `W'' = (V − z)W`";
* `inner_eq_of_ode` — such a `W` satisfies the deficiency identity
  `⟪H v, W⟫ = z⟪v, W⟫` for every `v` in the core;
* `not_deficiencyTrivialAt_of_l2_solution` — a *nonzero* such `W` obstructs triviality of the
  deficiency space at `z`;
* `deficiencyTrivialAt_iff_no_l2_solution` — the two-way characterisation;
* `isL2Ode_conj` — for real `V`, conjugation maps solutions at `z` to solutions at `conj z`;
* `not_essentiallySelfAdjointOn_of_l2_solution` — one nonzero `L²` solution at `i` (or at
  `−i`) already refutes essential self-adjointness;
* `no_l2_solution_of_nonneg` — the consistency check: for `V ≥ 0` and purely imaginary `z`
  there is no nonzero solution, so the characterisation reproduces
  `wallHam_deficiencyTrivialAt`.
-/

namespace BookProof.WallDeficiencyObstruction

open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WeakSecondDeriv

noncomputable section

/-! ## 1. Integration by parts, twice, against a compactly supported weight -/

/-- **Double integration by parts with no boundary terms.**  If `P` is twice differentiable
with compact support and `W` is twice differentiable with continuous second derivative `G`,
then `∫ conj(P'')·W = ∫ conj(P)·G`.  The proof differentiates the Wronskian-type combination
`conj(P)·W' − conj(P')·W`, which has compact support, and integrates it to zero. -/
theorem integral_conj_deriv2_mul {P P' P'' : ℝ → ℂ} {W W' G : ℝ → ℂ}
    (hP : ∀ x, HasDerivAt P (P' x) x) (hP' : ∀ x, HasDerivAt P' (P'' x) x)
    (hP''c : Continuous P'') (hPsupp : HasCompactSupport P)
    (hW : ∀ x, HasDerivAt W (W' x) x) (hW' : ∀ x, HasDerivAt W' (G x) x)
    (hGc : Continuous G) :
    ∫ x, (starRingEnd ℂ) (P'' x) * W x = ∫ x, (starRingEnd ℂ) (P x) * G x := by
  have hPeq : P' = deriv P := funext fun x => (hP x).deriv.symm
  have hP'eq : P'' = deriv P' := funext fun x => (hP' x).deriv.symm
  have hP'supp : HasCompactSupport P' := by rw [hPeq]; exact hPsupp.deriv
  have hP''supp : HasCompactSupport P'' := by rw [hP'eq]; exact hP'supp.deriv
  have hPcont : Continuous P := continuous_iff_continuousAt.2 fun x => (hP x).continuousAt
  have hP'cont : Continuous P' := continuous_iff_continuousAt.2 fun x => (hP' x).continuousAt
  have hWcont : Continuous W := continuous_iff_continuousAt.2 fun x => (hW x).continuousAt
  have hW'cont : Continuous W' := continuous_iff_continuousAt.2 fun x => (hW' x).continuousAt
  set f : ℝ → ℂ := fun x => (starRingEnd ℂ) (P x) * W' x - (starRingEnd ℂ) (P' x) * W x with hf
  have hfd : ∀ x, HasDerivAt f
      ((starRingEnd ℂ) (P x) * G x - (starRingEnd ℂ) (P'' x) * W x) x := by
    intro x
    have h1 : HasDerivAt (fun y => (starRingEnd ℂ) (P y) * W' y)
        ((starRingEnd ℂ) (P' x) * W' x + (starRingEnd ℂ) (P x) * G x) x := by
      simpa [mul_comm] using ((hP x).star.mul (hW' x))
    have h2 : HasDerivAt (fun y => (starRingEnd ℂ) (P' y) * W y)
        ((starRingEnd ℂ) (P'' x) * W x + (starRingEnd ℂ) (P' x) * W' x) x := by
      simpa [mul_comm] using ((hP' x).star.mul (hW x))
    have h3 := h1.sub h2
    convert h3 using 1
    ring
  have hAsupp : HasCompactSupport (fun x => (starRingEnd ℂ) (P x) * G x) :=
    (hPsupp.comp_left (g := fun z : ℂ => (starRingEnd ℂ) z) (by simp)).mul_right
  have hBsupp : HasCompactSupport (fun x => (starRingEnd ℂ) (P'' x) * W x) :=
    (hP''supp.comp_left (g := fun z : ℂ => (starRingEnd ℂ) z) (by simp)).mul_right
  have hAint : Integrable (fun x => (starRingEnd ℂ) (P x) * G x) volume :=
    ((Complex.continuous_conj.comp hPcont).mul hGc).integrable_of_hasCompactSupport hAsupp
  have hBint : Integrable (fun x => (starRingEnd ℂ) (P'' x) * W x) volume :=
    ((Complex.continuous_conj.comp hP''c).mul hWcont).integrable_of_hasCompactSupport hBsupp
  have hfsupp : HasCompactSupport f :=
    HasCompactSupport.sub
      ((hPsupp.comp_left (g := fun z : ℂ => (starRingEnd ℂ) z) (by simp)).mul_right)
      ((hP'supp.comp_left (g := fun z : ℂ => (starRingEnd ℂ) z) (by simp)).mul_right)
  have hfcont : Continuous f :=
    ((Complex.continuous_conj.comp hPcont).mul hW'cont).sub
      ((Complex.continuous_conj.comp hP'cont).mul hWcont)
  have hzero := MeasureTheory.integral_eq_zero_of_hasDerivAt_of_integrable hfd
    (hAint.sub hBint) (hfcont.integrable_of_hasCompactSupport hfsupp)
  rw [integral_sub hAint hBint] at hzero
  exact (sub_eq_zero.mp hzero).symm

/-! ## 2. Square-integrable classical solutions -/

/-- **`W` is a square-integrable classical solution of `W'' = (V − z)W`.**  This is exactly
the object the regularity theorem produces from a deficiency vector, and — by
`inner_eq_of_ode` below — exactly what produces one. -/
def IsL2Ode (V : ℝ → ℝ) (z : ℂ) (W : ℝ → ℂ) : Prop :=
  ∃ W' : ℝ → ℂ, (∀ x, HasDerivAt W (W' x) x) ∧
    (∀ x, HasDerivAt W' ((((V x : ℝ) : ℂ) - z) * W x) x) ∧ MemLp W 2 (volume : Measure ℝ)

lemma IsL2Ode.continuous {V : ℝ → ℝ} {z : ℂ} {W : ℝ → ℂ} (h : IsL2Ode V z W) :
    Continuous W := by
  obtain ⟨W', hW, -, -⟩ := h
  exact continuous_iff_continuousAt.2 fun x => (hW x).continuousAt

lemma IsL2Ode.memLp {V : ℝ → ℝ} {z : ℂ} {W : ℝ → ℂ} (h : IsL2Ode V z W) :
    MemLp W 2 (volume : Measure ℝ) := by
  obtain ⟨-, -, -, hm⟩ := h
  exact hm

/-! ## 3. A solution is a deficiency vector -/

/-- **An `L²` classical solution satisfies the deficiency identity.**  For every `v` in the
compactly supported smooth core, `⟪(−d²/dx² + V)v, W⟫ = z⟪v, W⟫`.  This is the converse of
`wallHam_weak_eq`: it turns the ODE solution back into a deficiency vector. -/
theorem inner_eq_of_ode (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (z : ℂ)
    {W W' : ℝ → ℂ} (hW : ∀ x, HasDerivAt W (W' x) x)
    (hW' : ∀ x, HasDerivAt W' ((((V x : ℝ) : ℂ) - z) * W x) x)
    (hmem : MemLp W 2 (volume : Measure ℝ)) (v : ccDomain ℝ) :
    (inner ℂ (wallHam V hV v) (hmem.toLp W) : ℂ)
      = z * inner ℂ (v : Lp ℂ 2 (volume : Measure ℝ)) (hmem.toLp W) := by
  classical
  set u : Lp ℂ 2 (volume : Measure ℝ) := hmem.toLp W with hu
  have hae : ∀ᵐ x : ℝ, u x = W x := hmem.coeFn_toLp
  -- write `v` through the core equivalence
  obtain ⟨ψ, rfl⟩ : ∃ ψ : ccSchwartz ℝ, ccEquiv ℝ ψ = v := ⟨(ccEquiv ℝ).symm v, by simp⟩
  set P : ℝ → ℂ := fun x => ((ψ : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x with hPdef
  have hsmooth : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) P := (ψ : 𝓢(ℝ, ℂ)).smooth _
  have hPd : ∀ x, HasDerivAt P (deriv P x) x := fun x =>
    (hsmooth.differentiable (by simp) x).hasDerivAt
  have hsmooth' : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (deriv P) := hsmooth.deriv'
  have hP'd : ∀ x, HasDerivAt (deriv P) (deriv (deriv P) x) x := fun x =>
    (hsmooth'.differentiable (by simp) x).hasDerivAt
  have hsmooth'' : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (deriv (deriv P)) := hsmooth'.deriv'
  have hP''c : Continuous (deriv (deriv P)) := hsmooth''.continuous
  have hPsupp : HasCompactSupport P := ψ.2
  have hPcont : Continuous P := hsmooth.continuous
  have hWcont : Continuous W := continuous_iff_continuousAt.2 fun x => (hW x).continuousAt
  have hGc : Continuous fun x => (((V x : ℝ) : ℂ) - z) * W x :=
    (((Complex.continuous_ofReal.comp hV.continuous).sub continuous_const).mul hWcont)
  -- the three pieces of the pairing
  have hincl : Submodule.inclusion (ccDomain_le_schwartzDomain (E := ℝ)) (ccEquiv ℝ ψ)
      = schwartzEquiv ℝ (ψ : 𝓢(ℝ, ℂ)) := Subtype.ext rfl
  have hkin : kinCcR (ccEquiv ℝ ψ) = (kinOpR (ψ : 𝓢(ℝ, ℂ))).toLp 2 (volume : Measure ℝ) := by
    simp only [kinCcR, LinearMap.coe_comp, Function.comp_apply, hincl, opL2_apply]
  have hkinint : (inner ℂ (kinCcR (ccEquiv ℝ ψ)) u : ℂ)
      = -∫ x, (starRingEnd ℂ) (deriv (deriv P) x) * W x := by
    rw [hkin, inner_toLp_left, ← integral_neg]
    refine integral_congr_ae ?_
    filter_upwards [hae] with x hx
    change (starRingEnd ℂ) ((kinOpR (ψ : 𝓢(ℝ, ℂ))) x) * u x
      = -((starRingEnd ℂ) (deriv (deriv P) x) * W x)
    rw [kinOpR_apply, hx]
    simp [hPdef]
  have hpot : (inner ℂ (opCc V hV (ccEquiv ℝ ψ)) u : ℂ)
      = ∫ x, ((V x : ℝ) : ℂ) * ((starRingEnd ℂ) (P x) * W x) := by
    rw [opCc_apply, inner_toLp_left]
    refine integral_congr_ae ?_
    filter_upwards [hae] with x hx
    simp only [mulCc_apply, map_mul, Complex.conj_ofReal, hx, hPdef]
    ring
  have hplain : (inner ℂ ((ccEquiv ℝ ψ : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ)) u : ℂ)
      = ∫ x, (starRingEnd ℂ) (P x) * W x := by
    rw [ccEquiv_coe, inner_toLp_left]
    refine integral_congr_ae ?_
    filter_upwards [hae] with x hx
    rw [hx]
  -- integration by parts
  have hIBP : ∫ x, (starRingEnd ℂ) (deriv (deriv P) x) * W x
      = ∫ x, (starRingEnd ℂ) (P x) * ((((V x : ℝ) : ℂ) - z) * W x) :=
    integral_conj_deriv2_mul hPd hP'd hP''c hPsupp hW hW' hGc
  -- split the right-hand side
  have hint1 : Integrable (fun x => (starRingEnd ℂ) (P x) * W x) volume :=
    ((Complex.continuous_conj.comp hPcont).mul hWcont).integrable_of_hasCompactSupport
      ((hPsupp.comp_left (g := fun w : ℂ => (starRingEnd ℂ) w) (by simp)).mul_right)
  have hint2 : Integrable (fun x => ((V x : ℝ) : ℂ) * ((starRingEnd ℂ) (P x) * W x)) volume :=
    (((Complex.continuous_ofReal.comp hV.continuous)).mul
      ((Complex.continuous_conj.comp hPcont).mul hWcont)).integrable_of_hasCompactSupport
        (HasCompactSupport.mul_left
          ((hPsupp.comp_left (g := fun w : ℂ => (starRingEnd ℂ) w) (by simp)).mul_right))
  have hsplit : ∫ x, (starRingEnd ℂ) (P x) * ((((V x : ℝ) : ℂ) - z) * W x)
      = (∫ x, ((V x : ℝ) : ℂ) * ((starRingEnd ℂ) (P x) * W x))
        - z * ∫ x, (starRingEnd ℂ) (P x) * W x := by
    rw [← MeasureTheory.integral_const_mul, ← integral_sub hint2 (hint1.const_mul z)]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    ring
  simp only [wallHam, LinearMap.add_apply, inner_add_left, hkinint, hpot, hplain]
  rw [hIBP, hsplit]
  ring

/-! ## 4. The characterisation -/

/-- **A nonzero `L²` solution obstructs triviality of the deficiency space.** -/
theorem not_deficiencyTrivialAt_of_l2_solution (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (z : ℂ) {W : ℝ → ℂ}
    (hsol : IsL2Ode V z W) (hne : ∃ x, W x ≠ 0) :
    ¬ DeficiencyTrivialAt (ccDomain ℝ) (wallHam V hV) z := by
  obtain ⟨W', hW, hW'', hmem⟩ := hsol
  intro hdef
  have hzero : hmem.toLp W = 0 := hdef _ (inner_eq_of_ode V hV z hW hW'' hmem)
  have hae : W =ᵐ[volume] 0 := by
    have h1 : (hmem.toLp W : ℝ → ℂ) =ᵐ[volume] W := hmem.coeFn_toLp
    have h2 : (hmem.toLp W : ℝ → ℂ) =ᵐ[volume] 0 := by
      rw [hzero]; exact Lp.coeFn_zero ℂ 2 (volume : Measure ℝ)
    exact h1.symm.trans h2
  have hWcont : Continuous W := continuous_iff_continuousAt.2 fun x => (hW x).continuousAt
  have : W = 0 := (hWcont.ae_eq_iff_eq volume continuous_const).mp hae
  obtain ⟨x, hx⟩ := hne
  exact hx (by rw [this]; rfl)

/-- **The Weyl characterisation of the deficiency space.**  The deficiency space of
`−d²/dx² + V` on the compactly supported smooth core at `z` is trivial *if and only if* the
ODE `W'' = (V − z)W` has no nonzero square-integrable classical solution.  No hypothesis on
`V` beyond smoothness, and none on `z`. -/
theorem deficiencyTrivialAt_iff_no_l2_solution (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (z : ℂ) :
    DeficiencyTrivialAt (ccDomain ℝ) (wallHam V hV) z
      ↔ ∀ W : ℝ → ℂ, IsL2Ode V z W → ∀ x, W x = 0 := by
  constructor
  · intro hdef W hsol x
    by_contra hx
    exact not_deficiencyTrivialAt_of_l2_solution V hV z hsol ⟨x, hx⟩ hdef
  · intro hno u hu
    have hloc : LocallyIntegrable (fun x => (u x : ℂ)) (volume : Measure ℝ) :=
      (Lp.memLp u).locallyIntegrable (by norm_num)
    have hc : Continuous fun x : ℝ => ((V x : ℝ) : ℂ) - z :=
      (Complex.continuous_ofReal.comp hV.continuous).sub continuous_const
    obtain ⟨W, W', hW, hW', hWae⟩ :=
      exists_deriv2_of_weak_eq hloc hc (fun g hg => wallHam_weak_eq V hV z u hu hg)
    have hmem : MemLp W 2 (volume : Measure ℝ) := (Lp.memLp u).ae_eq hWae
    have hzero := hno W ⟨W', hW, hW', hmem⟩
    refine Lp.eq_zero_iff_ae_eq_zero.mpr ?_
    filter_upwards [hWae] with x hx
    simp [hx, hzero x]

/-! ## 5. Consequences -/

/-- For a **real** potential, conjugation exchanges the two deficiency indices: a solution at
`z` gives a solution at `conj z`. -/
theorem isL2Ode_conj {V : ℝ → ℝ} {z : ℂ} {W : ℝ → ℂ} (h : IsL2Ode V z W) :
    IsL2Ode V ((starRingEnd ℂ) z) (fun x => (starRingEnd ℂ) (W x)) := by
  obtain ⟨W', hW, hW', hmem⟩ := h
  refine ⟨fun x => (starRingEnd ℂ) (W' x), fun x => (hW x).star, fun x => ?_, ?_⟩
  · have h2 := (hW' x).star
    have hval : (starRingEnd ℂ) ((((V x : ℝ) : ℂ) - z) * W x)
        = (((V x : ℝ) : ℂ) - (starRingEnd ℂ) z) * (starRingEnd ℂ) (W x) := by
      simp [map_mul, map_sub, Complex.conj_ofReal]
    rw [← hval]
    exact h2
  · exact hmem.congr_norm
      (Complex.continuous_conj.comp_aestronglyMeasurable hmem.aestronglyMeasurable)
      (Filter.Eventually.of_forall fun x => (Complex.norm_conj (W x)).symm)

/-- **For a real potential the two deficiency spaces stand or fall together.**  Conjugation is
an antiunitary bijection between the `L²` solution spaces at `z` and at `conj z`, so triviality
at one is triviality at the other. -/
theorem deficiencyTrivialAt_conj_iff (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (z : ℂ) :
    DeficiencyTrivialAt (ccDomain ℝ) (wallHam V hV) z
      ↔ DeficiencyTrivialAt (ccDomain ℝ) (wallHam V hV) ((starRingEnd ℂ) z) := by
  have key : ∀ w : ℂ, DeficiencyTrivialAt (ccDomain ℝ) (wallHam V hV) w →
      DeficiencyTrivialAt (ccDomain ℝ) (wallHam V hV) ((starRingEnd ℂ) w) := by
    intro w hw
    rw [deficiencyTrivialAt_iff_no_l2_solution] at hw ⊢
    intro W hsol x
    have hconj := isL2Ode_conj hsol
    rw [Complex.conj_conj] at hconj
    have := hw _ hconj x
    simpa using congrArg (starRingEnd ℂ) this
  refine ⟨key z, fun h => ?_⟩
  simpa using key _ h

/-- **One nonzero `L²` solution at `i` refutes essential self-adjointness.** -/
theorem not_essentiallySelfAdjointOn_of_l2_solution (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) {W : ℝ → ℂ}
    (hsol : IsL2Ode V Complex.I W) (hne : ∃ x, W x ≠ 0) :
    ¬ EssentiallySelfAdjointOn (ccDomain ℝ) (wallHam V hV) := by
  intro h
  exact not_deficiencyTrivialAt_of_l2_solution V hV Complex.I hsol hne h.1

/-- **Consistency with the positive-potential theorem.**  For `V ≥ 0` and purely imaginary
`z`, the ODE has no nonzero `L²` solution — this is `ode_solution_eq_zero` restated through
the characterisation. -/
theorem no_l2_solution_of_nonneg {V : ℝ → ℝ} (hVnn : ∀ x, 0 ≤ V x) {z : ℂ} (hz : z.re = 0)
    {W : ℝ → ℂ} (hsol : IsL2Ode V z W) : ∀ x, W x = 0 := by
  obtain ⟨W', hW, hW', hmem⟩ := hsol
  have hint : Integrable (fun x => ‖W x‖ ^ 2) (volume : Measure ℝ) := by
    have hW2 : MemLp W 2 (volume : Measure ℝ) := hmem
    exact (memLp_two_iff_integrable_sq_norm hW2.aestronglyMeasurable).1 hW2
  exact ode_solution_eq_zero hVnn hz hW hW' hint

/-! ## 6. The criterion is not vacuous: a worked instance

The harmonic potential `V(x) = x² − 1` has the Gaussian `e^{−x²/2}` as a square-integrable
classical solution of `W'' = (V − 0)W`, so the deficiency space of `−d²/dx² + V` at `z = 0`
is *not* trivial.  (`z = 0` is real, so this does not contradict essential self-adjointness:
it records that `0` is an eigenvalue — the shifted harmonic ground state.)  It does show that
`not_deficiencyTrivialAt_of_l2_solution` has content and that its hypotheses are
satisfiable. -/

/-- The harmonic potential shifted so that the ground-state energy is `0`. -/
def harmonicShiftedV : ℝ → ℝ := fun x => x ^ 2 - 1

lemma contDiff_harmonicShiftedV :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) harmonicShiftedV := by
  have h : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) fun x : ℝ => x ^ 2 - 1 :=
    (contDiff_id.pow 2).sub contDiff_const
  exact h

/-- The Gaussian ground state `e^{−x²/2}`, complexified. -/
def gaussianState : ℝ → ℂ := fun x => ((Real.exp (-(x ^ 2 / 2)) : ℝ) : ℂ)

/-- **The Gaussian is a square-integrable classical solution at `z = 0`** for the shifted
harmonic potential. -/
theorem gaussianState_isL2Ode : IsL2Ode harmonicShiftedV 0 gaussianState := by
  have hexp : ∀ x : ℝ, HasDerivAt (fun y : ℝ => Real.exp (-(y ^ 2 / 2)))
      (-x * Real.exp (-(x ^ 2 / 2))) x := by
    intro x
    have h1 : HasDerivAt (fun y : ℝ => -(y ^ 2 / 2)) (-x) x := by
      simpa using ((hasDerivAt_pow 2 x).div_const 2).neg
    simpa [mul_comm] using h1.exp
  refine ⟨fun x => ((-x * Real.exp (-(x ^ 2 / 2)) : ℝ) : ℂ), fun x => ?_, fun x => ?_, ?_⟩
  · exact (hexp x).ofReal_comp
  · have h3 : HasDerivAt (fun y : ℝ => (-y) * Real.exp (-(y ^ 2 / 2)))
        ((-1) * Real.exp (-(x ^ 2 / 2)) + (-x) * (-x * Real.exp (-(x ^ 2 / 2)))) x :=
      ((hasDerivAt_id x).neg).mul (hexp x)
    have hval : (-1 : ℝ) * Real.exp (-(x ^ 2 / 2)) + (-x) * (-x * Real.exp (-(x ^ 2 / 2)))
        = (x ^ 2 - 1) * Real.exp (-(x ^ 2 / 2)) := by ring
    rw [hval] at h3
    have h4 := h3.ofReal_comp
    have hcast : ((((x ^ 2 - 1) * Real.exp (-(x ^ 2 / 2)) : ℝ)) : ℂ)
        = (((harmonicShiftedV x : ℝ) : ℂ) - 0) * gaussianState x := by
      simp [harmonicShiftedV, gaussianState]
    rw [hcast] at h4
    exact h4
  · have hcont : Continuous gaussianState :=
      Complex.continuous_ofReal.comp (by fun_prop)
    refine (memLp_two_iff_integrable_sq_norm hcont.aestronglyMeasurable).2 ?_
    have h := integrable_exp_neg_mul_sq (b := (1 : ℝ)) one_pos
    refine h.congr ?_
    filter_upwards with x
    rw [gaussianState, Complex.norm_real, Real.norm_eq_abs, abs_of_pos (Real.exp_pos _),
      ← Real.exp_nat_mul]
    ring_nf

/-- **The deficiency space of `−d²/dx² + (x² − 1)` at `z = 0` is nontrivial**: the Gaussian
ground state is a square-integrable classical solution. -/
theorem not_deficiencyTrivialAt_harmonicShifted_zero :
    ¬ DeficiencyTrivialAt (ccDomain ℝ) (wallHam harmonicShiftedV contDiff_harmonicShiftedV) 0 :=
  not_deficiencyTrivialAt_of_l2_solution _ _ 0 gaussianState_isL2Ode
    ⟨0, by simp [gaussianState]⟩

end

/-! ## Audit -/

section Audit

#print axioms integral_conj_deriv2_mul
#print axioms inner_eq_of_ode
#print axioms not_deficiencyTrivialAt_of_l2_solution
#print axioms deficiencyTrivialAt_iff_no_l2_solution
#print axioms isL2Ode_conj
#print axioms deficiencyTrivialAt_conj_iff
#print axioms not_essentiallySelfAdjointOn_of_l2_solution
#print axioms no_l2_solution_of_nonneg
#print axioms gaussianState_isL2Ode
#print axioms not_deficiencyTrivialAt_harmonicShifted_zero

end Audit

end BookProof.WallDeficiencyObstruction
