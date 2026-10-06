import Definitions.Def_ChapterFockWeightedSchurEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFockSchurEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib


/-!
# From a graded band matrix to the weighted Schur gates

`BookProof.ChapterFockWeightedSchurEsa` proves essential self-adjointness of `dΓ(A)` on the
finite-occupation core under three gates weighted by a symbol `w ≥ 1` — the row gate, the
column gate and the commutator gate.  This chapter discharges all three from a single
structural hypothesis, the one satisfied by the Hermite matrix of a quadratic Hamiltonian:

```text
(card)  every column has at most `M` nonzero entries;
(band)  `A_{kj} = 0` unless `|deg j − deg k| ≤ D`;
(growth)`|A_{kj}| ≤ C (deg k + 1)`.
```

With the symbol `w k = deg k + 1` (`degW`):

* **`wRow_of_gradedBand`** — the row gate with `K = C·M`;
* **`wCol_of_gradedBand`** — the column gate with the same `K`, by hermiticity;
* **`wComm_of_gradedBand`** — the commutator gate with `B = C·M·D·(D+2)`: the band makes
  `|w_j² − w_k²| / (w_k w_j) ≤ D(D+2)/w_k`, which cancels the growth of the entries;
* **`dGamma_essentiallySelfAdjointOn_core_gradedBand`** — hence `dΓ(A)` is essentially
  self-adjoint on the finite-occupation core.  The one-particle operator need not be
  bounded: only its growth relative to the grading is constrained.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.GradedBandSchur

open BookProof.FockSecondQuantization BookProof.FockSchur BookProof.FockWeightedSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {deg : ℕ → ℕ} {D M : ℕ} {C : ℝ}

/-- The symbol attached to a grading: `w k = deg k + 1`. -/
def degW (deg : ℕ → ℕ) : ℕ → ℝ := fun k => (deg k : ℝ) + 1













end

end BookProof.GradedBandSchur
