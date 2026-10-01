import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
import Definitions.Def_ChapterA1b
import Definitions.Def_ChapterA1c
import Definitions.Def_ChapterA1d
import Mathlib


/-!
# Chapter A, §A.1 — the `V ⊕ V̄` splitting of a realified irreducible system (work-package N1)

This file continues work-package **N1** of `FORMALIZATION_ROADMAP.md` (§A.1,
Props 11/12).  Building on the realification correspondence of
`BookProof/ChapterA1d.lean` (the canonical R-imaginary operator `Jmap : u ↦ i·u`
and the criterion `complex_irreducible_iff_no_Jinvariant_subsystem`), we
establish the *structural dichotomy* underlying the R-pseudoreal / R-complex
cases of Prop 11/12:

> **`realification_splits`.**  If a complex system `(M, V)` is irreducible and
> `Y` is a real subsystem of its realification `(M, V^r)`, then either `Y` is
> trivial (`⊥` or `⊤`), or `V` splits as the (closure of the) internal direct
> sum `Y ⊕ J Y` — i.e. `Y ⊓ J Y = ⊥` and `(Y ⊔ J Y)‾ = ⊤`.

Here `J Y := Jmap '' Y` is the image of `Y` under the R-imaginary operator.
Both `Y ⊓ J Y` and the topological closure `(Y ⊔ J Y)‾` are `J`-invariant
subsystems, hence trivial by complex irreducibility (via
`complex_irreducible_iff_no_Jinvariant_subsystem`); the three cases of the
dichotomy are the resulting possibilities.  This is exactly the `V ⊕ V̄`
conjugate-space decomposition of a reducible realification that the roadmap
flags as the remaining ingredient of the R-pseudoreal / R-complex classification.

Everything here is intended to be `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

namespace BookProof.ChapterA

attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

/-- **The image `J Y := Jmap '' Y`** of a real subspace under the R-imaginary
operator `Jmap : u ↦ i·u`. -/
noncomputable def JY (Y : Submodule ℝ V) : Submodule ℝ V :=
  Y.map (Jmap.toLinearIsometry.toLinearMap)











/-
**`J Y` is a subsystem** of the realification whenever `Y` is: `Jmap`
commutes with every realified (`ℂ`-linear) operator.
-/


/-! ## The `J`-invariant subsystems `Y ⊓ J Y` and `(Y ⊔ J Y)‾` -/



/-
`Y ⊓ J Y` is a subsystem of the realification whenever `Y` is.
-/






/-
The topological closure `(Y ⊔ J Y)‾` is a subsystem of the realification
whenever `Y` is (a closed `M`-invariant subspace containing the `M`-invariant
algebraic sum `Y ⊔ J Y`).
-/


/-! ## Headline: the `V ⊕ V̄` dichotomy -/

/-
**`realification_splits` (§A.1, the `V ⊕ V̄` decomposition).**  If a complex
system `(M, V)` is irreducible and `Y` is a real subsystem of its realification
`(M, V^r)`, then either `Y` is trivial, or `V` is the closure of the internal
direct sum `Y ⊕ J Y`: `Y ⊓ J Y = ⊥` and `(Y ⊔ J Y)‾ = ⊤`.

The two `J`-invariant subsystems `Y ⊓ J Y` and `(Y ⊔ J Y)‾` are each `⊥` or `⊤`
by `complex_irreducible_iff_no_Jinvariant_subsystem`; the possible combinations
give exactly the three cases (the `Y ⊓ J Y = ⊤` case forces `Y = ⊤`, the
`(Y ⊔ J Y)‾ = ⊥` case forces `Y = ⊥`, and the remaining case is the direct-sum
splitting).
-/




end BookProof.ChapterA
