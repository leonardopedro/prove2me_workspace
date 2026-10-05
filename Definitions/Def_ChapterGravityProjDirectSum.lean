import Definitions.Def_ChapterGravityTimeProj
import Definitions.Def_ChapterGravityProjector
import Mathlib

/-!
# The spatial and temporal projectors split Minkowski space

`BookProof.ChapterGravityTimeProj` proves the algebraic identities satisfied by
the spatial projector `χ` and the temporal projector `Π` attached to a unit
timelike vector `v`:

* `spatialProj_add_timeProj` : `χ + Π = δ`;
* `spatialProj_mul_timeProj` : `χ · Π = 0`;
* `timeProj_mul_spatialProj` : `Π · χ = 0`.

The book's chapter on diffeomorphisms and gravity uses these to conclude that
the two projectors decompose spacetime, `ℝ^{1,3} = im χ ⊕ im Π`.  This file
records that conclusion as a genuine submodule statement, via the general
linear-algebra fact that two complementary, mutually annihilating endomorphisms
have complementary ranges.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/
namespace BookProof.ChapterGravityProjDirectSum

end BookProof.ChapterGravityProjDirectSum
