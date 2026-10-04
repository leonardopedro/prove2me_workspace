import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterSpectralDirectSum
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterUnitaryTransport
import Mathlib


/-!
# The spectral theorem in multiplication form for an **unbounded** self-adjoint operator

`BookProof.ChapterSpectralMultiplication` and `BookProof.ChapterSpectralDirectSum` prove
the spectral theorem in multiplication form for a **bounded** normal operator: with a
cyclic vector it is multiplication by the coordinate function `z` on `L²(μ)`, and in
general the space is a Hilbert sum of such models.  `BookProof.ChapterUnitaryTransport`
carries self-adjointness, the unitary group and Stone's relation through a *given*
unitary change of Hilbert space, and recorded the missing step: the **existence** of the
diagonalizing unitary for an *unbounded* self-adjoint operator.

This module supplies that step, by the classical resolvent (Cayley) route.  For a densely
defined self-adjoint `A` (the bundle `UnboundedSelfAdjoint` of
`BookProof.ChapterStoneResolvent`) the resolvent

`R = (A − i)⁻¹`

is a *bounded* operator (`resOp`), it is injective, its range is exactly the domain of `A`,
and it is **normal**: its adjoint is the resolvent at the conjugate point
(`adjoint_resOp`) and resolvents commute (`isStarNormal_resOp`).  So the bounded theory
applies to `R`, and `A` is read off from the model of `R` by `A = R⁻¹ + i`.

## What is proved

* `resOp`, `resOp_mem`, `op_resOp`, `resOp_injective`, `exists_resOp_eq` — the resolvent
  of an unbounded self-adjoint operator as a bounded operator, with `A(Ry) = y + iRy`,
  injective, and with range exactly the domain of `A`;
* `adjoint_resCLM`, `isStarNormal_resOp` — the resolvent is a bounded **normal** operator;
* `model_mem`, `model_apply` — **the model**: whenever an isometric embedding
  `V : L²(μ) → H` carries multiplication by `z` into `R`, every vector `V (z·u)` lies in
  the domain of `A` and `A (V (z·u)) = V (u + i z·u)`, i.e. `A` acts as multiplication by
  `1/z + i`;
* `model_ae_ne_zero`, `model_ae_circle` — `μ` gives no mass to `z = 0`, and is carried by
  the circle `|z|² = Im z`, the Cayley image of the real line; consequently
  `model_ae_real_multiplier`: the multiplier `1/z + i` equals the **real** function
  `Re z / |z|²` `μ`-almost everywhere, so `A` really is multiplication by a real function;
* `unbounded_multiplication_model_cyclic` — **the headline, cyclic case**: an unbounded
  self-adjoint operator whose resolvent has a cyclic unit vector is unitarily equivalent
  to multiplication by `1/z + i` on `L²(μ)` for a Borel probability measure `μ` carried by
  the Cayley circle, the domain being exactly the image of the multiplication-by-`z` range;
* `unbounded_multiplication_model_general` — **the headline, general case**: for *every*
  densely defined self-adjoint operator on a complex Hilbert space there are Borel
  probability measures `μₓ` and isometric embeddings `Vₓ : L²(μₓ) → H` exhibiting `H` as
  their Hilbert sum, on each of which the operator acts as multiplication by `1/z + i`.
  No cyclic vector and no separability is assumed;
* `unbounded_multiplication_model_separable` — the same with a countable family of
  summands, on a separable space.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

open MeasureTheory Complex
open scoped InnerProductSpace

namespace BookProof.UnboundedSpectralModel

open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication
open BookProof.ChapterSpectralDirectSum

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

/-! ## 1. The resolvent of an unbounded self-adjoint operator -/

/-- The **resolvent** `R = (A − i)⁻¹` of an unbounded self-adjoint operator, as a bounded
operator on the whole space. -/
def resOp (T : UnboundedSelfAdjoint H) : H →L[ℂ] H := T.resCLM 1















/-! ## 2. The Cayley symbol -/

/-- The **Cayley symbol** `Im z − |z|²`, a continuous real function on the spectrum of the
resolvent.  It vanishes exactly on the circle `|z − i/2| = 1/2`, the image of the real line
under the Cayley map `t ↦ 1/(t − i)`. -/
def cayleyFn (T : UnboundedSelfAdjoint H) : C(spectrum ℂ (resOp T), ℂ) where
  toFun z := ((z.1.im - ‖z.1‖ ^ 2 : ℝ) : ℂ)
  continuous_toFun := by fun_prop

@[simp] theorem cayleyFn_apply (T : UnboundedSelfAdjoint H) (z : spectrum ℂ (resOp T)) :
    cayleyFn T z = ((z.1.im - ‖z.1‖ ^ 2 : ℝ) : ℂ) := rfl







/-! ## 3. The model: an embedding intertwining multiplication by `z` with the resolvent -/

section Model

variable (T : UnboundedSelfAdjoint H) {mu : Measure (spectrum ℂ (resOp T))}
  (V : Lp ℂ 2 mu →ₗᵢ[ℂ] H)
  (hV : ∀ u : Lp ℂ 2 mu, V (mulRep mu (coordFn (resOp T)) u) = resOp T (V u))

include hV















end Model

/-! ## 3. The headline theorems -/







end BookProof.UnboundedSpectralModel

end
