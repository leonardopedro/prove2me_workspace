import Mathlib.Tactic
import Mathlib.Analysis.InnerProductSpace.Adjoint
import Mathlib.Analysis.InnerProductSpace.Positive
import Mathlib.Analysis.InnerProductSpace.StarOrder
import Mathlib.Analysis.CStarAlgebra.ContinuousLinearMap
import Mathlib.Analysis.InnerProductSpace.ProdL2
import Mathlib.Analysis.CStarAlgebra.ContinuousFunctionalCalculus.Order
import Mathlib.Analysis.CStarAlgebra.ContinuousFunctionalCalculus.Commute
import Mathlib.Analysis.CStarAlgebra.ContinuousFunctionalCalculus.Instances
import Mathlib.Analysis.CStarAlgebra.ContinuousFunctionalCalculus.Unique
import Mathlib.Analysis.SpecialFunctions.Sqrt
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Topology.Algebra.Module.LinearMap

/-!
# `BookProof.Prelude` — the cheap import for new chapters

Every chapter of this development used to open with `import Mathlib`, which pulls
the **whole** library (about 8000 build jobs) into the import cone of the file.
That is the single largest fixed cost of compiling a new chapter.

This module collects the Mathlib theory the analysis chapters actually use —
tactics, inner product spaces and adjoints, positive operators, the continuous
functional calculus and its order theory, and real square roots — in an import
cone of about 3200 jobs, i.e. **2.5× smaller**.

Use it instead of `import Mathlib` in new files:

```lean
import BookProof.Prelude
import BookProof.Chapter<TheOneChapterYouNeed>
```

If a proof needs something outside this cone, add the *specific* Mathlib module
here (or to the file that needs it) rather than falling back to `import Mathlib`.
-/
