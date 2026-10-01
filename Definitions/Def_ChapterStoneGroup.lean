import Definitions.Def_ChapterStoneResolvent
import Mathlib


/-!
# The general Stone theorem, part II: the Yosida approximation

Building on `BookProof.ChapterStoneResolvent`, this module constructs the bounded
**Yosida approximations**

`A_n = n² A (A² + n²)⁻¹ = n² (A + in)⁻¹ + i n³ (A - in)⁻¹ (A + in)⁻¹`

of an unbounded self-adjoint operator `A`, and proves that they are bounded,
self-adjoint, mutually commuting, and that `A_n x → A x` for `x` in the domain.
-/

open scoped InnerProductSpace
open Filter Topology

namespace BookProof.ChapterStoneResolvent

open BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

namespace UnboundedSelfAdjoint

variable (T : UnboundedSelfAdjoint H)

/-! ## The first resolvent identity -/



/-! ## The Yosida approximation -/

/-- The **Yosida approximation** `A_n = n² A (A² + n²)⁻¹`, written out in
resolvents as `n² (A + in)⁻¹ + i n³ (A - in)⁻¹ (A + in)⁻¹`. -/
noncomputable def yosida (n : ℝ) : H →L[ℂ] H :=
  ((n : ℂ) ^ 2) • T.resCLM (-n) + (((n : ℂ) ^ 3) * Complex.I) • (T.resCLM n * T.resCLM (-n))









/-! ## Symmetry of the Yosida approximation -/





/-! ## Commutation -/





/-! ## The approximate identity `J_n = (1 + A²/n²)⁻¹` -/

/-- `J_n = n² (A - in)⁻¹ (A + in)⁻¹ = (1 + A²/n²)⁻¹`, a contraction converging
strongly to the identity. -/
noncomputable def jn (n : ℝ) : H →L[ℂ] H := ((n : ℂ) ^ 2) • (T.resCLM n * T.resCLM (-n))

















end UnboundedSelfAdjoint

end BookProof.ChapterStoneResolvent
