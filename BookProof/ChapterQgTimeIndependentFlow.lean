import Mathlib
import BookProof.ChapterSirkTrotterKato
import BookProof.ChapterSirkSingleTimeShift
import BookProof.ChapterQgBrstDerivativeGauge

/-!
# The gauge-fixed quantum-gravity Hamiltonian is time-independent, and one finite time suffices

The 3D BRST gauge fixing on the vielbein variables
(`BookProof.ChapterQgBrstDerivativeGauge`) fixes the auxiliary variables to the *spatial*
derivatives of the vielbein.  No time derivative and no time parameter enters, so the
gauge-fixed quantum Hamiltonian is a single, fixed self-adjoint operator `H` — an
**autonomous** generator.  Combined with
`BookProof.ChapterSirkSingleTimeShift` (the SIRK/Hashimoto algorithm evaluates the
propagator at *one* finite time through the bounded shift-invert resolvent), this removes
any need for a discretization of time: there is no step size, no number of steps, no
time-ordering and no Dyson series.

This module supplies the statements that make "time-independent" a theorem rather than a
remark.

## What is proved

* `prop T t s = e^{−i(t−s)H}` — the **two-parameter propagator** of the autonomous
  generator, with
  * `prop_self` (`U(t,t) = 1`), `norm_prop_apply` (unitarity),
  * `prop_apply_prop` — the Chapman–Kolmogorov law `U(t,s)U(s,r) = U(t,r)`,
  * **`prop_time_translation`** — `U(t+h, s+h) = U(t,s)`: the propagator depends on the two
    times only through their difference.  This is the operational meaning of "the
    Hamiltonian carries no time dependence".
* `IsSchrodingerSolution T y` — a curve staying in the domain and solving
  `y'(r) = −i H y(r)` with the **same** generator at every time.
* `isSchrodingerSolution_prop` — the propagator produces such a solution, and
  **`eq_prop_of_isSchrodingerSolution`** — *every* such solution equals it:
  `y t = e^{−i(t−s)H} y s`.  Hence the Cauchy problem is uniquely solved by the
  one-parameter group; no time ordering is needed, and evaluating the group at a single
  finite time `t` is the entire content of the evolution problem.
* **`qgOuterFock_timeIndependent_singleTime`** — the quantum-gravity package: for the
  outer-Fock Hamiltonian with an arbitrary wall and arbitrary admissible mode data, there
  is a self-adjoint realization `H` whose propagator is time-translation invariant,
  satisfies Chapman–Kolmogorov and uniquely solves the Schrödinger equation, *and* whose
  mode truncations converge to it — in the Hashimoto shift-invert sense at every nonzero
  shift, and in the propagator sense at every single finite time.
* **`starobinsky_brstGaugeFixed_timeIndependent_singleTime`** — the physical instance: the
  3D BRST gauge-fixed continuum Hamiltonian (exact Fourier modes, exact torsion Gram
  matrix, scalaron–vielbein coupling at arbitrary `g`, full exponential Einstein-frame
  Starobinsky wall).  The first conjunct of the statement is the gauge-fixing identity
  itself (`BookProof.QgBrstDerivativeGauge.gaugeReduce_gram`): substituting the gauge
  condition `D_{μν}^i(k) = k_μ e_ν^i(k)` into the extended, derivative-free torsion returns
  the vielbein self-interaction that the Hamiltonian carries.
* **`starobinsky_qgManifold_timeIndependent_singleTime`** — the same over a general spatial
  manifold, with the spectral cutoff in place of the momentum cutoff.

Everything is `sorry`-free and `axiom`-free.  Together with
`BookProof.ChapterSirkSingleTimeShift` this supersedes the "choose a number of time steps
per cutoff" formulation of `BookProof.ChapterQgTimeStepping`: time stepping is one optional
scheme, not a requirement of the pipeline.
-/

namespace BookProof.QgTimeIndependent

open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

/-! ## 1. The propagator of a time-independent generator -/

/-- The **two-parameter propagator** of the autonomous generator `T`:
`U(t,s) = e^{−i(t−s)H}`.  It is defined from the one-parameter group, i.e. from a
Hamiltonian carrying no time argument. -/
def prop (T : UnboundedSelfAdjoint E) (t s : ℝ) : E →L[ℂ] E := T.stoneU (t - s)

@[simp] theorem prop_apply (T : UnboundedSelfAdjoint E) (t s : ℝ) (x : E) :
    prop T t s x = T.stoneU (t - s) x := rfl

@[simp] theorem prop_zero_right (T : UnboundedSelfAdjoint E) (t : ℝ) :
    prop T t 0 = T.stoneU t := by simp [prop]

@[simp] theorem prop_self (T : UnboundedSelfAdjoint E) (t : ℝ) : prop T t t = 1 := by
  simp [prop]

/-- Unitarity: the propagator preserves the norm of every state. -/
theorem norm_prop_apply (T : UnboundedSelfAdjoint E) (t s : ℝ) (x : E) :
    ‖prop T t s x‖ = ‖x‖ := T.norm_stoneU_apply _ _

/-- **Chapman–Kolmogorov**: `U(t,s) U(s,r) = U(t,r)`. -/
theorem prop_apply_prop (T : UnboundedSelfAdjoint E) (t s r : ℝ) (x : E) :
    prop T t s (prop T s r x) = prop T t r x := by
  have h : (t - s) + (s - r) = t - r := by ring
  simp only [prop_apply]
  rw [T.stoneU_apply_stoneU, h]

/-- **Time-translation invariance** of the propagator, `U(t+h, s+h) = U(t,s)`: the two times
enter only through their difference.  This is exactly what it means for the generator to
carry no time dependence. -/
theorem prop_time_translation (T : UnboundedSelfAdjoint E) (t s h : ℝ) :
    prop T (t + h) (s + h) = prop T t s := by
  have : t + h - (s + h) = t - s := by ring
  rw [prop, prop, this]

/-- The propagator solves the Schrödinger equation with the fixed generator `H`. -/
theorem hasDerivAt_prop (T : UnboundedSelfAdjoint E) (x : T.domain) (t s : ℝ) :
    HasDerivAt (fun r : ℝ => prop T r s (x : E))
      ((-Complex.I) • T.op ⟨T.stoneU (t - s) (x : E), T.stoneU_mem_domain (t - s) x⟩) t := by
  have h := T.hasDerivAt_stoneU_op x (t - s)
  exact h.comp_sub_const t s

/-- A curve solving the Schrödinger equation of the **time-independent** generator `T`:
it stays in the domain and satisfies `y'(r) = −i H y(r)` with the same `H` at every time.
No time ordering occurs. -/
structure IsSchrodingerSolution (T : UnboundedSelfAdjoint E) (y : ℝ → E) : Prop where
  mem : ∀ r, y r ∈ T.domain
  deriv : ∀ r, HasDerivAt y ((-Complex.I) • T.op ⟨y r, mem r⟩) r

/-- **Existence**: the propagator applied to a state in the domain is a solution. -/
theorem isSchrodingerSolution_prop (T : UnboundedSelfAdjoint E) (s : ℝ) (x : T.domain) :
    IsSchrodingerSolution T (fun r : ℝ => prop T r s (x : E)) := by
  refine ⟨fun r => T.stoneU_mem_domain (r - s) x, fun r => ?_⟩
  have h := hasDerivAt_prop T x r s
  exact h

/-- **Uniqueness**: every solution of the Schrödinger equation of the time-independent
generator is given by the one-parameter group, `y t = e^{−i(t−s)H} y s`.  Consequently the
whole evolution problem is the evaluation of a *single* unitary group at a *single* finite
time — no time discretization, no Dyson series, no time ordering. -/
theorem eq_prop_of_isSchrodingerSolution (T : UnboundedSelfAdjoint E) {y : ℝ → E}
    (hy : IsSchrodingerSolution T y) (t s : ℝ) : y t = prop T t s (y s) := by
  set f : ℝ → E := fun r : ℝ => T.stoneU (t - r) (y r) with hf
  have hzero : ∀ u : ℝ, HasDerivAt f 0 u := by
    intro u
    have hd := hasDerivAt_stoneU_const_sub_apply T (hy.deriv u) (hy.mem u) (t := t)
    have hop : T.op ⟨T.stoneU (t - u) (y u),
        T.stoneU_mem_domain (t - u) ⟨y u, hy.mem u⟩⟩
        = T.stoneU (t - u) (T.op ⟨y u, hy.mem u⟩) := T.stoneU_op (t - u) ⟨y u, hy.mem u⟩
    have hsum : Complex.I • T.op ⟨T.stoneU (t - u) (y u),
          T.stoneU_mem_domain (t - u) ⟨y u, hy.mem u⟩⟩
        + T.stoneU (t - u) ((-Complex.I) • T.op ⟨y u, hy.mem u⟩) = 0 := by
      rw [hop, ContinuousLinearMap.map_smul]
      module
    rw [← hsum]
    exact hd
  have hdiff : Differentiable ℝ f := fun u => (hzero u).differentiableAt
  have hderiv : ∀ u, deriv f u = 0 := fun u => (hzero u).deriv
  have hconst : f t = f s := is_const_of_deriv_eq_zero hdiff hderiv t s
  have hft : f t = y t := by
    have h0 : f t = T.stoneU (t - t) (y t) := rfl
    rw [h0, sub_self, T.stoneU_zero]
    rfl
  rw [hft] at hconst
  exact hconst

/-! ## 2. The quantum-gravity Hamiltonian: autonomous, and evaluated at one finite time -/

open BookProof.SirkSingleTime BookProof.QgTruncationResolvent BookProof.FarisLavine
open BookProof.EsaClosure BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgOuterFockCoreFL BookProof.HashimotoShiftInvert

variable {ι : Type*}

/-- **The outer-Fock quantum-gravity evolution is autonomous, and one finite time suffices.**

For the Hamiltonian `H = secHam W Q` on the outer Fock space and its mode truncations:

* `H` has a self-adjoint realization `T`, and the truncations have self-adjoint
  realizations `S n`;
* the propagator `U(t,s)` of `T` is unitary, obeys Chapman–Kolmogorov, is **invariant under
  a common shift of both times** and **uniquely** solves the Schrödinger equation with the
  one fixed generator — the Hamiltonian has no time dependence, so no time ordering and no
  Dyson series occurs;
* at every nonzero shift `ℓ` the bounded Hashimoto shift-invert operators `−(·− iℓ)⁻¹` of
  the truncations converge strongly to that of `T`;
* hence at **every single finite time** `t` the truncated propagators converge to the exact
  one.  No step size, number of steps or time splitting appears anywhere. -/
theorem qgOuterFock_timeIndependent_singleTime (W : WallPot) (Q : QgModeData ι)
    (Λ : ℕ → Set ι) (hexh : ∀ F : Finset ι, ∀ᶠ n in atTop, ∀ a ∈ F, a ∈ Λ n) :
    ∃ (T : UnboundedSelfAdjoint (Sec ι)) (S : ℕ → UnboundedSelfAdjoint (Sec ι)),
      IsSelfAdjointExtension (secHam W Q) T.op ∧
        (∀ n, IsSelfAdjointExtension (secHam W (truncModes Q (Λ n))) (S n).op) ∧
        (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
        (∀ (t s : ℝ) (x : Sec ι), ‖prop T t s x‖ = ‖x‖) ∧
        (∀ (t s r : ℝ) (x : Sec ι), prop T t s (prop T s r x) = prop T t r x) ∧
        (∀ t s h : ℝ, prop T (t + h) (s + h) = prop T t s) ∧
        (∀ y : ℝ → Sec ι, IsSchrodingerSolution T y → ∀ t s : ℝ, y t = prop T t s (y s)) ∧
        (∀ l : ℝ, l ≠ 0 →
          IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
            (∀ n, IsShiftInvertC (S n).op (((l : ℝ) : ℂ) * Complex.I) (-((S n).resCLM l))) ∧
            ∀ u : Sec ι,
              Tendsto (fun n => -((S n).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
        ∀ (v : Sec ι) (t : ℝ), Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) := by
  obtain ⟨T, S, hT, hS, hres, hflow⟩ :=
    qgOuterFock_singleTime_shiftInvert_convergence W Q Λ hexh
  exact ⟨T, S, hT, hS, fun t s => rfl, fun t s x => norm_prop_apply T t s x,
    fun t s r x => prop_apply_prop T t s r x, fun t s h => prop_time_translation T t s h,
    fun _ hy t s => eq_prop_of_isSchrodingerSolution T hy t s, hres, hflow⟩

open BookProof.QgContinuumModeInstance BookProof.QgBrstDerivativeGauge

/-- **The 3D BRST gauge-fixed quantum-gravity Hamiltonian is time-independent, and the
SIRK/Hashimoto algorithm needs only one finite time.**

The Hamiltonian is the continuum one — exact Fourier modes of the vielbein, the exact
torsion Gram matrix as vielbein self-interaction, the scalaron–vielbein coupling at
arbitrary coupling constant `g` and the **full exponential** Einstein-frame Starobinsky wall
— which by `BookProof.QgBrstDerivativeGauge.gaugeReduce_gram` is exactly the Hamiltonian
obtained from the 3D BRST gauge fixing on the vielbein variables (the auxiliary variables
fixed to the *spatial* derivatives of the vielbein: no time derivative, hence no time
dependence).

The conclusion lists, in order: self-adjoint realizations of the exact Hamiltonian and of
its momentum-cutoff truncations; the propagator of the exact Hamiltonian is
`e^{−i(t−s)H}`, unitary, Chapman–Kolmogorov, invariant under a common time shift, and the
unique solution operator of the Schrödinger equation; the Hashimoto shift-invert operators
at every nonzero shift converge; and the cutoff propagators converge at every single finite
time. -/
theorem starobinsky_brstGaugeFixed_timeIndependent_singleTime (M alpha : ℝ)
    (halpha : 0 < alpha) (g : ℝ) :
    ∃ (T : UnboundedSelfAdjoint (Sec CMode)) (S : ℕ → UnboundedSelfAdjoint (Sec CMode)),
      (∀ x y : CMode, x.1 = y.1 →
          ∑ mu : Fin 3, ∑ nu : Fin 3, ∑ i : Fin 3,
              (starRingEnd ℂ) (gaugeReduce (extTorsionCoef x.1 mu nu i) x)
                * gaugeReduce (extTorsionCoef x.1 mu nu i) y
            = contTorsionGram x y) ∧
      IsSelfAdjointExtension
          (secHam (starobinskyWall M alpha halpha) (qgContinuumModes g)) T.op ∧
        (∀ n, IsSelfAdjointExtension (secHam (starobinskyWall M alpha halpha)
          (truncModes (qgContinuumModes g) (momWindow n))) (S n).op) ∧
        (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
        (∀ (t s : ℝ) (x : Sec CMode), ‖prop T t s x‖ = ‖x‖) ∧
        (∀ (t s r : ℝ) (x : Sec CMode), prop T t s (prop T s r x) = prop T t r x) ∧
        (∀ t s h : ℝ, prop T (t + h) (s + h) = prop T t s) ∧
        (∀ y : ℝ → Sec CMode, IsSchrodingerSolution T y → ∀ t s : ℝ, y t = prop T t s (y s)) ∧
        (∀ l : ℝ, l ≠ 0 →
          IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
            (∀ n, IsShiftInvertC (S n).op (((l : ℝ) : ℂ) * Complex.I) (-((S n).resCLM l))) ∧
            ∀ u : Sec CMode,
              Tendsto (fun n => -((S n).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
        ∀ (v : Sec CMode) (t : ℝ),
          Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) := by
  obtain ⟨T, S, h⟩ := qgOuterFock_timeIndependent_singleTime (starobinskyWall M alpha halpha)
    (qgContinuumModes g) momWindow momWindow_exhausts
  exact ⟨T, S, fun x y hxy => gaugeReduce_gram x y hxy, h⟩

open BookProof.QgManifoldModeInstance

/-- **The same over a general spatial manifold.**  With the vielbein spectrum of a closed
Riemannian three-manifold, the gauge-fixed Hamiltonian is again a single time-independent
self-adjoint operator whose propagator depends on the two times only through their
difference and uniquely solves the Schrödinger equation, and its spectral truncations
converge to it at every nonzero shift and at every single finite time. -/
theorem starobinsky_qgManifold_timeIndependent_singleTime (M alpha : ℝ)
    (halpha : 0 < alpha) (Sp : VielbeinSpectrum ι) (g : ℝ) :
    ∃ (T : UnboundedSelfAdjoint (Sec ι)) (S : ℕ → UnboundedSelfAdjoint (Sec ι)),
      IsSelfAdjointExtension (secHam (starobinskyWall M alpha halpha) (Sp.modes g)) T.op ∧
        (∀ n, IsSelfAdjointExtension (secHam (starobinskyWall M alpha halpha)
          (truncModes (Sp.modes g) (Sp.energyWindow n))) (S n).op) ∧
        (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
        (∀ (t s : ℝ) (x : Sec ι), ‖prop T t s x‖ = ‖x‖) ∧
        (∀ (t s r : ℝ) (x : Sec ι), prop T t s (prop T s r x) = prop T t r x) ∧
        (∀ t s h : ℝ, prop T (t + h) (s + h) = prop T t s) ∧
        (∀ y : ℝ → Sec ι, IsSchrodingerSolution T y → ∀ t s : ℝ, y t = prop T t s (y s)) ∧
        (∀ l : ℝ, l ≠ 0 →
          IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
            (∀ n, IsShiftInvertC (S n).op (((l : ℝ) : ℂ) * Complex.I) (-((S n).resCLM l))) ∧
            ∀ u : Sec ι,
              Tendsto (fun n => -((S n).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
        ∀ (v : Sec ι) (t : ℝ),
          Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) :=
  qgOuterFock_timeIndependent_singleTime (starobinskyWall M alpha halpha)
    (Sp.modes g) Sp.energyWindow Sp.energyWindow_exhausts

end

end BookProof.QgTimeIndependent
