import Definitions.Def_ChapterKatoRellichDeficiency
import Definitions.Def_ChapterFarisLavine
import Mathlib

/-!
# Kato–Rellich for **relatively bounded** perturbations

`BookProof.ChapterKatoRellichDeficiency` proves the Kato–Rellich theorem for a
*bounded* symmetric perturbation.  This module proves the genuine version, the
one the Navier–Stokes Lagrangian route needs: the perturbation may be
**unbounded**, and is only assumed to be dominated by the unperturbed operator,

`‖B x‖ ≤ a ‖H x‖ + b ‖x‖`,  `0 ≤ a < 1`,

on the common domain `D`.  The conclusion is unchanged: if `H` is symmetric and
essentially self-adjoint on `D` and `B` is symmetric on `D`, then `H + B` is
essentially self-adjoint on `D`.

The proof is the same explicit Neumann iteration as in the bounded case — no
closures, no spectral theorem — with one new ingredient
(`norm_le_of_relBound`): for symmetric `H`,

`‖H x - e i x‖² = ‖H x‖² + e²‖x‖²`,

so `‖H x‖ ≤ ‖H x - e i x‖` **and** `|e| ‖x‖ ≤ ‖H x - e i x‖`, whence

`‖B x‖ ≤ (a + b/|e|) ‖H x - e i x‖`.

Choosing the shift `|e|` large makes the contraction factor `q = a + b/|e|`
smaller than `1`, which is exactly the room the hypothesis `a < 1` buys.  This
is the point where the relative bound replaces the operator norm `‖B‖` of the
bounded case; everything downstream is the same geometric Neumann estimate.

## What is proved

* `norm_le_of_relBound` — the relative bound transferred to the shifted
  operator, with contraction factor `a + b/|e|`;
* `dense_range_add_relBounded` — the Neumann step: at a shift with
  `a + b/|e| < 1` the range of `H + B - e i` is dense as soon as the range of
  `H - e i` is;
* `essentiallySelfAdjointOn_add_relBounded` — **the Kato–Rellich theorem**;
* `symmetricOn_add` — symmetry of the sum, and
  `essentiallySelfAdjointOn_add_bounded'` — the bounded case recovered as the
  special case `a = 0`, `b = ‖B‖`.
-/
namespace BookProof.KatoRellich

end BookProof.KatoRellich
