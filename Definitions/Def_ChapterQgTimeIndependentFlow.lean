import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterQgBrstDerivativeGauge
import Mathlib

import Mathlib
import Definitions.Def_ChapterEsaClosureCore

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















/-- A curve solving the Schrödinger equation of the **time-independent** generator `T`:
it stays in the domain and satisfies `y'(r) = −i H y(r)` with the same `H` at every time.
No time ordering occurs. -/
structure IsSchrodingerSolution (T : UnboundedSelfAdjoint E) (y : ℝ → E) : Prop where
  mem : ∀ r, y r ∈ T.domain
  deriv : ∀ r, HasDerivAt y ((-Complex.I) • T.op ⟨y r, mem r⟩) r





/-! ## 2. The quantum-gravity Hamiltonian: autonomous, and evaluated at one finite time -/

open BookProof.SirkSingleTime BookProof.QgTruncationResolvent BookProof.FarisLavine
open BookProof.EsaClosure BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgOuterFockCoreFL BookProof.HashimotoShiftInvert

variable {ι : Type*}



open BookProof.QgContinuumModeInstance BookProof.QgBrstDerivativeGauge



open BookProof.QgManifoldModeInstance



end

end BookProof.QgTimeIndependent
