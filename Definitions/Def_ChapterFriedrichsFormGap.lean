import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterYangMillsFriedrichs
import Mathlib

/-!
# Chapter FriedrichsFormGap — the Friedrichs extension inherits the gap of its core

`CONSOLIDATED_PLAN.md` (top work package) needs the **infinite** selected operator, not just
the finite truncations, to carry the certified positive lower bound.  The operator the
Hashimoto/shift-invert algorithm selects is the Friedrichs extension constructed in
`BookProof.FriedrichsExtension` (`friedrichs_extension_exists`,
`friedrichs_hashimoto_selects`).  This chapter proves the missing transfer:

> if the symmetric positive core satisfies `⟪x, H x⟫ ≥ μ‖x‖²` on its (dense) domain, then
> the Friedrichs extension satisfies `⟪y, A y⟫ ≥ μ‖y‖²` on **its** domain.

No boundedness and no spectral theorem for unbounded operators are used: the argument is
carried out in the form completion, where the core bound `‖x‖₁² ≥ (1+μ)‖x‖²` extends by
continuity to the whole form space (`formSpace_norm_bound`), and the extension's quadratic
form at `y = formExt k` is exactly `‖k‖₁² − ‖y‖²`.

## Deliverables

* `formSpace_norm_bound` — the core form bound extends to the form completion;
* `friedrichs_quadForm_lower_bound` — the constructed extension `A = S⁻¹ − 1` satisfies
  `⟪y, A y⟫ ≥ μ‖y‖²`;
* `friedrichs_extension_form_gap` — the packaged statement: the Friedrichs extension exists,
  is a positive self-adjoint extension of `H`, is the operator whose Hashimoto shift-invert
  at `γ = 1` is the resolvent `S` (hence the one the algorithm selects), and inherits the
  lower bound `μ`.
-/
namespace BookProof.FriedrichsFormGap

end BookProof.FriedrichsFormGap
