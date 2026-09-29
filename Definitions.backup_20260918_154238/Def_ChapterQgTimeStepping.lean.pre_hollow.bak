import Definitions.Def_ChapterQgTruncationResolvent
import Mathlib

import Mathlib
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent

/-!
# The time-stepping half: the Crank–Nicolson (Cayley) scheme and the fully discrete flow

**Time stepping is not required by the SIRK/Hashimoto algorithm.**  That algorithm evaluates
the propagator at a *single finite time* by a rational function of the bounded shift-invert
resolvent, so no step size, number of steps or splitting enters; the statements it actually
uses are in `BookProof.ChapterSirkSingleTimeShift`
(`singleTime_flow_tendsto_of_strongResAt`, `qgOuterFock_singleTime_shiftInvert_convergence`),
and they need no boundedness of the Hamiltonian either.  What this module analyses is one
*optional* alternative — a time-marching scheme — and it is kept because it is a
self-contained convergence result, not because the pipeline depends on it.

`BookProof.ChapterQgTruncationResolvent` analyses the *space* half of such a scheme for the
outer-Fock quantum-gravity Hamiltonian: the mode cutoff.  This module analyses the *time*
half, for a concrete scheme — the **Crank–Nicolson / Cayley** (implicit midpoint) step

`C(τ) = (1 − i τ H / 2)(1 + i τ H / 2)⁻¹`,

which is exactly one shift-invert solve per step and is the scheme the shift-invert layer of
this project implements.

## What is proved

* `cnStep` — the one-step propagator, written with the resolvent of the project's
  `UnboundedSelfAdjoint` interface, and `cnStep_eq_neg_shift`, the identification
  `C(τ) = −(H + i·(2/τ))(H − i·(2/τ))⁻¹`.
* `norm_cnStep_apply`, `norm_iterate_cnStep_apply` — the scheme is **unitary**: every step,
  and hence every number of steps, preserves the norm exactly.  There is no numerical
  dissipation and no stability restriction on the step size.
* `cnStep_second_order` and `norm_cnStep_sub_taylor_le` — the **consistency** of the step:
  `C(τ)x = x − iτHx + iτ (H − 2i/τ)⁻¹H²x`, so `‖C(τ)x − (x − iτHx)‖ ≤ (τ²/2)‖H²x‖` for
  every `x` in the domain of `H²`.
* `norm_stoneU_sub_taylor_le` — the same second-order Taylor estimate for the exact flow.
* `norm_cnStep_sub_stoneU_le` — the local error `‖C(τ)x − e^{−iτH}x‖ ≤ 2τ²‖H²x‖`.
* `norm_iterate_cnStep_sub_stoneU_le` — the **global error** after `k` steps,
  `‖C(τ)^k x − e^{−ikτH}x‖ ≤ 2kτ²‖H²x‖`, by telescoping (each step is unitary and the exact
  orbit stays in the domain of `H²` with the same norm).
* **`tendsto_iterate_cnStep`** — hence, for *every* vector of the Hilbert space (no
  smoothness assumption) and every time `t`, the Crank–Nicolson iterates with step `t/k`
  converge to `e^{−itH}v` as `k → ∞`.
* **`qgOuterFock_fullyDiscrete_convergence`** — the fully discrete statement for the
  quantum-gravity Hamiltonian: mode cutoff *and* Crank–Nicolson time stepping.  For each
  cutoff there is a number of time steps such that the resulting fully discrete, finitely
  many degrees of freedom, unitary evolution converges to the exact quantum-gravity flow.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.QgTimeStepping

open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgOuterFockCoreFL BookProof.QgTruncationResolvent

noncomputable section

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

/-! ## 1. The Crank–Nicolson (Cayley) one-step propagator -/

/-- **The Crank–Nicolson step** `C(τ) = (1 − iτA/2)(1 + iτA/2)⁻¹`, expressed through the
resolvent `(A − i l)⁻¹` at `l = 2/τ`:  `C(τ) = −1 − 2 i l (A − i l)⁻¹`. -/
def cnStep (T : UnboundedSelfAdjoint H) (tau : ℝ) : H →L[ℂ] H :=
  -(ContinuousLinearMap.id ℂ H)
    - (((2 * (2 / tau) : ℝ) : ℂ) * Complex.I) • T.resCLM (2 / tau)













/-! ## 2. Consistency: the second-order expansion of one step -/

variable (T : UnboundedSelfAdjoint H)







/-! ## 3. The second-order Taylor estimate for the exact flow -/



/-! ## 4. The local and the global error of the scheme -/









/-! ## 5. Convergence of the scheme for every initial vector -/





/-! ## 6. The fully discrete quantum-gravity evolution -/

variable {ι : Type*}



end

end BookProof.QgTimeStepping
