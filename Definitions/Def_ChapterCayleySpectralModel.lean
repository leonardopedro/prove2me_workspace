import Definitions.Def_ChapterCayleyTransform
import Definitions.Def_ChapterSpectralMultiplication
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterUnitaryTransport
import Mathlib


/-!
# The spectral model of an unbounded self-adjoint operator, via its Cayley transform

`ChapterSpectralMultiplication` proves the spectral theorem in multiplication form
for a **bounded** normal operator with a cyclic vector, and
`ChapterCayleyTransform` turns an **unbounded** self-adjoint operator `A` into the
unitary `V = (A - i)(A + i)⁻¹`.  This module composes the two, and so obtains a
multiplication model for the unbounded operator itself.

The point that makes the composition work without any theory of unbounded
multiplication operators is that the *resolvent* is a **continuous** function of
the Cayley transform:

* `res_neg_one_eq_cayley` — `(A + i)⁻¹ = (2i)⁻¹(1 - V)`;
* `res_one_eq_cayley` — `(A - i)⁻¹ = (2i)⁻¹(V⁻¹ - 1)`;
* `cayleyCLM`, `isStarNormal_cayleyCLM` — `V` as a bounded *normal* operator, so
  the continuous functional calculus applies to it;
* `resSymbol` `g(z) = (1 - z)/(2i)` and `opSymbol` `h(z) = (1 + z)/2`, with
  `cfcHom_resSymbol` (`g(V) = (A + i)⁻¹`) and `cfcHom_opSymbol`
  (`h(V)y = A (A + i)⁻¹ y`).

Feeding these two bounded symbols through the multiplication model of the Cayley
transform gives the headline

* `unbounded_spectral_multiplication_model` — there is a Borel probability measure
  `μ` on the spectrum of `V` and a unitary `U : L²(μ) ≃ H` such that **every**
  vector of `D(A)` is of the form `U(g·u)`, and `A U(g·u) = U(h·u)`.  Since
  `h/g = i(1 + z)/(1 - z)`, this says exactly that `A` is multiplication by the
  real function `i(1 + z)/(1 - z)` on `L²(μ)` — the spectral theorem for the
  unbounded operator, in the cyclic case.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped InnerProductSpace
open MeasureTheory

namespace BookProof.ChapterCayleySpectralModel

open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterCayleyTransform BookProof.ChapterAbelianGelfandModel
open BookProof.ChapterSpectralMultiplication

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

/-! ## The resolvents in terms of the Cayley transform -/





/-! ## The Cayley transform as a bounded normal operator -/

/-- The Cayley transform as a bounded operator. -/
noncomputable def cayleyCLM : H →L[ℂ] H := (cayley T).toContinuousLinearEquiv

@[simp] theorem cayleyCLM_apply (y : H) : cayleyCLM T y = cayley T y := rfl



/-! ## The two bounded symbols -/

/-- The symbol of the resolvent: `g(z) = (1 - z)/(2i)`. -/
noncomputable def resSymbol : C(spectrum ℂ (cayleyCLM T), ℂ) :=
  (2 * Complex.I)⁻¹ • (1 - coordFn (cayleyCLM T))

/-- The symbol of the operator on the range of the resolvent: `h(z) = (1 + z)/2`.
Since `h/g = i(1 + z)/(1 - z)`, the pair `(g, h)` is the multiplication model of
the unbounded operator. -/
noncomputable def opSymbol : C(spectrum ℂ (cayleyCLM T), ℂ) :=
  (2 : ℂ)⁻¹ • (1 + coordFn (cayleyCLM T))

@[simp] theorem resSymbol_apply (z : spectrum ℂ (cayleyCLM T)) :
    resSymbol T z = (1 - (z : ℂ)) / (2 * Complex.I) := by
  simp [resSymbol, coordFn, div_eq_inv_mul]

@[simp] theorem opSymbol_apply (z : spectrum ℂ (cayleyCLM T)) :
    opSymbol T z = (1 + (z : ℂ)) / 2 := by
  simp [opSymbol, coordFn, div_eq_inv_mul, mul_add]









/-! ## The multiplication model -/

variable (xi : H)







end BookProof.ChapterCayleySpectralModel
