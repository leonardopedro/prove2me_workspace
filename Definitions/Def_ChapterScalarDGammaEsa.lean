import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Mathlib


/-!
# An unconditional instance: second quantization of a scalar one-particle operator

The main theorem of `BookProof/ChapterSecondQuantizationCoreEsa.lean` carries one hypothesis,
sector by sector: essential self-adjointness of the derivation `dΓ(A)⁽ⁿ⁾` on the *full*
tensor power `D₂^{⊗n}` of the domain of the closure.  This module discharges that hypothesis
completely in a concrete family of examples — the **scalar** one-particle operators
`A = c • id` with `c : ℝ`, defined on all of `H` — and thereby produces an unconditional
statement of the second quantization theorem over an arbitrary dense core `D`:

> If `D ⊆ H` is any dense subspace, then `dΓ(c • id)` is essentially self-adjoint on the
> finite-particle domain `𝓕_fin(D)`.

Here `D` is a core for `c • id` but is in general *not* invariant under anything and carries
no resolvent; the passage from `H` to `D` is exactly the core transfer principle.  On the
`n`-particle sector the derivation is the scalar `n · c`, which is bounded, so the
sector hypothesis follows from the elementary criterion
`BookProof.GraphCore.essentiallySelfAdjointOn_of_bounded_dense`.

## Contents

* `scalarOp` — the one-particle operator `c • id` on `⊤`;
* `symmetricOn_scalarOp`, `isGraphCore_scalarOp` — it is symmetric, and every dense subspace
  is a core for it;
* `derPow_scalar` — the sector derivation of a scalar operator is the scalar `n · c`;
* `essentiallySelfAdjointOn_fockSectorDom_scalar` — the sector hypothesis, proved;
* `dGamma_scalar_essentiallySelfAdjointOn_fockCore` — **the unconditional theorem**.

Nothing is assumed: the module contains no `axiom` and no `sorry`.
-/

namespace BookProof.ScalarDGamma

open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore
  BookProof.SecondQuantizationCore BookProof.DirectSumEsa

noncomputable section

variable (Hs : IPSpace) (c : ℝ)

/-! ## The scalar one-particle operator -/

/-- The scalar one-particle operator `A = c • id`, defined on all of `H`. -/
def scalarOp : (⊤ : Submodule ℂ Hs.carrier) →ₗ[ℂ] Hs.carrier :=
  (c : ℂ) • (⊤ : Submodule ℂ Hs.carrier).subtype







/-! ## The sector derivation of a scalar operator -/



/-! ## The sector domain is everything -/







/-! ## The sector hypothesis, discharged -/







/-! ## The unconditional theorem -/



end

end BookProof.ScalarDGamma
