import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterWeakSecondDerivative
import Mathlib


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



/-! ## 2. Square-integrable classical solutions -/

/-- **`W` is a square-integrable classical solution of `W'' = (V − z)W`.**  This is exactly
the object the regularity theorem produces from a deficiency vector, and — by
`inner_eq_of_ode` below — exactly what produces one. -/
def IsL2Ode (V : ℝ → ℝ) (z : ℂ) (W : ℝ → ℂ) : Prop :=
  ∃ W' : ℝ → ℂ, (∀ x, HasDerivAt W (W' x) x) ∧
    (∀ x, HasDerivAt W' ((((V x : ℝ) : ℂ) - z) * W x) x) ∧ MemLp W 2 (volume : Measure ℝ)





/-! ## 3. A solution is a deficiency vector -/



/-! ## 4. The characterisation -/





/-! ## 5. Consequences -/









/-! ## 6. The criterion is not vacuous: a worked instance

The harmonic potential `V(x) = x² − 1` has the Gaussian `e^{−x²/2}` as a square-integrable
classical solution of `W'' = (V − 0)W`, so the deficiency space of `−d²/dx² + V` at `z = 0`
is *not* trivial.  (`z = 0` is real, so this does not contradict essential self-adjointness:
it records that `0` is an eigenvalue — the shifted harmonic ground state.)  It does show that
`not_deficiencyTrivialAt_of_l2_solution` has content and that its hypotheses are
satisfiable. -/

/-- The harmonic potential shifted so that the ground-state energy is `0`. -/
def harmonicShiftedV : ℝ → ℝ := fun x => x ^ 2 - 1



/-- The Gaussian ground state `e^{−x²/2}`, complexified. -/
def gaussianState : ℝ → ℂ := fun x => ((Real.exp (-(x ^ 2 / 2)) : ℝ) : ℂ)





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
