import Definitions.Def_ChapterWallDeficiencyObstruction
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Mathlib


/-!
# The wrong-sign conformal fiber: an explicit exponential-wall potential whose Schrödinger
# operator is *not* essentially self-adjoint

`CONSOLIDATED_PLAN.md`'s QG-2 "Case B" is the densitized **conformal** direction of the 3D
gauge-fixed gravity Hamiltonian.  There the densitized kinetic term enters with the *wrong*
sign, `(1/24) ∂²_y`, while the `R²` (Starobinsky) potential is a non-negative **exponential
wall** — growing like `e^{−2ay}` as `y → −∞` and flattening to a plateau as `y → +∞`.
Multiplying that fiber operator by the positive constant `24` and flipping the overall sign
turns it into a standard Schrödinger operator

`−24·((1/24) d²/dy² + U(y) + c₀) = −d²/dy² − 24·(U(y) + c₀)`,

i.e. `−d²/dy² + V` with `V = −24(U + c₀)` — a potential that is *unbounded below*
exponentially at `−∞` and constant at `+∞`.  The plan records (and its 2026-08-29f (v2)
analysis argues) that this is the Weyl **limit-circle** situation at the wall, so that
essential self-adjointness on the compactly supported smooth core **fails**.

`BookProof/ChapterLimitCircleExample.lean` already made the failure a theorem for *some*
smooth real potential (asymptotically `−x⁴/4`).  This module does it for a potential of
exactly the **conformal-fiber profile**: an explicit non-negative exponential wall `cfWall`
with a plateau at `+∞`, whose sign-flipped, rescaled potential `cfV = −24(cfWall + 1/32)`
carries an explicit square-integrable classical solution at `z = i`.

## The construction

As in the previous module, the problem is run backwards.  For `W = e^{p + iq}` with `p, q`
real,

`W''/W = (p'' + p'² − q'²) + i(q'' + 2p'q')`,

so `W` solves `W'' = (V − i)W` for the *real* potential `V = p'' + p'² − q'²` exactly when
`q'' + 2p'q' = −1`, and `W ∈ L²` exactly when `e^{2p}` is integrable.  Writing `q' = f`, the
imaginary equation forces `p' = −(1 + f')/(2f)`.  Choosing the **exponential** phase
derivative

`f(y) = q'(y) = 1 + e^{−y}`

gives `p'(y) = −(1/2)·tanh(y/2)`, i.e. `p(y) = −log cosh(y/2)`, so
`‖W(y)‖² = 1/cosh²(y/2) ≤ 4/(1 + y²)` is integrable, and

`V(y) = p'' + p'² − q'² = 1/4 − 1/(2 cosh²(y/2)) − (1 + e^{−y})²`,

which is `≤ 1/4 − e^{−2y}` everywhere (an exponential well at `−∞`) and tends to `−3/4` at
`+∞` (the plateau).  Its wall form `cfWall = −V/24 − 1/32` is non-negative, grows at least
like `e^{−y}/12` at `−∞`, and tends to `0` at `+∞`.

## What is proved

* `cfSol_isL2Ode` — the explicit `W` is a square-integrable classical solution of
  `W'' = (cfV − i)W`;
* `cfV_not_deficiencyTrivialAt_I`, `cfV_not_deficiencyTrivialAt_negI` — *both* deficiency
  spaces of `−d²/dy² + cfV` are nontrivial (deficiency indices `≥ (1,1)`);
* **`cfV_not_essentiallySelfAdjoint`** — `−d²/dy² + cfV` is not essentially self-adjoint on
  the compactly supported smooth core of `L²(ℝ)`;
* `cfWall_nonneg`, `cfWall_ge_exp`, `cfWall_tendsto_atBot`, `cfWall_tendsto_atTop`,
  `cfV_eq_wall` — the wall form: a *non-negative* potential with the exponential-wall /
  plateau profile of the Starobinsky conformal fiber, related to `cfV` by the sign flip and
  rescaling above;
* `exists_wall_potential_wrongSign_not_essentiallySelfAdjoint` — the packaged statement.

## Honest boundary

This settles the *shape* claim of QG-2 Case B: with the conformal direction's wrong-sign
kinetic term, a non-negative exponential wall does **not** restore essential self-adjointness
— the sign of the kinetic term, not the wall, decides.  It does **not** compute the
deficiency indices of the densitized conformal operator of the manuscript itself (whose wall
is the specific Starobinsky `K(1 − e^{−aφ})²`), and it makes no claim about the full quantum
gravity operator.  The relation to the wrong-sign fiber is recorded at the level of the
potential (`cfV_eq_wall`); the operator in the Lean statements is always the standard
`wallHam`, `−d²/dy² + V`.
-/

namespace BookProof.ConformalFiberDeficiency

open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

/-! ## 1. The real ingredients -/

/-- The log-modulus `p(y) = −log cosh(y/2)` of the solution. -/
def cfP : ℝ → ℝ := fun y => -Real.log (Real.cosh (y / 2))

/-- `p'(y) = −sinh(y/2)/(2 cosh(y/2)) = −½ tanh(y/2)`. -/
def cfP' : ℝ → ℝ := fun y => -(Real.sinh (y / 2) / (2 * Real.cosh (y / 2)))

/-- `p''(y) = −1/(4 cosh²(y/2))`. -/
def cfP'' : ℝ → ℝ := fun y => -(1 / (4 * Real.cosh (y / 2) ^ 2))

/-- The phase `q(y) = y − e^{−y}`. -/
def cfQ : ℝ → ℝ := fun y => y - Real.exp (-y)

/-- `q'(y) = 1 + e^{−y}` — the exponential phase derivative that produces the wall. -/
def cfQ' : ℝ → ℝ := fun y => 1 + Real.exp (-y)

/-- **The potential** `V(y) = 1/4 − 1/(2 cosh²(y/2)) − (1 + e^{−y})²`: smooth, real,
exponentially unbounded below at `−∞` and constant (`= −3/4`) at `+∞` — the sign-flipped
conformal-fiber profile. -/
def cfV : ℝ → ℝ := fun y =>
  1 / 4 - 1 / (2 * Real.cosh (y / 2) ^ 2) - (1 + Real.exp (-y)) ^ 2













/-! ## 2. The two algebraic identities -/







/-! ## 3. The solution -/

/-- **The deficiency vector** `W = e^{p + iq}`. -/
def cfSol : ℝ → ℂ := fun y =>
  Complex.exp (((cfP y : ℝ) : ℂ) + Complex.I * ((cfQ y : ℝ) : ℂ))

/-- Its logarithmic derivative `p' + iq'`. -/
def cfLog' : ℝ → ℂ := fun y => ((cfP' y : ℝ) : ℂ) + Complex.I * ((cfQ' y : ℝ) : ℂ)













/-! ## 4. Square integrability -/











/-! ## 5. The failure of essential self-adjointness -/









/-! ## 6. The wall form: the conformal-fiber profile -/

/-- **The wall potential** `U = −V/24 − 1/32`: the non-negative exponential wall whose
wrong-sign fiber operator `(1/24) d²/dy² + U + 1/32` is `−1/24` times `−d²/dy² + cfV`. -/
def cfWall : ℝ → ℝ := fun y => -(cfV y) / 24 - 1 / 32









/-! ## 7. The asymptotic profile -/

















/-! ## 8. The packaged statement -/



end

/-! ## Audit -/

section Audit

#print axioms cfSol_isL2Ode
#print axioms cfV_not_deficiencyTrivialAt_I
#print axioms cfV_not_deficiencyTrivialAt_negI
#print axioms cfV_not_essentiallySelfAdjoint
#print axioms cfV_tendsto_atBot
#print axioms cfV_tendsto_atTop
#print axioms cfWall_tendsto_atBot
#print axioms cfWall_tendsto_atTop
#print axioms exists_wall_potential_wrongSign_not_essentiallySelfAdjoint

end Audit

end BookProof.ConformalFiberDeficiency
